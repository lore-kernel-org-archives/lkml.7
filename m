Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8F5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91392206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="W5y32Q8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfC2PMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:12:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45768 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfC2PMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:12:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id 5so1672742lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mo0AFzPMoQ5Z8MnNCzngpyQdfNUsMqZK0C6acsupEhw=;
        b=W5y32Q8si1p6YbI84orXK1a+mj6uHtD8xJNwH3FnKpoZLeRihDL6NQEwJxjG5qT3nJ
         3tfi4g6v1KHJvZoOh+vN4ES1xKAoMhXkz6zFX1j4ClmP0N41wt15sCUUNTw0W3AIvebZ
         N0Pk7y7Sp/tWZPNwfv13M70wuYBnK4M0NJHDdcj9KixQ7GEFcZNYs1dfZbh2RrWrbz6M
         KXNZcS+4HQ0f8S/o7ueASid6fCrN+DloImxjMywprgGQZhvrHn0HesYq1fFBCRb+2vJY
         hRdVhmF3sT5IQuaSMTYjMI3DK0sy075Bm7c7MUEjuiWQq11LkNZYr3SHOlwltq9mQgBx
         YViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mo0AFzPMoQ5Z8MnNCzngpyQdfNUsMqZK0C6acsupEhw=;
        b=CxDpjq0/Jrg5rq5eWJ16N8RSkR5nmKvpPglp/Ymih31BiW5ztLSEukCRk2Jazmy4ud
         eWpt7fc16ry5nUtTBDOHrOJTFdNjLrBeBi74iN+ZuHHLsHzGEBBeFunpWCnX3blPJy1/
         6BIYro4cDXhISRl4JAxhd2aBxihs8B/Gq4aI/T1aVGayeK8TFXRYW6/bSQXUw0rfXl30
         ZXg8yW9KxTpBFTH09Fik7TPoHMMG7VTgRR/ylfhc9coKkBS6RCS6m39YP5KozGzoK5sM
         ad20psjhAYoeDifYVj+vowupcJh8BCu9uggV0BfFxOSonq1Ady1cld4j+wRmaITpNFuM
         hNIA==
X-Gm-Message-State: APjAAAWq9aH2ft3tMzXDkoypf6dZ2hKbc6E5jh1+HppsT9XlvtCxIQs6
        uyuaCaH4mqTodWTSMFDfTLq0+g==
X-Google-Smtp-Source: APXvYqz0iL1M61onR+P3JQw9irOexmkyFkP+w12l0qYx60mnZ+7lp5UMTEjlkGQRQZVodhTriQcQaw==
X-Received: by 2002:ac2:50d8:: with SMTP id h24mr25292600lfm.7.1553872365417;
        Fri, 29 Mar 2019 08:12:45 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.84.161])
        by smtp.gmail.com with ESMTPSA id y25sm391724lja.61.2019.03.29.08.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:12:44 -0700 (PDT)
Subject: Re: [PATCH v9 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-2-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5cf42c96-183c-1edd-8397-1de6e3033f33@cogentembedded.com>
Date:   Fri, 29 Mar 2019 18:12:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1553847606-18122-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2019 11:20 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
[...]
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

   regmap_reg_range((RPC_SMRDR0, RPC_SMRDR1), like Marek noted?

> +	regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),

   regmap_reg_range((RPC_SMWDR0, RPC_SMWDR1)?

> +static int rpc_mfd_probe(struct platform_device *pdev)
> +{
> +	struct device_node *ctlr;
> +	const struct mfd_cell *cell;
> +	struct resource *res;
> +	struct rpc_mfd *rpc;
> +	int ret;
> +
> +	ctlr = of_get_next_child(pdev->dev.of_node, NULL);

    The child should be a CFI or JEDEC flash device, no virtual devices,
please.

[...]
> +	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rpc->rstc))
> +		return PTR_ERR(rpc->rstc);
> +
> +	platform_set_drvdata(pdev, rpc);
> +
> +	ret = devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
> +
> +	return ret;

	return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);

> +}
> +
> +static int rpc_mfd_remove(struct platform_device *pdev)
> +{
> +	mfd_remove_devices(&pdev->dev);

   Why, if you used devm_mfd_add_devices() in the probe method?

> +	return 0;
> +}
[...]
> diff --git a/include/linux/mfd/renesas-rpc.h b/include/linux/mfd/renesas-rpc.h
> new file mode 100644
> index 0000000..209e64f1
> --- /dev/null
> +++ b/include/linux/mfd/renesas-rpc.h
> @@ -0,0 +1,154 @@
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

  Is any of these #include's used by the header itself? I don't think so...

> +
> +#define RPC_CMNCR		0x0000	// R/W

   Not sure we'd need the registers described in the public header after
we place the common RPC-IF code into the MFD driver. We'll see though...

[...]

MBR, Sergei
