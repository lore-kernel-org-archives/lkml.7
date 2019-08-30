Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A122C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BCA22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKaa+7WA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfH3Ldn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:33:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfH3Ldn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xRwLham4pk66OEWPaOwLBhsQ46VMNlLT4cSKhSz70R0=; b=iKaa+7WA7GlEl/xhNoNvu07Rq
        EG7NwGLB9i6CMa5I/Nv4egb6sB8Q/kySrM63kYt+Et8OkevLhoRtZYIc44NKmSAmSwChpQYNcTbgy
        KbKxmmZZxl00z6FAUOPY6km31obzzdVA0y+dsbKAE/c5EYHBbcgoMUXf0wOsvgI9bNF2lGGsJO6R+
        hFaqynrSXqPjR1kFtK3HZOTflPcH+spkjRTCZYfONgmuTnOMQIXCjJ+i6u3jzdiRnQsOqzUCZlzwr
        tUVY1qKq2HJjvUZXbtM7Vz0o3a412sm7uISzXQ274gVD7KmSFp1A6EuGJLVP4/YmpeQitd5LeFRl7
        nJS5OsXPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3f9s-000116-7u; Fri, 30 Aug 2019 11:33:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74FA63035D7;
        Fri, 30 Aug 2019 13:32:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1355A200AB64F; Fri, 30 Aug 2019 13:33:34 +0200 (CEST)
Date:   Fri, 30 Aug 2019 13:33:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf/x86/intel: Update ICL Core and Package C-state
 event counters
Message-ID: <20190830113334.GF2369@hirez.programming.kicks-ass.net>
References: <20190726090846.6109-1-harry.pan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726090846.6109-1-harry.pan@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 05:08:46PM +0800, Harry Pan wrote:
> Ice Lake microarchitecture inherits Cannon Lake, it has CC1/PC8/PC9/PC10
> residency counters.
> 
> Update the list of Ice Lake PMU event counters from the snb_cstates[] list
> of events to the cnl_cstates[] list of events, which keeps all previously
> supported events and also adds the CORE_C1, PKG_C8, PKG_C9, and PKG_C10
> residency counters.
> 
> This benefits users to profile them through the perf interface.
> 
> Signed-off-by: Harry Pan <harry.pan@intel.com>
> 
> ---
> 
>  arch/x86/events/intel/cstate.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index 688592b34564..08291233f5c9 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -40,51 +40,53 @@
>   * Model specific counters:
>   *	MSR_CORE_C1_RES: CORE C1 Residency Counter
>   *			 perf code: 0x00
> - *			 Available model: SLM,AMT,GLM,CNL
> + *			 Available model: SLM,AMT,GLM,CNL,ICL
>   *			 Scope: Core (each processor core has a MSR)
>   *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
>   *			       perf code: 0x01
>   *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
> -						CNL
> +						CNL,ICL

That has a missing * introduced by the last such patch. Please take this
opportunity to put it back in.
