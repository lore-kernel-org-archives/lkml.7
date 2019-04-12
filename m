Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68DFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A302171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDLKYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:24:05 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:39714 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbfDLKYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:24:04 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EtLkh05rdNG8zEtLlhCJfJ; Fri, 12 Apr 2019 12:24:01 +0200
Subject: Re: [PATCH v2 2/2] drm/sun4i: dw-hdmi: Bit bang CEC on some SoCs
To:     Jernej Skrabec <jernej.skrabec@siol.net>, maxime.ripard@bootlin.com
Cc:     narmstrong@baylibre.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        wens@csie.org, Laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org
References: <20190401191513.23159-1-jernej.skrabec@siol.net>
 <20190401191513.23159-3-jernej.skrabec@siol.net>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <bc3d80c3-c249-9d5e-f26b-df146b580224@xs4all.nl>
Date:   Fri, 12 Apr 2019 12:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401191513.23159-3-jernej.skrabec@siol.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAwB0wri52zhokfyFebSm91lsoHzNzKNuNDKFsyqfqoHJOyqSHINDsB46wtueYVW3WRcwhOHirggFzDKWERKM7pU6FcoJA66Hig41tb8jS0eIvFwBKww
 BGfBGjniPyu5vdqaK6d9MfY8SYz+oaw46wVfXFJmfQVkllZaEF3VeVhz1xErp2OTqxNvealWjrmkdok2DZOVrJ6dbfwWdI2SwvL6KfQxUf3p8CSMVVOVq30L
 aP8w2OgNCxqCcOzmijuFgkaeoedeJ/UtC9IHAUeFdYpNW/xUVzwfYNXzuTversOhGT61a/7ue6GSLk+1xVba6SJEaV8DBaHU+WKD5S95VSHVZve9N0GXofyQ
 nvBhEPnA0cXL6XPAbBaMNAVeTVyte3rBlDGX9fG9mcOvjEnVIZCu9rrrvR0yCvMPiCz1GvnXQ81SghV3UhPLTm0fwdg1T+wHm73xUwQEXU2Pfob61oKbwGc/
 gC0OYsJVqKsuy6xFx9Q/5orm1gHg2JUsao7C8Wav9DZXjzmqn66kSFLa3La5Cldc5YdQhlYMaPmj/hx/KBvd97W7Zx93B//H/soAZbzNKAuHpXaHfKW+kppw
 CrM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 9:15 PM, Jernej Skrabec wrote:
> All DW HDMI controllers used by Allwinner SoCs include CEC controller.
> However, due to additional logic put between CEC controller and pins,
> CEC communication doesn't work well on some of them.
> 
> Based on observations, it seems that only outgoing messages are
> properly transmitted. It's possible that it would still work correctly
> if pins are switched between input and output mode manually in right
> moment. But that's very error prone. It's better and easier just to bit
> bang protocol.
> 
> Enable bit banging just for controller and phy combination found in H3
> and other 40nm SoCs. Other combinations work (H6) or the status is
> unknown (A83T).
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/Kconfig          | 10 ++++
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  | 11 ++++
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 83 +++++++++++++++++++++++++-
>  3 files changed, 102 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index 1dbbc3a1b763..7149c72e44c8 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -60,6 +60,16 @@ config DRM_SUN8I_DW_HDMI
>  	  DesignWare HDMI controller with custom HDMI PHY. If M is
>  	  selected the module will be called sun8i_dw_hdmi.
>  
> +config DRM_SUN8I_DW_HDMI_CEC
> +       bool "Allwinner DesignWare HDMI CEC Support for 40nm SoCs"

I'm not sure mentioning "DesignWare" here is right. The CEC support
(as I understand it) bypasses the DW entirely and is really a sunxi
specific implementation.

