Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFD020715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aUc+ysWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKNJvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:51:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46994 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RFb84Wx8cc7mWiQHe41LwTIozaCOCfgKEuPtCjC/vQw=; b=aUc+ysWxulxWkEgxqip7anrSb
        6qTf67QjCHA2Bz3GoaylzLfVOEBSuygke+a4ydMNRbpvb71oQMD7d+NhixLryWUXEnsouvoIMLCGs
        YiUp5CGBlRk6EkC8omiNvTcHWMj9C4ptykOEbA4m8ax3FSbI3PA1t3+F1TW+7H3znya2gxPoSPCwL
        RT//zqgwFCh0x8ztcIm3ruhUZBISkHGmSMyCic5+egfHqnWbDHsCm4Em5wuDIK3PGiT3kkV4PZlto
        tLGe6z3qwTzCo6iNE1qmvyZXuzkgWrefaBPkojbO8rXJQcyMZ1paeMhlJVCH7je426oQHhJslYIMG
        yfLiJJ7tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVBmX-0003I1-6h; Thu, 14 Nov 2019 09:51:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71F143002B0;
        Thu, 14 Nov 2019 10:50:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D723129DF1245; Thu, 14 Nov 2019 10:51:14 +0100 (CET)
Date:   Thu, 14 Nov 2019 10:51:14 +0100
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
Subject: Re: [PATCH v3 04/10] perf: Add per perf_cpu_context min_heap storage
Message-ID: <20191114095114.GP4131@hirez.programming.kicks-ass.net>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114003042.85252-5-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:30:36PM -0800, Ian Rogers wrote:
> +	if (cpuctx) {
> +		event_heap = (struct min_max_heap){
> +			.data = cpuctx->itr_storage,
> +			.size = 0,

C guarantees that unnamed fields get to be 0

> +			.cap = cpuctx->itr_storage_cap,
> +		};
> +	} else {
> +		event_heap = (struct min_max_heap){
> +			.data = itrs,
> +			.size = 0,

idem.

> +			.cap = ARRAY_SIZE(itrs),
> +		};
> +		/* Events not within a CPU context may be on any CPU. */
> +		__heap_add(&event_heap, perf_event_groups_first(groups, -1));
> +

suprious whitespace

> +	}
> +	evt = event_heap.data;
> +
>  	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
