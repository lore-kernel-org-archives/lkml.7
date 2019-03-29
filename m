Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC41C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D93720811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEE6eTla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfC2Kqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:46:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34232 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfC2Kqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:46:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so889475pfd.1;
        Fri, 29 Mar 2019 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KxdjQtH+CSNDToOBqGstYVSkNFoz0kMA1ZTZGOP2o4Q=;
        b=UEE6eTlaCU0LVvOyxOMmFkBmj6scq0bda02J33mRawNsvxy2Qu6AzBvJqH/FfEkY0C
         RjFxaSqQWUCtJgmWp2qg017peOshqb01m6Le0OOiUa1efw7Uk91drqm9z0tiixIhACOy
         3ZGSkLKQDu0BzMIqGVvX7l4q1AOjI3LBf3PGdQV9epkgTXU/1oW7xv7U5KMkVUW1fiNL
         /kteTBDVhPtBQ+sIOtUrAomcIRcww47ZlkqJ2O2cj+h0iGCU9l6/LeYVvGjBXf16xdqH
         sltZ58rmBrpejDNHPe0ANocJd0gZvrg6RbB5jLZHDEkB3GdGcpDcV8U1FQyho5wqkZe1
         SxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KxdjQtH+CSNDToOBqGstYVSkNFoz0kMA1ZTZGOP2o4Q=;
        b=uNJR54wrrZP34wY3dcGVTDHZp9zkTldg6iOAGjd5PZg+KkSAG4YqSDIMWvw0oFDo/x
         FKoBkIvPOO46+Z0A8HCHeIkDK5WIGJAU4bwmXk5cAJtAMYg6zCDDq3TPliwvHSM8tqFM
         HFFxnxvo96I+Vg2boTy06YHG0zys/aOr6URgwWfSiLWz8y38GUW2HD093vunUMneyqqE
         K3QVfPliPwZDW3HJCFm0vekdgG0OPFEE2X/vqCLpOJV3xcrnpJw2gDi0hi9KB5T+Kn4u
         tFSAKMqwWQdVJ2pAmqq9Ak30H99nc/ITXUDW0gXjXFK1kHveWSo1AqSm+JmbN4Ncz8xP
         kEgg==
X-Gm-Message-State: APjAAAXoZoJ2rVYQyQXnKvNiU4eTtyfBHy2lNXt8KfsT+QOuMeKQxZ45
        34YbzOH2zNsSEYuqnsOpA6k=
X-Google-Smtp-Source: APXvYqx/clEgEhlG6iOErX7uGJbNnjDiUl0/dgqxhM88uDTRzEdS348K9dX2ev3oVWSq+6/tgekV4Q==
X-Received: by 2002:a63:1410:: with SMTP id u16mr43553340pgl.420.1553856397149;
        Fri, 29 Mar 2019 03:46:37 -0700 (PDT)
Received: from [192.168.42.180] (219x120x4x122.ap219.ftth.ucom.ne.jp. [219.120.4.122])
        by smtp.gmail.com with ESMTPSA id 28sm2384360pgq.59.2019.03.29.03.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:46:36 -0700 (PDT)
Subject: Re: [PATCH v9 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-2-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <1e0107a8-164c-7978-f2d0-2dd3430cc2b9@gmail.com>
Date:   Fri, 29 Mar 2019 11:43:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553847606-18122-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 9:20 AM, Mason Yang wrote:
> Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mfd/Kconfig             |   9 +++
>  drivers/mfd/Makefile            |   1 +
>  drivers/mfd/renesas-rpc.c       | 140 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/renesas-rpc.h | 154 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 304 insertions(+)
>  create mode 100644 drivers/mfd/renesas-rpc.c
>  create mode 100644 include/linux/mfd/renesas-rpc.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0ce2d8d..a870e12 100644
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
> +	  controller which provides either SPI host controller or HyperFlash.
> +	  You have to select individual components under the corresponding menu.
> +
>  config MFD_RT5033
>  	tristate "Richtek RT5033 Power Management IC"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index b4569ed7..4a49699 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -183,6 +183,7 @@ obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
>  obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
>  obj-$(CONFIG_LPC_ICH)		+= lpc_ich.o
>  obj-$(CONFIG_MFD_RDC321X)	+= rdc321x-southbridge.o
> +obj-$(CONFIG_MFD_RENESAS_RPC)	+= renesas-rpc.o
>  obj-$(CONFIG_MFD_JANZ_CMODIO)	+= janz-cmodio.o
>  obj-$(CONFIG_MFD_JZ4740_ADC)	+= jz4740-adc.o
>  obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
> diff --git a/drivers/mfd/renesas-rpc.c b/drivers/mfd/renesas-rpc.c
> new file mode 100644
> index 0000000..c92bb74
> --- /dev/null
> +++ b/drivers/mfd/renesas-rpc.c
> @@ -0,0 +1,140 @@
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
> +};
> +
> +static const struct mfd_cell rpc_spi_ctlr = {
> +	.name = "rpc-spi",
> +	.of_compatible = "renesas,rcar-rpc-spi",
> +};
> +
> +static const struct regmap_range rpc_mfd_volatile_ranges[] = {
> +	regmap_reg_range(RPC_SMRDR0, RPC_SMRDR0),
> +	regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),
> +	regmap_reg_range(RPC_CMNSR, RPC_CMNSR),
> +};

Isn't SMWDR1 volatile too ? And SMRDR1 too ?

[...]
-- 
Best regards,
Marek Vasut
