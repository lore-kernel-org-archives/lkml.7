Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB25C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E7F21BE5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408299AbfIYRJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:09:43 -0400
Received: from foss.arm.com ([217.140.110.172]:55148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437796AbfIYRJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:09:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B191570;
        Wed, 25 Sep 2019 10:09:42 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 021EE3F694;
        Wed, 25 Sep 2019 10:09:40 -0700 (PDT)
Date:   Wed, 25 Sep 2019 18:09:38 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V9 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20190925180938.6f3609f4@donnerap.cambridge.arm.com>
In-Reply-To: <1569377224-5755-3-git-send-email-peng.fan@nxp.com>
References: <1569377224-5755-1-git-send-email-peng.fan@nxp.com>
        <1569377224-5755-3-git-send-email-peng.fan@nxp.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 02:09:11 +0000
Peng Fan <peng.fan@nxp.com> wrote:

Hi,

> From: Peng Fan <peng.fan@nxp.com>
> 
> This mailbox driver implements a mailbox which signals transmitted data
> via an ARM smc (secure monitor call) instruction. The mailbox receiver
> is implemented in firmware and can synchronously return data when it
> returns execution to the non-secure world again.
> An asynchronous receive path is not implemented.
> This allows the usage of a mailbox to trigger firmware actions on SoCs
> which either don't have a separate management processor or on which such
> a core is not available. A user of this mailbox could be the SCP
> interface.
> 
> Modified from Andre Przywara's v2 patch
> https://lore.kernel.org/patchwork/patch/812999/
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Many thanks for the changes, that looks good to me now!

One tiny thing below, but anyway:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

> ---
>  drivers/mailbox/Kconfig                |   7 ++
>  drivers/mailbox/Makefile               |   2 +
>  drivers/mailbox/arm-smc-mailbox.c      | 167 +++++++++++++++++++++++++++++++++
>  include/linux/mailbox/arm-smccc-mbox.h |  20 ++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 drivers/mailbox/arm-smc-mailbox.c
>  create mode 100644 include/linux/mailbox/arm-smccc-mbox.h
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index ab4eb750bbdd..7707ee26251a 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -16,6 +16,13 @@ config ARM_MHU
>  	  The controller has 3 mailbox channels, the last of which can be
>  	  used in Secure mode only.
>  
> +config ARM_SMC_MBOX
> +	tristate "Generic ARM smc mailbox"
> +	depends on OF && HAVE_ARM_SMCCC
> +	help
> +	  Generic mailbox driver which uses ARM smc calls to call into
> +	  firmware for triggering mailboxes.
> +
>  config IMX_MBOX
>  	tristate "i.MX Mailbox"
>  	depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index c22fad6f696b..93918a84c91b 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
>  
>  obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
>  
> +obj-$(CONFIG_ARM_SMC_MBOX)	+= arm-smc-mailbox.o
> +
>  obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
>  
>  obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)	+= armada-37xx-rwtm-mailbox.o
> diff --git a/drivers/mailbox/arm-smc-mailbox.c b/drivers/mailbox/arm-smc-mailbox.c
> new file mode 100644
> index 000000000000..6f0b5fd6ad1b
> --- /dev/null
> +++ b/drivers/mailbox/arm-smc-mailbox.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016,2017 ARM Ltd.
> + * Copyright 2019 NXP
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>

We don't need this include anymore.

Cheers,
Andre.

> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox/arm-smccc-mbox.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +typedef unsigned long (smc_mbox_fn)(unsigned int, unsigned long,
> +				    unsigned long, unsigned long,
> +				    unsigned long, unsigned long,
> +				    unsigned long);
> +
> +struct arm_smc_chan_data {
> +	unsigned int function_id;
> +	smc_mbox_fn *invoke_smc_mbox_fn;
> +};
> +
> +static int arm_smc_send_data(struct mbox_chan *link, void *data)
> +{
> +	struct arm_smc_chan_data *chan_data = link->con_priv;
> +	struct arm_smccc_mbox_cmd *cmd = data;
> +	unsigned long ret;
> +
> +	if (ARM_SMCCC_IS_64(chan_data->function_id)) {
> +		ret = chan_data->invoke_smc_mbox_fn(chan_data->function_id,
> +						    cmd->args_smccc64[0],
> +						    cmd->args_smccc64[1],
> +						    cmd->args_smccc64[2],
> +						    cmd->args_smccc64[3],
> +						    cmd->args_smccc64[4],
> +						    cmd->args_smccc64[5]);
> +	} else {
> +		ret = chan_data->invoke_smc_mbox_fn(chan_data->function_id,
> +						    cmd->args_smccc32[0],
> +						    cmd->args_smccc32[1],
> +						    cmd->args_smccc32[2],
> +						    cmd->args_smccc32[3],
> +						    cmd->args_smccc32[4],
> +						    cmd->args_smccc32[5]);
> +	}
> +
> +	mbox_chan_received_data(link, (void *)ret);
> +
> +	return 0;
> +}
> +
> +static unsigned long __invoke_fn_hvc(unsigned int function_id,
> +				     unsigned long arg0, unsigned long arg1,
> +				     unsigned long arg2, unsigned long arg3,
> +				     unsigned long arg4, unsigned long arg5)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4,
> +		      arg5, 0, &res);
> +	return res.a0;
> +}
> +
> +static unsigned long __invoke_fn_smc(unsigned int function_id,
> +				     unsigned long arg0, unsigned long arg1,
> +				     unsigned long arg2, unsigned long arg3,
> +				     unsigned long arg4, unsigned long arg5)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4,
> +		      arg5, 0, &res);
> +	return res.a0;
> +}
> +
> +static const struct mbox_chan_ops arm_smc_mbox_chan_ops = {
> +	.send_data	= arm_smc_send_data,
> +};
> +
> +static struct mbox_chan *
> +arm_smc_mbox_of_xlate(struct mbox_controller *mbox,
> +		      const struct of_phandle_args *sp)
> +{
> +	return mbox->chans;
> +}
> +
> +static int arm_smc_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mbox_controller *mbox;
> +	struct arm_smc_chan_data *chan_data;
> +	int ret;
> +
> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +
> +	mbox->of_xlate = arm_smc_mbox_of_xlate;
> +	mbox->num_chans = 1;
> +	mbox->chans = devm_kzalloc(dev, sizeof(*mbox->chans), GFP_KERNEL);
> +	if (!mbox->chans)
> +		return -ENOMEM;
> +
> +	chan_data = devm_kzalloc(dev, sizeof(*chan_data), GFP_KERNEL);
> +	if (!chan_data)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32(dev->of_node, "arm,func-id",
> +				   &chan_data->function_id);
> +	if (ret)
> +		return ret;
> +
> +	if (of_device_is_compatible(dev->of_node, "arm,smc-mbox"))
> +		chan_data->invoke_smc_mbox_fn = __invoke_fn_smc;
> +	else
> +		chan_data->invoke_smc_mbox_fn = __invoke_fn_hvc;
> +
> +
> +	mbox->chans->con_priv = chan_data;
> +
> +	mbox->txdone_poll = false;
> +	mbox->txdone_irq = false;
> +	mbox->ops = &arm_smc_mbox_chan_ops;
> +	mbox->dev = dev;
> +
> +	platform_set_drvdata(pdev, mbox);
> +
> +	ret = devm_mbox_controller_register(dev, mbox);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "ARM SMC mailbox enabled.\n");
> +
> +	return ret;
> +}
> +
> +static int arm_smc_mbox_remove(struct platform_device *pdev)
> +{
> +	struct mbox_controller *mbox = platform_get_drvdata(pdev);
> +
> +	mbox_controller_unregister(mbox);
> +	return 0;
> +}
> +
> +static const struct of_device_id arm_smc_mbox_of_match[] = {
> +	{ .compatible = "arm,smc-mbox", },
> +	{ .compatible = "arm,hvc-mbox", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, arm_smc_mbox_of_match);
> +
> +static struct platform_driver arm_smc_mbox_driver = {
> +	.driver = {
> +		.name = "arm-smc-mbox",
> +		.of_match_table = arm_smc_mbox_of_match,
> +	},
> +	.probe		= arm_smc_mbox_probe,
> +	.remove		= arm_smc_mbox_remove,
> +};
> +module_platform_driver(arm_smc_mbox_driver);
> +
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("Generic ARM smc mailbox driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mailbox/arm-smccc-mbox.h b/include/linux/mailbox/arm-smccc-mbox.h
> new file mode 100644
> index 000000000000..d35fb89a77f5
> --- /dev/null
> +++ b/include/linux/mailbox/arm-smccc-mbox.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_ARM_SMCCC_MBOX_H_
> +#define _LINUX_ARM_SMCCC_MBOX_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct arm_smccc_mbox_cmd - ARM SMCCC message structure
> + * @args_smccc32/64:	actual usage of registers is up to the protocol
> + *			(within the SMCCC limits)
> + */
> +struct arm_smccc_mbox_cmd {
> +	union {
> +		u32 args_smccc32[6];
> +		u64 args_smccc64[6];
> +	};
> +};
> +
> +#endif /* _LINUX_ARM_SMCCC_MBOX_H_ */

