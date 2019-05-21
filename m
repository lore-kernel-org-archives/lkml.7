Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC459C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A568E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdK0JTt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfEUIcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:32:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35384 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfEUIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:32:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so4555938wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VA+jlRcUi0ui0LCMNYlU1Yq/q5U+h3sCxnKM/qqThVU=;
        b=BdK0JTt8NB9RKr6QsN4c1ezvq6htcXmR3Vf/4ow7MrzGwd7kW0y1b/CGqSxiq5rggM
         E+0qOZdSuXCttc+ye8xHUjGM9SoYhXdwqK2GQ/5XEnSRW9aTlV8bnk0UGl65lntu0QBX
         Uu84fcPaFw4BFK0um2rP8hp2MLGtIVhfxOHR0atI2d7FdrG/8szF+8ANmL8WUNVsEKPB
         DvbfzttmbAhQC2KWVxvNXM6AwN1QhQBFQQ6J+rZjg4LkBl8HMqB2e/290g0O7WOobShH
         50sUH4dmvaNs+1tNlh8sn1wMFoEKlwFifuQrzR07GWXrG27fnndM3UsptQkr+c7ghwmr
         26Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VA+jlRcUi0ui0LCMNYlU1Yq/q5U+h3sCxnKM/qqThVU=;
        b=NTBn4NDbOPmktg0RvYZQjfOukdVzZkiMAsFmHrh2ulzSZbTax0ueQ7drhj5TTUc5IH
         0tQbiDDvpjtH9knGCQ7mPZMGAjg1Va45LUZ4B7Wmh2WCW0D0Y6Vw5hHC4wr8b3AJcM/j
         p8PfSNaZf7ODptrXKp9ZFUD5CeafJugQdHbM0aVU9hV5XuHES1p9maS5iLizL7beTiZf
         WL529VL9G1jLKepkT6RNoEt4kLPUpsq5kgnas6rLL4ykJ3Bibx6A06NIL4UL4QDaQd+V
         pDhA+d0LmysAV+A8U1hD4IdcryK/zxy+Mw3YjL0m3E5F8DJvNnK8gEyMXFfNrCwg1U3O
         rwpw==
X-Gm-Message-State: APjAAAXaU/6wfiguboQ5WRn2uvGsA6DwUB2V/tczyYztJr1XAVgzEFWQ
        H2om9r34Y//uM241l/OVX7ltoQ==
X-Google-Smtp-Source: APXvYqyKmnAXzRm9YQA7oLoD9I6irA+fBhC2t8u6SgORz1TLXPh0j8LwQliegqwNmSs39ADDNVbW/w==
X-Received: by 2002:a5d:4ec6:: with SMTP id s6mr41712019wrv.184.1558427568318;
        Tue, 21 May 2019 01:32:48 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y18sm2029399wmi.37.2019.05.21.01.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:32:47 -0700 (PDT)
Subject: Re: [PATCH V3 2/4] nvmem: imx: add i.MX8 nvmem driver
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20190515080703.19147-1-peng.fan@nxp.com>
 <20190515080703.19147-2-peng.fan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <36036b4c-c154-d987-ffff-06f61005120c@linaro.org>
Date:   Tue, 21 May 2019 09:32:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515080703.19147-2-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/05/2019 08:53, Peng Fan wrote:
> This patch adds i.MX8 nvmem ocotp driver to access fuse via
> RPC to i.MX8 system controller.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I don't see any dt-binding patches in my list. May be you forgot to add 
me in CC.

Can You please make sure that you add me to the cc of the dt-bindings 
patch so that I can take the driver and dt-bindings together via nvmem tree.
I will not be able to apply any driver patches without dt-bindings.

