Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8BAC004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3600A215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556578575;
	bh=i6OJLEMsxvHyiCFvoFdM8tR4X1TxEiuZEYRdZCCOdrU=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=AqMIny/yxm9DuqHIJgE2LvlY6AbjlMNuAEo6oUNW+DiZCXBZwGX7qXB7wQKZiysgy
	 aIms8g53y2Kz0zBvIpg/xqrXTZUyTWXLYNMn7Rskpa/o05rV3ymTXggLtLAzkau+7P
	 fox4CX5oEdt10rkqY67bh1wSnRTEYcRaz1JtOivY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfD2W4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbfD2W4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:56:13 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E45F2075E;
        Mon, 29 Apr 2019 22:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556578571;
        bh=i6OJLEMsxvHyiCFvoFdM8tR4X1TxEiuZEYRdZCCOdrU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=vNKt+gsRRzDrmiNbTK0OkF7HeB1bcIpfnp43HpURLZrLoldO+hLvhsk2qsexaeZU2
         J/dU+kVzK4RQZPeZi1W6iWWpJHI3KlbPiSQ6D54gddt9UMl+h9aT/JTmBQUytAO67C
         qmYB+JCIB+/nk4+6xsMlxYAsTWI4VEGkYpaE6sCs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190411082733.3736-4-paul.walmsley@sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com> <20190411082733.3736-4-paul.walmsley@sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 3/3] clk: sifive: add a driver for the SiFive FU540 PRCI IP block
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>
Message-ID: <155657857064.168659.1879040965731877610@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 29 Apr 2019 15:56:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-11 01:27:36)
> diff --git a/drivers/clk/sifive/Makefile b/drivers/clk/sifive/Makefile
> new file mode 100644
> index 000000000000..74d58a4c0756
> --- /dev/null
> +++ b/drivers/clk/sifive/Makefile
> @@ -0,0 +1 @@

Any SPDX for this file?

> +obj-$(CONFIG_CLK_SIFIVE_FU540_PRCI)    +=3D fu540-prci.o
> diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-p=
rci.c
> new file mode 100644
> index 000000000000..ecf1dfbcc645
> --- /dev/null
> +++ b/drivers/clk/sifive/fu540-prci.c
> @@ -0,0 +1,630 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 SiFive, Inc.
> + * Wesley Terpstra
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Please remove above two hunks as they're part of SPDX already.

> + *
> + * The FU540 PRCI implements clock and reset control for the SiFive
> + * FU540-C000 chip.  This driver assumes that it has sole control
> + * over all PRCI resources.
> + *
> + * This driver is based on the PRCI driver written by Wesley Terpstra:
> + * https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d45=
6d221b2ee56bb60
> + *
> + * References:
> + * - SiFive FU540-C000 manual v1p0, Chapter 7 "Clocking and Reset"
> + */
> +
> +#include <dt-bindings/clock/sifive-fu540-prci.h>

Please put this after linux.

> +#include <linux/clkdev.h>

Do you need clkdev? Isn't this all DT based? If possible, please don't
use clkdev.

> +#include <linux/clk-provider.h>
> +#include <linux/clk/analogbits-wrpll-cln28hpc.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_clk.h>

