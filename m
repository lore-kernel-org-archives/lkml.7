Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAA720848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbfCARD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:03:59 -0500
Received: from foss.arm.com ([217.140.101.70]:39220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfCARD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:03:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 265D080D;
        Fri,  1 Mar 2019 09:03:59 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 595013F575;
        Fri,  1 Mar 2019 09:03:57 -0800 (PST)
Date:   Fri, 1 Mar 2019 17:03:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] drivers: firmware: psci: Move psci to separate
 directory
Message-ID: <20190301170354.GO15517@lakrids.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228135919.3747-2-ulf.hansson@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:59:13PM +0100, Ulf Hansson wrote:
> Some following changes extends the PSCI driver with some additional new
> files.  Let's avoid to continue cluttering the toplevel firmware directory
> and first move the PSCI files into a PSCI sub-directory.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/firmware/Kconfig                   | 15 +--------------
>  drivers/firmware/Makefile                  |  3 +--
>  drivers/firmware/psci/Kconfig              | 13 +++++++++++++
>  drivers/firmware/psci/Makefile             |  4 ++++
>  drivers/firmware/{ => psci}/psci.c         |  0
>  drivers/firmware/{ => psci}/psci_checker.c |  0
>  6 files changed, 19 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/firmware/psci/Kconfig
>  create mode 100644 drivers/firmware/psci/Makefile
>  rename drivers/firmware/{ => psci}/psci.c (100%)
>  rename drivers/firmware/{ => psci}/psci_checker.c (100%)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index f754578414f0..e1385f47d4ac 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -5,20 +5,6 @@
>  
>  menu "Firmware Drivers"
>  
> -config ARM_PSCI_FW
> -	bool
> -
> -config ARM_PSCI_CHECKER
> -	bool "ARM PSCI checker"
> -	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
> -	help
> -	  Run the PSCI checker during startup. This checks that hotplug and
> -	  suspend operations work correctly when using PSCI.
> -
> -	  The torture tests may interfere with the PSCI checker by turning CPUs
> -	  on and off through hotplug, so for now torture tests and PSCI checker
> -	  are mutually exclusive.
> -
>  config ARM_SCMI_PROTOCOL
>  	bool "ARM System Control and Management Interface (SCMI) Message Protocol"
>  	depends on ARM || ARM64 || COMPILE_TEST
> @@ -270,6 +256,7 @@ config TI_SCI_PROTOCOL
>  config HAVE_ARM_SMCCC
>  	bool
>  
> +source "drivers/firmware/psci/Kconfig"
>  source "drivers/firmware/broadcom/Kconfig"
>  source "drivers/firmware/google/Kconfig"
>  source "drivers/firmware/efi/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 80feb635120f..9a3909a22682 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -2,8 +2,6 @@
>  #
>  # Makefile for the linux kernel.
>  #
> -obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> -obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
>  obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
>  obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
> @@ -25,6 +23,7 @@ CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQU
>  obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL)	+= arm_scmi/
> +obj-y				+= psci/
>  obj-y				+= broadcom/
>  obj-y				+= meson/
>  obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
> new file mode 100644
> index 000000000000..26a3b32bf7ab
> --- /dev/null
> +++ b/drivers/firmware/psci/Kconfig
> @@ -0,0 +1,13 @@
> +config ARM_PSCI_FW
> +	bool
> +
> +config ARM_PSCI_CHECKER
> +	bool "ARM PSCI checker"
> +	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
> +	help
> +	  Run the PSCI checker during startup. This checks that hotplug and
> +	  suspend operations work correctly when using PSCI.
> +
> +	  The torture tests may interfere with the PSCI checker by turning CPUs
> +	  on and off through hotplug, so for now torture tests and PSCI checker
> +	  are mutually exclusive.
> diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> new file mode 100644
> index 000000000000..1956b882470f
> --- /dev/null
> +++ b/drivers/firmware/psci/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> +obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci/psci.c
> similarity index 100%
> rename from drivers/firmware/psci.c
> rename to drivers/firmware/psci/psci.c
> diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> similarity index 100%
> rename from drivers/firmware/psci_checker.c
> rename to drivers/firmware/psci/psci_checker.c
> -- 
> 2.17.1
> 
