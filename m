Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A62C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E012084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GS9FAhbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfCKLk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:40:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39679 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfCKLk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:40:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id g80so3719361ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XGeJu/yu28g981aZh9oEIyoO4PFUefFkvw/uajggBOc=;
        b=GS9FAhbNTX/8qMo8nHBu/ttexA19N/g6p56NBzYZxXSkQj3YnRxQt/wmwLjoPd3GIX
         HV53MiK5YhP+ZJOudnCYZtKg7r/wL026rlOV9qqTpSqW81t1PsyewmrFiqCnMht2O2tF
         HsD1NBlZaG2f1h3DADSBqv+cvmlYr7KXWTmvrL8aucQehIsgwb+LAVRSlPOUQTwg89N1
         zgu7s5Ecp5Td7kBYl4UJT99ibIzYPG5k33NJuZEs6zZnR6exGC3zq+qWl5ROF44alzj0
         MsnNeGSJjbqvS3wd8ShsaJ98vf9IJARaRXTWMqAhtL6Ap58ThzGquNxz2b/0oVe4vp2s
         Eg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XGeJu/yu28g981aZh9oEIyoO4PFUefFkvw/uajggBOc=;
        b=dTWR/vBWXWRjTenbZaTKmwFhXE6aEi1W3TBKdK0Xb1Xv2+PSSFaEcF+p8PBAoVZoX5
         TJ60xd/B551FCsQ+folyJDBzc1XsOuVk6nMMsDS/nFi4U+5CSCyZvrFEznbVp2Mr5TGS
         2suzzWqjBEnqaqPIZx02qoC+8pqFDF/ZIL2S1h315GzqcGTftlECGW2vc/2N7WojL3US
         DhBY0hNvKpHjH9SN3L1WRsgAKarYQAHb4bSzOtYW3yMqVYVkjFPz7fCbomwwkxIxS2WO
         iqmINC2KyzdogpF8h5HmJKvec8efAt47GkeBpbSJ8dKbiumVOXpvpwhu6iqnwjohoF2W
         73rA==
X-Gm-Message-State: APjAAAUBoS4caYaR/5GfK3FmgSH4PnxJCiHBCBpbvw+jffkcdv0lIA33
        k96T6NngcUByqD1rBN9V1ch56vprwhRlnvB2lDMhCA==
X-Google-Smtp-Source: APXvYqzqKkXivrFt8lFMFearykPYQ2344Dz1MEZFxmM6UyCkScX0jEkaEvwcCv33Eexb8RjxwaKb/sY2Q8cYaZnE+5A=
X-Received: by 2002:a2e:9843:: with SMTP id e3mr14492844ljj.57.1552304454297;
 Mon, 11 Mar 2019 04:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
 <1551437599-29509-3-git-send-email-yash.shah@sifive.com> <20190307152745.kaiv6q4ygf2apmuv@pengutronix.de>
 <CAJ2_jOFvr=sw7mWR53JbzMJa1jxwjhJSTibCsKYsxrht+PLPWw@mail.gmail.com> <20190308115726.smgooacsr37fmxwg@pengutronix.de>
In-Reply-To: <20190308115726.smgooacsr37fmxwg@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 11 Mar 2019 17:10:17 +0530
Message-ID: <CAJ2_jOFtg2_MAUYkTQM-=6KE2RN+FMxfEhLjZZfzM0k3A5RQiA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
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

On Fri, Mar 8, 2019 at 5:27 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Fri, Mar 08, 2019 at 04:59:36PM +0530, Yash Shah wrote:
> > On Thu, Mar 7, 2019 at 8:57 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_devi=
ce *dev,
> > > > +                         struct pwm_state *state)
> > > > +{
> > > > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chi=
p);
> > > > +     unsigned int duty_cycle, x;
> > > > +     u32 frac;
> > > > +     struct pwm_state cur_state;
> > > > +     bool enabled;
> > > > +     int ret =3D 0;
> > > > +     unsigned long num;
> > > > +
> > > > +     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > > > +             return -EINVAL;
> > > > +
> > > > +     mutex_lock(&pwm->lock);
> > > > +     pwm_get_state(dev, &cur_state);
> > > > +     enabled =3D cur_state.enabled;
> > > > +
> > > > +     if (state->period !=3D cur_state.period) {
> > >
> > > Did you test this with more than one consumer? For sure the following
> > > should work:
> > >
> > >         pwm1 =3D pwm_get(.. the first ..);
> > >         pwm_apply_state(pwm1, { .enabled =3D true, .period =3D 100000=
00, .... });
> > >
> > >         pwm2 =3D pwm_get(.. the second ..);
> > >         pwm_apply_state(pwm2, { .enabled =3D true, .period =3D 100000=
00, .... });
> > >
> > > but for the second pwm_apply_state() run state->period is likely not
> > > exactly 10000000.
> >
> > Yes, I have tested multiple consumers using sysfs interface. It is work=
ing.
>
> Can you provide details about your testing here? What is the parent clk
> rate? Which settings did you test? Can you confirm my claim that the
> above sequence would fail or point out my error in reasoning?
>

I have tested on HiFive Unleashed board using sysfs interface.
Parent clk rate is around 512 Mhz.
I have tested scenarios as you mentioned above with various period and
duty_cycle values.

After considering your below suggestion,
 | To get the result independent of the prior configuration you better use
 | the real targeted period length as input instead of the last configured
 | approximation
I will introduce approx_period feild, which will be used as the
targeted period length.
Also, in pwm_sifive_get_state, I will make below change
- state->period =3D pwm->real_period;
+ state->period =3D pwm->approx_period.
So with this change in place, I believe the cur_state.period for the
second pwm_apply_state() above (pwm2) will be exactly 10000000

> > > > +     x =3D 1U << PWM_SIFIVE_CMPWIDTH;
> > > > +     num =3D (u64)duty_cycle * x + x / 2;
> > > > +     frac =3D div_u64(num, state->period);
> > >
> > > I don't understand the "+ x / 2" part. Should this better be
> > > "+ state->period / 2"? Something like
> >
> > This eqn is as per your comments against v5 of this patch series.
> >  frac =3D (duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH) + (1 <<
> > PWM_SIFIVE_CMPWIDTH) / 2) / period;
>
> OK, then not only the code is wrong, but also my suggestion was. :-)
>
> > > #define div_u64_round(a, b) ({typeof(b) __b =3D b; div_u64(a + __b / =
2, __b)})
> > >
> > > would make this less error prone.
>
> This still stands. It makes it easier to get the code right and makes it
> easier to understand.

Sure, will implement this.

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