Is this used?

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/*
> + * EXPECTED_CLK_PARENT_COUNT: how many parent clocks this driver expects:
> + *     hfclk and rtcclk
> + */
> +#define EXPECTED_CLK_PARENT_COUNT              2
> +
> +/*
> + * Register offsets and bitmasks
> + */
> +
> +/* COREPLLCFG0 */
> +#define PRCI_COREPLLCFG0_OFFSET                        0x4
> +# define PRCI_COREPLLCFG0_DIVR_SHIFT           0
> +# define PRCI_COREPLLCFG0_DIVR_MASK            (0x3f << PRCI_COREPLLCFG0=
_DIVR_SHIFT)
> +# define PRCI_COREPLLCFG0_DIVF_SHIFT           6
> +# define PRCI_COREPLLCFG0_DIVF_MASK            (0x1ff << PRCI_COREPLLCFG=
0_DIVF_SHIFT)
> +# define PRCI_COREPLLCFG0_DIVQ_SHIFT           15
> +# define PRCI_COREPLLCFG0_DIVQ_MASK            (0x7 << PRCI_COREPLLCFG0_=
DIVQ_SHIFT)
> +# define PRCI_COREPLLCFG0_RANGE_SHIFT          18
> +# define PRCI_COREPLLCFG0_RANGE_MASK           (0x7 << PRCI_COREPLLCFG0_=
RANGE_SHIFT)
> +# define PRCI_COREPLLCFG0_BYPASS_SHIFT         24
> +# define PRCI_COREPLLCFG0_BYPASS_MASK          (0x1 << PRCI_COREPLLCFG0_=
BYPASS_SHIFT)
> +# define PRCI_COREPLLCFG0_FSE_SHIFT            25
> +# define PRCI_COREPLLCFG0_FSE_MASK             (0x1 << PRCI_COREPLLCFG0_=
FSE_SHIFT)
> +# define PRCI_COREPLLCFG0_LOCK_SHIFT           31
> +# define PRCI_COREPLLCFG0_LOCK_MASK            (0x1 << PRCI_COREPLLCFG0_=
LOCK_SHIFT)
> +
> +/* DDRPLLCFG0 */
> +#define PRCI_DDRPLLCFG0_OFFSET                 0xc
> +# define PRCI_DDRPLLCFG0_DIVR_SHIFT            0
> +# define PRCI_DDRPLLCFG0_DIVR_MASK             (0x3f << PRCI_DDRPLLCFG0_=
DIVR_SHIFT)
> +# define PRCI_DDRPLLCFG0_DIVF_SHIFT            6
> +# define PRCI_DDRPLLCFG0_DIVF_MASK             (0x1ff << PRCI_DDRPLLCFG0=
_DIVF_SHIFT)
> +# define PRCI_DDRPLLCFG0_DIVQ_SHIFT            15
> +# define PRCI_DDRPLLCFG0_DIVQ_MASK             (0x7 << PRCI_DDRPLLCFG0_D=
IVQ_SHIFT)
> +# define PRCI_DDRPLLCFG0_RANGE_SHIFT           18
> +# define PRCI_DDRPLLCFG0_RANGE_MASK            (0x7 << PRCI_DDRPLLCFG0_R=
ANGE_SHIFT)
> +# define PRCI_DDRPLLCFG0_BYPASS_SHIFT          24
> +# define PRCI_DDRPLLCFG0_BYPASS_MASK           (0x1 << PRCI_DDRPLLCFG0_B=
YPASS_SHIFT)
> +# define PRCI_DDRPLLCFG0_FSE_SHIFT             25
> +# define PRCI_DDRPLLCFG0_FSE_MASK              (0x1 << PRCI_DDRPLLCFG0_F=
SE_SHIFT)
> +# define PRCI_DDRPLLCFG0_LOCK_SHIFT            31
> +# define PRCI_DDRPLLCFG0_LOCK_MASK             (0x1 << PRCI_DDRPLLCFG0_L=
OCK_SHIFT)
> +
> +/* DDRPLLCFG1 */
> +#define PRCI_DDRPLLCFG1_OFFSET                 0x10
> +# define PRCI_DDRPLLCFG1_CKE_SHIFT             24
> +# define PRCI_DDRPLLCFG1_CKE_MASK              (0x1 << PRCI_DDRPLLCFG1_C=
KE_SHIFT)
> +
> +/* GEMGXLPLLCFG0 */
> +#define PRCI_GEMGXLPLLCFG0_OFFSET              0x1c
> +# define PRCI_GEMGXLPLLCFG0_DIVR_SHIFT         0
> +# define PRCI_GEMGXLPLLCFG0_DIVR_MASK          (0x3f << PRCI_GEMGXLPLLCF=
G0_DIVR_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_DIVF_SHIFT         6
> +# define PRCI_GEMGXLPLLCFG0_DIVF_MASK          (0x1ff << PRCI_GEMGXLPLLC=
FG0_DIVF_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_DIVQ_SHIFT         15
> +# define PRCI_GEMGXLPLLCFG0_DIVQ_MASK          (0x7 << PRCI_GEMGXLPLLCFG=
0_DIVQ_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_RANGE_SHIFT                18
> +# define PRCI_GEMGXLPLLCFG0_RANGE_MASK         (0x7 << PRCI_GEMGXLPLLCFG=
0_RANGE_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_BYPASS_SHIFT       24
> +# define PRCI_GEMGXLPLLCFG0_BYPASS_MASK                (0x1 << PRCI_GEMG=
XLPLLCFG0_BYPASS_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_FSE_SHIFT          25
> +# define PRCI_GEMGXLPLLCFG0_FSE_MASK           (0x1 << PRCI_GEMGXLPLLCFG=
0_FSE_SHIFT)
> +# define PRCI_GEMGXLPLLCFG0_LOCK_SHIFT         31
> +# define PRCI_GEMGXLPLLCFG0_LOCK_MASK          (0x1 << PRCI_GEMGXLPLLCFG=
0_LOCK_SHIFT)
> +
> +/* GEMGXLPLLCFG1 */
> +#define PRCI_GEMGXLPLLCFG1_OFFSET              0x20
> +# define PRCI_GEMGXLPLLCFG1_CKE_SHIFT          24
> +# define PRCI_GEMGXLPLLCFG1_CKE_MASK           (0x1 << PRCI_GEMGXLPLLCFG=
1_CKE_SHIFT)
> +
> +/* CORECLKSEL */
> +#define PRCI_CORECLKSEL_OFFSET                 0x24
> +# define PRCI_CORECLKSEL_CORECLKSEL_SHIFT      0
> +# define PRCI_CORECLKSEL_CORECLKSEL_MASK       (0x1 << PRCI_CORECLKSEL_C=
ORECLKSEL_SHIFT)
> +
> +/* DEVICESRESETREG */
> +#define PRCI_DEVICESRESETREG_OFFSET                    0x28
> +# define PRCI_DEVICESRESETREG_DDR_CTRL_RST_N_SHIFT     0
> +# define PRCI_DEVICESRESETREG_DDR_CTRL_RST_N_MASK      (0x1 << PRCI_DEVI=
CESRESETREG_DDR_CTRL_RST_N_SHIFT)
> +# define PRCI_DEVICESRESETREG_DDR_AXI_RST_N_SHIFT      1
> +# define PRCI_DEVICESRESETREG_DDR_AXI_RST_N_MASK       (0x1 << PRCI_DEVI=
CESRESETREG_DDR_AXI_RST_N_SHIFT)
> +# define PRCI_DEVICESRESETREG_DDR_AHB_RST_N_SHIFT      2
> +# define PRCI_DEVICESRESETREG_DDR_AHB_RST_N_MASK       (0x1 << PRCI_DEVI=
CESRESETREG_DDR_AHB_RST_N_SHIFT)
> +# define PRCI_DEVICESRESETREG_DDR_PHY_RST_N_SHIFT      3
> +# define PRCI_DEVICESRESETREG_DDR_PHY_RST_N_MASK       (0x1 << PRCI_DEVI=
CESRESETREG_DDR_PHY_RST_N_SHIFT)
> +# define PRCI_DEVICESRESETREG_GEMGXL_RST_N_SHIFT       5
> +# define PRCI_DEVICESRESETREG_GEMGXL_RST_N_MASK                (0x1 << P=
RCI_DEVICESRESETREG_GEMGXL_RST_N_SHIFT)
> +
> +/* CLKMUXSTATUSREG */
> +#define PRCI_CLKMUXSTATUSREG_OFFSET                    0x2c
> +# define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_SHIFT    1
> +# define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_MASK     (0x1 << PRCI_CLKM=
UXSTATUSREG_TLCLKSEL_STATUS_SHIFT)

