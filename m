Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701FFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388212070B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JJvukiDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfC3T3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 15:29:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35427 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfC3T3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 15:29:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so4286607oib.2;
        Sat, 30 Mar 2019 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E3qsfecLL9h7PueF/05aCXUcyy8uC+uxLap7FHg1oLI=;
        b=JJvukiDZK6piJa7w18mO2Sr0UIic7oHfTfXP5fMDsp7/PadyaGOOoap5p8ZwiT3sjQ
         eTNuZ3S59vVYnSUnTR2yJXxwsw3wgTY3oU33nS+6GR6b7LwtoJn+xJ+ZQgXabiENAxKb
         eD1gXPhlVswQUicBcqpBk5Cd6YOlc1oe3fQxK4Cqd1FbaEAKWzkmpBbUlUhd3UbZ5W5k
         RBah0roUdTOtftkyy5L3M4+/aHwz+WfdSeQxT601t7S6hmQRmr9Z4aHwIh9GHXPPHAzd
         FBVniLGDkAgrf43FInwns18VVM54dUMVtps+7qUK0TmW0/HwlxQN+9apVVU9d/Yvf5lZ
         9OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E3qsfecLL9h7PueF/05aCXUcyy8uC+uxLap7FHg1oLI=;
        b=V9UNlRl6EnJCwuDyG5udFOmrhp2cYMjwJ9qzsHHy72H/Ci/9psFJ6m51vCa7+t3Y5V
         u/GCpiZzecrGzcqNrT4R5YwRs/VjgdZZlr/c2p07PU92lGcfczFHziccUfGNxqgzEXul
         X4etiWzWGvP4ixpFamIabjZjrVKA99ZbtXHL5yEcXDA9ztSkh9A4ReaKPaVOhlTOhKyQ
         b/WRJ91XqRBVqDfCrTYZjZmRXBl1bZ7Dl0bKrZowRgKdBqfEMK6hDV3wZl241J2zKxgf
         cjHLVsDn0u7GdlYZWEMg/0/fVOJfdx8XOsOIgkItVSh6jQoB8znaJ3hafMG67XIKqn/t
         8LvQ==
X-Gm-Message-State: APjAAAV9RZESytqrxknHyylhoFHZknUeMGkPh7LIipznHcg1uZLhO8pW
        TLla3D1GW2HShLvPuJGLhdj9soGq2NFQ2M2c3Xk=
X-Google-Smtp-Source: APXvYqyXCN/J68ByPD5PoJSsE6cJXP7X4dcIOprd7tCb4VO6S6QFy8ORvZYorNyRECYOmImw997LvfB+tJ0rgk8+auw=
X-Received: by 2002:aca:4482:: with SMTP id r124mr2147683oia.39.1553974186198;
 Sat, 30 Mar 2019 12:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de> <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
 <20190325200730.cx73jgxfexz6ybzq@pengutronix.de>
In-Reply-To: <20190325200730.cx73jgxfexz6ybzq@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 30 Mar 2019 20:29:35 +0100
Message-ID: <CAFBinCCGWsb+1WHFe6uwrpUYgH4iix0WT8_v_Nj5BhGKRyjiLQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On Mon, Mar 25, 2019 at 9:07 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[...]
> > >  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
> > >    register) freeze the output, or is the currently running period
> > >    completed first? (The latter is the right behaviour.)
> > I don't know, I would have to measure this with a logic analyzer.
>
> In practise you can do this with a multimeter, too. Just do something
> like:
>
>         pwm_apply_state({ .enabled =3D true, .period =3D 5s, .duty_cycle =
=3D 5s, .polarity =3D PWM_POLARITY_NORMAL });
>         pwm_apply_state({ .enabled =3D false, .period =3D 5s, .duty_cycle=
 =3D 5s, .polarity =3D PWM_POLARITY_NORMAL });
>
> (assuming the PWM supports periods that long). The expectation is that
> the last command takes nearly 5 s to complete and while it waits the
> output is high and on return it's low. If that isn't the case, there is
> a bug somewhere.
the longest supported period (using the 24MHz crystal as input, which
is the slowest input clock and thus gives the longest possible
duration) is 349514407ns (that's approx. 0.35 seconds). my multimeter
isn't fast enough to measure this so I'm using my logic analyzer with
puleseview instead: [0]

I added the following code to meson_pwm_request:
  struct pwm_state enable =3D {
        .enabled =3D true,
        .period =3D 349514407U,
        .duty_cycle =3D 349514407U,
        .polarity =3D PWM_POLARITY_NORMAL };
  struct pwm_state disable =3D {
        .enabled =3D false,
        .period =3D 349514407U,
        .duty_cycle =3D 349514407U,
        .polarity =3D PWM_POLARITY_NORMAL };
  pwm_apply_state(pwm, &enable);
  pwm_apply_state(pwm, &disable);

this returns immediately. my logic analyzer doesn't see signal change
(I'm sampling at 1MHz).

can you please confirm that my test code and measurement procedure is corre=
ct?
if it is then my observation is that disabling the PWM does so
immediately, without waiting for the current period to complete


Regards
Martin


[0] https://sigrok.org/wiki/Lcsoft_Mini_Board