> +       depends on DRM_SUN8I_DW_HDMI
> +       select CEC_CORE
> +       select CEC_PIN
> +       help
> +	  Choose this option if you have an 40nm Allwinner SoC with
> +	  the DesignWare HDMI controller with custom HDMI PHY and
> +	  you want to use CEC.
> +
>  config DRM_SUN8I_MIXER
>  	tristate "Support for Allwinner Display Engine 2.0 Mixer"
>  	default MACH_SUN8I
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> index 720c5aa8adc1..49ca001923e3 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> @@ -12,6 +12,7 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> +#include <media/cec-pin.h>
>  
>  #define SUN8I_HDMI_PHY_DBG_CTRL_REG	0x0000
>  #define SUN8I_HDMI_PHY_DBG_CTRL_PX_LOCK		BIT(0)
> @@ -144,6 +145,13 @@
>  #define SUN8I_HDMI_PHY_ANA_STS_RCAL_MASK	GENMASK(5, 0)
>  
>  #define SUN8I_HDMI_PHY_CEC_REG		0x003c
> +#define SUN8I_HDMI_PHY_CEC_PIN_CTRL		BIT(7)
> +/*
> + * Documentation says that this bit is output enable. However,
> + * it seems that this bit is actually output disable.
> + */
> +#define SUN8I_HDMI_PHY_CEC_OUT_DIS		BIT(2)
> +#define SUN8I_HDMI_PHY_CEC_IN_DATA		BIT(1)
>  
>  struct sun8i_hdmi_phy;
>  
> @@ -151,6 +159,7 @@ struct sun8i_hdmi_phy_variant {
>  	bool has_phy_clk;
>  	bool has_second_pll;
>  	unsigned int is_custom_phy : 1;
> +	unsigned int bit_bang_cec : 1;
>  	const struct dw_hdmi_curr_ctrl *cur_ctr;
>  	const struct dw_hdmi_mpll_config *mpll_cfg;
>  	const struct dw_hdmi_phy_config *phy_cfg;
> @@ -163,6 +172,8 @@ struct sun8i_hdmi_phy_variant {
>  };
>  
>  struct sun8i_hdmi_phy {
> +	struct cec_adapter		*cec_adapter;
> +	struct cec_notifier		*cec_notifier;
>  	struct clk			*clk_bus;
>  	struct clk			*clk_mod;
>  	struct clk			*clk_phy;
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> index 66ea3a902e36..8fd6bf91714e 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -503,8 +503,9 @@ static void sun8i_hdmi_phy_init_h3(struct sun8i_hdmi_phy *phy)
>  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
>  			   SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK, 0);
>  
> -	/* set HW control of CEC pins */
> -	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG, 0);
> +	/* manual control of CEC pins */
> +	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG,
> +		     SUN8I_HDMI_PHY_CEC_PIN_CTRL);
>  
>  	/* read calibration data */
>  	regmap_read(phy->regs, SUN8I_HDMI_PHY_ANA_STS_REG, &val);
> @@ -530,8 +531,49 @@ void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
>  		plat_data->cur_ctr = variant->cur_ctr;
>  		plat_data->phy_config = variant->phy_cfg;
>  	}
> +	plat_data->disable_cec = phy->variant->bit_bang_cec;
>  }
>  
> +#ifdef CONFIG_DRM_SUN8I_DW_HDMI_CEC
> +static bool sun8i_hdmi_phy_cec_pin_read(struct cec_adapter *adap)
> +{
> +	struct sun8i_hdmi_phy *phy = cec_get_drvdata(adap);
> +	unsigned int val;
> +
> +	regmap_read(phy->regs, SUN8I_HDMI_PHY_CEC_REG, &val);
> +
> +	return val & SUN8I_HDMI_PHY_CEC_IN_DATA;
> +}
> +
> +static void sun8i_hdmi_phy_cec_pin_low(struct cec_adapter *adap)
> +{
> +	struct sun8i_hdmi_phy *phy = cec_get_drvdata(adap);
> +
> +	/* Start driving the CEC pin low */
> +	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG,
> +		     SUN8I_HDMI_PHY_CEC_PIN_CTRL);
> +}
> +
> +static void sun8i_hdmi_phy_cec_pin_high(struct cec_adapter *adap)
> +{
> +	struct sun8i_hdmi_phy *phy = cec_get_drvdata(adap);
> +
> +	/*
> +	 * Stop driving the CEC pin, the pull up will take over
> +	 * unless another CEC device is driving the pin low.
> +	 */
> +	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG,
> +		     SUN8I_HDMI_PHY_CEC_PIN_CTRL |
> +		     SUN8I_HDMI_PHY_CEC_OUT_DIS);
> +}
> +
> +static const struct cec_pin_ops sun8i_hdmi_phy_cec_pin_ops = {
> +	.read = sun8i_hdmi_phy_cec_pin_read,
> +	.low = sun8i_hdmi_phy_cec_pin_low,
> +	.high = sun8i_hdmi_phy_cec_pin_high,
> +};
> +#endif
> +
>  static struct regmap_config sun8i_hdmi_phy_regmap_config = {
>  	.reg_bits	= 32,
>  	.val_bits	= 32,
> @@ -548,6 +590,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
>  };
>  
>  static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
> +	.bit_bang_cec = true,
>  	.has_phy_clk = true,
>  	.is_custom_phy = true,
>  	.phy_init = &sun8i_hdmi_phy_init_h3,
> @@ -556,6 +599,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
>  };
>  
>  static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy = {
> +	.bit_bang_cec = true,
>  	.has_phy_clk = true,
>  	.has_second_pll = true,
>  	.is_custom_phy = true,
> @@ -565,6 +609,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_r40_hdmi_phy = {
>  };
>  
>  static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
> +	.bit_bang_cec = true,
>  	.has_phy_clk = true,
>  	.is_custom_phy = true,
>  	.phy_init = &sun8i_hdmi_phy_init_h3,
> @@ -708,10 +753,40 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
>  		goto err_disable_clk_bus;
>  	}
>  
> +#ifdef CONFIG_DRM_SUN8I_DW_HDMI_CEC
> +	if (phy->variant->bit_bang_cec) {
> +		phy->cec_notifier = cec_notifier_get(dev);
> +		if (!phy->cec_notifier) {
> +			ret = -ENOMEM;
> +			goto err_disable_clk_mod;
> +		}
> +
> +		phy->cec_adapter =
> +			cec_pin_allocate_adapter(&sun8i_hdmi_phy_cec_pin_ops,
> +						 phy, "sun8i-cec",
> +						 CEC_CAP_DEFAULTS);

Please note that while this cec-pin implementation is quite accurate, you can make
it miss messages. Specifically when transmitting or receiving broadcast messages
since there is no proper acknowledge mechanism to verify that there were no timing
errors due to a missed deadline of the high-res timer.

That said, when I tested this originally on the Allwinner A10, it was very hard
to make it fail. But it remains a second-choice implementation.

But it does have an advantage in that it allows you to enable CEC error injection
and test all sorts of nasty scenarios :-)

