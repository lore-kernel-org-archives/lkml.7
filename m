Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE1C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE3220665
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfFPQ46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:56:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:3759 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfFPQ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:56:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 09:56:57 -0700
X-ExtLoop1: 1
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.23.51]) ([10.252.23.51])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2019 09:56:53 -0700
Subject: Re: [PATCH v7 3/4] ASoC: rt5677: clear interrupts by polarity flip
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org
References: <20190614194854.208436-1-fletcherw@chromium.org>
 <20190614194854.208436-4-fletcherw@chromium.org>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <4e560e12-4c20-8d5d-b3f9-587a55da279d@intel.com>
Date:   Sun, 16 Jun 2019 18:56:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614194854.208436-4-fletcherw@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-06-14 21:48, Fletcher Woodruff wrote:
> From: Ben Zhang <benzh@chromium.org>
> 
> The rt5677 jack detection function has a requirement that the polarity
> of an interrupt be flipped after it fires in order to clear the
> interrupt.
> 
> This patch implements an irq_chip with irq_domain directly instead of
> using regmap-irq, so that interrupt source line polarities can be
> flipped in the irq handler.
> 
> The reason that this patch does not add this feature within regmap-irq
> is that future patches will add hotword detection support to this irq
> handler. Those patches will require adding additional logic that would
> not make sense to have in regmap-irq.
> 
> Signed-off-by: Ben Zhang <benzh@chromium.org>
> Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
> ---
>   sound/soc/codecs/rt5677.c | 170 ++++++++++++++++++++++++++++++--------
>   sound/soc/codecs/rt5677.h |   7 +-
>   2 files changed, 143 insertions(+), 34 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 87a92ba0d040b7..87466ee222ee59 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -23,6 +23,10 @@
>   #include <linux/firmware.h>
>   #include <linux/of_device.h>
>   #include <linux/property.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/workqueue.h>
>   #include <sound/core.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
> @@ -4620,7 +4624,6 @@ static void rt5677_gpio_config(struct rt5677_priv *rt5677, unsigned offset,
>   static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
>   {
>   	struct rt5677_priv *rt5677 = gpiochip_get_data(chip);
> -	struct regmap_irq_chip_data *data = rt5677->irq_data;
>   	int irq;
>   
>   	if ((rt5677->pdata.jd1_gpio == 1 && offset == RT5677_GPIO1) ||
> @@ -4646,7 +4649,7 @@ static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
>   		return -ENXIO;
>   	}
>   
> -	return regmap_irq_get_virq(data, irq);
> +	return irq_create_mapping(rt5677->domain, irq);
>   }
>   
>   static const struct gpio_chip rt5677_template_chip = {
> @@ -5042,30 +5045,130 @@ static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
>   		rt5677->pdata.jd3_gpio = val;
>   }
>   
> -static struct regmap_irq rt5677_irqs[] = {
> +struct rt5677_irq_desc {
> +	unsigned int enable_mask;
> +	unsigned int status_mask;
> +	unsigned int polarity_mask;
> +};
> +
> +static const struct rt5677_irq_desc rt5677_irq_descs[] = {
>   	[RT5677_IRQ_JD1] = {
> -		.reg_offset = 0,
> -		.mask = RT5677_EN_IRQ_GPIO_JD1,
> +		.enable_mask = RT5677_EN_IRQ_GPIO_JD1,
> +		.status_mask = RT5677_STA_GPIO_JD1,
> +		.polarity_mask = RT5677_INV_GPIO_JD1,
>   	},
>   	[RT5677_IRQ_JD2] = {
> -		.reg_offset = 0,
> -		.mask = RT5677_EN_IRQ_GPIO_JD2,
> +		.enable_mask = RT5677_EN_IRQ_GPIO_JD2,
> +		.status_mask = RT5677_STA_GPIO_JD2,
> +		.polarity_mask = RT5677_INV_GPIO_JD2,
>   	},
>   	[RT5677_IRQ_JD3] = {
> -		.reg_offset = 0,
> -		.mask = RT5677_EN_IRQ_GPIO_JD3,
> +		.enable_mask = RT5677_EN_IRQ_GPIO_JD3,
> +		.status_mask = RT5677_STA_GPIO_JD3,
> +		.polarity_mask = RT5677_INV_GPIO_JD3,
>   	},
>   };
>   
> -static struct regmap_irq_chip rt5677_irq_chip = {
> -	.name = RT5677_DRV_NAME,
> -	.irqs = rt5677_irqs,
> -	.num_irqs = ARRAY_SIZE(rt5677_irqs),
> +static irqreturn_t rt5677_irq(int unused, void *data)
> +{
> +	struct rt5677_priv *rt5677 = data;
> +	int ret = 0, i, reg_irq, virq;
> +	bool irq_fired = false;
> +
> +	mutex_lock(&rt5677->irq_lock);
> +	/* Read interrupt status */
> +	ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
> +	if (ret) {
> +		pr_err("rt5677: failed reading IRQ status: %d\n", ret);

The entire rt5677 makes use of dev_XXX with the exception of.. this very 
function. Consider reusing "component" field which is already part of 
struct rt5677_priv and removing pr_XXX.

> +		goto exit;
> +	}
> +
> +	for (i = 0; i < RT5677_IRQ_NUM; i++) {
> +		if (reg_irq & rt5677_irq_descs[i].status_mask) {
> +			irq_fired = true;
> +			virq = irq_find_mapping(rt5677->domain, i);
> +			if (virq)
> +				handle_nested_irq(virq);
> +
> +			/* Clear the interrupt by flipping the polarity of the
> +			 * interrupt source line that fired
> +			 */
> +			reg_irq ^= rt5677_irq_descs[i].polarity_mask;
> +		}
> +	}
> +
> +	if (!irq_fired)
> +		goto exit;
> +
> +	ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
> +	if (ret) {
> +		pr_err("rt5677: failed updating IRQ status: %d\n", ret);

Same here.

> +		goto exit;
> +	}
> +exit:
> +	mutex_unlock(&rt5677->irq_lock);
> +	if (irq_fired)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
> +}
>   
> -	.num_regs = 1,
> -	.status_base = RT5677_IRQ_CTRL1,
> -	.mask_base = RT5677_IRQ_CTRL1,
> -	.mask_invert = 1,
> +static void rt5677_irq_bus_lock(struct irq_data *data)
> +{
> +	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
> +
> +	mutex_lock(&rt5677->irq_lock);
> +}
> +
> +static void rt5677_irq_bus_sync_unlock(struct irq_data *data)
> +{
> +	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
> +
> +	// Set the enable/disable bits for the jack detect IRQs.
> +	regmap_update_bits(rt5677->regmap, RT5677_IRQ_CTRL1,
> +			RT5677_EN_IRQ_GPIO_JD1 | RT5677_EN_IRQ_GPIO_JD2 |
> +			RT5677_EN_IRQ_GPIO_JD3, rt5677->irq_en);
> +	mutex_unlock(&rt5677->irq_lock);
> +}
> +
> +static void rt5677_irq_enable(struct irq_data *data)
> +{
> +	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
> +
> +	rt5677->irq_en |= rt5677_irq_descs[data->hwirq].enable_mask;
> +}
> +
> +static void rt5677_irq_disable(struct irq_data *data)
> +{
> +	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
> +
> +	rt5677->irq_en &= ~rt5677_irq_descs[data->hwirq].enable_mask;
> +}
> +
> +static struct irq_chip rt5677_irq_chip = {
> +	.name			= "rt5677_irq_chip",
> +	.irq_bus_lock		= rt5677_irq_bus_lock,
> +	.irq_bus_sync_unlock	= rt5677_irq_bus_sync_unlock,
> +	.irq_disable		= rt5677_irq_disable,
> +	.irq_enable		= rt5677_irq_enable,
> +};
> +
> +static int rt5677_irq_map(struct irq_domain *h, unsigned int virq,
> +			  irq_hw_number_t hw)
> +{
> +	struct rt5677_priv *rt5677 = h->host_data;
> +
> +	irq_set_chip_data(virq, rt5677);
> +	irq_set_chip(virq, &rt5677_irq_chip);
> +	irq_set_nested_thread(virq, 1);
> +	irq_set_noprobe(virq);
> +	return 0;
> +}
> +
> +
> +static const struct irq_domain_ops rt5677_domain_ops = {
> +	.map	= rt5677_irq_map,
> +	.xlate	= irq_domain_xlate_twocell,
>   };
>   
>   static int rt5677_init_irq(struct i2c_client *i2c)
> @@ -5084,6 +5187,8 @@ static int rt5677_init_irq(struct i2c_client *i2c)
>   		return -EINVAL;
>   	}
>   
> +	mutex_init(&rt5677->irq_lock);
> +
>   	/*
>   	 * Select RC as the debounce clock so that GPIO works even when
>   	 * MCLK is gated which happens when there is no audio stream
> @@ -5092,7 +5197,6 @@ static int rt5677_init_irq(struct i2c_client *i2c)
>   	regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC,
>   			RT5677_IRQ_DEBOUNCE_SEL_MASK,
>   			RT5677_IRQ_DEBOUNCE_SEL_RC);
> -
>   	/* Enable auto power on RC when GPIO states are changed */
>   	regmap_update_bits(rt5677->regmap, RT5677_GEN_CTRL1, 0xff, 0xff);
>   
> @@ -5115,26 +5219,25 @@ static int rt5677_init_irq(struct i2c_client *i2c)
>   	regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL1,
>   			RT5677_GPIO1_PIN_MASK, RT5677_GPIO1_PIN_IRQ);
>   
> -	ret = regmap_add_irq_chip(rt5677->regmap, i2c->irq,
> -		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT, 0,
> -		&rt5677_irq_chip, &rt5677->irq_data);
> +	/* Ready to listen for interrupts */
> +	rt5677->domain = irq_domain_add_linear(i2c->dev.of_node,
> +			RT5677_IRQ_NUM, &rt5677_domain_ops, rt5677);
> +	if (!rt5677->domain) {
> +		dev_err(&i2c->dev, "Failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
>   
> -	if (ret != 0) {
> -		dev_err(&i2c->dev, "Failed to register IRQ chip: %d\n", ret);
> +	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL, rt5677_irq,
> +			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			"rt5677", rt5677);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
>   		return ret;

You may want to simplify this, similarly to how's it done in your 
rt5677_i2c_probe - leave message alone and return "ret" explicitly at 
the end.

>   	}
>   
>   	return 0;
>   }
>   
> -static void rt5677_free_irq(struct i2c_client *i2c)
> -{
> -	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
> -
> -	if (rt5677->irq_data)
> -		regmap_del_irq_chip(i2c->irq, rt5677->irq_data);
> -}
> -
>   static int rt5677_i2c_probe(struct i2c_client *i2c)
>   {
>   	struct rt5677_priv *rt5677;
> @@ -5259,7 +5362,9 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
>   			RT5677_MICBIAS1_CTRL_VDD_3_3V);
>   
>   	rt5677_init_gpio(i2c);
> -	rt5677_init_irq(i2c);
> +	ret = rt5677_init_irq(i2c);
> +	if (ret)
> +		dev_err(&i2c->dev, "Failed to initialize irq: %d\n", ret);
>   
>   	return devm_snd_soc_register_component(&i2c->dev,
>   				      &soc_component_dev_rt5677,
> @@ -5268,7 +5373,6 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
>   
>   static int rt5677_i2c_remove(struct i2c_client *i2c)
>   {
> -	rt5677_free_irq(i2c);
>   	rt5677_free_gpio(i2c);
>   
>   	return 0;
> diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
> index c26edd387e340b..d0ac26e562eb5f 100644
> --- a/sound/soc/codecs/rt5677.h
> +++ b/sound/soc/codecs/rt5677.h
> @@ -1749,6 +1749,7 @@ enum {
>   	RT5677_IRQ_JD1,
>   	RT5677_IRQ_JD2,
>   	RT5677_IRQ_JD3,
> +	RT5677_IRQ_NUM,
>   };
>   
>   enum rt5677_type {
> @@ -1847,9 +1848,13 @@ struct rt5677_priv {
>   	struct gpio_chip gpio_chip;
>   #endif
>   	bool dsp_vad_en;
> -	struct regmap_irq_chip_data *irq_data;
>   	bool is_dsp_mode;
>   	bool is_vref_slow;
> +
> +	/* Interrupt handling */
> +	struct irq_domain *domain;
> +	struct mutex irq_lock;
> +	unsigned int irq_en;
>   };
>   
>   int rt5677_sel_asrc_clk_src(struct snd_soc_component *component,
> 
