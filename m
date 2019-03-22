Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97661C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C8221925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RXHuvxKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfCVRI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:08:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51328 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfCVRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y/SDMualcy90uB9a78NRZwOtAxZtmRvJztAn99Durk8=; b=RXHuvxKXaVr1j8OO2rQwq9cuX
        htXX0RPGjIrOMhODd9vYFCW4wzBrBwtICwCE7TIYgt4P+k2k2baD4AzxVL0pswmpNHH7jLKqs+xYX
        hqHwBwdDV9vjwvDSWpDLd7Hnk4Bv9ucRJC0WOyD99dcvxXv6s0FxGDMyUSEO96eLbZEJ/rsu0uPt9
        fl8Q8uIFQDAx54ys5Mh+IUWGcb+pFqmYGRQmOE6aMdv2F4BGsqaeqYfzGK2HSLR4DAhjjDkYpUlQF
        /fy2fS8AIb+BOECGl9rh31oqqs+BJ2Aq7n2+gkoOuDjXYLyK30BEyuiewq2jUhscUiTnuL/59RwXt
        +F+KXF2SA==;
Received: from [31.161.229.66] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7Neu-0003eJ-A1; Fri, 22 Mar 2019 17:08:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E36A983858; Fri, 22 Mar 2019 18:08:41 +0100 (CET)
Date:   Fri, 22 Mar 2019 18:08:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V3 01/23] perf/x86: Support outputting XMM registers
Message-ID: <20190322170841.GJ7905@worktop.programming.kicks-ass.net>
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
 <20190322163718.2191-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322163718.2191-2-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 09:36:56AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Starting from Icelake, XMM registers can be collected in PEBS record.
> But current code only output the pt_regs.
> 
> Add a new struct x86_perf_regs for both pt_regs and xmm_regs.
> XMM registers are 128 bit. To simplify the code, they are handled like
> two different registers, which means setting two bits in the register
> bitmap. This also allows only sampling the lower 64bit bits in XMM.
> The index of XMM registers starts from 32. There are 16 XMM registers.
> So all reserved space for regs are used.
> PERF_REG_X86_MAX stands for the max number of all x86 regs include XMM.
> PERF_REG_GPR_X86_MAX stands for the max number of all x86 general
> purpose registers, which not include XMM.
> PERF_REG_GPR_X86_32_MAX and PERF_REG_GPR_X86_64_MAX are introduced to
> replace PERF_REG_X86_32_MAX and PERF_REG_X86_64_MAX for x86 general
> purpose registers.
> 
> The REG_RESERVED is also updated to allow the XMM registers.
> XMM is not supported on all platforms. Adding has_xmm_regs to indicate
> the specific platform. Also add checks in x86_pmu_hw_config() to reject
> invalid config of regs_user and regs_intr.

> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index f3329cabce5c..b33995313d17 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -28,7 +28,29 @@ enum perf_event_x86_regs {
>  	PERF_REG_X86_R14,
>  	PERF_REG_X86_R15,
>  
> -	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
> -	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,

So this changes UAPI visible symbols... did we think about that?

> +	/* These all need two bits set because they are 128bit */
> +	PERF_REG_X86_XMM0  = 32,
> +	PERF_REG_X86_XMM1  = 34,
> +	PERF_REG_X86_XMM2  = 36,
> +	PERF_REG_X86_XMM3  = 38,
> +	PERF_REG_X86_XMM4  = 40,
> +	PERF_REG_X86_XMM5  = 42,
> +	PERF_REG_X86_XMM6  = 44,
> +	PERF_REG_X86_XMM7  = 46,
> +	PERF_REG_X86_XMM8  = 48,
> +	PERF_REG_X86_XMM9  = 50,
> +	PERF_REG_X86_XMM10 = 52,
> +	PERF_REG_X86_XMM11 = 54,
> +	PERF_REG_X86_XMM12 = 56,
> +	PERF_REG_X86_XMM13 = 58,
> +	PERF_REG_X86_XMM14 = 60,
> +	PERF_REG_X86_XMM15 = 62,
> +
> +	/* This does not include the XMMX registers */
> +	PERF_REG_GPR_X86_32_MAX = PERF_REG_X86_GS + 1,
> +	PERF_REG_GPR_X86_64_MAX = PERF_REG_X86_R15 + 1,
> +
> +	/* All registers include the XMMX registers */
> +	PERF_REG_X86_MAX = PERF_REG_X86_XMM15 + 2,
>  };
>  #endif /* _ASM_X86_PERF_REGS_H */

Also, what happens if we run a 32bit kernel or 32bit compat task?

Then the register dump will report PERF_SAMPLE_REGS_ABI_32, should we
then still interpret the XMM registers as 2x64bit?

Are they still at the same offset?

Do we need additional PERF_SAMPLE_REGS_ABI_* definitions for this?
