Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89249C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407B4207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GBrE3X0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfCYRmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:42:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39395 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfCYRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:42:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id f10so8843249otb.6;
        Mon, 25 Mar 2019 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T4v4Br8JtRDt3/20dLwNUshqCtQL4H826E6hKlCy+sw=;
        b=GBrE3X0qnR9Q4BMi2WKWpcc3f0s5F9MqaNLkgdxHT8ttAxcFXe3hEjApdrcGLnKEPF
         K7vKfWH8TLJA1lBauPVqLLANeHnxg617Y+frtjtzXJLdJtRnqP5vwwBDul+E0gs7GcPS
         MJN2vaMZ69AU40TmAhiuWH4gTlQgaz0nHVb+qISeieZcdXNMxfigmbn0+K3r1WpjILgX
         Gno158c1ctOrwdipXolRt4gC7TDfQgRiXfhNI4YD3OGnsxPwhq7CWI9yKbTV4Qa9B+wi
         j43L21fko26rEK1z5nGEMPWgNasNVDux5tPaxSkr4i/B+jkmiK/SleN4wfl5rfbP84++
         s60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T4v4Br8JtRDt3/20dLwNUshqCtQL4H826E6hKlCy+sw=;
        b=KIhQLo1TkwQObhEByLEuLKzYnKwK4sQKpxnYkzXWm9FXtG0Zh40P5TdiQhklyj66zb
         ROk5GU2hWkaUC9qnrmeV8c3hpmc5NEXM0iVo0B4HyxGgko5lfw6+RnkMDcMdNIRwZYw1
         cV/1bGr/7O86vHUdlSqicQ4VPg3SVyG14fzZOIcGNUlG3x9ZCXh/QCKT7dabEL+DOJyT
         yrkGXg2kjQuISF0INsgmzgRZxVR2OKpGo/qt4Rc+u/I6r8U8jFdXTe99bUXsA3uTfx6L
         OQIyfC22i1uUK7VK5AE24XGYgz2QTP7oUCndlpiIa8hvBdm5rZ7YKWfJV0uEgxdIQFrC
         LPjA==
X-Gm-Message-State: APjAAAVJX9nAMtN5apxM4RY7iUjDJeKza2kOAaJCh4b77sz/YHZ6Fbey
        mJIxXJtyqOW37AY2MmOpt6UO8+UFTfRFpmW1ybs=
X-Google-Smtp-Source: APXvYqzzX6Xquwr+T9Ha793K5BD+Kbl0C7vVYNgJC1T9qzdd57mmxwwiXNCkE6fCQD4HuEbnlctlLxJO9PAhQnHho08=
X-Received: by 2002:a9d:5614:: with SMTP id e20mr18351425oti.348.1553535728147;
 Mon, 25 Mar 2019 10:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com> <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
In-Reply-To: <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 25 Mar 2019 18:41:57 +0100
Message-ID: <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On Mon, Mar 25, 2019 at 9:41 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Martin,
>
> On Sun, Mar 24, 2019 at 11:02:16PM +0100, Martin Blumenstingl wrote:
> > Back in January a "BUG: scheduling while atomic" error showed up during
> > boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply)=
.
> > The call trace comes down to:
> >   __mutex_lock
> >   clk_prepare_lock
> >   clk_core_get_rate
> >   meson_pwm_apply
> >   ..
> >   dev_pm_opp_set_rate
> >   ..
> >
> > Jerome has also seen the same problem but from pwm-leds (instead of a
> > pwm-regulator). He posted a patch which replaces the spinlock with a
> > mutex. That works. I believe we can optimize this by reducing the time
> > where the lock is held - that also allows to keep the spin-lock.
> >
> > Analyzing this issue helped me understand the pwm-meson driver better.
> > My plan is to send some cleanups (with the goal of re-using more of the
> > goodies from the PWM core in the pwm-meson driver) after this single fi=
x
> > is merged (they can be found here: [1]).
>
> I didn't look over these in detail, but I see an issue that according
> to the shortlogs isn't addressed: In the .apply callback there is
> (simplified):
>
>         if (!state->enabled) {
>                 meson_pwm_disable(meson, pwm->hwpwm);
>                 return;
>         }
>
> This results in the wrong output after:
>
>         pwm_apply_state(pwm, { .enabled =3D true, .polarity =3D PWM_POLAR=
ITY_NORMAL, ...});
>         pwm_apply_state(pwm, { .enabled =3D false, .polarity =3D PWM_POLA=
RITY_INVERTED, ...});
>
> because the polarity isn't checked.
let me rephrase this to make sure I understand this correctly:
- applying a PWM state with .enabled =3D true and PWM_POLARITY_NORMAL
will enable the PWM output
- applying a PWM state with .enabled =3D false and PWM_POLARITY_NORMAL
will disable the PWM output
- applying a PWM state with .enabled =3D true and PWM_POLARITY_INVERTED
will disable the PWM output
- applying a PWM state with .enabled =3D false and PWM_POLARITY_INVERTED
will enable the PWM output

in other words: the polarity doesn't only apply to period and
duty_cycle but also to the enabled state.

> If you want to implement further cleanups, my questions and propositions
> are:
>
>  - Is there a publicly available manual for this hardware? If yes, you
>    can add a link to it in the header of the driver.
yes, it's documented in the public S912 datasheet [0] page 542 and followin=
g
I'll add a patch which adds the link to the driver

>  - Why do you handle reparenting of the PWM's clk in .request? Wouldn't
>    this be more suitable in .apply?
Jerome's answer (not long after yours) basically covers this:
- the assigned-clock-parents property could have been used but it wasn't
- the driver could automatically set the correct parent, but this
isn't implemented

(I assume this was done to keep it short and simple to for the first
version of the driver)

>  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
>    register) freeze the output, or is the currently running period
>    completed first? (The latter is the right behaviour.)
I don't know, I would have to measure this with a logic analyzer.
can you please explain why this is important?

>  - Please point out in the header that for changing period/duty
>    cycle/polarity the hardware must be stopped. (I suggest to apply the
>    style used in https://www.spinics.net/lists/linux-pwm/msg09262.html
>    for some consistency.)
I'm not sure about this. Amlogic's vendor kernel uses a modified
version of this driver [1] which has an explicit comment not to
disable the PWM output when changing the period/duty cycle.
the PWM is configured with two separate registers (PWM_MISC_REG_AB
contains the divider and PWM_PWM_A contains the high/low count).
there's a short timeframe where the PWM output signal is neither the
"old setting" nor the "new setting" (but rather a mix of both). what
do other PWM drivers do in this case (if this is a common thing)?

> Another thing I just noted: The .get_state callback only sets .enabled
> but nothing of the remaining information is provided.
as far as I can see the PWM core uses .get_state only during registration:
this means we should read (and calculate) .duty_cycle and .period from
the register values. polarity always has to be "normal" since there's
no information about it in the registers.


Regards
Martin


[0] https://dl.khadas.com/Hardware/VIM2/Datasheet/S912_Datasheet_V0.2201703=
14publicversion-Wesion.pdf
[1] https://github.com/hardkernel/linux/blob/9a4a1f4b14fe66d7ebd73323b39fbf=
3bda9e1356/drivers/amlogic/pwm/pwm_meson.c#L381
