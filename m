Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F54C2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89192071A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577174739;
	bh=q+4fNfvxwFfvm6ehxq3tf+yjKjbLqy3OGlMpvibfKhE=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=GgsKsRU4QiB+52MnI2pxKeqXu91aW+RblhKQ396QgDNeMotI0Vu2o5kcdVtxlHE7D
	 BUMjsg+9oB/lmozPOO6USLHefHS/DBdG5FDjikcgaHxnt93P8GiMbStA3qi/UNYhxb
	 Mj5W7WduUil4/Dil7nvj/HEv4Sq/GbDBBfvVK1Eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLXIFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 03:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfLXIFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 03:05:38 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C99206CB;
        Tue, 24 Dec 2019 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577174736;
        bh=q+4fNfvxwFfvm6ehxq3tf+yjKjbLqy3OGlMpvibfKhE=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=pPvzsbBbP6MR6SnA/5X0FeGfkVY4CZ8izcoN8yDgHPCIZ8eCCPaoRCSPYhysvW6Pj
         rrnvi6eQuNIpLyKF8r6SaTuPP8sI5VJLaO6ycV27jLxP02Mqmnj+kZY5u3hC+fxZAY
         DaslL24dbHa06DyBXjvuKwkCPMl+7xcxIV0LkOVo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191209233305.18619-2-michael@walle.cc>
References: <20191209233305.18619-1-michael@walle.cc> <20191209233305.18619-2-michael@walle.cc>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: fsl-sai: new driver
User-Agent: alot/0.8.1
Date:   Tue, 24 Dec 2019 00:05:35 -0800
Message-Id: <20191224080536.B0C99206CB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Walle (2019-12-09 15:33:05)
> diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
> new file mode 100644
> index 000000000000..b92054d15ab1
> --- /dev/null
> +++ b/drivers/clk/clk-fsl-sai.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Freescale SAI BCLK as a generic clock driver
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#define I2S_CSR                0x00
> +#define I2S_CR2                0x08
> +#define CSR_BCE_BIT    28
> +#define CR2_BCD                BIT(24)
> +#define CR2_DIV_SHIFT  0
> +#define CR2_DIV_WIDTH  8
> +
> +struct fsl_sai_clk {
> +       struct clk_divider div;
> +       struct clk_gate gate;
> +       spinlock_t lock;
> +};
> +
> +static void __init fsl_sai_clk_setup(struct device_node *node)
> +{
> +       const char *clk_name =3D node->name;
> +       struct fsl_sai_clk *sai_clk;
> +       unsigned int num_parents;
> +       const char *parent_name;
> +       void __iomem *base;
> +       struct clk_hw *hw;
> +
> +       num_parents =3D of_clk_get_parent_count(node);
> +       if (!num_parents) {
> +               pr_err("%s: no parent found", clk_name);
> +               return;
> +       }
> +
> +       parent_name =3D of_clk_get_parent_name(node, 0);

Could this use the new way of specifying clk parents so that we don't
have to query DT for parent names and just let the core framework do it
whenever it needs to?

> +
> +       sai_clk =3D kzalloc(sizeof(*sai_clk), GFP_KERNEL);
> +       if (!sai_clk)
> +               return;
> +
> +       base =3D of_iomap(node, 0);
> +       if (base =3D=3D NULL) {
> +               pr_err("%s: failed to map register space", clk_name);
> +               goto err;
> +       }
> +
> +       spin_lock_init(&sai_clk->lock);
> +
> +       sai_clk->gate.reg =3D base + I2S_CSR;
> +       sai_clk->gate.bit_idx =3D CSR_BCE_BIT;
> +       sai_clk->gate.lock =3D &sai_clk->lock;
> +
> +       sai_clk->div.reg =3D base + I2S_CR2;
> +       sai_clk->div.shift =3D CR2_DIV_SHIFT;
> +       sai_clk->div.width =3D CR2_DIV_WIDTH;
> +       sai_clk->div.lock =3D &sai_clk->lock;
> +
> +       /* set clock direction, we are the BCLK master */

Should this configuration come from DT somehow?

> +       writel(CR2_BCD, base + I2S_CR2);
> +
> +       hw =3D clk_hw_register_composite(NULL, clk_name, &parent_name, 1,
> +                                      NULL, NULL,
> +                                      &sai_clk->div.hw, &clk_divider_ops,
> +                                      &sai_clk->gate.hw, &clk_gate_ops,
> +                                      CLK_SET_RATE_GATE);
> +       if (IS_ERR(hw))
> +               goto err;
> +
> +       of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
> +
> +       return;
> +
> +err:
> +       kfree(sai_clk);
> +}
> +
> +CLK_OF_DECLARE(fsl_sai_clk, "fsl,vf610-sai-clock", fsl_sai_clk_setup);

Is there a reason this can't be a platform device driver?

