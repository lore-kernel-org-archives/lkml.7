Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB87C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D43520811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfCZVaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:30:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49532 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbfCZVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:30:02 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8tdp-0006le-Dw; Tue, 26 Mar 2019 22:29:53 +0100
Date:   Tue, 26 Mar 2019 22:29:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [RFC PATCH v2 13/14] watchdog/hardlockup/hpet: Only enable the
 HPET watchdog via a boot parameter
In-Reply-To: <1551283518-18922-14-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903262223330.1789@nanos.tec.linutronix.de>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1551283518-18922-14-git-send-email-ricardo.neri-calderon@linux.intel.com>
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

On Wed, 27 Feb 2019, Ricardo Neri wrote:
> +			When hpet is specified, the NMI watchdog will be driven
> +			by an HPET timer, if available in the system. Otherwise,
> +			the perf-based implementation will be used. Specifying
> +			hpet implies that nmi_watchdog is on.

How so?

> +static int __init hardlockup_detector_hpet_setup(char *str)
> +{
> +	if (strstr(str, "hpet"))
> +		hardlockup_use_hpet = true;

strstr()? Not really.

> +
> +	return 0;
> +}
> +__setup("nmi_watchdog=", hardlockup_detector_hpet_setup);
> +
>  /**
>   * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
>   *
> @@ -405,6 +422,9 @@ int __init hardlockup_detector_hpet_init(void)
>  {
>  	int ret;
>  
> +	if (!hardlockup_use_hpet)
> +		return -ENODEV;

This should have been there in the patch which introduces
hardlockup_detector_hpet_init(). And this patch merily adds the command
line magic which sets that flag.

> +
>  	if (!is_hpet_enabled())
>  		return -ENODEV;
>  
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 367aa81294ef..28cad7310378 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -78,7 +78,7 @@ static int __init hardlockup_panic_setup(char *str)
>  		nmi_watchdog_user_enabled = 0;
>  	else if (!strncmp(str, "1", 1))
>  		nmi_watchdog_user_enabled = 1;
> -	return 1;
> +	return 0;

Why?

Thanks,

	tglx