I suspect a bunch of these macros could be simplified with FIELD_GET()
and FIELD_SET()?

> +
> +/*
> + * Private structures
> + */
> +
> +/**
> + * struct __prci_data - per-device-instance data
> + * @va: base virtual address of the PRCI IP block
> + * @hw_clks: encapsulates struct clk_hw records
> + *
> + * PRCI per-device instance data

What does PRCI stand for? The acronym is spelled out in Kconfig but not
this file.

> + */
> +struct __prci_data {
> +       void __iomem *va;
> +       struct clk_hw_onecell_data hw_clks;
> +};
> +
> +/**
> + * struct __prci_wrpll_data - WRPLL configuration and integration data
> + * @c: WRPLL current configuration record
> + * @enable_bypass: fn ptr to code to bypass the WRPLL (if applicable; el=
se NULL)
> + * @disable_bypass: fn ptr to code to not bypass the WRPLL (or NULL)

We know it's a function pointer, perhaps just "bypass the WRPLL (if
applicable)" and "unbypass the WRLPLL (if applicable)".

> + * @cfg0_offs: WRPLL CFG0 register offset (in bytes) from the PRCI base =
address
> + *
> + * @enable_bypass and @disable_bypass are used for WRPLL instances
> + * that contain a separate external glitchless clock mux downstream
> + * from the PLL.  The WRPLL internal bypass mux is not glitchless.
> + */
> +struct __prci_wrpll_data {
> +       struct analogbits_wrpll_cfg c;
> +       void (*enable_bypass)(struct __prci_data *pd);
> +       void (*disable_bypass)(struct __prci_data *pd);
> +       u8 cfg0_offs;
> +};
> +
> +/**
> + * struct __prci_clock - describes a clock device managed by PRCI
> + * @name: user-readable clock name string - should match the manual
> + * @parent_name: parent name for this clock
> + * @ops: struct clk_ops for the Linux clock framework to use for control
> + * @hw: Linux-private clock data
> + * @pwd: WRPLL-specific data, associated with this clock (if not NULL)
> + * @pd: PRCI-specific data associated with this clock (if not NULL)
> + *
> + * PRCI clock data.  Used by the PRCI driver to register PRCI-provided
> + * clocks to the Linux clock infrastructure.
> + */
> +struct __prci_clock {
> +       const char *name;
> +       const char *parent_name;
> +       const struct clk_ops *ops;
> +       struct clk_hw hw;
> +       struct __prci_wrpll_data *pwd;
> +       struct __prci_data *pd;
> +};
> +
> +#define clk_hw_to_prci_clock(pwd) container_of(pwd, struct __prci_clock,=
 hw)
