Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA295C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A082147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554281269;
	bh=+g7Dl65eGfYvXnab+jQYS7WdKj756tHeBsLPzjZB82Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lc3/yaiQj5Zru3752TGvQMEBCbv5oR1cUuZnAkcDAiD6MuiCN/3OqpylJvTJCyGeG
	 RqFuzPexzVJslMlu9HQQu/rfLZfOOWd/XPRhmSAqiaVNgcKy5sWeYM7B4y5z+9JSDK
	 2ANlJvEUmAEJJLgLnssKFi0EnZDMs2AtxZIaDWUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfDCIrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbfDCIrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:47:18 -0400
Received: from X250 (unknown [147.50.13.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0048B20830;
        Wed,  3 Apr 2019 08:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554281237;
        bh=+g7Dl65eGfYvXnab+jQYS7WdKj756tHeBsLPzjZB82Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j36K/q22FjHBjYyVoU4hFhRLswuCSzZ69uboTCzCKlAfaG6qes0SVlFmHUxlr8zZS
         fMQGqwdvcOlceLi6j4TyuvWZ7sDSDK9DR24J43SGUG4S35ZM08zHr42BibmyEhRMvU
         JvanSk0jl1jXvl7pVjIzcR8pXfuJaYYJmmwvp3PI=
Date:   Wed, 3 Apr 2019 15:47:08 +0700
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 2/4] firmware: imx: enable imx scu general irq function
Message-ID: <20190403084706.GB4636@X250>
References: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
 <1552878291-22866-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552878291-22866-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 03:09:55AM +0000, Anson Huang wrote:
> The System Controller Firmware (SCFW) controls RTC, thermal
> and WDOG etc., these resources' interrupt function are managed
> by SCU. When any IRQ pending, SCU will notify Linux via MU general
> interrupt channel #3, and Linux kernel needs to call SCU APIs
> to get IRQ status and notify each module to handle the interrupt.
> 
> Since there is no data transmission for SCU IRQ notification, so
> doorbell mode is used for this MU channel, and SCU driver will
> use notifier mechanism to broadcast to every module which registers
> the SCU block notifier.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

@Aisheng,

Are you fine with this?

Shawn

> ---
> Changes since V4:
> 	- move scu irq support to a new file imx-scu-irq.c;
> 	- improve the function name with "imx_scu_irq_" as prefix for irq related functions;
> 	- move MU IRQ sources id out of sc ipc struct;
> 	- add IRQ group info message print when get irq status fail;
> 	- move MU ID parse into imx_scu_enable_general_irq_channel() function and ONLY do it
> 	  when irq channel enable successfully.
> 	- change max IRQ group supported to 4, ONLY support for those kernel features.
> ---
>  drivers/firmware/imx/Makefile      |   2 +-
>  drivers/firmware/imx/imx-scu-irq.c | 133 +++++++++++++++++++++++++++++++++++++
>  drivers/firmware/imx/imx-scu.c     |   6 ++
>  include/linux/firmware/imx/sci.h   |   4 ++
>  4 files changed, 144 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/imx/imx-scu-irq.c
> 
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 1b2e15b..802c4ad 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o
> +obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o
>  obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> new file mode 100644
> index 0000000..0e20aa7
> --- /dev/null
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 NXP
> + *
> + * Implementation of the SCU IRQ functions using MU.
> + *
> + */
> +
> +#include <dt-bindings/firmware/imx/rsrc.h>
> +#include <linux/firmware/imx/ipc.h>
> +#include <linux/mailbox_client.h>
> +
> +#define IMX_SC_IRQ_FUNC_STATUS	2
> +#define IMX_SC_IRQ_NUM_GROUP	4
> +
> +static u32 mu_resource_id;
> +
> +struct imx_sc_msg_irq_get_status {
> +	struct imx_sc_rpc_msg hdr;
> +	union {
> +		struct {
> +			u16 resource;
> +			u8 group;
> +			u8 reserved;
> +		} __packed req;
> +		struct {
> +			u32 status;
> +		} resp;
> +	} data;
> +};
> +
> +static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
> +static struct work_struct imx_sc_irq_work;
> +static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
> +
> +int imx_scu_irq_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(
> +		&imx_scu_irq_notifier_chain, nb);
> +}
> +EXPORT_SYMBOL(imx_scu_irq_register_notifier);
> +
> +int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(
> +		&imx_scu_irq_notifier_chain, nb);
> +}
> +EXPORT_SYMBOL(imx_scu_irq_unregister_notifier);
> +
> +static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group)
> +{
> +	return blocking_notifier_call_chain(&imx_scu_irq_notifier_chain,
> +		status, (void *)group);
> +}
> +
> +static void imx_scu_irq_work_handler(struct work_struct *work)
> +{
> +	struct imx_sc_msg_irq_get_status msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	u32 irq_status;
> +	int ret;
> +	u8 i;
> +
> +	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
> +		hdr->ver = IMX_SC_RPC_VERSION;
> +		hdr->svc = IMX_SC_RPC_SVC_IRQ;
> +		hdr->func = IMX_SC_IRQ_FUNC_STATUS;
> +		hdr->size = 2;
> +
> +		msg.data.req.resource = mu_resource_id;
> +		msg.data.req.group = i;
> +
> +		ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
> +		if (ret) {
> +			pr_err("get irq group %d status failed, ret %d\n",
> +			       i, ret);
> +			return;
> +		}
> +
> +		irq_status = msg.data.resp.status;
> +		if (!irq_status)
> +			continue;
> +
> +		imx_scu_irq_notifier_call_chain(irq_status, &i);
> +	}
> +}
> +
> +static void imx_scu_irq_callback(struct mbox_client *c, void *msg)
> +{
> +	schedule_work(&imx_sc_irq_work);
> +}
> +
> +int imx_scu_enable_general_irq_channel(struct device *dev)
> +{
> +	struct of_phandle_args spec;
> +	struct mbox_client *cl;
> +	struct mbox_chan *ch;
> +	int ret = 0, i = 0;
> +
> +	cl = devm_kzalloc(dev, sizeof(*cl), GFP_KERNEL);
> +	if (!cl)
> +		return -ENOMEM;
> +
> +	cl->dev = dev;
> +	cl->rx_callback = imx_scu_irq_callback;
> +
> +	/* SCU general IRQ uses general interrupt channel 3 */
> +	ch = mbox_request_channel_byname(cl, "gip3");
> +	if (IS_ERR(ch)) {
> +		ret = PTR_ERR(ch);
> +		dev_err(dev, "failed to request mbox chan gip3, ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = imx_scu_get_handle(&imx_sc_irq_ipc_handle);
> +	if (ret)
> +		return ret;
> +
> +	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
> +
> +	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
> +				       "#mbox-cells", 0, &spec))
> +		i = of_alias_get_id(spec.np, "mu");
> +
> +	/* use mu1 as general mu irq channel if failed */
> +	if (i < 0)
> +		i = 1;
> +
> +	mu_resource_id = IMX_SC_R_MU_0A + i;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(imx_scu_enable_general_irq_channel);
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 2bb1a19..04a24a8 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -10,6 +10,7 @@
>  #include <linux/err.h>
>  #include <linux/firmware/imx/types.h>
>  #include <linux/firmware/imx/ipc.h>
> +#include <linux/firmware/imx/sci.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> @@ -246,6 +247,11 @@ static int imx_scu_probe(struct platform_device *pdev)
>  
>  	imx_sc_ipc_handle = sc_ipc;
>  
> +	ret = imx_scu_enable_general_irq_channel(dev);
> +	if (ret)
> +		dev_warn(dev,
> +			"failed to enable general irq channel: %d\n", ret);
> +
>  	dev_info(dev, "NXP i.MX SCU Initialized\n");
>  
>  	return devm_of_platform_populate(dev);
> diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
> index ebc5509..918fa16 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -15,4 +15,8 @@
>  
>  #include <linux/firmware/imx/svc/misc.h>
>  #include <linux/firmware/imx/svc/pm.h>
> +
> +int imx_scu_enable_general_irq_channel(struct device *dev);
> +int imx_scu_irq_register_notifier(struct notifier_block *nb);
> +int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
>  #endif /* _SC_SCI_H */
> -- 
> 2.7.4
> 
