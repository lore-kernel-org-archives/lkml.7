Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57E0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF57022BED
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbfHGIEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:04:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51051 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfHGIEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:04:31 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hvGvs-000855-EI; Wed, 07 Aug 2019 10:04:28 +0200
Message-ID: <1565165066.5048.2.camel@pengutronix.de>
Subject: Re: [PATCH v2 5/5] reset: Add support for resets provided by SCMI
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        aidapala@qti.qualcomm.com, pajay@qti.qualcomm.com,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wesleys@xilinx.com, Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>
Date:   Wed, 07 Aug 2019 10:04:26 +0200
In-Reply-To: <20190806170208.6787-6-sudeep.holla@arm.com>
References: <20190806170208.6787-1-sudeep.holla@arm.com>
         <20190806170208.6787-6-sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 18:02 +0100, Sudeep Holla wrote:
> On some ARM based systems, a separate Cortex-M based System Control
> Processor(SCP) provides the overall power, clock, reset and system
> control. System Control and Management Interface(SCMI) Message Protocol
> is defined for the communication between the Application Cores(AP)
> and the SCP.
> 
> Adds support for the resets provided using SCMI protocol for performing
> reset management of various devices present on the SoC. Various reset
> functionalities are achieved by the means of different ARM SCMI device
> operations provided by the ARM SCMI framework.
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  MAINTAINERS                |   1 +
>  drivers/reset/Kconfig      |  11 ++++
>  drivers/reset/Makefile     |   1 +
>  drivers/reset/reset-scmi.c | 126 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 139 insertions(+)
>  create mode 100644 drivers/reset/reset-scmi.c
> 
> v1->v2:
> 	- Renamed RESET_ARM_SCMI to RESET_SCMI and reworded Kconfig text
> 	- Dropped unused struct device pointer from scmi_reset_data
> 	- Added to_scmi_handle which helped to remove some repetitive code
> 	- Fixed some doxygen comments
> 	- Initialised rcdev.nr_resets
> 	- Fixed MODULE_DESCRIPTION
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6426db5198f0..f4af5c59c116 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15545,6 +15545,7 @@ F:	drivers/clk/clk-sc[mp]i.c
>  F:	drivers/cpufreq/sc[mp]i-cpufreq.c
>  F:	drivers/firmware/arm_scpi.c
>  F:	drivers/firmware/arm_scmi/
> +F:	drivers/reset/reset-scmi.c
>  F:	include/linux/sc[mp]i_protocol.h
>  
>  SYSTEM RESET/SHUTDOWN DRIVERS
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 21efb7d39d62..4178ac11ba85 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -116,6 +116,17 @@ config RESET_QCOM_PDC
>  	  to control reset signals provided by PDC for Modem, Compute,
>  	  Display, GPU, Debug, AOP, Sensors, Audio, SP and APPS.
>  
> +config RESET_SCMI
> +	tristate "Reset driver controlled via ARM SCMI interface"
> +	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> +	default ARM_SCMI_PROTOCOL
> +	help
> +	  This driver provides support for reset signal/domains that are
> +	  controlled by firmware that implements the SCMI interface.
> +
> +	  This driver uses SCMI Message Protocol to interact with the
> +	  firmware controlling all the reset signals.
> +
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
>  	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 61456b8f659c..cf60ce526064 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>  obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
>  obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
>  obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
> +obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
>  obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>  obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
>  obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
> diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
> new file mode 100644
> index 000000000000..5e976a02a6cc
> --- /dev/null
> +++ b/drivers/reset/reset-scmi.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM System Control and Management Interface (ARM SCMI) reset driver
> + *
> + * Copyright (C) 2019 ARM Ltd.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mutex.h>

You can drop mutex.h, it is unused.

> +#include <linux/of.h>
> +#include <linux/platform_device.h>

This is not a platform device driver. Better replace this with

#include <linux/device.h>

> +#include <linux/reset-controller.h>
> +#include <linux/scmi_protocol.h>
> +
> +/**
> + * struct scmi_reset_data - reset controller information structure
> + * @rcdev: reset controller entity
> + * @handle: ARM SCMI handle used for communication with system controller
> + * @dev: reset controller device pointer

Drop this line, dev has been removed from struct scmi_reset_data.

> + */
> +struct scmi_reset_data {
> +	struct reset_controller_dev rcdev;
> +	const struct scmi_handle *handle;
> +};
> +
> +#define to_scmi_reset_data(p)	container_of((p), struct scmi_reset_data, rcdev)
> +#define to_scmi_handle(p)	(to_scmi_reset_data(p)->handle)
[...]

Apart from these,
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