> +
> +/*
> + * Private functions
> + */
> +
> +/**
> + * __prci_readl() - read from a PRCI register
> + * @pd: PRCI context
> + * @offs: register offset to read from (in bytes, from PRCI base address)
> + *
> + * Read the register located at offset @offs from the base virtual
> + * address of the PRCI register target described by @pd, and return
> + * the value to the caller.
> + *
> + * Context: Any context.
> + *
> + * Return: the contents of the register described by @pd and @offs.
> + */
> +static u32 __prci_readl(struct __prci_data *pd, u32 offs)
> +{
> +       return readl_relaxed(pd->va + offs);
> +}
> +
> +static void __prci_writel(u32 v, u32 offs, struct __prci_data *pd)

No kernel-doc for this wrapper? Do we need kernel-doc for the read
wrapper?

> +{
> +       return writel_relaxed(v, pd->va + offs);
> +}
> +
> +/* WRPLL-related private functions */
> +
> +/**
> + * __prci_wrpll_unpack() - unpack WRPLL configuration registers into par=
ameters
> + * @c: ptr to a struct analogbits_wrpll_cfg record to write config into
> + * @r: value read from the PRCI PLL configuration register
> + *
> + * Given a value @r read from an FU540 PRCI PLL configuration register,
> + * split it into fields and populate it into the WRPLL configuration rec=
ord
> + * pointed to by @c.
> + *
> + * The COREPLLCFG0 macros are used below, but the other *PLLCFG0 macros
> + * have the same register layout.
> + *
> + * Context: Any context.
> + */
> +static void __prci_wrpll_unpack(struct analogbits_wrpll_cfg *c, u32 r)
> +{
> +       u32 v;
> +
> +       v =3D r & PRCI_COREPLLCFG0_DIVR_MASK;
> +       v >>=3D PRCI_COREPLLCFG0_DIVR_SHIFT;
> +       c->divr =3D v;
> +
> +       v =3D r & PRCI_COREPLLCFG0_DIVF_MASK;
> +       v >>=3D PRCI_COREPLLCFG0_DIVF_SHIFT;
> +       c->divf =3D v;
> +
> +       v =3D r & PRCI_COREPLLCFG0_DIVQ_MASK;
> +       v >>=3D PRCI_COREPLLCFG0_DIVQ_SHIFT;
> +       c->divq =3D v;
> +
> +       v =3D r & PRCI_COREPLLCFG0_RANGE_MASK;
> +       v >>=3D PRCI_COREPLLCFG0_RANGE_SHIFT;
> +       c->range =3D v;
> +
> +       c->flags &=3D (WRPLL_FLAGS_INT_FEEDBACK_MASK |
> +                    WRPLL_FLAGS_EXT_FEEDBACK_MASK);
> +
> +       /* external feedback mode not supported */
> +       c->flags |=3D WRPLL_FLAGS_INT_FEEDBACK_MASK;
> +}
> +
> +/**
> + * __prci_wrpll_pack() - pack PLL configuration parameters into a regist=
er value
> + * @c: pointer to a struct analogbits_wrpll_cfg record containing the PL=
L's cfg
> + *
> + * Using a set of WRPLL configuration values pointed to by @c,
> + * assemble a PRCI PLL configuration register value, and return it to
> + * the caller.
> + *
> + * Context: Any context.  Caller must ensure that the contents of the
> + *          record pointed to by @c do not change during the execution
> + *          of this function.
> + *
> + * Returns: a value suitable for writing into a PRCI PLL configuration
> + *          register
> + */
> +static u32 __prci_wrpll_pack(struct analogbits_wrpll_cfg * const c)

