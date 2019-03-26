Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660A0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1725B2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Oi6YWp43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbfCZUFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:05:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43825 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbfCZUFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:05:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id 67so10940062oif.10;
        Tue, 26 Mar 2019 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JFcXMN+Vc+lFNRfE2dwGYd2oHc4mvgj/6zMKxG0fVJM=;
        b=Oi6YWp43gX1JFJGeZHP8W3AMhKDRL9FT4HGAOSh0Bis5hYngrJdcKoGnlhyLCNWvpY
         z1cudm5TyMPVGW/aN6pSDt0/4O0KlAkQX4XvDLfiAWTWJ1ubfkPivikm/RX1OsZtWW12
         NvZr9e4Cb7O4B6Cdvw65mfSo+iJ2qn+OUqc4Q66rFn0Qdhl4dMYHv+rhinzXC7tq+v7C
         9zFxg49oZH9KoNMBkbRbPPX5v211kfDMLbo7s8qiVKrCUT6B7u4kQQ4r0aNpEKO8I8SM
         xVVpExjrkSejn/ijigyMIyXdJetVdvJ71zWdHJErUExGr1DMfCKeSmLeRs9BC5LaA4JA
         evug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JFcXMN+Vc+lFNRfE2dwGYd2oHc4mvgj/6zMKxG0fVJM=;
        b=dZ6vX9oY++5p66+rsPJ4NThOvb/GpKwtn4GIZkd7xl23dejpL10/AlxO6mpIgQ6xfF
         NBmAipuGGORjpggyNpVAI1nQFIpAYG97o1GdqDuyQfSDNduqHtUngceIQLjkh/p84aXz
         8Ae70Fx6Q0SIhaB4iuiaaQbOrnP8qsGsOw88HuAZwm/1wYqAyWfuRiPpc0MOixHsvktr
         u9UALPNUL6K3GvAzupiRiqNf6v+LohIL6ZS37OvMmRUVgeCndwmp/nIpbBjW85mx63TH
         PfZCDSGcWcP1GgXdvQOmqleOp2m9bCTzbxDVwUzT0v/1WfzEmanEgx9Y2ZN8EQ95CDZW
         5p1Q==
X-Gm-Message-State: APjAAAVOR/6UCjUHlR36X9MseiynZhB80bHFGtlVACFLhJMCeP9LGalP
        YzhE/tpGgTtfTAIaZMEPw7GR52g4Fjz8/VeF1cF55Xqj
X-Google-Smtp-Source: APXvYqyDJcbdtUs2vBY79qgaMgRd6r6oxeOqdZPwiLhZofzLx6gmpRbfTYeh80Ui04vWHezgduYg6q9B0n5VKdWgv2g=
X-Received: by 2002:aca:ecd1:: with SMTP id k200mr16960433oih.15.1553630746956;
 Tue, 26 Mar 2019 13:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de> <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
 <20190325200730.cx73jgxfexz6ybzq@pengutronix.de>
In-Reply-To: <20190325200730.cx73jgxfexz6ybzq@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 26 Mar 2019 21:05:35 +0100
Message-ID: <CAFBinCBZ=+uAM_8Pgk0e7YzSrjKVR=Csggf2Ke3=CmReMeU9og@mail.gmail.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, bichao.zheng@amlogic.com,
        Jianxin Pan <jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On Mon, Mar 25, 2019 at 9:07 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Martin,
>
> On Mon, Mar 25, 2019 at 06:41:57PM +0100, Martin Blumenstingl wrote:
> > On Mon, Mar 25, 2019 at 9:41 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Sun, Mar 24, 2019 at 11:02:16PM +0100, Martin Blumenstingl wrote:
> > > > Analyzing this issue helped me understand the pwm-meson driver bett=
er.
> > > > My plan is to send some cleanups (with the goal of re-using more of=
 the
> > > > goodies from the PWM core in the pwm-meson driver) after this singl=
e fix
> > > > is merged (they can be found here: [1]).
> > >
> > > I didn't look over these in detail, but I see an issue that according
> > > to the shortlogs isn't addressed: In the .apply callback there is
> > > (simplified):
> > >
> > >         if (!state->enabled) {
> > >                 meson_pwm_disable(meson, pwm->hwpwm);
> > >                 return;
> > >         }
> > >
> > > This results in the wrong output after:
> > >
> > >         pwm_apply_state(pwm, { .enabled =3D true, .polarity =3D PWM_P=
OLARITY_NORMAL, ...});
> > >         pwm_apply_state(pwm, { .enabled =3D false, .polarity =3D PWM_=
POLARITY_INVERTED, ...});
> > >
> > > because the polarity isn't checked.
> > let me rephrase this to make sure I understand this correctly:
> > - applying a PWM state with .enabled =3D true and PWM_POLARITY_NORMAL
> > will enable the PWM output
> > - applying a PWM state with .enabled =3D false and PWM_POLARITY_NORMAL
> > will disable the PWM output
> > - applying a PWM state with .enabled =3D true and PWM_POLARITY_INVERTED
> > will disable the PWM output
> > - applying a PWM state with .enabled =3D false and PWM_POLARITY_INVERTE=
D
> > will enable the PWM output
> >
> > in other words: the polarity doesn't only apply to period and
> > duty_cycle but also to the enabled state.
>
> You're wrong (I think):
>
>  - if .enabled =3D true, you should configure the output to repeat the
>    following pattern: be active for $duty_cycle ns and then inactive for
>    the rest of $period ns.
>
>  - if .enabled =3D false, you should configure the output to be constant
>    inactive.
>
>  - if .polarity =3D PWM_POLARITY_NORMAL we have: inactive =3D low, active=
 =3D
