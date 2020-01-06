Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDDEC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E0821734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578280148;
	bh=vxNW2GyhdGoGRiMtNDnrgoP06OCkjtgTm1EGwq+PnAg=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=lQ719h5tW45M0AqFzYqkW5DxF9ta24K4Cx9lKxBna9WJDvEuwyokTdxdNazsuqcqv
	 TdDcu1kXcf8PZIj+NdHSihCNoCdEZrjIBlzlvEa0yAXryX45gWokTuieU9vq11q9/X
	 OISleu+mAoRh+RWU7Jmd4QkzsW5ErHPLjevEmzwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgAFDJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:09:07 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8643221582;
        Mon,  6 Jan 2020 03:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578280145;
        bh=vxNW2GyhdGoGRiMtNDnrgoP06OCkjtgTm1EGwq+PnAg=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=dS7d1yUleZjq1UFYvj0xQTgJV2/bxxSAHOKWKxc+tpZYzZvWxPSMQ/pqqE/VJy6LL
         VOhb+ayiihHrhvbTa/rfVVdk9x4E4FL9F7gQANJ1hKVtgUCYro5gWVxBY8/Dmrp40n
         8FEP3QhRMLZ981sJy4Cde6/Fp1U4nP3qVvCKA+ak=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191229202907.335931-1-alexandre.belloni@bootlin.com>
