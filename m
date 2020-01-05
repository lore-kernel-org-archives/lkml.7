Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2774C33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B736521775
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578208809;
	bh=DFP+6Fqfh7hM7WvrzekJyaKGyzJkPSyVvD0HF60ILVU=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=tsLtV1LxesCo8ID2A7Z7wqAtcv1wu1+zDB2dnhqSHOIzSNTM9B/p32v1tBlb6pyzL
	 mEyLj2rs55l1sg9acucjcFlCAy0Of0/Erh5Fuf48fVrNwssY5iLh83/FdxKWS+gagI
	 oJ2hK7HAI0SL1fwNjR/6W1xqLsL4XKwfqmEsiSUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAEHUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 02:20:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAEHUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:20:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910862085B;
        Sun,  5 Jan 2020 07:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578208807;
        bh=DFP+6Fqfh7hM7WvrzekJyaKGyzJkPSyVvD0HF60ILVU=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=PKUxDu88g3Pb0WzRLvMn8jnZv+pqxcUwzBcJjGAW6qli8rsetWUoEUOYezXcpbixJ
         naFvHX7Ucvl8sXbm/v5SodZszL6zRhkUt9EP+TxXPbks+ss8eJaZa1qiPktQCZ3k+g
         ZhYzV7x1DwufbBpiaRciMUbwzvUA1I9eigX9kpk0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216121932.22967-7-zhang.lyra@gmail.com>
References: <20191216121932.22967-1-zhang.lyra@gmail.com> <20191216121932.22967-7-zhang.lyra@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2 6/6] clk: sprd: add clocks support for SC9863A
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 23:20:06 -0800
Message-Id: <20200105072007.910862085B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-12-16 04:19:32)
> diff --git a/drivers/clk/sprd/sc9863a-clk.c b/drivers/clk/sprd/sc9863a-cl=
k.c
> new file mode 100644
> index 000000000000..145bb0a78740
> --- /dev/null
> +++ b/drivers/clk/sprd/sc9863a-clk.c
> @@ -0,0 +1,1835 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Unisoc SC9863A clock driver
> + *
> + * Copyright (C) 2019 Unisoc, Inc.
> + * Author: Chunyan Zhang <chunyan.zhang@unisoc.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Is this include used?

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/sprd,sc9863a-clk.h>
> +
> +#include "common.h"
> +#include "composite.h"
> +#include "div.h"
> +#include "gate.h"
> +#include "mux.h"
> +#include "pll.h"
> +
[...]
> +                               0x1000, BIT(12), 0, 0);
> +static SPRD_SC_GATE_CLK_FW_NAME(uart0_eb,      "uart0-eb",     "ext-26m"=
, 0x0,
> +                               0x1000, BIT(13), CLK_IGNORE_UNUSED, 0);

Why are we CLK_IGNORE_UNUSED marking these clks? Please add a comment to
explain why this should stay instead of being marked as critical.

> +static SPRD_SC_GATE_CLK_FW_NAME(uart1_eb,      "uart1-eb",     "ext-26m"=
, 0x0,
> +                               0x1000, BIT(14), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK_FW_NAME(uart2_eb,      "uart2-eb",     "ext-26m"=
, 0x0,
> +                               0x1000, BIT(15), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK_FW_NAME(uart3_eb,      "uart3-eb",     "ext-26m"=
, 0x0,
> +                               0x1000, BIT(16), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK_FW_NAME(uart4_eb,      "uart4-eb",     "ext-26m"=
, 0x0,
> +                               0x1000, BIT(17), CLK_IGNORE_UNUSED, 0);
> +static SPRD_SC_GATE_CLK_FW_NAME(sim0_32k_eb,   "sim0_32k-eb",  "ext-26m"=
, 0x0,
> +                               0x1000, BIT(18), 0, 0);
> +static SPRD_SC_GATE_CLK_FW_NAME(spi3_eb,       "spi3-eb",      "ext-26m"=
, 0x0,
> +                               0x1000, BIT(19), 0, 0);
> +static SPRD_SC_GATE_CLK_FW_NAME(i2c5_eb,       "i2c5-eb",      "ext-26m"=
, 0x0,
> +                               0x1000, BIT(20), 0, 0);
> +static SPRD_SC_GATE_CLK_FW_NAME(i2c6_eb,       "i2c6-eb",      "ext-26m"=
, 0x0,
> +                               0x1000, BIT(21), 0, 0);
> +
> +
> +static int sc9863a_clk_probe(struct platform_device *pdev)
> +{
> +       const struct sprd_clk_desc *desc;
> +
> +       desc =3D device_get_match_data(&pdev->dev);
> +       if (!desc)
> +               return -ENODEV;
> +
> +       sprd_clk_regmap_init(pdev, desc);

Can this fail?

> +
> +       return sprd_clk_probe(&pdev->dev, desc->hw_clks);
> +}
> +
