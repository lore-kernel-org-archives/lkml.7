Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE27C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE83217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577952571;
	bh=yKk4Yxcs8PbwJF1fYpOt/+cGZY0MXBz9tOWOoJQKoDM=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=auxc9dkXUZf/jRLN3058rCrnixE9nY9VT3NSvGo9zEVRtc+u3GcqUyN4oj6ek4V8d
	 3/gvLdcj9hwC2nfSU6XnDghH4mq+4IHWEHjEvBpUmu6gnOLBVjjz9e1Vq5glASqSAl
	 YqVSpo8rpI9BFeo+5vxCR7GooBlBrP9CLbspxW00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgABIJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbgABIJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:09:30 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE2C215A4;
        Thu,  2 Jan 2020 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577952569;
        bh=yKk4Yxcs8PbwJF1fYpOt/+cGZY0MXBz9tOWOoJQKoDM=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=nsBAoR7hGS+zpj6oHxmL46hoZd5ZxIZJWuwShLiZjfIcQS+x0LObrojJVAd5yJiDp
         TYsrrNT0w2qKObbn4of2dK+/TgxmvbHdKPQB048voAuK474SI8iv/oInhXAZ37oU4z
         vUGgygKBlgwWUIosCB8XanFDY9Q9kpGan8ALu/nI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <91275d33d6a7c9978a2c70545fde38cd@walle.cc>
References: <20191209233305.18619-1-michael@walle.cc> <20191209233305.18619-2-michael@walle.cc> <20191224080536.B0C99206CB@mail.kernel.org> <91275d33d6a7c9978a2c70545fde38cd@walle.cc>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 2/2] clk: fsl-sai: new driver
User-Agent: alot/0.8.1
Date:   Thu, 02 Jan 2020 00:09:28 -0800
Message-Id: <20200102080929.0EE2C215A4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Walle (2020-01-01 07:15:32)
>=20
> Hi Stephen,
>=20
> thanks for the review.
>=20
> Am 2019-12-24 09:05, schrieb Stephen Boyd:
> > Quoting Michael Walle (2019-12-09 15:33:05)
> >> diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
> >> new file mode 100644
> >> index 000000000000..b92054d15ab1
> >> --- /dev/null
> >> +++ b/drivers/clk/clk-fsl-sai.c
> >> @@ -0,0 +1,84 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Freescale SAI BCLK as a generic clock driver
> >> + *
> >> + * Copyright 2019 Kontron Europe GmbH
> >> + */
> >> +
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/err.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#define I2S_CSR                0x00
> >> +#define I2S_CR2                0x08
> >> +#define CSR_BCE_BIT    28
> >> +#define CR2_BCD                BIT(24)
> >> +#define CR2_DIV_SHIFT  0
> >> +#define CR2_DIV_WIDTH  8
> >> +
> >> +struct fsl_sai_clk {
> >> +       struct clk_divider div;
> >> +       struct clk_gate gate;
> >> +       spinlock_t lock;
> >> +};
> >> +
> >> +static void __init fsl_sai_clk_setup(struct device_node *node)
> >> +{
> >> +       const char *clk_name =3D node->name;
> >> +       struct fsl_sai_clk *sai_clk;
> >> +       unsigned int num_parents;
> >> +       const char *parent_name;
> >> +       void __iomem *base;
> >> +       struct clk_hw *hw;
> >> +
> >> +       num_parents =3D of_clk_get_parent_count(node);
> >> +       if (!num_parents) {
> >> +               pr_err("%s: no parent found", clk_name);
> >> +               return;
> >> +       }
> >> +
> >> +       parent_name =3D of_clk_get_parent_name(node, 0);
> >=20
> > Could this use the new way of specifying clk parents so that we don't
> > have to query DT for parent names and just let the core framework do it
> > whenever it needs to?
>=20
> you mean specifying parent_data with .index =3D 0? Seems like=20
> clk_composite
> does not support this. The parent can only be specified by supplying the
> clock names.
>=20
> I could add that in a separate patch. What do you think about the
> following new functions, where a driver can use parent_data instead
> of parent_names.

I started doing this in
https://lkml.kernel.org/r/20190830150923.259497-1-sboyd@kernel.org but I
never got around to the composite clks. Sounds fine to add this new API
for your use case.

>=20
> +struct clk *clk_register_composite_pdata(struct device *dev, const char =

> *name,
> +               const struct clk_parent_data *parent_data,
> +               struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
> +               struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
> +               struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
> +               unsigned long flags);
>=20
> +struct clk_hw *clk_hw_register_composite_pdata(struct device *dev,
> +               const char *name, const struct clk_parent_data=20
> *parent_data,
> +               struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
> +               struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
> +               struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
> +               unsigned long flags);
>=20
>=20
> >> +
> >> +       sai_clk =3D kzalloc(sizeof(*sai_clk), GFP_KERNEL);
> >> +       if (!sai_clk)
> >> +               return;
> >> +
> >> +       base =3D of_iomap(node, 0);
> >> +       if (base =3D=3D NULL) {
> >> +               pr_err("%s: failed to map register space", clk_name);
> >> +               goto err;
> >> +       }
> >> +
> >> +       spin_lock_init(&sai_clk->lock);
> >> +
> >> +       sai_clk->gate.reg =3D base + I2S_CSR;
> >> +       sai_clk->gate.bit_idx =3D CSR_BCE_BIT;
> >> +       sai_clk->gate.lock =3D &sai_clk->lock;
> >> +
> >> +       sai_clk->div.reg =3D base + I2S_CR2;
> >> +       sai_clk->div.shift =3D CR2_DIV_SHIFT;
> >> +       sai_clk->div.width =3D CR2_DIV_WIDTH;
> >> +       sai_clk->div.lock =3D &sai_clk->lock;
> >> +
> >> +       /* set clock direction, we are the BCLK master */
> >=20
> > Should this configuration come from DT somehow?
>=20
> No, we are always master, because as a slave, there would be no clock
> output ;)

Got it.

>=20
> >> +       writel(CR2_BCD, base + I2S_CR2);
> >> +
> >> +       hw =3D clk_hw_register_composite(NULL, clk_name, &parent_name,=
=20
> >> 1,
> >> +                                      NULL, NULL,
> >> +                                      &sai_clk->div.hw,=20
> >> &clk_divider_ops,
> >> +                                      &sai_clk->gate.hw,=20
> >> &clk_gate_ops,
> >> +                                      CLK_SET_RATE_GATE);
> >> +       if (IS_ERR(hw))
> >> +               goto err;
> >> +
> >> +       of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
> >> +
> >> +       return;
> >> +
> >> +err:
> >> +       kfree(sai_clk);
> >> +}
> >> +
> >> +CLK_OF_DECLARE(fsl_sai_clk, "fsl,vf610-sai-clock",=20
> >> fsl_sai_clk_setup);
> >=20
> > Is there a reason this can't be a platform device driver?
>=20
> I don't think so, the user will be a sound codec for now. I'll convert=20
> it
> to a platform device, in that case I could also use the devm_ variants.
>=20

Awesome. Thanks!

