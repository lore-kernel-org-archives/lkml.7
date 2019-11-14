Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E699AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1612070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ondIJO+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKNIu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:50:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNIu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1wxVpyQh0vekRMPuXPgyIq/v1OcqmGGMKosRRrc1FKM=; b=ondIJO+lfWnXDrjLEqSmurbIs
        7SDblHUbM/2K5fI6vB3mXUS2vO3jrnCHW1xpi5HMIOcr1zi1Mr+snJ35G4ePWX1rnc+c0PqK39QP3
        DixwCYX90/xW9szByi1vxX+/Y8r8YmYLwvVIAVbExUmfaOZ3x9CejgOQOeQuDHi0gKFNH9fEa8HG1
        hs+3Bwdcr8yKwODDvhF+wkpubujmKzBTGt8tUpSvcEZiBw2DiNlW6T+QChrkNHtLdDO/klO70GKYh
        emyp5vQGEUHWR6eNMYsQBotN8WTD1PxtINChrgC+x0/bE8JAZCkky4TZV/xHYjIrQCoGldsI6ya6v
        CxVPXyGoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVApT-0002Sk-1u; Thu, 14 Nov 2019 08:50:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAE27301120;
        Thu, 14 Nov 2019 09:49:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3540529DF1242; Thu, 14 Nov 2019 09:50:11 +0100 (CET)
Date:   Thu, 14 Nov 2019 09:50:11 +0100
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
Subject: Re: [PATCH v3 01/10] perf/cgroup: Reorder perf_cgroup_connect()
Message-ID: <20191114085011.GL4131@hirez.programming.kicks-ass.net>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114003042.85252-2-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hurm, you didn't fix my missing Changelog.. 

On Wed, Nov 13, 2019 at 04:30:33PM -0800, Ian Rogers wrote:
> From: Peter Zijlstra <peterz@infradead.org>

Move perf_cgroup_connect() after perf_event_alloc(), such that we can
find/use the PMU's cpu context.

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  kernel/events/core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cfd89b4a02d8..0dce28b0aae0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10597,12 +10597,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	if (!has_branch_stack(event))
>  		event->attr.branch_sample_type = 0;
>  
> -	if (cgroup_fd != -1) {
> -		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
> -		if (err)
> -			goto err_ns;
> -	}
> -
>  	pmu = perf_init_event(event);
>  	if (IS_ERR(pmu)) {
>  		err = PTR_ERR(pmu);
> @@ -10615,6 +10609,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  		goto err_pmu;
>  	}
>  
> +	if (cgroup_fd != -1) {
> +		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
> +		if (err)
> +			goto err_pmu;
> +	}
> +
>  	err = exclusive_event_init(event);
>  	if (err)
>  		goto err_pmu;
> @@ -10675,12 +10675,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	exclusive_event_destroy(event);
>  
>  err_pmu:
> +	if (is_cgroup_event(event))
> +		perf_detach_cgroup(event);
>  	if (event->destroy)
>  		event->destroy(event);
>  	module_put(pmu->module);
>  err_ns:
> -	if (is_cgroup_event(event))
> -		perf_detach_cgroup(event);
>  	if (event->ns)
>  		put_pid_ns(event->ns);
>  	if (event->hw.target)
> -- 
> 2.24.0.432.g9d3f5f5b63-goog
> 
