Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBF0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F192171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCMIco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:32:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49125 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfCMIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:32:43 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h3zJM-00067H-Uf; Wed, 13 Mar 2019 09:32:28 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h3zJK-0001sW-VA; Wed, 13 Mar 2019 09:32:26 +0100
Date:   Wed, 13 Mar 2019 09:32:26 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190313083226.qgnldzd6pc3arooc@pengutronix.de>
References: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
 <1552288273-31028-3-git-send-email-Anson.Huang@nxp.com>
 <20190311092644.a2x53zgxv2iseqao@pengutronix.de>
 <AM6PR0402MB391160F820907ABE8ECA4C26F54A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR0402MB391160F820907ABE8ECA4C26F54A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 13, 2019 at 07:28:24AM +0000, Anson Huang wrote:
> > On Mon, Mar 11, 2019 at 07:16:16AM +0000, Anson Huang wrote:
> > > +
> > >  config PWM_JZ4740
> > >  	tristate "Ingenic JZ47xx PWM support"
> > >  	depends on MACH_INGENIC
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> > > 9c676a0..64e036c 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
> > >  obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
> > >  obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
> > >  obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
> > > +obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
> > >  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
> > >  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
> > >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
> > > diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> > new
> > > file mode 100644 index 0000000..a53256a
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-imx-tpm.c
> > > @@ -0,0 +1,277 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright 2018-2019 NXP.
> > > + */
> > 
> > Please add a link to the reference manual to the header.
> 
> I checked the NXP website, looks like i.MX7ULP reference manual is NOT
> published yet, should be published very soon.

ok.

> > > +#include <linux/bitops.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#define TPM_GLOBAL	0x8
> > > +#define TPM_SC		0x10
> > > +#define TPM_CNT		0x14
> > > +#define TPM_MOD		0x18
> > > +#define TPM_C0SC	0x20
> > > +#define TPM_C0V		0x24
> > > +
> > > +#define SC_CMOD		3
> > 
> > This seems to be an offset, why not defining it as BIT(3) instead?
> 
> SC_CMOD field as 2 bits, I will use below in V2 patch set:
> 
> #define TPM_SC_CMOD_SHIFT       3
> #define TPM_SC_CMOD_MASK        (0x3 << TPM_SC_CMOD_SHIFT)

I suggest

	#define PWM_IMX_TPM_SC_CMOD	GENMASK(1, 0)

instead. See include/linux/bitfield.h for details.
Also note that "TPM" isn't a great prefix given that we have:

	$ git ls-files | grep -c tpm
	82

. Even though PWM_IMX_TPM is longer I think it's worth the extra bytes.
Then if you use pwm_imx_tpm als prefix for your function it's obvious
that they all belong together. For extra credits also adapt the driver
name to match.

