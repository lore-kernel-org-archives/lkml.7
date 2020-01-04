Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12170C32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E049E21734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgADAqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:46:42 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:49479 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgADAqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:46:42 -0500
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 410BA100004;
        Sat,  4 Jan 2020 00:46:39 +0000 (UTC)
Date:   Sat, 4 Jan 2020 01:46:38 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Karl =?iso-8859-1?Q?Rudb=E6k?= Olsen <karl@micro-technic.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: add sama5d3 pmc driver
Message-ID: <20200104004638.GL3040@piout.net>
References: <a223a3f5c8b64b80afac96a5cc2206ec@ATHSHREX13CAS01.ATHENAMAIL.NET>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a223a3f5c8b64b80afac96a5cc2206ec@ATHSHREX13CAS01.ATHENAMAIL.NET>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2020 11:37:53+0000, Karl Rudbæk Olsen wrote:
> On 2019-12-29 21:29, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > Add a driver for the PMC clocks of the sama5d3.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> The datasheet lists the maximum peripheral clock frequencies in terms of
> MCK dividers, and for those of us using MCK = 134 MHz instead of 133 MHz,
> the .max values will make the peripherals run at half the possible clock.
> Could we use .max values based on 134 MHz instead? Or based on 166 MHz
> which is the maximum allowed MCK?
> 

I'll update with values based on 166MHz.

> See also comments inline.
> 
> Thanks,
> Karl Olsen
> 
> > ---
> >  drivers/clk/at91/Makefile  |   1 +
> >  drivers/clk/at91/sama5d3.c | 236 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 237 insertions(+)
> >  create mode 100644 drivers/clk/at91/sama5d3.c
> > 
> > diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
> > index 3732241352ce..e3be7f40f79e 100644
> > --- a/drivers/clk/at91/Makefile
> > +++ b/drivers/clk/at91/Makefile
> > @@ -17,5 +17,6 @@ obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
> >  obj-$(CONFIG_HAVE_AT91_SAM9X60_PLL)	+= clk-sam9x60-pll.o
> >  obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o
> >  obj-$(CONFIG_SOC_SAM9X60) += sam9x60.o
> > +obj-$(CONFIG_SOC_SAMA5D3) += sama5d3.o
> >  obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
> >  obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o
> > diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
> > new file mode 100644
> > index 000000000000..0b73c174ab56
> > --- /dev/null
> > +++ b/drivers/clk/at91/sama5d3.c
> > @@ -0,0 +1,236 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/clk-provider.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/slab.h>
> > +
> > +#include <dt-bindings/clock/at91.h>
> > +
> > +#include "pmc.h"
> > +
> > +static const struct clk_master_characteristics mck_characteristics = {
> > +	.output = { .min = 0, .max = 166000000 },
> > +	.divisors = { 1, 2, 4, 3 },
> > +};
> > +
> > +static u8 plla_out[] = { 0 };
> > +
> > +static u16 plla_icpll[] = { 0 };
> > +
> > +static const struct clk_range plla_outputs[] = {
> > +	{ .min = 400000000, .max = 1000000000 },
> > +};
> > +
> > +static const struct clk_pll_characteristics plla_characteristics = {
> > +	.input = { .min = 8000000, .max = 50000000 },
> > +	.num_output = ARRAY_SIZE(plla_outputs),
> > +	.output = plla_outputs,
> > +	.icpll = plla_icpll,
> > +	.out = plla_out,
> > +};
> > +
> > +static const struct clk_pcr_layout sama5d3_pcr_layout = {
> > +	.offset = 0x10c,
> > +	.cmd = BIT(12),
> > +	.pid_mask = GENMASK(6, 0),
> > +	.div_mask = GENMASK(17, 16),
> > +};
> > +
> > +static const struct {
> > +	char *n;
> > +	char *p;
> > +	u8 id;
> > +} sama5d3_systemck[] = {
> > +	{ .n = "ddrck", .p = "masterck", .id = 2 },
> > +	{ .n = "lcdck", .p = "masterck", .id = 3 },
> > +	{ .n = "smdck", .p = "smdclk",   .id = 4 },
> > +	{ .n = "uhpck", .p = "usbck",    .id = 6 },
> > +	{ .n = "udpck", .p = "usbck",    .id = 7 },
> > +	{ .n = "pck0",  .p = "prog0",    .id = 8 },
> > +	{ .n = "pck1",  .p = "prog1",    .id = 9 },
> > +	{ .n = "pck2",  .p = "prog2",    .id = 10 },
> > +};
> > +
> > +static const struct {
> > +	char *n;
> > +	u8 id;
> > +	struct clk_range r;
> > +} sama5d3_periphck[] = {
> > +	{ .n = "dbgu_clk", .id = 2, },
> > +	{ .n = "hsmc_clk", .id = 5, },
> > +	{ .n = "pioA_clk", .id = 6, },
> > +	{ .n = "pioB_clk", .id = 7, },
> > +	{ .n = "pioC_clk", .id = 8, },
> > +	{ .n = "pioD_clk", .id = 9, },
> > +	{ .n = "pioE_clk", .id = 10, },
> > +	{ .n = "usart0_clk", .id = 12, .r = { .min = 0, .max = 66000000 }, },
> > +	{ .n = "usart1_clk", .id = 13, .r = { .min = 0, .max = 66000000 }, },
> > +	{ .n = "usart2_clk", .id = 14, .r = { .min = 0, .max = 66000000 }, },
> > +	{ .n = "usart3_clk", .id = 15, .r = { .min = 0, .max = 66000000 }, },
> > +	{ .n = "uart0_clk", .id = 16, .r = { .min = 0, .max = 66000000 }, },
> > +	{ .n = "uart1_clk", .id = 17, .r = { .min = 0, .max = 66000000 }, },
> > +	{ .n = "twi0_clk", .id = 18, .r = { .min = 0, .max = 16625000 }, },
> > +	{ .n = "twi1_clk", .id = 19, .r = { .min = 0, .max = 16625000 }, },
> > +	{ .n = "twi2_clk", .id = 20, .r = { .min = 0, .max = 16625000 }, },
> 
> The datasheet says max freq for TWI is MCK/4, not MCK/8.
> 

You are right.

> > +	{ .n = "mci0_clk", .id = 21, },
> > +	{ .n = "mci1_clk", .id = 22, },
> > +	{ .n = "mci2_clk", .id = 23, },
> > +	{ .n = "spi0_clk", .id = 24, .r = { .min = 0, .max = 133000000 }, },
> > +	{ .n = "spi1_clk", .id = 25, .r = { .min = 0, .max = 133000000 }, },
> > +	{ .n = "tcb0_clk", .id = 26, .r = { .min = 0, .max = 133000000 }, },
> > +	{ .n = "tcb1_clk", .id = 27, },
> 
> tcb1_clk should also have .min and .max?
> 

And right again. What is happening here is that all those values are
coming from the dtsi instead of the datasheet, this ensures the PMC
driver behaves the same before and after the DT binding switch.

What I did is first fix the dtsi so the patches can be backported to
stable kernels then I fixed the PMC driver so it is correct from the
beginning. I'll send patches soon.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
