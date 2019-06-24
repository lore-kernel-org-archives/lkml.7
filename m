Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178A0C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C694F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Im0l8x6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfFXTbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:31:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfFXTbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8ZhVLbrVEu9qNpIdvb/u1Bup6gHcBX3xecQojTKBcMs=; b=Im0l8x6/B9mUso7iiUnHOkZcIn
        cTaeswhJ/K59uTrfAIY68SlWuj4W4S1a5WUY8s+g7v/dJUrANVZFfyPS8iCYxQbY5DBC9K2U33ft0
        N/5qUOPO/72vvbo8w5Qqk90eqY5wPpytrtMwLfPE56ebw89sifxHWLEkuuNKcSxPAoM/5LR3cyh/V
        khDchm8ugbKkfmplxP57Zrh56Jri5Cy73FCXnlBlVtBeqfkG1M/6Rly+0mf09cbK0X7r+6pYpQc4o
        2l2d085+sAXPiXrXGYh8+1cVKoaEPEsqtfKLrG5MN7513Th3EUVQh4P81UcRDmQIUY9JHMtTjGMNF
        FvInlp9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfUgX-0008KU-Oz; Mon, 24 Jun 2019 19:31:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96FF120A0EACA; Mon, 24 Jun 2019 21:31:23 +0200 (CEST)
Date:   Mon, 24 Jun 2019 21:31:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190624193123.GI3436@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624161913.GA32270@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:19:13AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> arch/x86/events/intel/core.c: In function ‘intel_pmu_init’:
> arch/x86/events/intel/core.c:4959:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    pmem = true;
>    ~~~~~^~~~~~
> arch/x86/events/intel/core.c:4960:2: note: here
>   case INTEL_FAM6_SKYLAKE_MOBILE:
>   ^~~~
> arch/x86/events/intel/core.c:5008:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    pmem = true;
>    ~~~~~^~~~~~
> arch/x86/events/intel/core.c:5009:2: note: here
>   case INTEL_FAM6_ICELAKE_MOBILE:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I still consider it an abomination that the C parser looks at comments
-- other than to delete them, but OK I suppose, I'll take it.
