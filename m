Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2062075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPUXCYEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCDMW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:22:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56068 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfCDMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:22:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so4423134wme.5;
        Mon, 04 Mar 2019 04:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4kMnixqjzqkVi41V58fiyomEz0pDuXojx7d8ot1TBB8=;
        b=uPUXCYEpCBKDtNpG2AVsbYF+M1J0DzYhdB/l5L4iyF0hVGANzJnDwfhV+P23UKGO6l
         O12kteTUcjxB0uTrHiGsjrkuLKhLilBX3cGWU/lOxyq/v0MSSMz5qNwR4Ref54ikXQEx
         VLqh0t2kKbTsZqXVXNX9kYOS9kVrx8tfCuIwsyRRvVvehVlROsCL46wPGKeQeAVSC8pS
         wDB8WXpjpjJtkL7o+817NBtVIQWyA9WfrX+HomM/QSGK1Z9IM27tcY2sQnHwvDh4GzfH
         DbzKC2gkvvlEnviKBegt1NI/PNNd8aYsCOwVvoPzxGImjF7D5kkDOG1CiLXMbszsRI03
         UG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4kMnixqjzqkVi41V58fiyomEz0pDuXojx7d8ot1TBB8=;
        b=OyYxCqLWcm+A1ar6frXHJOUHpJ8MjTo4coSL0RYmsYeY3IT5Mv2vgODezN3//W2WcY
         DJ3b2TdFbU8QgfCBbUeZIVgyYGb1tTfVVcVzFNcYTG4ygadfqQJ5EgI0nSj4eejTWfw0
         D+LweAndL6x2m/cF9J0Wd4UzwfpvrJD0x+IwzLvTF9uqO1+0J96y1bMYdtw5BQVVuVRh
         DfXifZpLrC5+4FJWk90KtbkfmMaICI4deWh+Qobdq4QKmdxuzYY1YTCdY/0m7v9lQjge
         5oFBxArXNIzMfqqz1lRt9ZpL0X2TgKRNtv45GGtblpCeHtLp0X+smNXw+hTQS0346Xf9
         ymNw==
X-Gm-Message-State: AHQUAub15b5HKT6AENUsm+EINANzbefHjEgyBpz86bg6DgpuFhsJs92w
        mdIkxTiFOM2vCj9feGsee6E=
X-Google-Smtp-Source: AHgI3IYZZ0NC/HO25B4pOdCxXLOUlddwCPug+brfMjzX0JkXYDgo7VpoCTBsyy/rLF+pjWliwKyzLg==
X-Received: by 2002:a1c:9684:: with SMTP id y126mr11355894wmd.124.1551702172813;
        Mon, 04 Mar 2019 04:22:52 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id o12sm6804146wrx.53.2019.03.04.04.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 04:22:51 -0800 (PST)
Date:   Mon, 4 Mar 2019 13:22:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 04/27] clocksource: Add a new timer-ingenic driver
Message-ID: <20190304122250.GC9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-5-paul@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 02, 2019 at 08:33:50PM -0300, Paul Cercueil wrote:
[...]
> diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
[...]
> +struct ingenic_tcu {
> +	const struct ingenic_soc_info *soc_info;
> +	struct regmap *map;
> +	struct clk *clk, *timer_clk, *cs_clk;
> +
> +	struct irq_domain *domain;
> +	unsigned int nb_parent_irqs;
> +	u32 parent_irqs[3];
> +
> +	struct clk_hw_onecell_data *clocks;
> +
> +	unsigned int timer_channel, cs_channel;
> +	struct clock_event_device cevt;
> +	struct clocksource cs;
> +	char name[4];
> +
> +	unsigned long pwm_channels_mask;
> +};
> +
> +static struct ingenic_tcu *ingenic_tcu;

Is there really a need for this? Seems like the only two reasons for why
you keep this around are as pointed out below.

> +void __iomem *ingenic_tcu_base;
> +EXPORT_SYMBOL_GPL(ingenic_tcu_base);

Same here.

