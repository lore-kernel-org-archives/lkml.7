Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D52C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD0C20675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="avnQLDFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfCDSNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:13:22 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:60528 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDSNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551723196; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sT52sQEbmT2yUQzfhx0VIuGfrJcDBmqoJxedtaDHlZE=;
        b=avnQLDFn8Wgd54n5GlO1/w0pguic2HUcTZtmfuYq+CCMAp5WwaX0mUcX+RwTfPTaoJu8Ei
        YxwQN7bR/aG3XTF2XXOe5Latdh4HZw5ds88BHjkg51GZzOvXWC8yVT0GDqKj+6l4m1fBTC
        EowEYqbIL9wvUqi7uyS1hpUukhHbpJE=
Date:   Mon, 04 Mar 2019 19:13:05 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v10 04/27] clocksource: Add a new timer-ingenic driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Message-Id: <1551723186.4932.0@crapouillou.net>
In-Reply-To: <20190304122250.GC9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
        <20190302233413.14813-5-paul@crapouillou.net> <20190304122250.GC9040@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Mon, Mar 4, 2019 at 1:22 PM, Thierry Reding 
<thierry.reding@gmail.com> wrote:
> On Sat, Mar 02, 2019 at 08:33:50PM -0300, Paul Cercueil wrote:
> [...]
>>  diff --git a/drivers/clocksource/ingenic-timer.c 
>> b/drivers/clocksource/ingenic-timer.c
> [...]
>>  +struct ingenic_tcu {
>>  +	const struct ingenic_soc_info *soc_info;
>>  +	struct regmap *map;
>>  +	struct clk *clk, *timer_clk, *cs_clk;
>>  +
>>  +	struct irq_domain *domain;
>>  +	unsigned int nb_parent_irqs;
>>  +	u32 parent_irqs[3];
>>  +
>>  +	struct clk_hw_onecell_data *clocks;
>>  +
>>  +	unsigned int timer_channel, cs_channel;
>>  +	struct clock_event_device cevt;
>>  +	struct clocksource cs;
>>  +	char name[4];
>>  +
>>  +	unsigned long pwm_channels_mask;
>>  +};
>>  +
>>  +static struct ingenic_tcu *ingenic_tcu;
> 
> Is there really a need for this? Seems like the only two reasons for 
> why
> you keep this around are as pointed out below.
> 
>>  +void __iomem *ingenic_tcu_base;
>>  +EXPORT_SYMBOL_GPL(ingenic_tcu_base);
> 
> Same here.
> 
>>  +static u64 notrace ingenic_tcu_timer_read(void)
>>  +{
>>  +	unsigned int channel = ingenic_tcu->cs_channel;
>>  +	u16 count;
>>  +
>>  +	count = readw(ingenic_tcu_base + TCU_REG_TCNTc(channel));
> 
> Can't yo do this via the regmap?

I could, but for the sched_clock to be precise the function must return
as fast as possible. That's the rationale behind the use of readw() 
here.

That's also the reason why ingenic_tcu_base is global and exported, so
that the OS Timer driver can use it as well.

>>  +
>>  +	return count;
>>  +}
>>  +
>>  +static u64 notrace ingenic_tcu_timer_cs_read(struct clocksource 
>> *cs)
>>  +{
>>  +	return ingenic_tcu_timer_read();
>>  +}
> 
> And here you've got access to the struct clocksource *, from which you
> should be able to get at struct ingenic_tcu * using container_of.
> 
> [...]
>>  +static int __init ingenic_tcu_init(struct device_node *np)
>>  +{
>>  +	const struct of_device_id *id = 
>> of_match_node(ingenic_tcu_of_match, np);
>>  +	const struct ingenic_soc_info *soc_info = id->data;
>>  +	struct ingenic_tcu *tcu;
>>  +	struct resource res;
>>  +	void __iomem *base;
>>  +	long rate;
>>  +	int ret;
>>  +
>>  +	of_node_clear_flag(np, OF_POPULATED);
>>  +
>>  +	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
>>  +	if (!tcu)
>>  +		return -ENOMEM;
>>  +
>>  +	/* Enable all TCU channels for PWM use by default except channel 0
>>  +	 * and channel 1.
>>  +	 */
>>  +	tcu->pwm_channels_mask = GENMASK(soc_info->num_channels - 1, 2);
>>  +	of_property_read_u32(np, "ingenic,pwm-channels-mask",
>>  +			     (u32 *)&tcu->pwm_channels_mask);
>>  +
>>  +	/* Verify that we have at least two free channels */
>>  +	if (hweight8(tcu->pwm_channels_mask) > soc_info->num_channels - 
>> 2) {
>>  +		pr_crit("ingenic-tcu: Invalid PWM channel mask: 0x%02lx\n",
>>  +			tcu->pwm_channels_mask);
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	tcu->soc_info = soc_info;
>>  +	ingenic_tcu = tcu;
>>  +
>>  +	tcu->timer_channel = find_first_zero_bit(&tcu->pwm_channels_mask,
>>  +						 soc_info->num_channels);
>>  +	tcu->cs_channel = find_next_zero_bit(&tcu->pwm_channels_mask,
>>  +					     soc_info->num_channels,
>>  +					     tcu->timer_channel + 1);
>>  +
>>  +	base = of_io_request_and_map(np, 0, NULL);
>>  +	if (IS_ERR(base)) {
>>  +		ret = PTR_ERR(base);
>>  +		goto err_free_ingenic_tcu;
>>  +	}
>>  +
>>  +	of_address_to_resource(np, 0, &res);
>>  +
>>  +	ingenic_tcu_base = base;
>>  +
>>  +	tcu->map = regmap_init_mmio(NULL, base, 
>> &ingenic_tcu_regmap_config);
>>  +	if (IS_ERR(tcu->map)) {
>>  +		ret = PTR_ERR(tcu->map);
>>  +		goto err_iounmap;
>>  +	}
>>  +
>>  +	tcu->clk = of_clk_get_by_name(np, "tcu");
>>  +	if (IS_ERR(tcu->clk)) {
>>  +		ret = PTR_ERR(tcu->clk);
>>  +		pr_crit("ingenic-tcu: Unable to find TCU clock: %i\n", ret);
>>  +		goto err_free_regmap;
>>  +	}
>>  +
>>  +	ret = clk_prepare_enable(tcu->clk);
>>  +	if (ret) {
>>  +		pr_crit("ingenic-tcu: Unable to enable TCU clock: %i\n", ret);
>>  +		goto err_clk_put;
>>  +	}
>>  +
>>  +	ret = ingenic_tcu_intc_init(tcu, np);
>>  +	if (ret)
>>  +		goto err_clk_disable;
>>  +
>>  +	ret = ingenic_tcu_clk_init(tcu, np);
>>  +	if (ret)
>>  +		goto err_tcu_intc_cleanup;
>>  +
>>  +	ret = ingenic_tcu_clocksource_init(tcu);
>>  +	if (ret)
>>  +		goto err_tcu_clk_cleanup;
>>  +
>>  +	ret = ingenic_tcu_timer_init(tcu);
>>  +	if (ret)
>>  +		goto err_tcu_clocksource_cleanup;
>>  +
>>  +	// Register the sched_clock at the very end as there's no way to 
>> undo it
>>  +	rate = clk_get_rate(tcu->cs_clk);
>>  +	sched_clock_register(ingenic_tcu_timer_read, 16, rate);
> 
> Oh wow... so you managed to nicely encapsulate everything and now this
> seems to be the only reason why you need to rely on global variables.
> 
> That's unfortunate. I suppose we could go and add a void *data 
> parameter
> to sched_clock_register() and pass that to the read() function. That 
> way
> you could make this completely independent of global variables, but
> there are 73 callers of sched_clock_register() and they are spread all
> over the place, so sounds a bit daunting to me.

Yes, that's the main reason behind the use of a global variables.
Is there a way we could introduce another callback, e.g. .read_value(),
that would receive a void *param? Then the current .read() callback
can be deprecated and the 73 callers can be migrated later.

>>  +
>>  +	return 0;
>>  +
>>  +err_tcu_clocksource_cleanup:
>>  +	ingenic_tcu_clocksource_cleanup(tcu);
>>  +err_tcu_clk_cleanup:
>>  +	ingenic_tcu_clk_cleanup(tcu, np);
>>  +err_tcu_intc_cleanup:
>>  +	ingenic_tcu_intc_cleanup(tcu);
>>  +err_clk_disable:
>>  +	clk_disable_unprepare(tcu->clk);
>>  +err_clk_put:
>>  +	clk_put(tcu->clk);
>>  +err_free_regmap:
>>  +	regmap_exit(tcu->map);
>>  +err_iounmap:
>>  +	iounmap(base);
>>  +	release_mem_region(res.start, resource_size(&res));
>>  +err_free_ingenic_tcu:
>>  +	kfree(tcu);
>>  +	return ret;
>>  +}
>>  +
>>  +TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu",  
>> ingenic_tcu_init);
>>  +TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu", 
>> ingenic_tcu_init);
>>  +TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu",  
>> ingenic_tcu_init);
>>  +
>>  +
>>  +static int __init ingenic_tcu_probe(struct platform_device *pdev)
>>  +{
>>  +	platform_set_drvdata(pdev, ingenic_tcu);
> 
> Then there's also this. Oh well... nevermind then.

The content of ingenic_tcu_platform_init() could be moved inside
ingenic_tcu_init(). But can we get a hold of the struct device before 
the
probe function is called? That would allow to set the drvdata and regmap
without relying on global state.

>>  +bool ingenic_tcu_pwm_can_use_chn(unsigned int channel)
>>  +{
>>  +	return !!(ingenic_tcu->pwm_channels_mask & BIT(channel));
>>  +}
>>  +EXPORT_SYMBOL_GPL(ingenic_tcu_pwm_can_use_chn);
> 
> I wonder if we could make this slightly nicer, though. Judging by the
> name, this one seems like it would only ever be used by the PWM. If 
> the
> PWM is a child of the TCU, could it not pass in a struct device * that
> points to its parent into this? Or perhaps pass its own struct device 
> *
> and have this function look up the struct ingenic_tcu from that? 
> Should
> be something trivial as:
> 
> 	bool ingenic_tcu_pwm_can_use_channel(struct device *dev, unsigned 
> int channel)
> 	{
> 		struct ingenic_tcu *tcu = dev_get_drvdata(dev->parent);
> 
> 		return !!(tcu->pwm_channels_mask & BIT(channel));
> 	}
> 
> Thierry

Yes, that definitely looks better. Thanks for the hint.

-Paul


