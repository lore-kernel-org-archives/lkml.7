Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03555C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D703A22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfHTPjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:39:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45525 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfHTPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:39:47 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i06EZ-0001wj-Be; Tue, 20 Aug 2019 17:39:43 +0200
Message-ID: <1566315581.3030.18.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: meson-audio-arb: add sm1 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 20 Aug 2019 17:39:41 +0200
In-Reply-To: <20190820094625.13455-3-jbrunet@baylibre.com>
References: <20190820094625.13455-1-jbrunet@baylibre.com>
         <20190820094625.13455-3-jbrunet@baylibre.com>
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

Hi Jerome,

thank you for the patch. Just one nitpick and one real issue below:

On Tue, 2019-08-20 at 11:46 +0200, Jerome Brunet wrote:
> Add the new arb reset lines of the SM1 SoC family
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/reset-meson-audio-arb.c | 28 ++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
> index c53a2185a039..72d29dbca45a 100644
> --- a/drivers/reset/reset-meson-audio-arb.c
> +++ b/drivers/reset/reset-meson-audio-arb.c
> @@ -30,6 +30,17 @@ static const unsigned int axg_audio_arb_reset_bits[] = {
>  	[AXG_ARB_FRDDR_C]	= 6,
>  };
>  
> +static const unsigned int sm1_audio_arb_reset_bits[] = {
> +	[AXG_ARB_TODDR_A]	= 0,
> +	[AXG_ARB_TODDR_B]	= 1,
> +	[AXG_ARB_TODDR_C]	= 2,
> +	[AXG_ARB_FRDDR_A]	= 4,
> +	[AXG_ARB_FRDDR_B]	= 5,
> +	[AXG_ARB_FRDDR_C]	= 6,
> +	[AXG_ARB_TODDR_D]	= 3,
> +	[AXG_ARB_FRDDR_D]	= 7,
> +};
> +
>  static int meson_audio_arb_update(struct reset_controller_dev *rcdev,
>  				  unsigned long id, bool assert)
>  {
> @@ -82,8 +93,14 @@ static const struct reset_control_ops meson_audio_arb_rstc_ops = {
>  };
>  
>  static const struct of_device_id meson_audio_arb_of_match[] = {
> -	{ .compatible = "amlogic,meson-axg-audio-arb", },
> -	{}
> +	{
> +		.compatible = "amlogic,meson-axg-audio-arb",
> +		.data = axg_audio_arb_reset_bits,
> +	},
> +	{
> +		.compatible = "amlogic,meson-sm1-audio-arb",
> +		.data = sm1_audio_arb_reset_bits
> +	}, {}

Only slight preference, I would keep the sentinel on a separate line.
Your choice.

>  };
>  MODULE_DEVICE_TABLE(of, meson_audio_arb_of_match);
>  
> @@ -104,10 +121,15 @@ static int meson_audio_arb_remove(struct platform_device *pdev)
>  static int meson_audio_arb_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	const unsigned int *data;
>  	struct meson_audio_arb_data *arb;
>  	struct resource *res;
>  	int ret;
>  
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +
>  	arb = devm_kzalloc(dev, sizeof(*arb), GFP_KERNEL);
>  	if (!arb)
>  		return -ENOMEM;
> @@ -126,7 +148,7 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
>  		return PTR_ERR(arb->regs);
>  
>  	spin_lock_init(&arb->lock);
> -	arb->reset_bits = axg_audio_arb_reset_bits;
> +	arb->reset_bits = data;
>  	arb->rstc.nr_resets = ARRAY_SIZE(axg_audio_arb_reset_bits);

Since SM1 has two more resets, this needs to come from device match data
as well, or the last two resets will be unusable.

>  	arb->rstc.ops = &meson_audio_arb_rstc_ops;
>  	arb->rstc.of_node = dev->of_node;

regards
Philipp
