Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9921CC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6470821A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbfIIPmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:42:21 -0400
Received: from foss.arm.com ([217.140.110.172]:52778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388577AbfIIPmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:42:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 156F1169E;
        Mon,  9 Sep 2019 08:42:20 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5B4F3F59C;
        Mon,  9 Sep 2019 08:42:18 -0700 (PDT)
Date:   Mon, 9 Sep 2019 16:42:16 +0100
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
Subject: Re: [PATCH v5 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20190909164216.0abe640b@donnerap.cambridge.arm.com>
In-Reply-To: <1567004515-3567-3-git-send-email-peng.fan@nxp.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
        <1567004515-3567-3-git-send-email-peng.fan@nxp.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 03:03:02 +0000
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
> ---
>  drivers/mailbox/Kconfig           |   7 ++
>  drivers/mailbox/Makefile          |   2 +
>  drivers/mailbox/arm-smc-mailbox.c | 215 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 drivers/mailbox/arm-smc-mailbox.c
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
> index 000000000000..76a2ae11ee4d
> --- /dev/null
> +++ b/drivers/mailbox/arm-smc-mailbox.c
> @@ -0,0 +1,215 @@
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
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define ARM_SMC_MBOX_MEM_TRANS	BIT(0)
> +
> +struct arm_smc_chan_data {
> +	u32 function_id;
> +	u32 chan_id;
> +	u32 flags;
> +};
> +
> +struct arm_smccc_mbox_cmd {
> +	unsigned long a0, a1, a2, a3, a4, a5, a6, a7;

I think this is one or even two registers too long?
The SMCCC speaks of the function ID in x0/r0 and six arguments, with a "client ID" being an optional seventh argument. Looking at the description there I believe we cannot use the client ID here for this purpose, as this is supposed to be set by a hypervisor before passing on an SMC to EL3 firmware. KVM does not allow passing on SMCs in this way.

Also, while using "long" in here seems to make sense from the mailbox and SMC point of view, aliasing this to the mailbox client provided data seems dangerous to me, as this exposes the difference between arm32 and arm64 to the client. I think this is not what we want, the client should not be architecture specific.

> +};
> +
> +typedef unsigned long (smc_mbox_fn)(unsigned long, unsigned long,
> +				    unsigned long, unsigned long,
> +				    unsigned long, unsigned long,
> +				    unsigned long, unsigned long);
> +static smc_mbox_fn *invoke_smc_mbox_fn;
> +
> +static int arm_smc_send_data(struct mbox_chan *link, void *data)
> +{
> +	struct arm_smc_chan_data *chan_data = link->con_priv;
> +	struct arm_smccc_mbox_cmd *cmd = data;
> +	unsigned long ret;
> +	u32 function_id;
> +	u32 chan_id;
> +
> +	if (chan_data->flags & ARM_SMC_MBOX_MEM_TRANS) {
> +		if (chan_data->function_id != UINT_MAX)
> +			function_id = chan_data->function_id;
> +		else
> +			function_id = cmd->a0;

This is somewhat surprising, dangerous and undocumented. We should *not* allow mailbox clients to specify the function ID. They could end up using PSCI function IDs, for instance, that sounds especially scary if a client driver allows userland to set parameters of some sort.
The function ID is presumably allocated and fixed in the firmware, so it should not be dynamic. Any dynamic properties should be done within a function ID on the protocol level, by using r1/x1, for instance.

> +		chan_id = chan_data->chan_id;

Why is this here? Where is this documented? Isn't this redundant with function ID? Or is this meant to be a replacement for it when a client provided function ID is used (which is not desired, as mentioned above)?

> +		ret = invoke_smc_mbox_fn(function_id, chan_id, 0, 0, 0, 0,
> +					 0, 0);
> +	} else {
> +		ret = invoke_smc_mbox_fn(cmd->a0, cmd->a1, cmd->a2, cmd->a3,
> +					 cmd->a4, cmd->a5, cmd->a6, cmd->a7);
> +	}

As mentioned in my reply to the binding patch, I don't see this is necessary. Instead of ignoring the client provided data, we should just always pass it on. If clients and protocols don't use them, the client could zero it as well, letting the firmware side ignore it.

Also this underlines the problem with using "long" above: For 32-bit and 64-bit kernels the layout would be different.
I think the size of each argument should be determined by the calling convention class (bit 30) of the function ID.
The client doesn't know about that one (it's a controller/firmware property), so this driver here should split up the stream of data according to SMC64 vs. SMC32.
Does that make sense?

> +
> +	mbox_chan_received_data(link, (void *)ret);

Not a mailbox expert, but shouldn't we mark the TX operation as complete here? Clearly by returning from the SMC the firmware has received the request.
Whether the requested action has completed, is a protocol / mailbox client question.

> +
> +	return 0;
> +}
> +
> +static unsigned long __invoke_fn_hvc(unsigned long function_id,
> +				     unsigned long arg0, unsigned long arg1,
> +				     unsigned long arg2, unsigned long arg3,
> +				     unsigned long arg4, unsigned long arg5,
> +				     unsigned long arg6)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4,
> +		      arg5, arg6, &res);
> +	return res.a0;
> +}
> +
> +static unsigned long __invoke_fn_smc(unsigned long function_id,
> +				     unsigned long arg0, unsigned long arg1,
> +				     unsigned long arg2, unsigned long arg3,
> +				     unsigned long arg4, unsigned long arg5,
> +				     unsigned long arg6)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4,
> +		      arg5, arg6, &res);
> +	return res.a0;
> +}
> +
> +static const struct mbox_chan_ops arm_smc_mbox_chan_ops = {
> +	.send_data	= arm_smc_send_data,
> +};
> +
> +static int arm_smc_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mbox_controller *mbox;
> +	struct arm_smc_chan_data *chan_data;
> +	const char *method;
> +	bool mem_trans = false;
> +	int ret, i;
> +	u32 val;
> +
> +	if (!of_property_read_u32(dev->of_node, "arm,num-chans", &val)) {
> +		if (!val) {
> +			dev_err(dev, "invalid arm,num-chans value %u\n", val);
> +			return -EINVAL;
> +		}
> +	} else {
> +		return -EINVAL;
> +	}