References: <20191229202907.335931-1-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] clk: at91: add sama5d3 pmc driver
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 19:09:04 -0800
Message-Id: <20200106030905.8643221582@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-12-29 12:29:07)
> diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
> new file mode 100644
> index 000000000000..0b73c174ab56
> --- /dev/null
> +++ b/drivers/clk/at91/sama5d3.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/at91.h>
> +
> +#include "pmc.h"
> +
> +static const struct clk_master_characteristics mck_characteristics =3D {
> +       .output =3D { .min =3D 0, .max =3D 166000000 },
> +       .divisors =3D { 1, 2, 4, 3 },
> +};
> +
> +static u8 plla_out[] =3D { 0 };
> +
> +static u16 plla_icpll[] =3D { 0 };
> +
> +static const struct clk_range plla_outputs[] =3D {
> +       { .min =3D 400000000, .max =3D 1000000000 },
> +};
> +
> +static const struct clk_pll_characteristics plla_characteristics =3D {
> +       .input =3D { .min =3D 8000000, .max =3D 50000000 },
> +       .num_output =3D ARRAY_SIZE(plla_outputs),
> +       .output =3D plla_outputs,
> +       .icpll =3D plla_icpll,
> +       .out =3D plla_out,
> +};
> +
> +static const struct clk_pcr_layout sama5d3_pcr_layout =3D {
> +       .offset =3D 0x10c,
> +       .cmd =3D BIT(12),
> +       .pid_mask =3D GENMASK(6, 0),
> +       .div_mask =3D GENMASK(17, 16),
> +};
> +
> +static const struct {
> +       char *n;
> +       char *p;
> +       u8 id;
> +} sama5d3_systemck[] =3D {
> +       { .n =3D "ddrck", .p =3D "masterck", .id =3D 2 },
> +       { .n =3D "lcdck", .p =3D "masterck", .id =3D 3 },
> +       { .n =3D "smdck", .p =3D "smdclk",   .id =3D 4 },
> +       { .n =3D "uhpck", .p =3D "usbck",    .id =3D 6 },
> +       { .n =3D "udpck", .p =3D "usbck",    .id =3D 7 },
> +       { .n =3D "pck0",  .p =3D "prog0",    .id =3D 8 },
> +       { .n =3D "pck1",  .p =3D "prog1",    .id =3D 9 },
> +       { .n =3D "pck2",  .p =3D "prog2",    .id =3D 10 },
> +};
> +
> +static const struct {
> +       char *n;
> +       u8 id;
> +       struct clk_range r;
> +} sama5d3_periphck[] =3D {

If it can't be a platform device can this be __initconst?

> +       { .n =3D "dbgu_clk", .id =3D 2, },
> +       { .n =3D "hsmc_clk", .id =3D 5, },
> +       { .n =3D "pioA_clk", .id =3D 6, },
> +       { .n =3D "pioB_clk", .id =3D 7, },
> +       { .n =3D "pioC_clk", .id =3D 8, },
> +       { .n =3D "pioD_clk", .id =3D 9, },
> +       { .n =3D "pioE_clk", .id =3D 10, },
> +       { .n =3D "usart0_clk", .id =3D 12, .r =3D { .min =3D 0, .max =3D =
66000000 }, },
> +       { .n =3D "usart1_clk", .id =3D 13, .r =3D { .min =3D 0, .max =3D =
66000000 }, },
> +       { .n =3D "usart2_clk", .id =3D 14, .r =3D { .min =3D 0, .max =3D =
66000000 }, },
> +       { .n =3D "usart3_clk", .id =3D 15, .r =3D { .min =3D 0, .max =3D =
66000000 }, },
> +       { .n =3D "uart0_clk", .id =3D 16, .r =3D { .min =3D 0, .max =3D 6=
6000000 }, },
> +       { .n =3D "uart1_clk", .id =3D 17, .r =3D { .min =3D 0, .max =3D 6=
6000000 }, },
> +       { .n =3D "twi0_clk", .id =3D 18, .r =3D { .min =3D 0, .max =3D 16=
625000 }, },
> +       { .n =3D "twi1_clk", .id =3D 19, .r =3D { .min =3D 0, .max =3D 16=
625000 }, },
> +       { .n =3D "twi2_clk", .id =3D 20, .r =3D { .min =3D 0, .max =3D 16=
625000 }, },
> +       { .n =3D "mci0_clk", .id =3D 21, },
> +       { .n =3D "mci1_clk", .id =3D 22, },
> +       { .n =3D "mci2_clk", .id =3D 23, },
> +       { .n =3D "spi0_clk", .id =3D 24, .r =3D { .min =3D 0, .max =3D 13=
3000000 }, },
> +       { .n =3D "spi1_clk", .id =3D 25, .r =3D { .min =3D 0, .max =3D 13=
3000000 }, },
> +       { .n =3D "tcb0_clk", .id =3D 26, .r =3D { .min =3D 0, .max =3D 13=
3000000 }, },
> +       { .n =3D "tcb1_clk", .id =3D 27, },
> +       { .n =3D "pwm_clk", .id =3D 28, },
> +       { .n =3D "adc_clk", .id =3D 29, .r =3D { .min =3D 0, .max =3D 660=
00000 }, },
> +       { .n =3D "dma0_clk", .id =3D 30, },
> +       { .n =3D "dma1_clk", .id =3D 31, },
> +       { .n =3D "uhphs_clk", .id =3D 32, },
> +       { .n =3D "udphs_clk", .id =3D 33, },
> +       { .n =3D "macb0_clk", .id =3D 34, },
> +       { .n =3D "macb1_clk", .id =3D 35, },
> +       { .n =3D "lcdc_clk", .id =3D 36, },
> +       { .n =3D "isi_clk", .id =3D 37, },
> +       { .n =3D "ssc0_clk", .id =3D 38, .r =3D { .min =3D 0, .max =3D 66=
000000 }, },
> +       { .n =3D "ssc1_clk", .id =3D 39, .r =3D { .min =3D 0, .max =3D 66=
000000 }, },
> +       { .n =3D "can0_clk", .id =3D 40, .r =3D { .min =3D 0, .max =3D 66=
000000 }, },
> +       { .n =3D "can1_clk", .id =3D 41, .r =3D { .min =3D 0, .max =3D 66=
000000 }, },
> +       { .n =3D "sha_clk", .id =3D 42, },
> +       { .n =3D "aes_clk", .id =3D 43, },
> +       { .n =3D "tdes_clk", .id =3D 44, },
> +       { .n =3D "trng_clk", .id =3D 45, },
> +       { .n =3D "fuse_clk", .id =3D 48, },
> +       { .n =3D "mpddr_clk", .id =3D 49, },
> +};
> +
> +static void __init sama5d3_pmc_setup(struct device_node *np)
> +{
> +       const char *slck_name, *mainxtal_name;
> +       struct pmc_data *sama5d3_pmc;
> +       const char *parent_names[5];
> +       struct regmap *regmap;
> +       struct clk_hw *hw;
> +       int i;
> +       bool bypass;
> +
> +       i =3D of_property_match_string(np, "clock-names", "slow_clk");
> +       if (i < 0)
> +               return;
> +
> +       slck_name =3D of_clk_get_parent_name(np, i);
> +
> +       i =3D of_property_match_string(np, "clock-names", "main_xtal");
> +       if (i < 0)
> +               return;
> +       mainxtal_name =3D of_clk_get_parent_name(np, i);
> +
> +       regmap =3D syscon_node_to_regmap(np);
> +       if (IS_ERR(regmap))
> +               return;
> +
> +       sama5d3_pmc =3D pmc_data_allocate(PMC_MAIN + 1,
> +                                       nck(sama5d3_systemck),
> +                                       nck(sama5d3_periphck), 0);
> +       if (!sama5d3_pmc)
> +               return;
> +
> +       hw =3D at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000=
000,
> +                                          50000000);
> +       if (IS_ERR(hw))
> +               goto err_free;
> +
> +       bypass =3D of_property_read_bool(np, "atmel,osc-bypass");
> +
> +       hw =3D at91_clk_register_main_osc(regmap, "main_osc", mainxtal_na=
me,
> +                                       bypass);
> +       if (IS_ERR(hw))
> +               goto err_free;
> +
> +       parent_names[0] =3D "main_rc_osc";
> +       parent_names[1] =3D "main_osc";
> +       hw =3D at91_clk_register_sam9x5_main(regmap, "mainck", parent_nam=
es, 2);
> +       if (IS_ERR(hw))
> +               goto err_free;
> +
> +       hw =3D at91_clk_register_pll(regmap, "pllack", "mainck", 0,
> +                                  &sama5d3_pll_layout, &plla_characteris=
tics);
> +       if (IS_ERR(hw))
> +               goto err_free;
> +
> +       hw =3D at91_clk_register_plldiv(regmap, "plladivck", "pllack");
> +       if (IS_ERR(hw))
> +               goto err_free;
> +
> +       hw =3D at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
> +       if (IS_ERR(hw))
> +               goto err_free;
> +
> +       sama5d3_pmc->chws[PMC_UTMI] =3D hw;
> +
> +       parent_names[0] =3D slck_name;
> +       parent_names[1] =3D "mainck";
> +       parent_names[2] =3D "plladivck";
> +       parent_names[3] =3D "utmick";
> +       hw =3D at91_clk_register_master(regmap, "masterck", 4, parent_nam=
es,
> +                                     &at91sam9x5_master_layout,
> +                                     &mck_characteristics);
> +       if (IS_ERR(hw))
> +               goto err_free;
> +
> +       sama5d3_pmc->chws[PMC_MCK] =3D hw;
> +
> +       parent_names[0] =3D "plladivck";
> +       parent_names[1] =3D "utmick";
> +       hw =3D at91sam9x5_clk_register_usb(regmap, "usbck", parent_names,=
 2);
