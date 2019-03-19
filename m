Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B32DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7EF20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Thhz749A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfCSHWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:22:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41661 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCSHWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:22:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so13603080lfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MHL0Sxo6BG5Jcft2RXSB41j/JBrrAJBQ133ZKurVz6c=;
        b=Thhz749An43yjKLn0OR5Am9I/cThvR/fhaPrzuY//bT2eN5lcdxzjpA0nyy3HZSoUU
         ftSEp1bmOV2yQ2D/foD0qRgh6xvQGDMTFHJLzZE8App3Y+PCqBLKYmET81F5YdA+US2y
         nwdgp/FrFbxl8V3HzR3Hk5jnxG1mtvAldCn7G23fwL4gGT4KKsq9/aRN1gzsBUiCJfyx
         O4NABbkQnnZnX+E7j+CHl19JpR6B/CZvqwo8ETSlwswiCjQzgSCx65KGJrXp6uUdl8CU
         veEoVu2rP9b8kKPdE4wdHp7/wQHAX1dOmCH/V75gg0z56+6r1VFi9XjRSbKeMWANLdWy
         ddHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MHL0Sxo6BG5Jcft2RXSB41j/JBrrAJBQ133ZKurVz6c=;
        b=syf5ougyuNGJVdZBC95jBko2KYaL050WRUidJ9nubOKYMcno7oQkdqXDGta3akrO6/
         xrCsQAhhZjJ9jZQnQjZ/K2ZRo+RIbc7hfTON4AHsUsfAMPMDgjl559FW8SyM3ZSOVrRZ
         UnpWAxGNA7RxLGYPqwJllr4WfonJz1KbZ0Fi14ibZ4uV6MDYXnfBNGw2VJCRZ+b5+vax
         n7ynNJCyNYbC+EdFSYxJySP/nd0m31WiJqZDGpvyIKEBHs6dZ61QbeRJ68xGGsG7ElLN
         hH3EiDOE8q0AVMlfOOPJs6vjpaPHVG6XBNGbcB8UM+pZRQwgK1XFriLpynfWSi5Yfnjl
         PmWw==
X-Gm-Message-State: APjAAAW7eCujjLSUnU7qotUyEpP10rMO5wgcXv+Zv3upQ75J+6pKLUSC
        x+9nlVKpJUfzleL2uAUZhh8Gp4/F4AwNMzAfY5CVDg==
X-Google-Smtp-Source: APXvYqxw9ZBFokmsbr1yo344RaCe3qnzg+FyggoWFBk/r+VlgcsGJwgxgYCl3R6nuM9TocN9kiSfYy/ZWmHd0oACA0A=
X-Received: by 2002:ac2:52a6:: with SMTP id r6mr2152391lfm.27.1552980169056;
 Tue, 19 Mar 2019 00:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <1552909634-18757-1-git-send-email-yash.shah@sifive.com>
 <1552909634-18757-3-git-send-email-yash.shah@sifive.com> <20190318214640.ob2ldr3tpn2vsfkl@pengutronix.de>
