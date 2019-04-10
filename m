Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFAEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BCE217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ygu5Pn6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfDJHlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:41:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50818 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfDJHlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sB7rP349fMgKEWKgTDVO+kL+48Wd3pYpfCjRGsD9hz0=; b=Ygu5Pn6mGhQ5wHgHu40VX8rMe
        oOnYR3F14wNBm9mznG0izH9Zmvxe9pfmTVBGVPhB8LqIitF9p1sTpa4EKtx2zn/o1YJzFdCgi0QsX
        x1ZBRP/GVsIMaVh+B1XjSRyA+y7+0lEaNuBW9Or0qkKW54khWksORBVhWiwFrxidZ+bTVZG5qtwTO
        +6ACi6cG+y99MyN8Ag94WISOq+7XHTCex60BCX9U+hJcyzY3eUNiBW4rfyfYfPCGpfNu/SqjSgkMY
        kt0pFgPeUjFD0tMjWSca5d91BHO/RbygAG6+i7KcomGDraxQjGfaXq0B52UfY9PbAd36SZSydZ3ZI
        RjM+2z3BA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE7rY-0006Oz-T3; Wed, 10 Apr 2019 07:41:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F2C029B453E0; Wed, 10 Apr 2019 09:41:39 +0200 (CEST)
Date:   Wed, 10 Apr 2019 09:41:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 1/2] perf/x86/intel: Support adaptive PEBS for fixed
 counters
Message-ID: <20190410074139.GW11158@hirez.programming.kicks-ass.net>
References: <1554858600-148296-1-git-send-email-kan.liang@linux.intel.com>
 <1554858600-148296-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554858600-148296-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 06:09:59PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Fixed counters can also generate adaptive PEBS record, if the
> corresponding bit in IA32_FIXED_CTR_CTRL is set.
> Otherwise, only basic record is generated.
> 
> Unconditionally set the bit when PEBS is enabled on fixed counters.
> Let MSR_PEBS_CFG decide which format of PEBS record should be generated.
> There is no harmful to leave the bit set.

I'll merge this back into:

  Subject: perf/x86/intel: Support adaptive PEBSv4

such that this bug never existed, ok?

> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c      | 5 +++++
>  arch/x86/include/asm/perf_event.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 56df0f6..f34d92b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2174,6 +2174,11 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
>  	bits <<= (idx * 4);
>  	mask = 0xfULL << (idx * 4);
>  
> +	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
> +		bits |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
> +		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
> +	}
> +
>  	rdmsrl(hwc->config_base, ctrl_val);
>  	ctrl_val &= ~mask;
>  	ctrl_val |= bits;
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index dcb8bac..ce0dc88 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -33,6 +33,7 @@
>  #define HSW_IN_TX					(1ULL << 32)
>  #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
>  #define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
> +#define ICL_FIXED_0_ADAPTIVE				(1ULL << 32)
>  
>  #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
>  #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
> -- 
> 2.7.4
> 