> > > +		ret = clk_prepare_enable(tpm->clk);
> > > +		if (ret) {
> > > +			dev_err(chip->dev,
> > > +				"failed to prepare or enable clk %d\n", ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	val = readl(tpm->base + TPM_SC);
> > > +	val &= ~TPM_SC_PS_MASK;
> > > +	val |= div;
> > > +	writel(val, tpm->base + TPM_SC);
> > 
> > If the unit ran with (say) div == 5 and a high duty cycle before and for the
> > new configuration you need div == 6 with a low duty cycle, can it happen
> > here that the output uses the new div value already with the high duty cycle?
> > If so, this is bad.
> 
> As the TPM counter is shared between 2 channels, so I will make this prescale setting
> to be initialized ONLY once, ONLY first channel will config it, this makes things simple
> and the other channel should use same prescale value as first channel and ONLY adjust
> its own duty cycle and polarity etc..

So the two channels have to share the period length? If so please note
this in the header of the driver like it was done in
https://www.spinics.net/lists/linux-pwm/msg09149.html (search for
"Limitations"). You also need some logic to assert that setting the 2nd
channel doesn't modify the first (if the first is in use).

> > > +	period_cycles = c;
> > > +	c *= duty_ns;
> > > +	do_div(c, period_ns);
> > > +	duty_cycles = c;
> > > +
> > > +	writel(period_cycles & TPM_MOD_MOD_MASK, tpm->base +
> > TPM_MOD);
> > 
> > Don't you need to add pwm->hwpwm * TPM_CHn_ADDR_OFFSET to the
> > register offset here? And if not, I assume this affects the other PWMs
> > provided by this hardware unit which is bad.
> 
> The MOD register is shared between different channels, ONLY 1 register there.
> This register will be same as SC, ONLY configured ONCE by first channel.
> 
> > 
> > > +	writel(duty_cycles & TPM_MOD_MOD_MASK, tpm->base +
> > > +	       TPM_C0V + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
> > > +
> > > +	/* if pwm is not enabled, disable clk after setting */
> > > +	if (!pwm_is_enabled(pwm))
> > > +		clk_disable_unprepare(tpm->clk);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int tpm_pwm_enable(struct pwm_chip *chip, struct pwm_device
> > > +*pwm) {
> > > +	struct tpm_pwm_chip *tpm = to_tpm_pwm_chip(chip);
> > > +	int ret;
> > > +	u32 val;
> > > +
> > > +	ret = clk_prepare_enable(tpm->clk);
> > > +	if (ret) {
> > > +		dev_err(chip->dev,
> > > +			"failed to prepare or enable clk %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	/*
> > > +	 * To enable a tpm channel, CPWMS = 0, MSnB:MSnA = 0x0,
> > > +	 * for TPM normal polarity ELSnB:ELSnA = 2b'10,
> > > +	 * inverse ELSnB:ELSnA = 2b'01
> > > +	 */
> > > +	val = readl(tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);

You could make it obvious which channels are shared and which have one
instance per pwm by doing:

	#define PWM_IMX_TPM_C0SC(hwid)	(0x20 + hwid * 4)

> > > +	val |= pwm->state.polarity ? ELSnA : ELSnB;
> > > +
> > > +	writel(val, tpm->base + TPM_C0SC + pwm->hwpwm *
> > > +TPM_CHn_ADDR_OFFSET);
> > > +
> > > +	/* start the counter */
> > > +	val = readl(tpm->base + TPM_SC);
> > > +	val |= 0x1 << SC_CMOD;
> > > +	writel(val, tpm->base + TPM_SC);
> > 
> > If tpm_pwm_enable is called for the first PWM provided by the hardware,
> > how does this writel affect the second one?
> 
> I will make the TPM counter enabled for every channel enabled, if ONLY disabled
> when both channels are disabled.

So you have to make sure that:

 - if you disable one channel while the other is still running, just set
   the duty cycle to zero to not interfere with the other
 - if you enable one channel while the other is still off/unused, make
   sure that other channel doesn't start to wiggle.

> > > +	return 0;
> > > +}
> > > +
> > > +static int tpm_pwm_remove(struct platform_device *pdev) {
> > > +	struct tpm_pwm_chip *tpm = platform_get_drvdata(pdev);
> > > +
> > > +	return pwmchip_remove(&tpm->chip);
> > > +}
> > > +
> > > +static int __maybe_unused tpm_pwm_suspend(struct device *dev) {
> > > +	struct tpm_pwm_chip *tpm = dev_get_drvdata(dev);
> > > +
> > > +	clk_disable_unprepare(tpm->clk);
> > 
> > If the PWM is in use, it shouldn't stop on suspend.
> 
> I think PWM should be disabled when suspend, if a device is suspended, but PWM
> is still enabled, we will see backlight is enabled. This is weird. Unless the backlight
> driver will guarantee that pwm is disabled before suspend?

No, on suspend it's the responsibility of the backlight driver to
disable the pwm. Otherwise the PWM changes its behaviour without the
consumer's consent which depending on the purpose of the PWM is bad.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