> +       if (IS_ERR(hw))
> +               goto err_free;
> +
> +       hw =3D at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names=
, 2);
> +       if (IS_ERR(hw))
> +               goto err_free;
> +
> +       parent_names[0] =3D slck_name;
> +       parent_names[1] =3D "mainck";
> +       parent_names[2] =3D "plladivck";
> +       parent_names[3] =3D "utmick";
> +       parent_names[4] =3D "masterck";
> +       for (i =3D 0; i < 3; i++) {
> +               char name[6];
> +
> +               snprintf(name, sizeof(name), "prog%d", i);
> +
> +               hw =3D at91_clk_register_programmable(regmap, name,
> +                                                   parent_names, 5, i,
> +                                                   &at91sam9x5_programma=
ble_layout);
> +               if (IS_ERR(hw))
> +                       goto err_free;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(sama5d3_systemck); i++) {
> +               hw =3D at91_clk_register_system(regmap, sama5d3_systemck[=
i].n,
> +                                             sama5d3_systemck[i].p,
> +                                             sama5d3_systemck[i].id);
> +               if (IS_ERR(hw))
> +                       goto err_free;
> +
> +               sama5d3_pmc->shws[sama5d3_systemck[i].id] =3D hw;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(sama5d3_periphck); i++) {
> +               hw =3D at91_clk_register_sam9x5_peripheral(regmap, &pmc_p=
cr_lock,
> +                                                        &sama5d3_pcr_lay=
out,
> +                                                        sama5d3_periphck=
[i].n,
> +                                                        "masterck",
> +                                                        sama5d3_periphck=
[i].id,
> +                                                        &sama5d3_periphc=
k[i].r);
> +               if (IS_ERR(hw))
> +                       goto err_free;
> +
> +               sama5d3_pmc->phws[sama5d3_periphck[i].id] =3D hw;
> +       }
> +
> +       of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sama5d3_pmc);
> +
> +       return;
> +
> +err_free:
> +       pmc_data_free(sama5d3_pmc);
> +}
> +CLK_OF_DECLARE_DRIVER(sama5d3_pmc, "atmel,sama5d3-pmc", sama5d3_pmc_setu=
p);

Any reason this can't be a platform driver?

