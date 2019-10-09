Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D707C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282272067B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsuuy05M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbfJIQU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:20:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54466 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfJIQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:20:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so3294218wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YD6Nvv0Ivm0Q+cK2tBiqyE/aTP0p2UnVV4lpYYz+xU0=;
        b=qsuuy05MjH4vG17uyUuGtnaEbbvR1SAJjJskGtHkNnpROH6/b4Ho5oHF6W8Kh+ve/N
         34zusW8UaEL1mS23SSu7umHi5vqx6sp3IlTxS5XF2WTDvUBMdxA01YuD5hoZwj/n6a9P
         +Co/IOjR83rOLqOjd4mYVBqj2t2Gf35s7sM4oLWLbLon168TXIjeHJOyjVqkD+zO9IEd
         rae8aFJtUzHZEhLz803ek2gmBvWEsYTYyZQ8xu8C/xybVC1uyjGcLnU9mZe9R+iG5DUh
         wdbeayz2CJrH0bL2o11VgXDDwmeCU+Bwmiujfa9X0Aoa9V3K2sZ0N96n4/nwRJkeuUtS
         76vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YD6Nvv0Ivm0Q+cK2tBiqyE/aTP0p2UnVV4lpYYz+xU0=;
        b=fVFISjpOseU24mv1ZiSkFoUndmgzvHlF4+MS5IogztUL7B/y80rU4PCzgtV4C5d7g3
         MZ6C5L+0C/FaeukK+2gkcedgLOone4FpZWF2jPXAnjbUFi0UzKNR3Lv7+MADDziFLsVC
         xmmG8xqDpjEyw+I3f5K+GaxKSn2Tu7Ymo9u21aXoVGbVEIA8qwa4fw2u3q3HP8FOzuSr
         3CjiOjmlj2hRi1iUgHvuAANC2bo8O293ZHps/Sl5CO5ZBiMzjxq0euP3r7+7BE6is7iz
         Cgpa78DkZcIVquTToLWIbVVgP5K+CPEyHd1zN6p22zDPlmkBGQXbv1SqWVXjPIvigxey
         RPfg==
X-Gm-Message-State: APjAAAWgD1UZeuxw7svkx3lr2XCdFtw8byVZ5ENcxPd3PFRyhxvXBJSZ
        8F8XcINCJSqvwWKBPGRyKElihgYeIQc=
X-Google-Smtp-Source: APXvYqx09LXA5uqWIo+1W1H9vF7SFzdDWyskiu3IhytntRcEExi9f7vzM0nEvsSt3+rZ2zm2jN/VvA==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr3204922wml.83.1570638023089;
        Wed, 09 Oct 2019 09:20:23 -0700 (PDT)
Received: from griffinp-mac (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id y5sm2887623wma.14.2019.10.09.09.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 09:20:22 -0700 (PDT)
Date:   Wed, 9 Oct 2019 17:20:20 +0100
From:   Peter Griffin <peter.griffin@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Enrico Weigelt <info@metux.net>
Subject: Re: [PATCH] reset: hi6220: Add support for AO reset controller
Message-ID: <20191009162020.GC29241@griffinp-mac>
References: <20191001182114.69699-1-john.stultz@linaro.org>
 <1570542167.18914.5.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570542167.18914.5.camel@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Many thanks for your review.

(sending again as I dropped the cc list)

On Tue, 08 Oct 2019, Philipp Zabel wrote:

> Hi John, Peter,
> 
> On Tue, 2019-10-01 at 18:21 +0000, John Stultz wrote:
> > From: Peter Griffin <peter.griffin@linaro.org>
> > 
> > This is required to bring Mali450 gpu out of reset.
> 
> Do you know whether this is actually a module reset going to the GPU,
> or if this is somehow part of the clock and power gating machinery?

I don't know for sure, there is no documentation for these registers
apart from the code in [1] and [2], and that is really just the register name.

> There's also clock and isolation cell control going on, so this looks a
> bit like it should be part of a power domain driver.

I choose to add it here as this driver was already managing the
MEDIA_SCTRL_SC_MEDIA_RSTDIS_ADDR register, so it seemed correct for it to also
manage the AO_SCTRL_SC_PW_RSTDIS0_ADDR register.

The write to AO_SCTRL_SC_PW_ISODIS0_ADDR and
AO_SCTRL_SC_PW_CLKEN0_ADDR I guess aren't so clear cut but I wanted to maintain the
same ordering from [1].

I have no info about the power domains on the SoC, so not sure it will be
possible to make it part of a power domain driver.

> Do you have an (internal or external) regulator that could be disabled
> while the GPU is inactive, like [1]?
> 
> [1]
> https://raw.githubusercontent.com/96boards/meta-96boards/master/recipes-kernel/linux/linux-96boards/0004-drivers-gpu-arm-utgard-add-basic-HiKey-platform-file.patch

This patch is based off [1] the regulator mentioned there G3D_PD_VDD it turns
out has never been available and always fails to do anything.

So AFAIK there is no external regulator available to disable. This code has since been
removed from Johns tree [2].

[2] https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey-5.3&id=64ec445a8271a2ced841484492ed9bf2e1ef4313

> 
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Peter Griffin <peter.griffin@linaro.org>
> > Cc: Enrico Weigelt <info@metux.net>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  drivers/reset/hisilicon/hi6220_reset.c | 51 +++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
> > index 24e6d420b26b..d84674a2cead 100644
> > --- a/drivers/reset/hisilicon/hi6220_reset.c
> > +++ b/drivers/reset/hisilicon/hi6220_reset.c
> > @@ -33,6 +33,7 @@
> >  enum hi6220_reset_ctrl_type {
> >  	PERIPHERAL,
> >  	MEDIA,
> > +	AO,
> >  };
> >  
> >  struct hi6220_reset_data {
> > @@ -92,6 +93,47 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
> >  	.deassert = hi6220_media_deassert,
> >  };
> >  
> > +#define AO_SCTRL_SC_PW_CLKEN0     0x800
> > +#define AO_SCTRL_SC_PW_CLKDIS0    0x804
> > +
> > +#define AO_SCTRL_SC_PW_RSTEN0     0x810
> > +#define AO_SCTRL_SC_PW_RSTDIS0    0x814
> > +
> > +#define AO_SCTRL_SC_PW_ISOEN0     0x820
> > +#define AO_SCTRL_SC_PW_ISODIS0    0x824
> > +#define AO_MAX_INDEX              12
> > +
> > +static int hi6220_ao_assert(struct reset_controller_dev *rc_dev,
> > +			    unsigned long idx)
> > +{
> > +	struct hi6220_reset_data *data = to_reset_data(rc_dev);
> > +	struct regmap *regmap = data->regmap;
> > +	int ret;
> > +
> > +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTEN0, BIT(idx));
> > +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISOEN0, BIT(idx));
> > +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKDIS0, BIT(idx));
> 
> I would like the return values not to be ORed together, since they are
> returned to the caller.