> +static u64 notrace ingenic_tcu_timer_read(void)
> +{
> +	unsigned int channel = ingenic_tcu->cs_channel;
> +	u16 count;
> +
> +	count = readw(ingenic_tcu_base + TCU_REG_TCNTc(channel));

Can't yo do this via the regmap?

> +
> +	return count;
> +}
> +
> +static u64 notrace ingenic_tcu_timer_cs_read(struct clocksource *cs)
> +{
> +	return ingenic_tcu_timer_read();
> +}

And here you've got access to the struct clocksource *, from which you
should be able to get at struct ingenic_tcu * using container_of.

[...]
> +static int __init ingenic_tcu_init(struct device_node *np)
> +{
> +	const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
> +	const struct ingenic_soc_info *soc_info = id->data;
> +	struct ingenic_tcu *tcu;
> +	struct resource res;
> +	void __iomem *base;
> +	long rate;
> +	int ret;
> +
> +	of_node_clear_flag(np, OF_POPULATED);
> +
> +	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
> +	if (!tcu)
> +		return -ENOMEM;
> +
> +	/* Enable all TCU channels for PWM use by default except channel 0
> +	 * and channel 1.
> +	 */
> +	tcu->pwm_channels_mask = GENMASK(soc_info->num_channels - 1, 2);
> +	of_property_read_u32(np, "ingenic,pwm-channels-mask",
> +			     (u32 *)&tcu->pwm_channels_mask);
> +
> +	/* Verify that we have at least two free channels */
> +	if (hweight8(tcu->pwm_channels_mask) > soc_info->num_channels - 2) {
> +		pr_crit("ingenic-tcu: Invalid PWM channel mask: 0x%02lx\n",
> +			tcu->pwm_channels_mask);
> +		return -EINVAL;
> +	}
> +
> +	tcu->soc_info = soc_info;
> +	ingenic_tcu = tcu;
> +
> +	tcu->timer_channel = find_first_zero_bit(&tcu->pwm_channels_mask,
> +						 soc_info->num_channels);
> +	tcu->cs_channel = find_next_zero_bit(&tcu->pwm_channels_mask,
> +					     soc_info->num_channels,
> +					     tcu->timer_channel + 1);
> +
> +	base = of_io_request_and_map(np, 0, NULL);
> +	if (IS_ERR(base)) {
> +		ret = PTR_ERR(base);
> +		goto err_free_ingenic_tcu;
> +	}
> +
> +	of_address_to_resource(np, 0, &res);
> +
> +	ingenic_tcu_base = base;
> +
> +	tcu->map = regmap_init_mmio(NULL, base, &ingenic_tcu_regmap_config);
> +	if (IS_ERR(tcu->map)) {
> +		ret = PTR_ERR(tcu->map);
> +		goto err_iounmap;
> +	}
> +
> +	tcu->clk = of_clk_get_by_name(np, "tcu");
> +	if (IS_ERR(tcu->clk)) {
> +		ret = PTR_ERR(tcu->clk);
> +		pr_crit("ingenic-tcu: Unable to find TCU clock: %i\n", ret);
> +		goto err_free_regmap;
> +	}
> +
> +	ret = clk_prepare_enable(tcu->clk);
> +	if (ret) {
> +		pr_crit("ingenic-tcu: Unable to enable TCU clock: %i\n", ret);
> +		goto err_clk_put;
> +	}
> +
> +	ret = ingenic_tcu_intc_init(tcu, np);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	ret = ingenic_tcu_clk_init(tcu, np);
> +	if (ret)
> +		goto err_tcu_intc_cleanup;
> +
> +	ret = ingenic_tcu_clocksource_init(tcu);
> +	if (ret)
> +		goto err_tcu_clk_cleanup;
> +
> +	ret = ingenic_tcu_timer_init(tcu);
> +	if (ret)
> +		goto err_tcu_clocksource_cleanup;
> +
> +	// Register the sched_clock at the very end as there's no way to undo it
> +	rate = clk_get_rate(tcu->cs_clk);
> +	sched_clock_register(ingenic_tcu_timer_read, 16, rate);

Oh wow... so you managed to nicely encapsulate everything and now this
seems to be the only reason why you need to rely on global variables.

That's unfortunate. I suppose we could go and add a void *data parameter
to sched_clock_register() and pass that to the read() function. That way
you could make this completely independent of global variables, but
there are 73 callers of sched_clock_register() and they are spread all
over the place, so sounds a bit daunting to me.

> +
> +	return 0;
> +
> +err_tcu_clocksource_cleanup:
> +	ingenic_tcu_clocksource_cleanup(tcu);
> +err_tcu_clk_cleanup:
> +	ingenic_tcu_clk_cleanup(tcu, np);
> +err_tcu_intc_cleanup:
> +	ingenic_tcu_intc_cleanup(tcu);
> +err_clk_disable:
> +	clk_disable_unprepare(tcu->clk);
> +err_clk_put:
> +	clk_put(tcu->clk);
> +err_free_regmap:
> +	regmap_exit(tcu->map);
> +err_iounmap:
> +	iounmap(base);
> +	release_mem_region(res.start, resource_size(&res));
> +err_free_ingenic_tcu:
> +	kfree(tcu);
> +	return ret;
> +}
> +
> +TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu",  ingenic_tcu_init);
> +TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu", ingenic_tcu_init);
> +TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu",  ingenic_tcu_init);
> +
> +
> +static int __init ingenic_tcu_probe(struct platform_device *pdev)
> +{
> +	platform_set_drvdata(pdev, ingenic_tcu);

Then there's also this. Oh well... nevermind then.

> +bool ingenic_tcu_pwm_can_use_chn(unsigned int channel)
> +{
> +	return !!(ingenic_tcu->pwm_channels_mask & BIT(channel));
> +}
> +EXPORT_SYMBOL_GPL(ingenic_tcu_pwm_can_use_chn);

I wonder if we could make this slightly nicer, though. Judging by the
name, this one seems like it would only ever be used by the PWM. If the
PWM is a child of the TCU, could it not pass in a struct device * that
points to its parent into this? Or perhaps pass its own struct device *
and have this function look up the struct ingenic_tcu from that? Should
be something trivial as:

	bool ingenic_tcu_pwm_can_use_channel(struct device *dev, unsigned int channel)
	{
		struct ingenic_tcu *tcu = dev_get_drvdata(dev->parent);

		return !!(tcu->pwm_channels_mask & BIT(channel));
	}

Thierry

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9GJcACgkQ3SOs138+
s6F7URAAonKyjm1TO5vpfGkXMXLesXSN6P+QqnMc7ogf7RZ3A7T3nsX4gmTfGu14
5epCBgN6dhJZnJ/QP7BnG7UIpdgYewrRq+yeMsaHnP2IZn1+gXN+fJjD1iRf2DVa
8vz1mcgBkDYcjKQg0Ti1uQblUf6RUeWN1sjAgp9k4K8BUTFfPCmy7w1BP+st7gBR
+/SlptiNNHikY58D2UdDq99Zqvo7nGnr/f5SXsTWCJ23/9vOJczwyKI3+CUGUkG3
1+JVrXz+yX5QE28/zmXtji9ihMiz0Z65vPPLilK2/QaFPYY4Ge/+P34Lq/XMVKMH
5Jcfsqcgvok2zSHxdi5/yEZt2EZO03I5RDD9rgUb9pVBcdfRQSddS7l4SikDlIJy
BPMz3MrQ6mz4XZZic9P1oIt0zZm3nh5/xXNtzAYYZ/gUKCRZJ2tKGu7roO8VDRB5
Tl9CQFDYhPE329lfDV/T9+rau9JAFIFPY/lDV7+n9pcnkWBV8TsLQslM9KhHbAlx
ex3+/cWKkcbuvUQPp+M0DExJ4hBfosbGDqy6gPnAz0w+Jo9To84HJkoNGJN+qBXn
M8rclw5bom9YIBMliKNmU6UpzzMQCx74OVf8yfS5HwpWh2LG1ke13qSCtR5Y6YMl
b4DfBsLQnJ5ViOMfGY4QVVZ9zMkwjP032dO7zIfWRRilhQcxXbc=
=jOCv
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