Thanks,
srini
> ---
> 
> V3:
>   Use imx_sc_msg_misc_fuse_read for req/resp
>   Drop uneccessary check
>   Drop the unnecessary type conversion
>   Minor fixes according to v2 comments
> 
> V2:
>   Add "scu" or "SCU", Add imx_sc_misc_otp_fuse_read, minor fixes
> 
>   drivers/nvmem/Kconfig         |   7 ++
>   drivers/nvmem/Makefile        |   2 +
>   drivers/nvmem/imx-ocotp-scu.c | 161 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 170 insertions(+)
>   create mode 100644 drivers/nvmem/imx-ocotp-scu.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 530d570724c9..79afe44195a1 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -36,6 +36,13 @@ config NVMEM_IMX_OCOTP
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-imx-ocotp.
>   
> +config NVMEM_IMX_OCOTP_SCU
> +	tristate "i.MX8 SCU On-Chip OTP Controller support"
> +	depends on IMX_SCU
> +	help
> +	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
> +	  available on i.MX8 SoCs.
> +
>   config NVMEM_LPC18XX_EEPROM
>   	tristate "NXP LPC18XX EEPROM Memory Support"
>   	depends on ARCH_LPC18XX || COMPILE_TEST
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 2ece8ffffdda..30d653d34e57 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -13,6 +13,8 @@ obj-$(CONFIG_NVMEM_IMX_IIM)	+= nvmem-imx-iim.o
>   nvmem-imx-iim-y			:= imx-iim.o
>   obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
>   nvmem-imx-ocotp-y		:= imx-ocotp.o
> +obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
> +nvmem-imx-ocotp-scu-y		:= imx-ocotp-scu.o
>   obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
>   nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
>   obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
> new file mode 100644
> index 000000000000..d9dc482ecb2f
> --- /dev/null
> +++ b/drivers/nvmem/imx-ocotp-scu.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * i.MX8 OCOTP fusebox driver
> + *
> + * Copyright 2019 NXP
> + *
> + * Peng Fan <peng.fan@nxp.com>
> + */
> +
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +enum ocotp_devtype {
> +	IMX8QXP,
> +};
> +
> +struct ocotp_devtype_data {
> +	int devtype;
> +	int nregs;
> +};
> +
> +struct ocotp_priv {
> +	struct device *dev;
> +	const struct ocotp_devtype_data *data;
> +	struct imx_sc_ipc *nvmem_ipc;
> +};
> +
> +struct imx_sc_msg_misc_fuse_read {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 word;
> +} __packed;
> +
> +static struct ocotp_devtype_data imx8qxp_data = {
> +	.devtype = IMX8QXP,
> +	.nregs = 800,
> +};
> +
> +static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
> +				     u32 *val)
> +{
> +	struct imx_sc_msg_misc_fuse_read msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_MISC;
> +	hdr->func = IMX_SC_MISC_FUNC_OTP_FUSE_READ;
> +	hdr->size = 2;
> +
> +	msg.word = word;
> +
> +	ret = imx_scu_call_rpc(ipc, &msg, true);
> +	if (ret)
> +		return ret;
> +
> +	*val = msg.word;
> +
> +	return 0;
> +}
> +
> +static int imx_scu_ocotp_read(void *context, unsigned int offset,
> +			      void *val, size_t bytes)
> +{
> +	struct ocotp_priv *priv = context;
> +	u32 count, index, num_bytes;
> +	u32 *buf;
> +	void *p;
> +	int i, ret;
> +
> +	index = offset >> 2;
> +	num_bytes = round_up((offset % 4) + bytes, 4);
> +	count = num_bytes >> 2;
> +
> +	if (count > (priv->data->nregs - index))
> +		count = priv->data->nregs - index;
> +
> +	p = kzalloc(num_bytes, GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	buf = p;
> +
> +	for (i = index; i < (index + count); i++) {
> +		if (priv->data->devtype == IMX8QXP) {
> +			if ((i > 271) && (i < 544)) {
> +				*buf++ = 0;
> +				continue;
> +			}
> +		}
> +
> +		ret = imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
> +		if (ret) {
> +			kfree(p);
> +			return ret;
> +		}
> +		buf++;
> +	}
> +
> +	memcpy(val, (u8 *)p + offset % 4, bytes);
> +
> +	kfree(p);
> +
> +	return 0;
> +}
> +
> +static struct nvmem_config imx_scu_ocotp_nvmem_config = {
> +	.name = "imx-scu-ocotp",
> +	.read_only = true,
> +	.word_size = 4,
> +	.stride = 1,
> +	.owner = THIS_MODULE,
> +	.reg_read = imx_scu_ocotp_read,
> +};
> +
> +static const struct of_device_id imx_scu_ocotp_dt_ids[] = {
> +	{ .compatible = "fsl,imx8qxp-scu-ocotp", (void *)&imx8qxp_data },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx_scu_ocotp_dt_ids);
> +
> +static int imx_scu_ocotp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ocotp_priv *priv;
> +	struct nvmem_device *nvmem;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ret = imx_scu_get_handle(&priv->nvmem_ipc);
> +	if (ret)
> +		return ret;
> +
> +	priv->data = of_device_get_match_data(dev);
> +	priv->dev = dev;
> +	imx_scu_ocotp_nvmem_config.size = 4 * priv->data->nregs;
> +	imx_scu_ocotp_nvmem_config.dev = dev;
> +	imx_scu_ocotp_nvmem_config.priv = priv;
> +	nvmem = devm_nvmem_register(dev, &imx_scu_ocotp_nvmem_config);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static struct platform_driver imx_scu_ocotp_driver = {
> +	.probe	= imx_scu_ocotp_probe,
> +	.driver = {
> +		.name	= "imx_scu_ocotp",
> +		.of_match_table = imx_scu_ocotp_dt_ids,
> +	},
> +};
> +module_platform_driver(imx_scu_ocotp_driver);
> +
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("i.MX8 SCU OCOTP fuse box driver");
> +MODULE_LICENSE("GPL v2");
> 