Shouldn't that be const struct analogbits_wrpll_cfg *c?

> +{
> +       u32 r =3D 0;
> +
> +       r |=3D c->divr << PRCI_COREPLLCFG0_DIVR_SHIFT;
> +       r |=3D c->divf << PRCI_COREPLLCFG0_DIVF_SHIFT;
> +       r |=3D c->divq << PRCI_COREPLLCFG0_DIVQ_SHIFT;
> +       r |=3D c->range << PRCI_COREPLLCFG0_RANGE_SHIFT;
> +
> +       /* external feedback mode not supported */
> +       r |=3D PRCI_COREPLLCFG0_FSE_MASK;
> +
> +       return r;
> +}
> +
> +/**
> + * __prci_wrpll_read_cfg() - read the WRPLL configuration from the PRCI
> + * @pd: PRCI context
> + * @pwd: PRCI WRPLL metadata
> + *
> + * Read the current configuration of the PLL identified by @pwd from
> + * the PRCI identified by @pd, and store it into the local configuration
> + * cache in @pwd.
> + *
> + * Context: Any context.  Caller must prevent the records pointed to by
> + *          @pd and @pwd from changing during execution.
> + */
> +static void __prci_wrpll_read_cfg(struct __prci_data *pd,

Maybe call this __prci_wrpll_cache_cfg?

> +                                 struct __prci_wrpll_data *pwd)
> +{
> +       __prci_wrpll_unpack(&pwd->c, __prci_readl(pd, pwd->cfg0_offs));
> +}
> +
> +/**
> + * __prci_wrpll_write_cfg() - write WRPLL configuration into the PRCI
> + * @pd: PRCI context
> + * @pwd: PRCI WRPLL metadata
> + * @c: WRPLL configuration record to write
> + *
> + * Write the WRPLL configuration described by @c into the WRPLL
> + * configuration register identified by @pwd in the PRCI instance
> + * described by @c.  Make a cached copy of the WRPLL's current
> + * configuration so it can be used by other code.
> + *
> + * Context: Any context.  Caller must prevent the records pointed to by
> + *          @pd and @pwd from changing during execution.
> + */
> +static void __prci_wrpll_write_cfg(struct __prci_data *pd,

const pd?

> +                                  struct __prci_wrpll_data *pwd,
> +                                  struct analogbits_wrpll_cfg *c)
> +{
> +       __prci_writel(__prci_wrpll_pack(c), pwd->cfg0_offs, pd);
> +
> +       memcpy(&pwd->c, c, sizeof(struct analogbits_wrpll_cfg));
> +}
> +
> +/* Core clock mux control */
> +
> +/**
> + * __prci_coreclksel_use_hfclk() - switch the CORECLK mux to output HFCLK
> + * @pd: struct __prci_data * for the PRCI containing the CORECLK mux reg
> + *
> + * Switch the CORECLK mux to the HFCLK input source; return once complet=
e.
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PRCI_CORECLKSEL_OFFSET register.
> + */
> +static void __prci_coreclksel_use_hfclk(struct __prci_data *pd)
> +{
> +       u32 r;
> +
> +       r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
> +       r |=3D PRCI_CORECLKSEL_CORECLKSEL_MASK;
> +       __prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
> +
> +       r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET); /* barrier */
> +}
> +
> +/**
> + * __prci_coreclksel_use_corepll() - switch the CORECLK mux to output CO=
REPLL
> + * @pd: struct __prci_data * for the PRCI containing the CORECLK mux reg
> + *
> + * Switch the CORECLK mux to the PLL output clock; return once complete.
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PRCI_CORECLKSEL_OFFSET register.
> + */
> +static void __prci_coreclksel_use_corepll(struct __prci_data *pd)
> +{
> +       u32 r;
> +
> +       r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
> +       r &=3D ~PRCI_CORECLKSEL_CORECLKSEL_MASK;
> +       __prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
> +
> +       r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET); /* barrier */
> +}
> +
> +/*
> + * Linux clock framework integration
> + *
> + * See the Linux clock framework documentation for more information on
> + * these functions.
> + */

