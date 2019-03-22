Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB630C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751D1218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="b6bLss9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfCVO20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:28:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36922 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbfCVO2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:28:25 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35C441EC00FF;
        Fri, 22 Mar 2019 15:28:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553264904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xROtQ3lPB34jz8QZgjrxqlObnm92aodmjQzoFMjYC7M=;
        b=b6bLss9lHSosC9ZX5ABsBjMDCXuViAaXiCOAELSagxAFG0F0Qs4B5PappTlmXKUHzNHhrI
        GfpLmzRw83WKWB+nVGKYlDAGFLYJMX1n8ka2u8u2j/ObR6zCW4sKSEtd1AfghYKMVvIT85
        ZIqNkFq1l1N5xhO2HlcesDAd2T4Pba8=
Date:   Fri, 22 Mar 2019 15:28:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Message-ID: <20190322142828.GA12472@zn.tnic>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1605148.8jT99SsvVP@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1605148.8jT99SsvVP@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:18:01PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current handling of MSR_IA32_ENERGY_PERF_BIAS in the kernel is
> problematic, because it may cause changes made by user space to that
> MSR (with the help of the x86_energy_perf_policy tool, for example)

One more reason to control MSR accesses from userspace. I'm working on
a series to even completely forbid accesses to some MSRs over /dev/msr
so I think accessing MSR_IA32_ENERGY_PERF_BIAS solely over the new
interface in patch 2 would be much better.

So, you're carrying those and you'd like to have an ACK from me?

Btw, a couple of nitpicks below.

> Index: linux-pm/arch/x86/kernel/cpu/intel_epb.c
> ===================================================================
> --- /dev/null
> +++ linux-pm/arch/x86/kernel/cpu/intel_epb.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0

...

> +static DEFINE_PER_CPU(u8, saved_epb);
> +
> +#define EPB_MASK	0x0fULL
> +#define EPB_SAVED	0x10ULL
> +
> +static int intel_epb_save(void)

I'd drop that "intel_epb_" prefix from those static functions, but your
call...

> +{
> +	u64 epb;
> +
> +	rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> +	/*
> +	 * Ensure that saved_epb will always be nonzero after this write even if
> +	 * the EPB value read from the MSR is 0.
> +	 */
> +	this_cpu_write(saved_epb, (epb & EPB_MASK) | EPB_SAVED);
> +
> +	return 0;
> +}

...

> Index: linux-pm/Documentation/admin-guide/pm/intel_epb.rst
> ===================================================================
> --- /dev/null
> +++ linux-pm/Documentation/admin-guide/pm/intel_epb.rst

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#345: FILE: Documentation/admin-guide/pm/intel_epb.rst:1:
+======================================

> @@ -0,0 +1,6 @@
> +======================================
> +Intel Performance and Energy Bias Hint
> +======================================
> +
> +.. kernel-doc:: arch/x86/kernel/cpu/intel_epb.c
> +   :doc: overview
> Index: linux-pm/Documentation/admin-guide/pm/working-state.rst
> ===================================================================
> --- linux-pm.orig/Documentation/admin-guide/pm/working-state.rst
> +++ linux-pm/Documentation/admin-guide/pm/working-state.rst
> @@ -8,3 +8,4 @@ Working-State Power Management
>     cpuidle
>     cpufreq
>     intel_pstate
> +   intel_epb
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
