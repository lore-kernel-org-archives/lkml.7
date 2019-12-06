Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC0C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4DE24659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ik58BICk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfLFKkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:40:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47166 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLFKkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fgNNXE243Z78C2Vrn2IpnFR/JH6GNPrsQTpTxQybzKQ=; b=ik58BICkOkXgAVcc3yKuQCUXK
        lW+EWh2mmEXw+ESs11NEZSjmAYetfCNELNjwok654TJLNOS23xIt+3ZNi1U9Ej2dJLNIyaAdn6uW+
        RmrQEWxcQEvN3B1ZEBQoLBtp9e5//hdm/pb80WPJ0A4wLaMQzbCRAnioSQ2iq9PbdHSObfXu3OWxK
        IvBFrDPnbF5fJS4TA5nA4z6oYBDb4x/1wHK8970ZvVVPMKYLN4l1C8jx2i3CKJl2dnQcXuU2vz94S
        6Nik+wxJ1pj5PRf0YNf2EIgTv8V21q91mAjPlSDHtF3JIoLxCrkyXUe0ceJGEKRQOq2juSwFL5LlA
        gFcpTBKiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idB1V-0005BH-0y; Fri, 06 Dec 2019 10:39:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E508303F45;
        Fri,  6 Dec 2019 11:38:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F20152B26E210; Fri,  6 Dec 2019 11:39:42 +0100 (CET)
Date:   Fri, 6 Dec 2019 11:39:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "malat@debian.org" <malat@debian.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH] x86/tsc: Don't use cpuid 0x16 leaf to determine cpu
 speed.
Message-ID: <20191206103942.GE2844@hirez.programming.kicks-ass.net>
References: <SoluZg51N39Rx0tDCSJFbEvvgMrDnJ_g0RdRdN5mtCfag4GahIOPfok7UbkyeO5Qpl3wUHp8H8y73JtClcZvr1ARSIOBIFQAne0Z712el8M=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SoluZg51N39Rx0tDCSJFbEvvgMrDnJ_g0RdRdN5mtCfag4GahIOPfok7UbkyeO5Qpl3wUHp8H8y73JtClcZvr1ARSIOBIFQAne0Z712el8M=@protonmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 07:15:03PM +0000, Krzysztof Piecuch wrote:
> This patch corrects tsc drift on systems with changed base clock frequency
> (e.g. overclocking).
> 
> We can't use 0x16 cpu leaf as it's documented as "not reflecting actual
> values" and is supposed to be used only as a mean to determine "processor
> brand string and for determining the appropriate range to use when
> displaying processor information e.g. frequency history graphs".

What is the actual problem you're seeing? Because if CPUID.16h is used,
we don't set KNOWN_FREQ and will thus run tsc_refine_calibration_work()
(against HPET/PIT) later.

The CPUIS.16h value is only used as an initial guess.

> Signed-off-by: Krzysztof Piecuch <piecuch@protonmail.com>
> ---
>  arch/x86/kernel/tsc.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 7e322e2daaf5..fc9a000a814c 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -641,29 +641,16 @@ unsigned long native_calibrate_tsc(void)
>  			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_D)
>  		crystal_khz = 25000;
> 
> +	if (crystal_khz == 0)
> +		return 0;
> +
>  	/*
>  	 * TSC frequency reported directly by CPUID is a "hardware reported"
>  	 * frequency and is the most accurate one so far we have. This
>  	 * is considered a known frequency.
>  	 */
> -	if (crystal_khz != 0)
> -		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> -
> -	/*
> -	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
> -	 * clock, but we can easily calculate it to a high degree of accuracy
> -	 * by considering the crystal ratio and the CPU speed.
> -	 */
> -	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= 0x16) {
> -		unsigned int eax_base_mhz, ebx, ecx, edx;
> -
> -		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
> -		crystal_khz = eax_base_mhz * 1000 *
> -			eax_denominator / ebx_numerator;
> -	}
> 
> -	if (crystal_khz == 0)
> -		return 0;
> +	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> 
>  	/*
>  	 * For Atom SoCs TSC is the only reliable clocksource.

This completely screws over everything that doesn't have HPET/PIT and
doesn't have a useful CPUID.15h.

If you're on a system that has no HPET/PIT and also doesn't have a
useful CPUID.15h and CPUID.16h is wrong, then you're up a creek without
paddles.

So please, be more specific in your problem description.