Seems like a useless comment.

> +
> +static unsigned long sifive_fu540_prci_wrpll_recalc_rate(struct clk_hw *=
hw,
> +                                                        unsigned long pa=
rent_rate)
> +{
> +       struct __prci_clock *pc =3D clk_hw_to_prci_clock(hw);
> +       struct __prci_wrpll_data *pwd =3D pc->pwd;
> +
> +       return analogbits_wrpll_calc_output_rate(&pwd->c, parent_rate);
> +}
> +
> +static long sifive_fu540_prci_wrpll_round_rate(struct clk_hw *hw,
> +                                              unsigned long rate,
> +                                              unsigned long *parent_rate)
> +{
> +       struct __prci_clock *pc =3D clk_hw_to_prci_clock(hw);
> +       struct __prci_wrpll_data *pwd =3D pc->pwd;
> +       struct analogbits_wrpll_cfg c;
> +
> +       memcpy(&c, &pwd->c, sizeof(c));
> +
> +       analogbits_wrpll_configure_for_rate(&c, rate, *parent_rate);
> +
> +       return analogbits_wrpll_calc_output_rate(&c, *parent_rate);
> +}
> +
> +static int sifive_fu540_prci_wrpll_set_rate(struct clk_hw *hw,
> +                                           unsigned long rate,
> +                                           unsigned long parent_rate)
> +{
> +       struct __prci_clock *pc =3D clk_hw_to_prci_clock(hw);
> +       struct __prci_wrpll_data *pwd =3D pc->pwd;
> +       struct __prci_data *pd =3D pc->pd;
> +       int r;
> +
> +       r =3D analogbits_wrpll_configure_for_rate(&pwd->c, rate, parent_r=
ate);
> +       if (r)
> +               return r;
> +
> +       if (pwd->enable_bypass)
> +               pwd->enable_bypass(pd);
> +
> +       __prci_wrpll_write_cfg(pd, pwd, &pwd->c);
> +
> +       udelay(analogbits_wrpll_calc_max_lock_us(&pwd->c));

Can it be usleep_range()? This is a set_rate path after all.

> +
> +       if (pwd->disable_bypass)
> +               pwd->disable_bypass(pd);
> +
> +       return 0;
> +}
[...]
> +/* TLCLKSEL clock integration */
> +
> +static unsigned long sifive_fu540_prci_tlclksel_recalc_rate(struct clk_h=
w *hw,
> +                                                           unsigned long=
 parent_rate)
