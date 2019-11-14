Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF1CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFDC2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FBsImf4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfKNJ4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:56:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47088 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNJ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vCqnBTsA0Doyeisgqnh1HHPsTTJOUvX4mTovg5b7Lpw=; b=FBsImf4+vDOEdeJO95btrJWZc
        ugo1ATV+XJICPEkrlKMPfgh6QNQuqsK5V+prmxYEidzf3l2WRw6z4FQd77820kwKJ8RbmDavJJqr5
        c6TYZoZ8TdT+e+1SJ6qZ1U9t8e+x1lS7Y48KFuS6R2WgtkaDSdHeU8Us77+4G4gQ5RdKW5wA/Oox2
        2dqssnx1oUgMFdhxPCFqWYxcFGftEWQXWFt4NpMOd/VeJyq4kOto9HL/+xqUN8OGBaCrPpux0yB5s
        o2frjcng9Cfbe6QuvZbnieI2XjQY2xvHG/eVwfatx133QO+U75gY1XWEEG4a3qRoWPo1hmLs600E8
        X+6J7eG0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVBpe-0003PT-3N; Thu, 14 Nov 2019 09:54:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE19230018B;
        Thu, 14 Nov 2019 10:53:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 924C129DF1245; Thu, 14 Nov 2019 10:54:28 +0100 (CET)
Date:   Thu, 14 Nov 2019 10:54:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 05/10] perf/cgroup: Grow per perf_cpu_context heap
 storage
Message-ID: <20191114095428.GQ4131@hirez.programming.kicks-ass.net>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114003042.85252-6-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:30:37PM -0800, Ian Rogers wrote:
> Allow the per-CPU min heap storage to have sufficient space for per-cgroup
> iterators.
> 
> Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  kernel/events/core.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0dab60bf5935..3c44be7de44e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -892,6 +892,47 @@ static inline void perf_cgroup_sched_in(struct task_struct *prev,
>  	rcu_read_unlock();
>  }
>  
> +static int perf_cgroup_ensure_itr_storage_cap(struct perf_event *event,

That's a ludicrous function name.

> +					struct cgroup_subsys_state *css)
> +{
