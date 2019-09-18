Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78410C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E14B218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568782813;
	bh=bPIDjXgt58yLO+E6U9+WUer8Pfnp19M85GLLbvZUqWI=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=NBWkB1ijZ0aOaBS8VYPGArWnxGBZW39/YwvVEogwPi5oYpX3f7oGVlRL5s6AJ2Xpw
	 IU7KP618WsBrDlFB2zuIizkU03dhGzDS/hb0dtYxjj0UOYiP60X1TirQqUVFvxv/X5
	 N6o/5qAf+xsQzQVuWvtvfZgQbiK0h5OHdQRXhM5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfIRFAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfIRFAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:00:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B4021848;
        Wed, 18 Sep 2019 05:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568782810;
        bh=bPIDjXgt58yLO+E6U9+WUer8Pfnp19M85GLLbvZUqWI=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=c7MRl97mTF+9eg+ce79cicSM8ZPJwC8fgaW/lFvvFzUpcmveKWOUof1TmYwKkjNk9
         RhYY0/kT7UIpkU0eY2tCwDFGejcsJwSVeVglSh1cyv5LImZf7p0FaOpwTvz9RyPqvc
         V6KXo0hcPUlVdWGt1wQu+MNC7JgiVrasqV/eIUNQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190918013459.15966-2-dinguyen@kernel.org>
References: <20190918013459.15966-1-dinguyen@kernel.org> <20190918013459.15966-2-dinguyen@kernel.org>
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: socfpga: agilex: add clock driver for the Agilex platform
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 22:00:09 -0700
Message-Id: <20190918050010.74B4021848@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2019-09-17 18:34:59)
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 0cad76021297..ef2c96c0f1e0 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -18,6 +18,7 @@ endif
> =20
>  # hardware specific clock types
>  # please keep this section sorted lexicographically by file path name
> +obj-$(CONFIG_ARCH_AGILEX)              +=3D socfpga/

Sort by filepath, so all files come before all directories, and
directories have a different section in this file.

>  obj-$(CONFIG_MACH_ASM9260)             +=3D clk-asm9260.o
>  obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)    +=3D clk-axi-clkgen.o
>  obj-$(CONFIG_ARCH_AXXIA)               +=3D clk-axm5516.o
> diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
> index ce5aa7802eb8..bf736f8d201a 100644
> --- a/drivers/clk/socfpga/Makefile
> +++ b/drivers/clk/socfpga/Makefile
> @@ -3,3 +3,5 @@ obj-$(CONFIG_ARCH_SOCFPGA) +=3D clk.o clk-gate.o clk-pll.=
o clk-periph.o
>  obj-$(CONFIG_ARCH_SOCFPGA) +=3D clk-pll-a10.o clk-periph-a10.o clk-gate-=
a10.o
>  obj-$(CONFIG_ARCH_STRATIX10) +=3D clk-s10.o
>  obj-$(CONFIG_ARCH_STRATIX10) +=3D clk-pll-s10.o clk-periph-s10.o clk-gat=
e-s10.o
> +obj-$(CONFIG_ARCH_AGILEX) +=3D clk-agilex.o
> +obj-$(CONFIG_ARCH_AGILEX) +=3D clk-pll-s10.o clk-periph-s10.o clk-gate-s=
10.o

Preferably keep this sorted on Kconfig name.

> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-a=
gilex.c
> new file mode 100644
> index 000000000000..7d5093f0b2c9
> --- /dev/null
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019, Intel Corporation
> + */
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/agilex-clock.h>
> +
> +#include "stratix10-clk.h"
> +
> +static const char * const pll_mux[] =3D { "osc1", "cb-intosc-hs-div2-clk=
",
> +                                       "f2s-free-clk",};
> +static const char * const cntr_mux[] =3D { "main_pll", "periph_pll",
> +                                        "osc1", "cb-intosc-hs-div2-clk",
> +                                        "f2s-free-clk"};
> +static const char * const boot_mux[] =3D { "osc1", "cb-intosc-hs-div2-cl=
k",};
> +
> +static const char * const mpu_free_mux[] =3D {"main_pll_c0", "peri_pll_c=
0",
> +                                           "osc1", "cb-intosc-hs-div2-cl=
k",
> +                                           "f2s-free-clk"};
> +
> +static const char * const noc_free_mux[] =3D {"main_pll_c1", "peri_pll_c=
1",
> +                                           "osc1", "cb-intosc-hs-div2-cl=
k",
> +                                           "f2s-free-clk"};
> +
> +static const char * const emaca_free_mux[] =3D {"main_pll_c2", "peri_pll=
_c2",
> +                                             "osc1", "cb-intosc-hs-div2-=
clk",
> +                                             "f2s-free-clk"};
> +static const char * const emacb_free_mux[] =3D {"main_pll_c3", "peri_pll=
_c3",
> +                                             "osc1", "cb-intosc-hs-div2-=
clk",
> +                                             "f2s-free-clk"};
> +static const char * const emac_ptp_free_mux[] =3D {"main_pll_c3", "peri_=
pll_c3",
> +                                             "osc1", "cb-intosc-hs-div2-=
clk",
> +                                             "f2s-free-clk"};
> +static const char * const gpio_db_free_mux[] =3D {"main_pll_c3", "peri_p=
ll_c3",
> +                                             "osc1", "cb-intosc-hs-div2-=
clk",
> +                                             "f2s-free-clk"};
> +static const char * const psi_ref_free_mux[] =3D {"main_pll_c3", "peri_p=
ll_c3",
> +                                             "osc1", "cb-intosc-hs-div2-=
clk",
> +                                             "f2s-free-clk"};
> +static const char * const sdmmc_free_mux[] =3D {"main_pll_c3", "peri_pll=
_c3",
> +                                             "osc1", "cb-intosc-hs-div2-=
clk",
> +                                             "f2s-free-clk"};
> +static const char * const s2f_usr0_free_mux[] =3D {"main_pll_c2", "peri_=
pll_c2",
> +                                                "osc1", "cb-intosc-hs-di=
v2-clk",
> +                                                "f2s-free-clk"};
> +static const char * const s2f_usr1_free_mux[] =3D {"main_pll_c2", "peri_=
pll_c2",
> +                                                "osc1", "cb-intosc-hs-di=
v2-clk",
> +                                                "f2s-free-clk"};
> +static const char * const mpu_mux[] =3D { "mpu_free_clk", "boot_clk",};
> +
> +static const char * const s2f_usr0_mux[] =3D {"f2s-free-clk", "boot_clk"=
};
> +static const char * const emac_mux[] =3D {"emaca_free_clk", "emacb_free_=
clk"};
> +static const char * const noc_mux[] =3D {"noc_free_clk", "boot_clk"};
> +
> +/* clocks in AO (always on) controller */
> +static const struct stratix10_pll_clock agilex_pll_clks[] =3D {
> +       { AGILEX_BOOT_CLK, "boot_clk", boot_mux, ARRAY_SIZE(boot_mux), 0,
> +         0x0},
> +       { AGILEX_MAIN_PLL_CLK, "main_pll", pll_mux, ARRAY_SIZE(pll_mux),
> +         0, 0x48},
> +       { AGILEX_PERIPH_PLL_CLK, "periph_pll", pll_mux, ARRAY_SIZE(pll_mu=
x),
> +         0, 0x9c},
> +};
> +
> +static const struct stratix10_perip_c_clock agilex_main_perip_c_clks[] =
=3D {
> +       { AGILEX_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0, =
0x58},
> +       { AGILEX_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0, =
0x5C},
> +       { AGILEX_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0, =
0x64},
> +       { AGILEX_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0, =
0x68},
> +       { AGILEX_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1,=
 0, 0xAC},
> +       { AGILEX_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1,=
 0, 0xB0},
> +       { AGILEX_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1,=
 0, 0xB8},
> +       { AGILEX_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1,=
 0, 0xBC},
> +};
> +
> +static const struct stratix10_perip_cnt_clock agilex_main_perip_cnt_clks=
[] =3D {
> +       { AGILEX_MPU_FREE_CLK, "mpu_free_clk", NULL, mpu_free_mux, ARRAY_=
SIZE(mpu_free_mux),
> +          0, 0x3C, 0, 0, 0},
> +       { AGILEX_NOC_FREE_CLK, "noc_free_clk", NULL, noc_free_mux, ARRAY_=
SIZE(noc_free_mux),
> +         0, 0x40, 0, 0, 1},
> +       { AGILEX_L4_SYS_FREE_CLK, "l4_sys_free_clk", "noc_free_clk", NULL=
, 1, 0,
> +         0, 4, 0, 0},
> +       { AGILEX_NOC_CLK, "noc_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux),
> +         0, 0, 0, 0x30, 1},
> +       { AGILEX_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, emaca_free_mux,=
 ARRAY_SIZE(emaca_free_mux),
> +         0, 0xD4, 0, 0x88, 0},
> +       { AGILEX_EMAC_B_FREE_CLK, "emacb_free_clk", NULL, emacb_free_mux,=
 ARRAY_SIZE(emacb_free_mux),
> +         0, 0xD8, 0, 0x88, 1},
> +       { AGILEX_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL, emac_ptp_f=
ree_mux,
> +         ARRAY_SIZE(emac_ptp_free_mux), 0, 0xDC, 0, 0x88, 2},
> +       { AGILEX_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL, gpio_db_free=
_mux,
> +         ARRAY_SIZE(gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3},
> +       { AGILEX_SDMMC_FREE_CLK, "sdmmc_free_clk", NULL, sdmmc_free_mux,
> +         ARRAY_SIZE(sdmmc_free_mux), 0, 0xE4, 0, 0x88, 4},
> +       { AGILEX_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", NULL, s2f_usr0=
_free_mux,
> +         ARRAY_SIZE(s2f_usr0_free_mux), 0, 0xE8, 0, 0, 0},
> +       { AGILEX_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", NULL, s2f_usr1=
_free_mux,
> +         ARRAY_SIZE(s2f_usr1_free_mux), 0, 0xEC, 0, 0x88, 5},
> +       { AGILEX_PSI_REF_FREE_CLK, "psi_ref_free_clk", NULL, psi_ref_free=
_mux,
> +         ARRAY_SIZE(psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6},
> +};
> +
> +static const struct stratix10_gate_clock agilex_gate_clks[] =3D {
> +       { AGILEX_MPU_CLK, "mpu_clk", NULL, mpu_mux, ARRAY_SIZE(mpu_mux), =
0, 0x24,
> +         0, 0, 0, 0, 0x30, 0, 0},
> +       { AGILEX_MPU_PERIPH_CLK, "mpu_periph_clk", "mpu_clk", NULL, 1, 0,=
 0x24,
> +         0, 0, 0, 0, 0, 0, 4},
> +       { AGILEX_MPU_L2RAM_CLK, "mpu_l2ram_clk", "mpu_clk", NULL, 1, 0, 0=
x24,
> +         0, 0, 0, 0, 0, 0, 2},
> +       { AGILEX_L4_MAIN_CLK, "l4_main_clk", "noc_clk", NULL, 1, 0, 0x24,
> +         1, 0x44, 0, 2, 0, 0, 0},
> +       { AGILEX_L4_MP_CLK, "l4_mp_clk", "noc_clk", NULL, 1, 0, 0x24,
> +         2, 0x44, 8, 2, 0, 0, 0},
> +       { AGILEX_L4_SP_CLK, "l4_sp_clk", "noc_clk", NULL, 1, CLK_IS_CRITI=
CAL, 0x24,

Please document why a clk is critical in the code.

> +         3, 0x44, 16, 2, 0, 0, 0},
> +       { AGILEX_CS_AT_CLK, "cs_at_clk", "noc_clk", NULL, 1, 0, 0x24,
> +         4, 0x44, 24, 2, 0, 0, 0},
> +       { AGILEX_CS_TRACE_CLK, "cs_trace_clk", "noc_clk", NULL, 1, 0, 0x2=
4,
> +         4, 0x44, 26, 2, 0, 0, 0},
> +       { AGILEX_CS_PDBG_CLK, "cs_pdbg_clk", "cs_at_clk", NULL, 1, 0, 0x2=
4,
> +         4, 0x44, 28, 1, 0, 0, 0},
> +       { AGILEX_CS_TIMER_CLK, "cs_timer_clk", "noc_clk", NULL, 1, 0, 0x2=
4,
> +         5, 0, 0, 0, 0, 0, 0},
> +       { AGILEX_S2F_USER0_CLK, "s2f_user0_clk", NULL, s2f_usr0_mux, ARRA=
Y_SIZE(s2f_usr0_mux), 0, 0x24,
> +         6, 0, 0, 0, 0, 0, 0},
> +       { AGILEX_EMAC0_CLK, "emac0_clk", NULL, emac_mux, ARRAY_SIZE(emac_=
mux), 0, 0x7C,
> +         0, 0, 0, 0, 0x94, 26, 0},
> +       { AGILEX_EMAC1_CLK, "emac1_clk", NULL, emac_mux, ARRAY_SIZE(emac_=
mux), 0, 0x7C,
> +         1, 0, 0, 0, 0x94, 27, 0},
> +       { AGILEX_EMAC2_CLK, "emac2_clk", NULL, emac_mux, ARRAY_SIZE(emac_=
mux), 0, 0x7C,
> +         2, 0, 0, 0, 0x94, 28, 0},
> +       { AGILEX_EMAC_PTP_CLK, "emac_ptp_clk", "emac_ptp_free_clk", NULL,=
 1, 0, 0x7C,
> +         3, 0, 0, 0, 0, 0, 0},
> +       { AGILEX_GPIO_DB_CLK, "gpio_db_clk", "gpio_db_free_clk", NULL, 1,=
 0, 0x7C,
> +         4, 0x98, 0, 16, 0, 0, 0},
> +       { AGILEX_SDMMC_CLK, "sdmmc_clk", "sdmmc_free_clk", NULL, 1, 0, 0x=
7C,
> +         5, 0, 0, 0, 0, 0, 4},
> +       { AGILEX_S2F_USER1_CLK, "s2f_user1_clk", "s2f_user1_free_clk", NU=
LL, 1, 0, 0x7C,
> +         6, 0, 0, 0, 0, 0, 0},
> +       { AGILEX_PSI_REF_CLK, "psi_ref_clk", "psi_ref_free_clk", NULL, 1,=
 0, 0x7C,
> +         7, 0, 0, 0, 0, 0, 0},
> +       { AGILEX_USB_CLK, "usb_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> +         8, 0, 0, 0, 0, 0, 0},
> +       { AGILEX_SPI_M_CLK, "spi_m_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> +         9, 0, 0, 0, 0, 0, 0},
> +       { AGILEX_NAND_CLK, "nand_clk", "l4_main_clk", NULL, 1, 0, 0x7C,
> +         10, 0, 0, 0, 0, 0, 0},
> +};
> +
> +static int agilex_clk_register_c_perip(const struct stratix10_perip_c_cl=
ock *clks,
> +                                      int nums, struct stratix10_clock_d=
ata *data)
> +{
> +       struct clk *clk;
> +       void __iomem *base =3D data->base;
> +       int i;
> +
> +       for (i =3D 0; i < nums; i++) {
> +               clk =3D s10_register_periph(clks[i].name, clks[i].parent_=
name,
> +                                         clks[i].parent_names, clks[i].n=
um_parents,
> +                                         clks[i].flags, base, clks[i].of=
fset);
> +               if (IS_ERR(clk)) {
> +                       pr_err("%s: failed to register clock %s\n",
> +                              __func__, clks[i].name);
> +                       continue;
> +               }
> +               data->clk_data.clks[clks[i].id] =3D clk;
> +       }
> +       return 0;
> +}
> +
> +static int agilex_clk_register_cnt_perip(const struct stratix10_perip_cn=
t_clock *clks,
> +                                        int nums, struct stratix10_clock=
_data *data)
> +{
> +       struct clk *clk;
> +       void __iomem *base =3D data->base;
> +       int i;
> +
> +       for (i =3D 0; i < nums; i++) {
> +               clk =3D s10_register_cnt_periph(clks[i].name, clks[i].par=
ent_name,
> +                                             clks[i].parent_names,
> +                                             clks[i].num_parents,
> +                                             clks[i].flags, base,
> +                                             clks[i].offset,
> +                                             clks[i].fixed_divider,
> +                                             clks[i].bypass_reg,
> +                                             clks[i].bypass_shift);
> +               if (IS_ERR(clk)) {
> +                       pr_err("%s: failed to register clock %s\n",
> +                              __func__, clks[i].name);
> +                       continue;
> +               }
> +               data->clk_data.clks[clks[i].id] =3D clk;
> +       }
> +
> +       return 0;
> +}
> +
> +static int agilex_clk_register_gate(const struct stratix10_gate_clock *c=
lks,                                       int nums, struct stratix10_clock=
_data *data)
> +{

Something weird happened here.

> +       struct clk *clk;
> +       void __iomem *base =3D data->base;
> +       int i;
> +
> +       for (i =3D 0; i < nums; i++) {
> +               clk =3D s10_register_gate(clks[i].name, clks[i].parent_na=
me,
> +                                       clks[i].parent_names,
> +                                       clks[i].num_parents,
> +                                       clks[i].flags, base,
> +                                       clks[i].gate_reg,
> +                                       clks[i].gate_idx, clks[i].div_reg,
> +                                       clks[i].div_offset, clks[i].div_w=
idth,
> +                                       clks[i].bypass_reg,
> +                                       clks[i].bypass_shift,
> +                                       clks[i].fixed_div);

Maybe s10_regsiter_gate should take a struct stratix10_gate_clock
instead?

> +               if (IS_ERR(clk)) {
> +                       pr_err("%s: failed to register clock %s\n",
> +                              __func__, clks[i].name);
> +                       continue;
> +               }
> +               data->clk_data.clks[clks[i].id] =3D clk;
> +       }
> +
> +       return 0;
> +}
> +
> +static int agilex_clk_register_pll(const struct stratix10_pll_clock *clk=
s,
> +                                int nums, struct stratix10_clock_data *d=
ata)
> +{
> +       struct clk *clk;
> +       void __iomem *base =3D data->base;
> +       int i;
> +
> +       for (i =3D 0; i < nums; i++) {
> +               clk =3D agilex_register_pll(clks[i].name, clks[i].parent_=
names,
> +                                   clks[i].num_parents,
> +                                   clks[i].flags, base,
> +                                   clks[i].offset);
> +               if (IS_ERR(clk)) {
> +                       pr_err("%s: failed to register clock %s\n",
> +                              __func__, clks[i].name);
> +                       continue;
> +               }
> +               data->clk_data.clks[clks[i].id] =3D clk;

Hmm I just reviewed something that looked so similar. Please use some
local variables to simplify this line.

> +       }
> +
> +       return 0;
> +}
> +
> +static struct stratix10_clock_data *__socfpga_agilex_clk_init(struct pla=
tform_device *pdev,
> +                                                   int nr_clks)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct device *dev =3D &pdev->dev;
> +       struct stratix10_clock_data *clk_data;
> +       struct clk **clk_table;
> +       struct resource *res;
> +       void __iomem *base;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base)) {
> +               pr_err("%s: failed to map clock registers\n", __func__);

devm_ioremap_resource() already prints this error. Also, there's a
helper now that gets the resource and maps it in one call instead of
two, please use it.

> +               return ERR_CAST(base);
> +       }
> +
> +       clk_data =3D devm_kzalloc(dev, sizeof(*clk_data), GFP_KERNEL);
> +       if (!clk_data)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk_data->base =3D base;
> +       clk_table =3D devm_kcalloc(dev, nr_clks, sizeof(*clk_table), GFP_=
KERNEL);
> +       if (!clk_table)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk_data->clk_data.clks =3D clk_table;
> +       clk_data->clk_data.clk_num =3D nr_clks;
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_da=
ta);

Please add the clk provider after registering all clks, not before.

> +       return clk_data;
> +}
> +
> +static int agilex_clkmgr_init(struct platform_device *pdev)
> +{
> +       struct stratix10_clock_data *clk_data;
> +
> +       clk_data =3D __socfpga_agilex_clk_init(pdev, AGILEX_NUM_CLKS);
> +       if (IS_ERR(clk_data))
> +               return PTR_ERR(clk_data);

Please inline this init function here.

> +
> +       agilex_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_cl=
ks), clk_data);
> +
> +       agilex_clk_register_c_perip(agilex_main_perip_c_clks,
> +                                ARRAY_SIZE(agilex_main_perip_c_clks), cl=
k_data);
> +
> +       agilex_clk_register_cnt_perip(agilex_main_perip_cnt_clks,
> +                                  ARRAY_SIZE(agilex_main_perip_cnt_clks),
> +                                  clk_data);
> +
> +       agilex_clk_register_gate(agilex_gate_clks, ARRAY_SIZE(agilex_gate=
_clks),
> +                             clk_data);
> +       return 0;
> +}
> +
> +static int agilex_clkmgr_probe(struct platform_device *pdev)
> +{
> +       return  agilex_clkmgr_init(pdev);

Just inline the function into probe.

> +}
> diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-=
pll-s10.c
> index 4705eb544f01..e6ce0ec39494 100644
> --- a/drivers/clk/socfpga/clk-pll-s10.c
> +++ b/drivers/clk/socfpga/clk-pll-s10.c
> @@ -18,8 +18,12 @@
>  #define SOCFPGA_PLL_RESET_MASK         0x2
>  #define SOCFPGA_PLL_REFDIV_MASK                0x00003F00
>  #define SOCFPGA_PLL_REFDIV_SHIFT       8
> +#define SOCFPGA_PLL_AREFDIV_MASK       0x00000F00
> +#define SOCFPGA_PLL_DREFDIV_MASK       0x00003000
> +#define SOCFPGA_PLL_DREFDIV_SHIFT      12
>  #define SOCFPGA_PLL_MDIV_MASK          0xFF000000
>  #define SOCFPGA_PLL_MDIV_SHIFT         24
> +#define SOCFPGA_AGILEX_PLL_MDIV_MASK   0x000003FF
>  #define SWCTRLBTCLKSEL_MASK            0x200
>  #define SWCTRLBTCLKSEL_SHIFT           9
> =20
> @@ -27,6 +31,27 @@
> =20
>  #define to_socfpga_clk(p) container_of(p, struct socfpga_pll, hw.hw)
> =20
> +static unsigned long agilex_clk_pll_recalc_rate(struct clk_hw *hwclk,
> +                                               unsigned long parent_rate)
> +{
> +       struct socfpga_pll *socfpgaclk =3D to_socfpga_clk(hwclk);
> +       unsigned long arefdiv, reg, mdiv;
> +       unsigned long long vco_freq;
> +
> +       /* read VCO1 reg for numerator and denominator */
> +       reg =3D readl(socfpgaclk->hw.reg);
> +       arefdiv =3D (reg & SOCFPGA_PLL_AREFDIV_MASK) >> SOCFPGA_PLL_REFDI=
V_SHIFT;
> +
> +       vco_freq =3D (unsigned long long)parent_rate / arefdiv;

Is this a 64-bit div? Probably needs a do_div() call instead.

> +
> +       /* Read mdiv and fdiv from the fdbck register */
> +       reg =3D readl(socfpgaclk->hw.reg + 0x24);
> +       mdiv =3D (reg & SOCFPGA_AGILEX_PLL_MDIV_MASK);
> +
> +       vco_freq =3D (unsigned long long)vco_freq * mdiv;
> +       return (unsigned long)vco_freq;

Drop the cast, it's implicit.

> +}
> +
>  static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
>                                          unsigned long parent_rate)
>  {
> @@ -145,3 +176,42 @@ struct clk *s10_register_pll(const char *name, const=
 char * const *parent_names,
>         }
>         return clk;
>  }
> +
> +struct clk *agilex_register_pll(const char *name,
> +                               const char * const *parent_names,
> +                               u8 num_parents, unsigned long flags,
> +                               void __iomem *reg, unsigned long offset)
> +{
> +       struct clk *clk;
> +       struct socfpga_pll *pll_clk;
> +       struct clk_init_data init;
> +
> +       pll_clk =3D kzalloc(sizeof(*pll_clk), GFP_KERNEL);
> +       if (WARN_ON(!pll_clk))
> +               return NULL;
> +
> +       pll_clk->hw.reg =3D reg + offset;
> +
> +       if (streq(name, SOCFPGA_BOOT_CLK))
> +               init.ops =3D &clk_boot_ops;
> +       else
> +               init.ops =3D &agilex_clk_pll_ops;
> +
> +       init.name =3D name;
> +       init.flags =3D flags;
> +
> +       init.num_parents =3D num_parents;
> +       init.parent_names =3D parent_names;

Is it possible to use the new way of specifying clk parents here so that
we don't have to keep using strings to describe the clk topology?

> +       pll_clk->hw.hw.init =3D &init;
> +
> +       pll_clk->hw.bit_idx =3D SOCFPGA_PLL_POWER;
> +       clk_pll_ops.enable =3D clk_gate_ops.enable;
> +       clk_pll_ops.disable =3D clk_gate_ops.disable;
> +
> +       clk =3D clk_register(NULL, &pll_clk->hw.hw);

Any reason clk_hw_register() can't be used?

> +       if (WARN_ON(IS_ERR(clk))) {
> +               kfree(pll_clk);
> +               return NULL;
> +       }
> +       return clk;
> +}