Yes I think you mentioned that before. I did send a v2 previously that
addressed that https://lkml.org/lkml/2019/4/19/253. That's my fault for
not following this series up sooner.

> 
> > +	return ret;
> > +}
> > +
> > +static int hi6220_ao_deassert(struct reset_controller_dev *rc_dev,
> > +			      unsigned long idx)
> > +{
> > +	struct hi6220_reset_data *data = to_reset_data(rc_dev);
> > +	struct regmap *regmap = data->regmap;
> > +	int ret;
> > +
> > +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTDIS0, BIT(idx));
> > +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISODIS0, BIT(idx));
> > +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKEN0, BIT(idx));
> 
> Are you sure these are fire and forget, or might the order be important?

The order maybe important, I've not tried a different ordering to
what is here. I kept it the same as [1] which was working with the blob driver
and continues to work with driver.

> 
> It might be necessary to disable isolation before enabling the clocks
> and deasserting reset, to avoid glitches.

You mean a register sequence like this?

regmap_write(regmap, AO_SCTRL_SC_PW_ISODIS0, BIT(idx));
regmap_write(regmap, AO_SCTRL_SC_PW_RSTDIS0, BIT(idx));
regmap_write(AO_SCTRL_SC_PW_CLKEN0, BIT(idx));

regards,

Peter.

> 
> > +	return ret;
> > +}
> > +
> > +static const struct reset_control_ops hi6220_ao_reset_ops = {
> > +	.assert = hi6220_ao_assert,
> > +	.deassert = hi6220_ao_deassert,
> > +};
> > +
> >  static int hi6220_reset_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *np = pdev->dev.of_node;
> > @@ -117,9 +159,12 @@ static int hi6220_reset_probe(struct platform_device *pdev)
> >  	if (type == MEDIA) {
> >  		data->rc_dev.ops = &hi6220_media_reset_ops;
> >  		data->rc_dev.nr_resets = MEDIA_MAX_INDEX;
> > -	} else {
> > +	} else if (type == PERIPHERAL) {
> >  		data->rc_dev.ops = &hi6220_peripheral_reset_ops;
> >  		data->rc_dev.nr_resets = PERIPH_MAX_INDEX;
> > +	} else {
> > +		data->rc_dev.ops = &hi6220_ao_reset_ops;
> > +		data->rc_dev.nr_resets = AO_MAX_INDEX;
> >  	}
> >  
> >  	return reset_controller_register(&data->rc_dev);
> > @@ -134,6 +179,10 @@ static const struct of_device_id hi6220_reset_match[] = {
> >  		.compatible = "hisilicon,hi6220-mediactrl",
> >  		.data = (void *)MEDIA,
> >  	},
> > +	{
> > +		.compatible = "hisilicon,hi6220-aoctrl",
> > +		.data = (void *)AO,
> > +	},
> >  	{ /* sentinel */ },
> >  };
> >  MODULE_DEVICE_TABLE(of, hi6220_reset_match);
> 
> regards
> Philipp
