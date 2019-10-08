Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0014FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D752520673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfJHNmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:42:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36103 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJHNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:42:48 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iHplH-0003AG-N2; Tue, 08 Oct 2019 15:42:47 +0200
Message-ID: <1570542167.18914.5.camel@pengutronix.de>
Subject: Re: [PATCH] reset: hi6220: Add support for AO reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Enrico Weigelt <info@metux.net>
Date:   Tue, 08 Oct 2019 15:42:47 +0200
In-Reply-To: <20191001182114.69699-1-john.stultz@linaro.org>
References: <20191001182114.69699-1-john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John, Peter,

On Tue, 2019-10-01 at 18:21 +0000, John Stultz wrote:
> From: Peter Griffin <peter.griffin@linaro.org>
> 
> This is required to bring Mali450 gpu out of reset.

Do you know whether this is actually a module reset going to the GPU,
or if this is somehow part of the clock and power gating machinery?
There's also clock and isolation cell control going on, so this looks a
bit like it should be part of a power domain driver.
Do you have an (internal or external) regulator that could be disabled
while the GPU is inactive, like [1]?

[1] https://raw.githubusercontent.com/96boards/meta-96boards/master/recipes-kernel/linux/linux-96boards/0004-drivers-gpu-arm-utgard-add-basic-HiKey-platform-file.patch

> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Enrico Weigelt <info@metux.net>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/reset/hisilicon/hi6220_reset.c | 51 +++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
> index 24e6d420b26b..d84674a2cead 100644
> --- a/drivers/reset/hisilicon/hi6220_reset.c
> +++ b/drivers/reset/hisilicon/hi6220_reset.c
> @@ -33,6 +33,7 @@
>  enum hi6220_reset_ctrl_type {
>  	PERIPHERAL,
>  	MEDIA,
> +	AO,
>  };
>  
>  struct hi6220_reset_data {
> @@ -92,6 +93,47 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
>  	.deassert = hi6220_media_deassert,
>  };
>  
> +#define AO_SCTRL_SC_PW_CLKEN0     0x800
> +#define AO_SCTRL_SC_PW_CLKDIS0    0x804
> +
> +#define AO_SCTRL_SC_PW_RSTEN0     0x810
> +#define AO_SCTRL_SC_PW_RSTDIS0    0x814
> +
> +#define AO_SCTRL_SC_PW_ISOEN0     0x820
> +#define AO_SCTRL_SC_PW_ISODIS0    0x824
> +#define AO_MAX_INDEX              12
> +
> +static int hi6220_ao_assert(struct reset_controller_dev *rc_dev,
> +			    unsigned long idx)
> +{
> +	struct hi6220_reset_data *data = to_reset_data(rc_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret;
> +
> +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTEN0, BIT(idx));
> +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISOEN0, BIT(idx));
> +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKDIS0, BIT(idx));

I would like the return values not to be ORed together, since they are
returned to the caller.

> +	return ret;
> +}
> +
> +static int hi6220_ao_deassert(struct reset_controller_dev *rc_dev,
> +			      unsigned long idx)
> +{
> +	struct hi6220_reset_data *data = to_reset_data(rc_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret;
> +
> +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTDIS0, BIT(idx));
> +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISODIS0, BIT(idx));
> +	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKEN0, BIT(idx));

Are you sure these are fire and forget, or might the order be important?

It might be necessary to disable isolation before enabling the clocks
and deasserting reset, to avoid glitches.

> +	return ret;
> +}
> +
> +static const struct reset_control_ops hi6220_ao_reset_ops = {
> +	.assert = hi6220_ao_assert,
> +	.deassert = hi6220_ao_deassert,
> +};
> +
>  static int hi6220_reset_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -117,9 +159,12 @@ static int hi6220_reset_probe(struct platform_device *pdev)
>  	if (type == MEDIA) {
>  		data->rc_dev.ops = &hi6220_media_reset_ops;
>  		data->rc_dev.nr_resets = MEDIA_MAX_INDEX;
> -	} else {
> +	} else if (type == PERIPHERAL) {
>  		data->rc_dev.ops = &hi6220_peripheral_reset_ops;
>  		data->rc_dev.nr_resets = PERIPH_MAX_INDEX;
> +	} else {
> +		data->rc_dev.ops = &hi6220_ao_reset_ops;
> +		data->rc_dev.nr_resets = AO_MAX_INDEX;
>  	}
>  
>  	return reset_controller_register(&data->rc_dev);
> @@ -134,6 +179,10 @@ static const struct of_device_id hi6220_reset_match[] = {
>  		.compatible = "hisilicon,hi6220-mediactrl",
>  		.data = (void *)MEDIA,
>  	},
> +	{
> +		.compatible = "hisilicon,hi6220-aoctrl",
> +		.data = (void *)AO,
> +	},
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, hi6220_reset_match);

regards
Philipp