>    high
>
>  - if .polarity =3D PWM_POLARITY_INVERTED we have: inactive =3D high, act=
ive =3D
>    low
thank you for explaining it again!

now I see what you mean that we're missing the case with
PWM_POLARITY_INVERTED and enabled =3D false:
* PWM_POLARITY_INVERTED/PWM_POLARITY_NORMAL and enabled =3D true are
managed in meson_pwm_calc()
* PWM_POLARITY_NORMAL and enabled =3D false is managed in meson_pwm_apply()
* logic for PWM_POLARITY_INVERTED and enabled =3D false is missing
(current result: same as PWM_POLARITY_NORMAL and enabled =3D false which
means: output is constant LOW, expected result: output is constant
HIGH)

> So after the two pwm_apply_state above the expectation is that the
> output is constant high. But as the meson driver's apply function
> doesn't check for .polarity when .enabled =3D false is requested the
> result is probably constant low. (Unless the driver is still more broken
> and doesn't ensure the output gets inactive on .disable().)
I will put this on my TODO-list for my cleanups

> > > If you want to implement further cleanups, my questions and propositi=
ons
> > > are:
> > >
> > >  - Is there a publicly available manual for this hardware? If yes, yo=
u
> > >    can add a link to it in the header of the driver.
> > yes, it's documented in the public S912 datasheet [0] page 542 and foll=
owing
> > I'll add a patch which adds the link to the driver
> >
> > >  - Why do you handle reparenting of the PWM's clk in .request? Wouldn=
't
> > >    this be more suitable in .apply?
> > Jerome's answer (not long after yours) basically covers this:
> > - the assigned-clock-parents property could have been used but it wasn'=
t
> > - the driver could automatically set the correct parent, but this
> > isn't implemented
> >
> > (I assume this was done to keep it short and simple to for the first
> > version of the driver)
>
> I don't know how assigned-clock-parents works, but maybe it is even
> simpler to use than the hardcoding that currently is used in the driver?
>
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
thank you for explaining the test-case!
I'll do the maths on the weekend and determine the longest supported
period - then I'll measure this with a multimeter.

> > can you please explain why this is important?
>
> Well, that's the semantic that the PWM API promises to its users.
> Up to now this is poorly documented, there is an RFC patch waiting for
> review that improves the situation.
that makes sense, thank you for the explanation.

> > >  - Please point out in the header that for changing period/duty
> > >    cycle/polarity the hardware must be stopped. (I suggest to apply t=
he
> > >    style used in https://www.spinics.net/lists/linux-pwm/msg09262.htm=
l
> > >    for some consistency.)
> > I'm not sure about this. Amlogic's vendor kernel uses a modified
> > version of this driver [1] which has an explicit comment not to
> > disable the PWM output when changing the period/duty cycle.
>
> That would be better as stopping the driver also violates the API's
> requirements. If this is not a hardware imposed limit, it would be great
> to fix the driver accordingly.
I found out that Bichao Zheng from Amlogic changed the PWM driver in
the vendor kernel. He even provided useful details in the commit
message (which I'll quote here for archive purposes): [0]
  pwm: meson: don't disable pwm when setting duty repeatedly

  There is an abnormally low about 20ms,when setting duty repeatedly.
  Because setting the duty will disable pwm and then enable.Delete
  this operation now.

> > the PWM is configured with two separate registers (PWM_MISC_REG_AB
> > contains the divider and PWM_PWM_A contains the high/low count).
> > there's a short timeframe where the PWM output signal is neither the
> > "old setting" nor the "new setting" (but rather a mix of both). what
> > do other PWM drivers do in this case (if this is a common thing)?
>
> If this cannot be prevented in hardware, I think this should be
> documented clearly at the top of the driver. Up to now this kind of
> problem isn't (TTBOMK) well tracked and questions like "How many drivers
> suffer from $problem" cannot be easily answered.
> (A bit unrelated: I think the violation that disabling a PWM doesn't
> complete the currently running period is a common one. But because the
> corresponding questions where not asked for new driver submissions until
> recently, this is untracked and probably driver authors are not even
> aware of this requirement.)
I will port Bichao Zheng's commit to the mainline driver and try it on
one of my 32-bit Meson boards (where a PWM controlled regulator
supplies the CPU cores) and one my 64-bit Meson boards (where a PWM
clock is used for the 32.768kHz LPO clock for the Wifi chipset).

I'm not sure if we still have a small timeframe where the clock
divider gets reconfigured.
However, I'm not sure if that's an actual problem for the use-cases
that we have on the boards with Amlogic Meson SoCs:
- maybe the controller is smart enough to read the clock frequency
only when starting the PWM
- for the pwm-regulator and pwm-clock use-cases we only configure the
period once. thus we always get the same clock divider internally, so
we don't run into issues
(I still think that adding documentation for the actual behavior is
good, but maybe we don't need a "fix" right now because it probably
works fine anyways for our current use-cases)

> > > Another thing I just noted: The .get_state callback only sets .enable=
d
> > > but nothing of the remaining information is provided.
> > as far as I can see the PWM core uses .get_state only during registrati=
on:
> > this means we should read (and calculate) .duty_cycle and .period from
> > the register values. polarity always has to be "normal" since there's
> > no information about it in the registers.
>
> So you can change the polarity, but you cannot read that information
> back? That's another item for the list of limitations.
OK, noted
(as Neil explained we swap the low/high duration in software, the
hardware doesn't know about this)


Regards
Martin


[0] https://github.com/hardkernel/linux/commit/11573cdb34ec790c3dd6f860442b=
e4f7b4d651d5#diff-e432928020d0ce66e5bef757ba2c6f36
