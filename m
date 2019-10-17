Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CB7FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E752521835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440092AbfJQOV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:21:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37395 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbfJQOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:27 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iL6ec-0006cH-0H; Thu, 17 Oct 2019 16:21:26 +0200
Message-ID: <2a6ff5b73c9461d9ad25da677a94f860b216a596.camel@pengutronix.de>
Subject: Re: [PATCH] reset: hi6220: Add support for AO reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Peter Griffin <peter.griffin@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Enrico Weigelt <info@metux.net>
Date:   Thu, 17 Oct 2019 16:21:25 +0200
In-Reply-To: <20191009162020.GC29241@griffinp-mac>
References: <20191001182114.69699-1-john.stultz@linaro.org>
         <1570542167.18914.5.camel@pengutronix.de>
         <20191009162020.GC29241@griffinp-mac>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, 2019-10-09 at 17:20 +0100, Peter Griffin wrote:
[...]
> > Do you know whether this is actually a module reset going to the GPU,
> > or if this is somehow part of the clock and power gating machinery?
> 
> I don't know for sure, there is no documentation for these registers
> apart from the code in [1] and [2], and that is really just the register name.

Ok.

> > There's also clock and isolation cell control going on, so this looks a
> > bit like it should be part of a power domain driver.
> 
> I choose to add it here as this driver was already managing the
> MEDIA_SCTRL_SC_MEDIA_RSTDIS_ADDR register, so it seemed correct for it to also
> manage the AO_SCTRL_SC_PW_RSTDIS0_ADDR register.

I agree here ...

> The write to AO_SCTRL_SC_PW_ISODIS0_ADDR and
> AO_SCTRL_SC_PW_CLKEN0_ADDR I guess aren't so clear cut but I wanted to maintain the
> same ordering from [1].

... but not here, necessarily. These register names make it look like
this is the wrong place.

On the other hand, if you don't actually have a way to disable power to
the GPU domain, it is a bit hard for me to argue that it would be more
correct to place this in a power domain driver. Certainly the power
domain driver could (de)assert the reset in the right order though.

I notice the actual GPU reset seems to be MEDIA_G3D, and is deasserted
after whatever is controlled via AO_SCTRL_SC_PW_* in [1], so maybe this
is indeed just the power domain control?

> I have no info about the power domains on the SoC, so not sure it will be
> possible to make it part of a power domain driver.
> 
> > Do you have an (internal or external) regulator that could be disabled
> > while the GPU is inactive, like [1]?
> > 
> > [1]
> > https://raw.githubusercontent.com/96boards/meta-96boards/master/recipes-kernel/linux/linux-96boards/0004-drivers-gpu-arm-utgard-add-basic-HiKey-platform-file.patch
> 
> This patch is based off [1] the regulator mentioned there G3D_PD_VDD it turns
> out has never been available and always fails to do anything.
> 
> So AFAIK there is no external regulator available to disable. This code has since been
> removed from Johns tree [2].
> 
> [2] https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey-5.3&id=64ec445a8271a2ced841484492ed9bf2e1ef4313

The comment

  "Note: GPU DVFS is not implemented and a custom Device Tree
         entry is needed by these platform files.  This is a
         first working version that needs to be improved."

doesn't exactly make it clear whether it is "not implemented" in the
SoC, not implemented on the board, or just not implemented in the driver
in this patchset.
So even if this board has the regulator fixed, could there be others
where GPU power could be switched off? I wouldn't want to encode the the
limitations of a particular board into the SoC DT bindings.

> > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > Cc: Peter Griffin <peter.griffin@linaro.org>
> > > Cc: Enrico Weigelt <info@metux.net>
> > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > ---
> > >  drivers/reset/hisilicon/hi6220_reset.c | 51 +++++++++++++++++++++++++-
> > >  1 file changed, 50 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
> > > index 24e6d420b26b..d84674a2cead 100644
> > > --- a/drivers/reset/hisilicon/hi6220_reset.c
> > > +++ b/drivers/reset/hisilicon/hi6220_reset.c
> > > @@ -33,6 +33,7 @@
> > >  enum hi6220_reset_ctrl_type {
> > >  	PERIPHERAL,
> > >  	MEDIA,
> > > +	AO,
> > >  };
> > >  
> > >  struct hi6220_reset_data {
> > > @@ -92,6 +93,47 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
> > >  	.deassert = hi6220_media_deassert,
> > >  };
> > >  
> > > +#define AO_SCTRL_SC_PW_CLKEN0     0x800
> > > +#define AO_SCTRL_SC_PW_CLKDIS0    0x804
> > > +
> > > +#define AO_SCTRL_SC_PW_RSTEN0     0x810
> > > +#define AO_SCTRL_SC_PW_RSTDIS0    0x814

Is this the only reset register in the "Always-On" (that would have been
nice to include in the commit description for my education) controller?

According to [3] there also seem to be rst4 and rst5 registers?

[3] https://github.com/u-boot/u-boot/blob/master/arch/arm/include/asm/arch-hi6220/hi6220_regs_alwayson.h

> > > +
> > > +#define AO_SCTRL_SC_PW_ISOEN0     0x820
> > > +#define AO_SCTRL_SC_PW_ISODIS0    0x824
> > > +#define AO_MAX_INDEX              12

Where does this number come from? I can't find any information about the
bits in the PW_* registers...

> > > +
> > > +static int hi6220_ao_assert(struct reset_controller_dev *rc_dev,
> > > +			    unsigned long idx)
> > > +{
> > > +	struct hi6220_reset_data *data = to_reset_data(rc_dev);
> > > +	struct regmap *regmap = data->regmap;
> > > +	int ret;
> > > +
> > > +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTEN0, BIT(idx));
> > > +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISOEN0, BIT(idx));
> > > +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKDIS0, BIT(idx));
> > 
> > I would like the return values not to be ORed together, since they are
> > returned to the caller.
> 
> Yes I think you mentioned that before. I did send a v2 previously that
> addressed that https://lkml.org/lkml/2019/4/19/253. That's my fault for
> not following this series up sooner.

I'm sorry, I missed that.

> > > +	return ret;
> > > +}
> > > +
> > > +static int hi6220_ao_deassert(struct reset_controller_dev *rc_dev,
> > > +			      unsigned long idx)
> > > +{
> > > +	struct hi6220_reset_data *data = to_reset_data(rc_dev);
> > > +	struct regmap *regmap = data->regmap;
> > > +	int ret;
> > > +
> > > +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTDIS0, BIT(idx));
> > > +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISODIS0, BIT(idx));
> > > +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKEN0, BIT(idx));
> > 
> > Are you sure these are fire and forget, or might the order be important?
> 
> The order maybe important, I've not tried a different ordering to
> what is here. I kept it the same as [1] which was working with the blob driver
> and continues to work with driver.

Ok, that makes sense.

> > It might be necessary to disable isolation before enabling the clocks
> > and deasserting reset, to avoid glitches.
> 
> You mean a register sequence like this?
> 
> regmap_write(regmap, AO_SCTRL_SC_PW_ISODIS0, BIT(idx));
> regmap_write(regmap, AO_SCTRL_SC_PW_RSTDIS0, BIT(idx));
> regmap_write(AO_SCTRL_SC_PW_CLKEN0, BIT(idx));

I'm just asking whether you have considered potential side effects, but
without better knowledge about the SoC, following the order found in the
vendor code, is probably the best we can do.

In [1] the corresponding _STAT registers (+0x8) are checked after
setting each bit, is there a reason you dropped these checks?

regards
Philipp

