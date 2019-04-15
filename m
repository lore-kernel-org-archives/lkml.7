Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E99CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4402070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="B7orOxy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfDOT5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:57:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44735 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfDOT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:57:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so16840348ljg.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1MMV0mrpetojB6wkoeaHxVzGhoDBvvAhfwEHNFpeNg=;
        b=B7orOxy/CPdQGiyRKz3VaPZPbyqvFvxsSjgAa/OzKviEfARbjiccjYRd85Sfq7Xskp
         XqH6YBxyfheIMnVeJjwkmrZhGkjcxBg4f3amuJbg/JRiQbfdBgUBINWnCmB0wX3G0PJi
         mCGxOxTlA2VVdv1YfWWtTIWYA59IRiWSJVYSzrvyRKJ2L2kx12Um5kBZKeA1o0HeA7/G
         r6X021NWrEJnnQGQTj1Vl/FeLNQjtS8fonFwUfPrsGhBCzBwe1Dot4IoQH1D5NW1ykSL
         RyxiJ5/7qqB+SuRISY0idSfVSrt+7nLHpjb1MpztGgHZ8dunmmKvshtHu1b3mQTtodd0
         E/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H1MMV0mrpetojB6wkoeaHxVzGhoDBvvAhfwEHNFpeNg=;
        b=IJkMrK2Mz7FQsCQIrIdw3g00Myh7q3DOdTog5KPS8UyP+7jfwa7HzIZYygExhTqT/Q
         pJSgYaNuP6FCql5ljnuItABgyDV4/g3DwRsFTWoFKMkd1abl0dtbZ9qRjVDf816bU+qi
         C9c4YZMNBNL/81zzcoNJPWpSLQrGKEZ1SYIKLUw8qC1nwqqaGDHYmc6tYqX3gS1vdf6Q
         p9yElyBvY3Sp3cBdihyGrVs6xaAK7v19cbbgAct7mrxdTIszRQdljzbD2ehjacjY36xj
         ygfgM1cnt1ixq8w6N++TCkGvsnLJRWnjBJ8Z10wbF1gK4L3+nxDg0pVe0uY2OJOY0zTn
         il4g==
X-Gm-Message-State: APjAAAVz7KQhta7wwLTDTPin5X9wMqOL5uB48OkFjz9TloJccEnU+hwz
        wKf60pj/YHIPifKAWt4ShAnH3Q==
X-Google-Smtp-Source: APXvYqzuApBgmMNGPYTpGaX2JM/hPR8Eymqv0HeFTK7bnzToX69hgX82bDRKVYj0WPAiXD6hce9jlg==
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr15789356ljj.159.1555358267348;
        Mon, 15 Apr 2019 12:57:47 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.61])
        by smtp.gmail.com with ESMTPSA id x72sm1073507lfa.58.2019.04.15.12.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:57:46 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v10 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
 <1555313834-15107-2-git-send-email-masonccyang@mxic.com.tw>
Organization: Cogent Embedded
Message-ID: <935046cc-e2e5-b9b8-0c94-1be5ae604276@cogentembedded.com>
Date:   Mon, 15 Apr 2019 22:57:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1555313834-15107-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch name is somewhat misleading -- there's no "MFD controller".

On 04/15/2019 10:37 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
[...]
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 26ad646..7914349 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -978,6 +978,15 @@ config MFD_RDC321X
>  	  southbridge which provides access to GPIOs and Watchdog using the
>  	  southbridge PCI device configuration space.
>  
> +config MFD_RENESAS_RPC
> +	tristate "Renesas R-Car Gen3 RPC-IF MFD driver"
> +	select MFD_CORE
> +	depends on ARCH_RENESAS
> +	help
> +	  This supports for Renesas R-Car Gen3 RPC-IF multifunction device

   "For" node needed here.

> +	  controller which provides either SPI host controller or HyperFlash.
> +	  You have to select individual components under the corresponding menu.
> +
>  config MFD_RT5033
>  	tristate "Richtek RT5033 Power Management IC"
>  	depends on I2C
[...]
> diff --git a/drivers/mfd/renesas-rpc.c b/drivers/mfd/renesas-rpc.c
> new file mode 100644
> index 0000000..a565f31
> --- /dev/null
> +++ b/drivers/mfd/renesas-rpc.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> +// Copyright (C) 2019 Macronix International Co., Ltd.
> +//
> +// R-Car Gen3 RPC-IF MFD driver
> +//
> +// Author:
> +//	Mason Yang <masonccyang@mxic.com.tw>
> +//
> +
> +#include <linux/mfd/renesas-rpc.h>
> +#include <linux/mfd/core.h>
> +
> +static const struct mfd_cell rpc_hf_ctlr = {
> +	.name = "rpc-hf",
> +	.of_compatible = "renesas,rcar-rpc-hf",

   Don't need this line any more...

> +};
> +
> +static const struct mfd_cell rpc_spi_ctlr = {
> +	.name = "rpc-spi",
> +	.of_compatible = "renesas,rcar-rpc-spi",

   ... and this too.

[...]
> +static int rpc_mfd_probe(struct platform_device *pdev)
> +{
> +	struct device_node *flash;
> +	const struct mfd_cell *cell;
> +	struct resource *res;
> +	struct rpc_mfd *rpc;
> +	void __iomem *base;
> +	int ret;
> +
> +	flash = of_get_next_child(pdev->dev.of_node, NULL);
> +	if (!flash) {
> +		dev_warn(&pdev->dev, "no flash node found\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_device_is_compatible(flash, "jedec,spi-nor");
> +	if (ret) {
> +		cell = &rpc_spi_ctlr;
> +	} else {
> +		ret = of_device_is_compatible(flash, "cfi-flash");
> +		if (ret) {
> +			cell = &rpc_hf_ctlr;
> +		} else {
> +			dev_warn(&pdev->dev, "no jedec spi/cfi device found\n");
> +			return -ENODEV;
> +		}
> +	}


   This definitely should look simpler, like below:

	if (of_device_is_compatible(flash, "jedec,spi-nor")) {
 		cell = &rpc_spi_ctlr;
	} else if (of_device_is_compatible(flash, "cfi-flash")) {
		cell = &rpc_hf_ctlr;
 	} else {
		dev_warn(&pdev->dev, "unknown flash type\n");
		return -ENODEV;
	}

[...]

> +	ret = devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
> +
> +	return ret;

	return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);

[...]
> diff --git a/include/linux/mfd/renesas-rpc.h b/include/linux/mfd/renesas-rpc.h
> new file mode 100644
> index 0000000..61ada14
> --- /dev/null
> +++ b/include/linux/mfd/renesas-rpc.h
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> +// Copyright (C) 2019 Macronix International Co., Ltd.
> +//
> +// R-Car Gen3 RPC-IF MFD driver
> +//
> +// Author:
> +//	Mason Yang <masonccyang@mxic.com.tw>
> +//
> +
> +#ifndef __MFD_RENESAS_RPC_H
> +#define __MFD_RENESAS_RPC_H
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>

   NAK. I have already told you that these #include's are only needed in the
drivers, not in this header.

   My idea is to contain all hardware manipulation in the MFD driver,
with SPI/HF drivers calling that code via a set of APIs declared in this header.
The registers (declared below) would end up only needed by that common MFD driver...

[...]

MBR, Sergei
