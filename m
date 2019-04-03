Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1894AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C3B20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDCDdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:33:22 -0400
Received: from foss.arm.com ([217.140.101.70]:59780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfDCDdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:33:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE52A80D;
        Tue,  2 Apr 2019 20:33:21 -0700 (PDT)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFBD03F721;
        Tue,  2 Apr 2019 20:33:19 -0700 (PDT)
Date:   Wed, 3 Apr 2019 04:33:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] drivers: firmware: psci: add support for warm reset
Message-ID: <20190403033314.k2wqxkm5c7imhtu5@blommer>
References: <20190401181443.6459-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401181443.6459-1-aaro.koskinen@iki.fi>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 09:14:43PM +0300, Aaro Koskinen wrote:
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> Add support for warm reset using SYSTEM_RESET2 introduced in PSCI
> 1.1 specification.

For reference, how do you intend to use this?

> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  drivers/firmware/psci.c   | 25 +++++++++++++++++++++++++
>  include/uapi/linux/psci.h |  3 +++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index c80ec1d03274..1d95b5f6d403 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -73,6 +73,7 @@ enum psci_function {
>  	PSCI_FN_CPU_ON,
>  	PSCI_FN_CPU_OFF,
>  	PSCI_FN_MIGRATE,
> +	PSCI_FN_SYSTEM_RESET2,
>  	PSCI_FN_MAX,
>  };
>  
> @@ -256,6 +257,14 @@ static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>  	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
>  }
>  
> +static void psci_sys_reset2(enum reboot_mode reboot_mode, const char *cmd)
> +{
> +	if (reboot_mode == REBOOT_WARM)
> +		invoke_psci_fn(psci_function_id[PSCI_FN_SYSTEM_RESET2], 0, 0, 0);
> +	else
> +		psci_sys_reset(reboot_mode, cmd);
> +}

What happens when RESET2 isn't available, but the user requests s REBOOT_WARM
reset? It looks like we'd invoke a bogus SMC.

Could we please add a preprocessor definition for SYSTEM_RESET_WARM so that
it's clear that we're passing a parameter here?

> +
>  static void psci_sys_poweroff(void)
>  {
>  	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> @@ -564,6 +573,20 @@ static void __init psci_0_2_set_functions(void)
>  	pm_power_off = psci_sys_poweroff;
>  }
>  
> +static void __init psci_1_1_set_functions(void)
> +{
> +	int sys_reset2;
> +	int feature;
> +
> +	sys_reset2 = PSCI_FN_NATIVE(1_1, SYSTEM_RESET2);
> +	feature	= psci_features(sys_reset2);
> +
> +	if (feature != PSCI_RET_NOT_SUPPORTED) {
> +		psci_function_id[PSCI_FN_SYSTEM_RESET2] = sys_reset2;
> +		arm_pm_restart = psci_sys_reset2;
> +	}
> +}
> +
>  /*
>   * Probe function for PSCI firmware versions >= 0.2
>   */
> @@ -588,6 +611,8 @@ static int __init psci_probe(void)
>  		psci_init_smccc();
>  		psci_init_cpu_suspend();
>  		psci_init_system_suspend();
> +		if (PSCI_VERSION_MINOR(ver) >= 1)
> +			psci_1_1_set_functions();
>  	}

If we're going to add more things to this chain, can we please refactor this as:

	if (ver < PSCI_VERSION(1, 0))
		return;

	/* PSCI 1.0 setup here */

	if (ver < PSCI_VERSION(1,1))
		return;

	/* PSCI 1.1 setup here */

... as that saves on indentation and is easier to extend in future.

Thanks,
Mark