> +{
> +       struct __prci_clock *pc =3D clk_hw_to_prci_clock(hw);
> +       struct __prci_data *pd =3D pc->pd;
> +       u32 v;
> +       u8 div;
> +
> +       v =3D __prci_readl(pd, PRCI_CLKMUXSTATUSREG_OFFSET);
> +       v &=3D PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_MASK;
> +       div =3D v ? 1 : 2;

I thought there was a helper for this 1 vs. 2 descision?

> +
> +       return div_u64(parent_rate, div);

Why use div_u64? parent_rate is unsigned long.

> +}
> +
> +static const struct clk_ops sifive_fu540_prci_tlclksel_clk_ops =3D {
> +       .recalc_rate =3D sifive_fu540_prci_tlclksel_recalc_rate,
> +};
> +
> +/*
> + * PRCI integration data for each WRPLL instance
> + */
> +
> +static struct __prci_wrpll_data __prci_corepll_data =3D {
> +       .cfg0_offs =3D PRCI_COREPLLCFG0_OFFSET,
> +       .enable_bypass =3D __prci_coreclksel_use_hfclk,
> +       .disable_bypass =3D __prci_coreclksel_use_corepll,
> +};
> +
> +static struct __prci_wrpll_data __prci_ddrpll_data =3D {
> +       .cfg0_offs =3D PRCI_DDRPLLCFG0_OFFSET,
> +};
> +
> +static struct __prci_wrpll_data __prci_gemgxlpll_data =3D {
> +       .cfg0_offs =3D PRCI_GEMGXLPLLCFG0_OFFSET,
> +};
> +
> +/*
> + * List of clock controls provided by the PRCI
> + */
> +
> +static struct __prci_clock __prci_init_clocks[] =3D {
> +       [PRCI_CLK_COREPLL] =3D {
> +               .name =3D "corepll",
> +               .parent_name =3D "hfclk",
> +               .ops =3D &sifive_fu540_prci_wrpll_clk_ops,
> +               .pwd =3D &__prci_corepll_data,

Why is this a pointer stored in here? Put another way, why can't we
store the whole structure for the prci_wrpll_data directly inside the
prci_clock structure?

> +       },
> +       [PRCI_CLK_DDRPLL] =3D {
> +               .name =3D "ddrpll",
> +               .parent_name =3D "hfclk",
> +               .ops =3D &sifive_fu540_prci_wrpll_ro_clk_ops,
> +               .pwd =3D &__prci_ddrpll_data,
> +       },
> +       [PRCI_CLK_GEMGXLPLL] =3D {
> +               .name =3D "gemgxlpll",
> +               .parent_name =3D "hfclk",
> +               .ops =3D &sifive_fu540_prci_wrpll_clk_ops,
> +               .pwd =3D &__prci_gemgxlpll_data,
> +       },
> +       [PRCI_CLK_TLCLK] =3D {
> +               .name =3D "tlclk",
> +               .parent_name =3D "corepll",
> +               .ops =3D &sifive_fu540_prci_tlclksel_clk_ops,
> +       },
> +};
> +
> +/**
> + * __prci_register_clocks() - register clock controls in the PRCI with L=
inux
> + * @dev: Linux struct device *

Maybe 'device registering clks'. Or just collapse this into 'probe'
below.

> + *
> + * Register the list of clock controls described in __prci_init_plls[] w=
ith
> + * the Linux clock framework.
> + *
> + * Return: 0 upon success or a negative error code upon failure.
> + */
> +static int __prci_register_clocks(struct device *dev, struct __prci_data=
 *pd)
> +{
> +       struct clk_init_data init;
> +       struct __prci_clock *pic;
> +       int parent_count, i, clk_hw_count, r;
> +
> +       parent_count =3D of_clk_get_parent_count(dev->of_node);
> +       if (parent_count !=3D EXPECTED_CLK_PARENT_COUNT) {

We don't need to validate DT. That's what DT schemas are for.

> +               dev_err(dev, "expected only two parent clocks, found %d\n=
",
> +                       parent_count);
> +               return -EINVAL;
> +       }
> +
> +       memset(&init, 0, sizeof(struct clk_init_data));

sizeof(init)? Or just struct clk_init_data init =3D { };

> +
> +       /* Register PLLs */
> +       clk_hw_count =3D sizeof(__prci_init_clocks) / sizeof(struct __prc=
i_clock);

Is this ARRAY_SIZE()?

> +
> +       for (i =3D 0; i < clk_hw_count; ++i) {
> +               pic =3D &__prci_init_clocks[i];
> +
> +               init.name =3D pic->name;
> +               init.parent_names =3D &pic->parent_name;
> +               init.num_parents =3D 1;
> +               init.ops =3D pic->ops;
> +               pic->hw.init =3D &init;
> +
> +               pic->pd =3D pd;
> +
> +               if (pic->pwd)
> +                       __prci_wrpll_read_cfg(pd, pic->pwd);
> +
> +               r =3D devm_clk_hw_register(dev, &pic->hw);
> +               if (r) {
> +                       dev_warn(dev, "Failed to register clock %s: %d\n",
> +                                init.name, r);
> +                       return r;
> +               }
> +
> +               r =3D clk_hw_register_clkdev(&pic->hw, pic->name, dev_nam=
e(dev));
> +               if (r) {
> +                       dev_warn(dev, "Failed to register clkdev for %s: =
%d\n",

But we return right after, and don't use devm_() to register other
clkdevs so we leak some here? I hope clkdev can be removed from this
driver.

> +                                init.name, r);
> +                       return r;
> +               }
> +
> +               pd->hw_clks.hws[i] =3D &pic->hw;
> +       }
> +
> +       pd->hw_clks.num =3D i;
> +
> +       r =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                       &pd->hw_clks);
> +       if (r) {
> +               dev_err(dev, "could not add hw_provider: %d\n", r);
> +               return r;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Linux device model integration
> + *
> + * See the Linux device model documentation for more information about
> + * these functions.
> + */

Can you remove this comment? It doesn't seem worthwhile.

