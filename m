Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A6DC004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8D12075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfF0UiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:38:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59801 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0UiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:38:23 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgb9r-0007t0-7w; Thu, 27 Jun 2019 22:38:15 +0200
Date:   Thu, 27 Jun 2019 22:38:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Alan Cox <alan.cox@intel.com>, Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordan Borgner <mail@jordan-borgner.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Mohammad Etemadi <mohammad.etemadi@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Feiner <pfeiner@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] x86/cpu/intel: Clear cache self-snoop capability in
 CPUs with known errata
In-Reply-To: <1561660997-21562-2-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906272231060.32342@nanos.tec.linutronix.de>
References: <1561660997-21562-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1561660997-21562-2-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo,

On Thu, 27 Jun 2019, Ricardo Neri wrote:
>  
> +/*
> + * Processors which have self-snooping capability can handle conflicting
> + * memory type across CPUs by snooping its own cache. However, there exists
> + * CPU models in which having conflicting memory types still leads to
> + * unpredictable behavior, machine check errors, or hangs. Clear this feature
> + * to prevent its use. For instance, the algorithm to program the Memory Type
> + * Region Registers and the Page Attribute Table MSR can skip expensive cache
> + * flushes if self-snooping is supported.

I appreciate informative comments, but this is the part which disables a
feature on errata inflicted CPUs. So the whole information about what
self-snooping helps with is not that interesting here. It's broken, we
disable it and be done with it.

> + */
> +static void check_memory_type_self_snoop_errata(struct cpuinfo_x86 *c)
> +{
> +	switch (c->x86_model) {
> +	case INTEL_FAM6_CORE_YONAH:
> +	case INTEL_FAM6_CORE2_MEROM:
> +	case INTEL_FAM6_CORE2_MEROM_L:
> +	case INTEL_FAM6_CORE2_PENRYN:
> +	case INTEL_FAM6_CORE2_DUNNINGTON:
> +	case INTEL_FAM6_NEHALEM:
> +	case INTEL_FAM6_NEHALEM_G:
> +	case INTEL_FAM6_NEHALEM_EP:
> +	case INTEL_FAM6_NEHALEM_EX:
> +	case INTEL_FAM6_WESTMERE:
> +	case INTEL_FAM6_WESTMERE_EP:
> +	case INTEL_FAM6_SANDYBRIDGE:
> +		setup_clear_cpu_cap(X86_FEATURE_SELFSNOOP);
> +	}
> +}
> +

But looking at the actual interesting part of the 2nd patch:

> @@ -743,7 +743,9 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
>        /* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
>        cr0 = read_cr0() | X86_CR0_CD;
>        write_cr0(cr0);
> -       wbinvd();
> +
> +       if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
> +               wbinvd();

This part lacks any form of explanation. So I'd rather have the comment
about why we can avoid the wbindv() here. I''d surely never would look at
that errata handling function to get that information.

Other than that detail, the patches are well done!

Thanks,

	tglx
