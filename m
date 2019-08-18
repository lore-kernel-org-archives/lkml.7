Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC449C3A59B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBF62173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566091323;
	bh=xejrLwa66URdSbHgEWH+VYlZlmVMdEM+Iat9Fp4d62g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=rPJR1Uk4FPekpTHcabjCqqHveylqxbTKNrf03gQ5LliijY6o/4z1EmqY0r4b0r8q5
	 wBjFrq1lKqQPOGUm/nDYJp/34HVvtaC2Kxx0mnA5o+VY1CL9VF73YKqAsRnlzj5SMW
	 1G3Q3BYT/0NPHV/3CzabyqmjTr92Ldlt4I5Q0D7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfHRBWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 21:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfHRBWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 21:22:00 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF652077C;
        Sun, 18 Aug 2019 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566091319;
        bh=xejrLwa66URdSbHgEWH+VYlZlmVMdEM+Iat9Fp4d62g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YNtSfO44v0PazpS7CkN2kGoRs8D5ceC8i+mcj5BdB3R9iAUCdx1C9j7NQGD0NIrKc
         B2hn3vF6u13fvWoHxlo3os7i3BfLCMDm+O3UVl8hW2wUYjnNnlNmaobgWSV3eqPNy8
         P7TroKe4pKbyHpRLa7/hULRqGBAPgP4Uutwh39lU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190817035557.GC14652@Mani-XPS-13-9360>
References: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org> <20190705151440.20844-5-manivannan.sadhasivam@linaro.org> <20190808051600.4EF7D2186A@mail.kernel.org> <20190817035557.GC14652@Mani-XPS-13-9360>
Subject: Re: [PATCH 4/5] clk: Add driver for Bitmain BM1880 SoC clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
User-Agent: alot/0.8.1
Date:   Sat, 17 Aug 2019 18:21:58 -0700
Message-Id: <20190818012159.1EF652077C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-08-16 20:55:57)
> Hi Stephen,
>=20
> On Wed, Aug 07, 2019 at 10:15:59PM -0700, Stephen Boyd wrote:
> > Quoting Manivannan Sadhasivam (2019-07-05 08:14:39)
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index fc1e0cf44995..ffc61ed85ade 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -304,6 +304,12 @@ config COMMON_CLK_FIXED_MMIO
> > >         help
> > >           Support for Memory Mapped IO Fixed clocks
> > > =20
> > > +config COMMON_CLK_BM1880
> > > +       bool "Clock driver for Bitmain BM1880 SoC"
> > > +       depends on ARCH_BITMAIN || COMPILE_TEST
> > > +       help
> > > +         This driver supports the clocks on Bitmain BM1880 SoC.
> >=20
> > Can you add this config somewhere else besides the end? Preferably
> > close to alphabetically in this file.
> >=20
>=20
> Okay. I got confused by the fact that Makefile is sorted but not the
> Kconfig.

Ok. I'll make a reminder to sort the Kconfig after -rc1 next time.

>=20
> > > +
> > >  source "drivers/clk/actions/Kconfig"
> > >  source "drivers/clk/analogbits/Kconfig"
> > >  source "drivers/clk/bcm/Kconfig"
> > > diff --git a/drivers/clk/clk-bm1880.c b/drivers/clk/clk-bm1880.c
> > > new file mode 100644
> > > index 000000000000..26cdb75bb936
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-bm1880.c
[....]
> > > +
> > > +struct clk *bm1880_clk_register_pll(const struct bm1880_pll_clock *p=
ll_clk,
> > > +                                   void __iomem *sys_base)
> > > +{
> > > +       struct bm1880_pll_hw_clock *pll_hw;
> > > +       struct clk_init_data init;
> > > +       struct clk_hw *hw;
> > > +       int err;
> > > +
> > > +       pll_hw =3D kzalloc(sizeof(*pll_hw), GFP_KERNEL);
> > > +       if (!pll_hw)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       init.name =3D pll_clk->name;
> > > +       init.ops =3D &bm1880_pll_ops;
> > > +       init.flags =3D pll_clk->flags;
> > > +       init.parent_names =3D &pll_clk->parent;
> >=20
> > Can you use the new way of specifying parents instead of using strings
> > for everything?
> >=20
>=20
> Sure, will do it for clocks which doesn't use helper APIs.
>=20
> > > +       init.num_parents =3D 1;
> > > +
> > > +       pll_hw->hw.init =3D &init;
> > > +       pll_hw->pll.reg =3D pll_clk->reg;
> > > +       pll_hw->base =3D sys_base;
> > > +
> > > +       hw =3D &pll_hw->hw;
> > > +       err =3D clk_hw_register(NULL, hw);
> > > +
> > > +       if (err) {
> > > +               kfree(pll_hw);
> > > +               return ERR_PTR(err);
> > > +       }
> > > +
> > > +       return hw->clk;
> >=20
> > Can this return the clk_hw pointer instead?
> >=20
>=20
> What is the benefit? I see that only hw:init is going to be NULL in futur=
e.

Eventually we will remove ->clk from struct clk_hw and then this will
break. It also clearly makes this driver a clk provider driver and not a
clk consumer.

> So, I'll keep it as it is.

Please no!

> > > +               bm1880_clk_unregister_pll(data->clk_data.clks[clks[i]=
.id]);
> > > +
> > > +       return PTR_ERR(clk);
> > > +}
> > > +
> > > +int bm1880_clk_register_mux(const struct bm1880_mux_clock *clks,
> > > +                           int num_clks, struct bm1880_clock_data *d=
ata)
> > > +{
> > > +       struct clk *clk;
> > > +       void __iomem *sys_base =3D data->sys_base;
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < num_clks; i++) {
> > > +               clk =3D clk_register_mux(NULL, clks[i].name,
> >=20
> > Can you use the clk_hw based APIs for generic type clks?
> >=20
>=20
> IMO using helper APIs greatly reduce code size and makes the driver
> look more clean. So I prefer to use the helpers wherever applicable.
> When you plan to deprecate those, I'll switch over to plain clk_hw APIs.

We have clk_hw_register_mux(). Please use it. The clk based registration
APIs are deprecated.

> > > +       kfree(clk_data);
> > > +}
> > > +
> > > +CLK_OF_DECLARE_DRIVER(bm1880_clk, "bitmain,bm1880-clk", bm1880_clk_i=
nit);
> >=20
> > Is there a reason why it can't be a platform driver?
> >=20
>=20
> Hmm, I looked into the majority of drivers which live under `driver/clk/`.
> Most of them are using CLK_OF_DECLARE_DRIVER, so I thought that only driv=
ers
> which have a separate directory are preferred by the maintainers to use
> platform driver way.
>=20
> Anyway, I can switch over to platform driver and that's what I prefer.
>=20

Yes please use a platform driver unless it doesn't work for some reason.
Even then, use a platform driver and CLK_OF_DECLARE_DRIVER() in
conjunction to register the early clks from the OF_DECLARED section and
then adopt the rest to the proper device driver later on. This way we
gain the benefits of driver core.