In-Reply-To: <20190318214640.ob2ldr3tpn2vsfkl@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 19 Mar 2019 12:52:12 +0530
Message-ID: <CAJ2_jOHqGBB=eej6KkdspTNiCU_uJ8deHN3O=BQmyu=GtrTT7w@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 3:16 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> [I put Thierry into To: because some remaining questions depend on his
> views]
>
> On Mon, Mar 18, 2019 at 05:17:14PM +0530, Yash Shah wrote:
> > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC=
.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Various fixes and code cleanup]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  drivers/pwm/Kconfig      |  11 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-sifive.c | 334 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 346 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sifive.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index a8f47df..4a61d1a 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -380,6 +380,17 @@ config PWM_SAMSUNG
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-samsung.
> >
> > +config PWM_SIFIVE
> > +     tristate "SiFive PWM support"
> > +     depends on OF
> > +     depends on COMMON_CLK
> > +     depends on RISCV || COMPILE_TEST
> > +     help
> > +       Generic PWM framework driver for SiFive SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sifive.
> > +
> >  config PWM_SPEAR
> >       tristate "STMicroelectronics SPEAr PWM support"
> >       depends on PLAT_SPEAR
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 9c676a0..30089ca 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)              +=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)        +=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)   +=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_SAMSUNG)    +=3D pwm-samsung.o
> > +obj-$(CONFIG_PWM_SIFIVE)     +=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SPEAR)              +=3D pwm-spear.o
> >  obj-$(CONFIG_PWM_STI)                +=3D pwm-sti.o
> >  obj-$(CONFIG_PWM_STM32)              +=3D pwm-stm32.o
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > new file mode 100644
> > index 0000000..4b4d48e
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -0,0 +1,334 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017-2018 SiFive
> > + * For SiFive's PWM IP block documentation please refer Chapter 14 of
> > + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pd=
f
> > + *
> > + * Limitations:
> > + * - When changing both duty cycle and period, we cannot prevent in
> > + *   software that the output might produce a period with mixed
> > + *   settings (new period length and old duty cycle).
> > + * - The hardware cannot generate a 100% duty cycle.
> > + * - The hardware generates only inverted output.
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/slab.h>
> > +#include <linux/bitfield.h>
> > +
> > +/* Register offsets */
> > +#define PWM_SIFIVE_PWMCFG            0x0
> > +#define PWM_SIFIVE_PWMCOUNT          0x8
> > +#define PWM_SIFIVE_PWMS                      0x10
> > +#define PWM_SIFIVE_PWMCMP0           0x20
> > +
> > +/* PWMCFG fields */
> > +#define PWM_SIFIVE_PWMCFG_SCALE              GENMASK(3, 0)
> > +#define PWM_SIFIVE_PWMCFG_STICKY     BIT(8)
> > +#define PWM_SIFIVE_PWMCFG_ZERO_CMP   BIT(9)
> > +#define PWM_SIFIVE_PWMCFG_DEGLITCH   BIT(10)
> > +#define PWM_SIFIVE_PWMCFG_EN_ALWAYS  BIT(12)
> > +#define PWM_SIFIVE_PWMCFG_EN_ONCE    BIT(13)
> > +#define PWM_SIFIVE_PWMCFG_CENTER     BIT(16)
> > +#define PWM_SIFIVE_PWMCFG_GANG               BIT(24)
> > +#define PWM_SIFIVE_PWMCFG_IP         BIT(28)
> > +
> > +/* PWM_SIFIVE_SIZE_PWMCMP is used to calculate offset for pwmcmpX regi=
sters */
> > +#define PWM_SIFIVE_SIZE_PWMCMP               4
> > +#define PWM_SIFIVE_CMPWIDTH          16
> > +#define PWM_SIFIVE_DEFAULT_PERIOD    10000000
> > +
> > +struct pwm_sifive_ddata {
> > +     struct pwm_chip chip;
> > +     struct mutex lock; /* lock to protect user_count */
> > +     struct notifier_block notifier;
> > +     struct clk *clk;
> > +     void __iomem *regs;
> > +     unsigned int real_period;
> > +     unsigned int approx_period;
> > +     int user_count;
> > +};
> > +
> > +static inline
> > +struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *c)
> > +{
> > +     return container_of(c, struct pwm_sifive_ddata, chip);
> > +}
> > +
> > +static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device=
 *dev)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +
