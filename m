Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EE7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766FE206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Lc05wF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfKNKDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:03:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47302 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfKNKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mPaFMkt9vXYAXdgv2nrv3oFLuBgUpmcKm2BpYsASRvQ=; b=0Lc05wF3opZg2k0YXqmTaPzHx
        9itYPzCFRvM/HsAwRR6lV6OWJsxiAsZEKJeost+FQAqbRbJVMAeq8B3dWGGM/oYzjihISOiwxgKS0
        fQ9yrNZjukq7JZ7xMAXIZ2Fc9LxuuEo1XARn0vYIFMn+EVRk9ly7x9wVbhZYxM827RwRHBf+LwfWg
        5zPFeF+L5OcK5S5KaA/hR/uXD5sSxmWlJHDNa/ZwOucTdadR/QwlCOVpkSFIcP7KcLElJ0dJk272e
        2TX+rwICG2l/PK8ebDwCgV5BhMgW8yqYWKNlbtaCjvpkKAtRNSTummNQmtAdkOOQVi2Qfcs6Bomnj
        zCI6NgL4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVBy9-0003wY-0k; Thu, 14 Nov 2019 10:03:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7209E3002B0;
        Thu, 14 Nov 2019 11:02:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBB5829DF1247; Thu, 14 Nov 2019 11:03:12 +0100 (CET)
Date:   Thu, 14 Nov 2019 11:03:12 +0100
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
Subject: Re: [PATCH v3 07/10] perf: simplify and rename visit_groups_merge
Message-ID: <20191114100312.GR4131@hirez.programming.kicks-ass.net>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-8-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114003042.85252-8-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:30:39PM -0800, Ian Rogers wrote:
> To enable a future caching optimization, pass in whether
> visit_groups_merge is operating on pinned or flexible groups. The
> is_pinned argument makes the func argument redundant, rename the
> function to ctx_groups_sched_in as it just schedules pinned or flexible
> groups in. Compute the cpu and groups arguments locally to reduce the
> argument list size. Remove sched_in_data as it repeats arguments already
> passed in. Remove the unused data argument to pinned_sched_in.

Where did my first two patches go? Why aren't
{pinned,flexible}_sched_in() merged?
