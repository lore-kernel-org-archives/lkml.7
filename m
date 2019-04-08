Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35953C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B6D20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDHMEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:04:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDHMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:04:13 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hDT01-0003go-Hu; Mon, 08 Apr 2019 14:03:41 +0200
Date:   Mon, 8 Apr 2019 14:03:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     You-Sheng Yang <vicamo@gmail.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Xiaoming Gao <gxm.linux.kernel@gmail.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chuanhua Lei <chuanhua.lei@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tsc: mark tsc reliable on CoffeeLake
In-Reply-To: <20190408104012.26791-1-vicamo@gmail.com>
Message-ID: <alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de>
References: <20190408104012.26791-1-vicamo@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019, You-Sheng Yang wrote:

> From: You-Sheng Yang <vicamo.yang@canonical.com>
> 
> On Intel CoffeeLake it's observed tsc is always marked unstable
> unexpectedly after entering idle state Package C10(PC10), and then clock
> source is switched to hpet. This patch marks tsc as reliable when CPUID
> matches CoffeeLake.

This lacks a proper analysis:

  1) Why is it marked unstable

  2) Why is it correct to set that for coffeelake
 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203183
> Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
> ---
>  arch/x86/kernel/tsc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index aab0c82e0a0d..2abbadc9cff0 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1161,6 +1161,16 @@ static void __init check_system_tsc_reliable(void)
>  #endif
>  	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
>  		tsc_clocksource_reliable = 1;
> +
> +	/*
> +	 * On Intel CoffeeLake, tsc may be marked unstable unexpectedly after
> +	 * entering PC10.
> +	 */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> +	    (boot_cpu_data.x86_model == INTEL_FAM6_KABYLAKE_MOBILE ||
> +	     boot_cpu_data.x86_model == INTEL_FAM6_KABYLAKE_DESKTOP) &&
> +	    boot_cpu_data.x86_stepping >= 0x0a)
> +		tsc_clocksource_reliable = 1;

No. We are not starting that family/model/stepping game especially not
with random stepping cutoffs which are pulled out of thin air.  That's
going to spiral out of control sooner than later.

There must be a better way to do that. Rafael?

Thanks,

	tglx