> > +     mutex_lock(&pwm->lock);
> > +     pwm->user_count++;
> > +     mutex_unlock(&pwm->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static void pwm_sifive_free(struct pwm_chip *chip, struct pwm_device *=
dev)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +
> > +     mutex_lock(&pwm->lock);
> > +     pwm->user_count--;
> > +     mutex_unlock(&pwm->lock);
> > +}
> > +
> > +static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
> > +                                 unsigned long rate)
> > +{
> > +     u32 val;
> > +     unsigned long long num;
> > +     /*
> > +      * The PWM unit is used with pwmzerocmp=3D0, so the only way to m=
odify the
> > +      * period length is using pwmscale which provides the number of b=
its the
> > +      * counter is shifted before being feed to the comparators. A per=
iod
> > +      * lasts (1 << (PWM_SIFIVE_CMPWIDTH + pwmscale)) clock ticks.
> > +      * (1 << (PWM_SIFIVE_CMPWIDTH + scale)) * 10^9/rate =3D period
> > +      */
> > +     unsigned long scale_pow =3D
> > +                     div64_ul(pwm->approx_period * (u64)rate, NSEC_PER=
_SEC);
> > +     int scale =3D clamp(ilog2(scale_pow) - PWM_SIFIVE_CMPWIDTH, 0, 0x=
f);
>
> The situation here is as follows: The actual period length calculates
> as:
>
>         period_length =3D (0x10000 << scale) / rate
>
> Consider a clk rate of 600 MHz, then the driver maps "requested period"
> to "actual period" as follows:
>
>         if requested_period <=3D 218453 ns:
>                 // scale =3D 0
>                 actual_period =3D 109226 ns
>         else if requested_period <=3D 436906 ns:
>                 // scale =3D 1
>                 actual_period =3D 218452 ns
>         else if requested_period <=3D 873812 ns:
>                 // scale =3D 2
>                 actual_period =3D 436904 ns
>         ...
>         else if requested_period <=3D 3579139413 ns:
>                 // scale =3D 14
>                 actual_period =3D 1789569707 ns
>         else:
>                 //scale =3D 15
>                 actual_period =3D 3579139413 ns
>
> There is an obvious rounding issue: If 218452 ns are requested, we
> should end in the scale =3D 1 case for sure. (Similar issues exist for th=
e
> other cases.)
>
> And then there are cases that are not that clear: What if 218000 ns are
> requested? Where should the line be drawn? Thierry?
>
> And what about long periods? The longest actually supported period
> length is around 3.5 seconds. What if a consumer requests 18 seconds?
> Where should the line be drawn when the driver is supposed to return
> -EINVAL (or -ERANGE)? Thierry?
>
> > +     val =3D PWM_SIFIVE_PWMCFG_EN_ALWAYS |
> > +           FIELD_PREP(PWM_SIFIVE_PWMCFG_SCALE, scale);
> > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
>
> Starting with this write the new period length might be active with the
> previous duty cycle. Is this worth a comment? I think the window where
> this can actually happen should be made as small as possible, so it
> would be great to first calculate both register values and then write
> them in two consecutive writels.

The comment for this scenario has already been mentioned under the
limitation on top of this driver.
Anyway, I will try to implement your suggestion of consecutive writes

>
> > +     /* As scale <=3D 15 the shift operation cannot overflow. */
> > +     num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH =
+ scale);
> > +     pwm->real_period =3D div64_ul(num, rate);
>
> What about rounding here? I'd say use "round closest" instead of "round
> down".
>
> > +     dev_dbg(pwm->chip.dev, "New real_period =3D %u ns\n", pwm->real_p=
eriod);
> > +}
> > +
> > +static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *dev,
> > +                              struct pwm_state *state)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     u32 duty, val;
> > +
> > +     duty =3D readl(pwm->regs + PWM_SIFIVE_PWMCMP0 +
> > +                  dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +     state->enabled =3D duty > 0;
> > +
> > +     val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > +     if (!(val & PWM_SIFIVE_PWMCFG_EN_ALWAYS))
> > +             state->enabled =3D false;
> > +
> > +     state->period =3D pwm->real_period;
> > +     state->duty_cycle =3D
> > +             (u64)duty * pwm->real_period >> PWM_SIFIVE_CMPWIDTH;
> > +     state->polarity =3D PWM_POLARITY_INVERSED;
>
> If the PWM was configured for { .period =3D 1000000, .duty_cycle =3D
> 1000000, .enabled =3D false, ... }, .get_state still returns .duty_cycle =
=3D
> 0. Is this acceptable?
>
> > +}
> > +
> > +static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     int ret;
> > +
> > +     if (enable) {
> > +             ret =3D clk_enable(pwm->clk);
> > +             if (ret) {
> > +                     dev_err(pwm->chip.dev, "Enable clk failed:%d\n", =
ret);
>
> Space after : please. Also applies to the other error strings.

Sure

>
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     if (!enable)
> > +             clk_disable(pwm->clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *=
dev,
> > +                         struct pwm_state *state)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
>
> I think it would be more common to call the struct pwm_device pointer
> "pwm" and the struct pwm_sifive_ddata pointer "ddata".
> "dev" is usually a pointer to a struct device. The other functions need
> the same adaption of course.

Ok. Will change that

>
> > +     unsigned int duty_cycle;
> > +     u32 frac;
> > +     struct pwm_state cur_state;
> > +     bool enabled;
> > +     int ret =3D 0;
> > +     unsigned long long num;
> > +
> > +     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +             return -EINVAL;
> > +
> > +     ret =3D clk_enable(pwm->clk);
> > +     if (ret) {
> > +             dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     mutex_lock(&pwm->lock);
> > +     cur_state =3D dev->state;
> > +     enabled =3D cur_state.enabled;
> > +
> > +     if (state->period !=3D pwm->approx_period) {
> > +             if (pwm->user_count !=3D 1) {
> > +                     ret =3D -EBUSY;
> > +                     goto exit;
> > +             }
> > +             pwm->approx_period =3D state->period;
> > +             pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> > +     }
> > +
> > +     duty_cycle =3D state->duty_cycle;
> > +     if (!state->enabled)
> > +             duty_cycle =3D 0;
> > +
> > +     num =3D (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> > +     frac =3D DIV_ROUND_CLOSEST_ULL(num, state->period);
> > +     /* The hardware cannot generate a 100% duty cycle */
> > +     frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > +
> > +     writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 +
> > +            dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
>
> Here is another rounding question. Given that the period length can only
> be modified by factors of two there are cases where the real period is
> off by a factor of at least 1.4 which has an effect on the duty cycle.
> Consider again an input clk rate of 600 MHz, and:
>
>         .duty_cycle =3D 109226 [ns]
>         .period =3D 152916 [ns]
>
> We either have to go for real period =3D 109226 ns (as is currently
> implemented) or with 218452 ns. Which one should be chosen I already
> asked above. Here the question is (probably depending on the former
> question) how should the actual duty_cycle be calculated?
>
> > +     if (state->enabled !=3D enabled) {
> > +             ret =3D pwm_sifive_enable(chip, state->enabled);
> > +             if (ret)
> > +                     goto exit;
>
> This goto is a noop and so can be dropped.

Sure

>
> > +     }
> > +
> > +exit:
> > +     clk_disable(pwm->clk);
> > +     mutex_unlock(&pwm->lock);
> > +     return ret;
> > +}
> > +
> > +static const struct pwm_ops pwm_sifive_ops =3D {
> > +     .request =3D pwm_sifive_request,
> > +     .free =3D pwm_sifive_free,
> > +     .get_state =3D pwm_sifive_get_state,
> > +     .apply =3D pwm_sifive_apply,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int pwm_sifive_clock_notifier(struct notifier_block *nb,
> > +                                  unsigned long event, void *data)
> > +{
> > +     struct clk_notifier_data *ndata =3D data;
> > +     struct pwm_sifive_ddata *pwm =3D
> > +             container_of(nb, struct pwm_sifive_ddata, notifier);
> > +
> > +     if (event =3D=3D POST_RATE_CHANGE)
> > +             pwm_sifive_update_clock(pwm, ndata->new_rate);
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int pwm_sifive_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct pwm_sifive_ddata *pwm;
> > +     struct pwm_chip *chip;
> > +     struct resource *res;
> > +     int ret;
> > +
> > +     pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> > +     if (!pwm)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&pwm->lock);
> > +     chip =3D &pwm->chip;
> > +     chip->dev =3D dev;
> > +     chip->ops =3D &pwm_sifive_ops;
> > +     chip->of_pwm_n_cells =3D 3;
> > +     chip->base =3D -1;
> > +     chip->npwm =3D 4;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     pwm->regs =3D devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(pwm->regs)) {
> > +             dev_err(dev, "Unable to map IO resources\n");
> > +             return PTR_ERR(pwm->regs);
> > +     }
> > +
> > +     pwm->clk =3D devm_clk_get(dev, NULL);
> > +     if (IS_ERR(pwm->clk)) {
> > +             if (PTR_ERR(pwm->clk) !=3D -EPROBE_DEFER)
> > +                     dev_err(dev, "Unable to find controller clock\n")=
;
> > +             return PTR_ERR(pwm->clk);
> > +     }
> > +
> > +     ret =3D clk_prepare_enable(pwm->clk);
> > +     if (ret) {
> > +             dev_err(dev, "failed to enable clock for pwm: %d\n", ret)=
;
> > +             return ret;
> > +     }
> > +
> > +     /* Watch for changes to underlying clock frequency */
> > +     pwm->notifier.notifier_call =3D pwm_sifive_clock_notifier;
> > +     ret =3D clk_notifier_register(pwm->clk, &pwm->notifier);
>
> Is it a problem when the notifier is called before pwmchip_add was
> called? Out of interest: Is a real problem addressed here? I.e.: Does
> the input clock actually change in practise? Also note that
> pwm_sifive_clock_notifier only adapts the period but not the duty cycle
> (any more).
>
> Given that a clk rate change affects the output, I wonder if the change
> should be declined if the pwm is running.
>
> > +     if (ret) {
> > +             dev_err(dev, "failed to register clock notifier: %d\n", r=
et);
> > +             goto disable_clk;
> > +     }
> > +
> > +     /* Initialize PWM */
> > +     pwm->approx_period =3D PWM_SIFIVE_DEFAULT_PERIOD;
> > +     pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
>
> If the bootloader setup a display with a backlight driven by a PWM it
> would be ideal to not modify the already running hardware here.

Ok, will drop this initialization.

>
> > +     ret =3D pwmchip_add(chip);
> > +     if (ret < 0) {
> > +             dev_err(dev, "cannot register PWM: %d\n", ret);
> > +             goto unregister_clk;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, pwm);
> > +     dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
> > +
> > +     return 0;
> > +
> > +unregister_clk:
> > +     clk_notifier_unregister(pwm->clk, &pwm->notifier);
> > +disable_clk:
> > +     clk_disable_unprepare(pwm->clk);
> > +
> > +     return ret;
> > +}
> > +
> > +static int pwm_sifive_remove(struct platform_device *dev)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D platform_get_drvdata(dev);
> > +     int ret, ch;
> > +     bool is_enabled =3D false;
> > +
> > +     ret =3D pwmchip_remove(&pwm->chip);
> > +     clk_notifier_unregister(pwm->clk, &pwm->notifier);
> > +
> > +     for (ch =3D 0; ch < pwm->chip.npwm; ch++) {
> > +             if (pwm_is_enabled(&pwm->chip.pwms[ch])) {
>
> Here is another consumer API function call.

Will avoid using it.

>
> > +                     is_enabled =3D true;
> > +                     break;
> > +             }
> > +     }
> > +     if (is_enabled)
> > +             clk_disable(pwm->clk);
> > +     clk_unprepare(pwm->clk);
>
> I think you're leaking a clk_enable here. The probe function does one
> unconditionally that is never undone.

Will use clk_disable_unprepare instead of clk_unprepare

>
> > +     return ret;
> > +}
> > +
> > +static const struct of_device_id pwm_sifive_of_match[] =3D {
> > +     { .compatible =3D "sifive,pwm0" },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, pwm_sifive_of_match);
> > +
> > +static struct platform_driver pwm_sifive_driver =3D {
> > +     .probe =3D pwm_sifive_probe,
> > +     .remove =3D pwm_sifive_remove,
> > +     .driver =3D {
> > +             .name =3D "pwm-sifive",
> > +             .of_match_table =3D pwm_sifive_of_match,
> > +     },
> > +};
> > +module_platform_driver(pwm_sifive_driver);
> > +
> > +MODULE_DESCRIPTION("SiFive PWM driver");
> > +MODULE_LICENSE("GPL v2");
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