I do think you should document somewhere why you had to choose this option for
CEC instead of the DW solution. It's not obvious.

Regards,

	Hans

> +		ret = PTR_ERR_OR_ZERO(phy->cec_adapter);
> +		if (ret < 0)
> +			goto err_put_cec_notifier;
> +
> +		ret = cec_register_adapter(phy->cec_adapter, dev);
> +		if (ret < 0)
> +			goto err_delete_cec_adapter;
> +
> +		cec_register_cec_notifier(phy->cec_adapter, phy->cec_notifier);
> +	}
> +#endif
> +
>  	hdmi->phy = phy;
>  
>  	return 0;
>  
> +err_delete_cec_adapter:
> +	cec_delete_adapter(phy->cec_adapter);
> +err_put_cec_notifier:
> +	cec_notifier_put(phy->cec_notifier);
> +err_disable_clk_mod:
> +	clk_disable_unprepare(phy->clk_mod);
>  err_disable_clk_bus:
>  	clk_disable_unprepare(phy->clk_bus);
>  err_deassert_rst_phy:
> @@ -736,6 +811,10 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
>  {
>  	struct sun8i_hdmi_phy *phy = hdmi->phy;
>  
> +	cec_unregister_adapter(phy->cec_adapter);
> +	if (phy->cec_notifier)
> +		cec_notifier_put(phy->cec_notifier);
> +
>  	clk_disable_unprepare(phy->clk_mod);
>  	clk_disable_unprepare(phy->clk_bus);
>  	clk_disable_unprepare(phy->clk_phy);
> 