As mentioned, this property should be removed, ...

> +
> +	if (!of_property_read_string(dev->of_node, "transports", &method)) {
> +		if (!strcmp("mem", method)) {
> +			mem_trans = true;
> +		} else if (!strcmp("reg", method)) {
> +			mem_trans = false;
> +		} else {
> +			dev_warn(dev, "invalid \"transports\" property: %s\n",
> +				 method);
> +
> +			return -EINVAL;
> +		}
> +	} else {
> +		return -EINVAL;
> +	}

... and this one as well.

> +
> +	if (!of_property_read_string(dev->of_node, "method", &method)) {
> +		if (!strcmp("hvc", method)) {
> +			invoke_smc_mbox_fn = __invoke_fn_hvc;
> +		} else if (!strcmp("smc", method)) {
> +			invoke_smc_mbox_fn = __invoke_fn_smc;
> +		} else {
> +			dev_warn(dev, "invalid \"method\" property: %s\n",
> +				 method);

Just a nit, but if this is fatal for the driver, it should be dev_err().

> +
> +			return -EINVAL;
> +		}
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +
> +	mbox->num_chans = val;

This could be replaced with:
	mbox->num_chans = of_property_count_elems_of_size(dev_of_node(dev),
                                     "arm,func-ids", sizeof(u32));

> +	mbox->chans = devm_kcalloc(dev, mbox->num_chans, sizeof(*mbox->chans),
> +				   GFP_KERNEL);
> +	if (!mbox->chans)
> +		return -ENOMEM;
> +
> +	chan_data = devm_kcalloc(dev, mbox->num_chans, sizeof(*chan_data),
> +				 GFP_KERNEL);
> +	if (!chan_data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < mbox->num_chans; i++) {
> +		u32 function_id;
> +
> +		ret = of_property_read_u32_index(dev->of_node,
> +						 "arm,func-ids", i,
> +						 &function_id);
> +		if (ret)
> +			chan_data[i].function_id = UINT_MAX;
> +
> +		else
> +			chan_data[i].function_id = function_id;

As mentioned above, this should go. Any non-0 return value should stop the driver probing.

Cheers,
Andre.

> +
> +		chan_data[i].chan_id = i;
> +
> +		if (mem_trans)
> +			chan_data[i].flags |= ARM_SMC_MBOX_MEM_TRANS;
> +		mbox->chans[i].con_priv = &chan_data[i];
> +	}
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
> +	dev_info(dev, "ARM SMC mailbox enabled with %d chan%s.\n",
> +		 mbox->num_chans, mbox->num_chans == 1 ? "" : "s");
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
> +MODULE_AUTHOR("Andre Przywara <andre.przywara@arm.com>");
> +MODULE_DESCRIPTION("Generic ARM smc mailbox driver");
> +MODULE_LICENSE("GPL v2");

