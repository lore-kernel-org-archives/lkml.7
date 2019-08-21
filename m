Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1919C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C962339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1To62xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfHUKoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:44:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35084 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfHUKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:43:23 -0400
Received: by mail-io1-f67.google.com with SMTP id i22so3580632ioh.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=21mfaxXpzzpcpjFxLsuOaE64M3Kk3ik/0tTAJe54ZzM=;
        b=T1To62xzjvEzr+9ni5+lpN2/GgC8rIsJ+fA7ZZG22Eib4BoVxDScW9e1mqvuWFc3Tt
         8/TUJ1PcvRC7h0FtQJP7KCPLUXakXY8sZjMnMC0HoAZW9AQs+9cNJGiHbPMyuhWALN3H
         AxKQvPM3cJdyFLqk78GlGCjS/fnp+HKZJGVZXAll95v7op+6lFP2nBem63fteWtn1G7M
         vuRBZ9F2DPrCF2YviqYUCo3rGBb4dVeV9CydJ1Q8Wlhx5gXzgDauAp2ItU0qeCdKdJBn
         30n9Ndn3jEBd3+f8rRS+NDForNpmmj3Wgbmiox77JD4ghaAdl7k/ZPakI46yskWOw1Tv
         66gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=21mfaxXpzzpcpjFxLsuOaE64M3Kk3ik/0tTAJe54ZzM=;
        b=prI5Sxnv0z6qebM+tkaKYyd6Q3B5T5CsKeADq+hQ/NDJOW142GbhGrPwdfmMj4aq0n
         1fwqLZdIY7US+0pcUser4XRaop1c66jQILpC4LWbdstelIQf2P6tG7IYGwa7qlpabXVX
         DJKKAgvttl1dOg3BsEtTGk8M8/Kmi/WsHCM31LTZcYagnqS0C518cwy2hKePw9hPldWa
         Tj1kzvVRcLUY4QXsG3WRj4uIXudIPanuTd1+pL2bqOcxGRhESsFnBp+fIKoPkdsAazwR
         Q1g0k/EztiGPyZ+fPHzqsS+mKWHnQCVhtEfVSZc3DobnZbg3Qoehk8BIBXOLaWY87vQn
         p7nw==
X-Gm-Message-State: APjAAAXksVMO+8l417/Gu1Q3xae0aWWfsBHusrqG0Plwn6faOa3yAo9C
        /ZThQ+oZjR+0IJrpUJpo3Iopyregn2jaBDcYwQ==
X-Google-Smtp-Source: APXvYqwW95LjpMO9piBiCEl4iZLPGgAKcSDCHDXwI9uuYqLMnZH3/UMptPpMLWSQk2fEzw/SOVaaxgRnFzC+JtGR5cg=
X-Received: by 2002:a05:6638:303:: with SMTP id w3mr8829447jap.103.1566384202422;
 Wed, 21 Aug 2019 03:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190729170354.202374-1-avifishman70@gmail.com> <744188a1-d11a-7edc-79cd-e3c7dbcf6e86@linaro.org>
In-Reply-To: <744188a1-d11a-7edc-79cd-e3c7dbcf6e86@linaro.org>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Wed, 21 Aug 2019 13:42:27 +0300
Message-ID: <CAKKbWA72VX4LnLM0on2=bj787J53GUwkh6PTU2+0fvP+gPu+Xg@mail.gmail.com>
Subject: Re: [PATCH] [v5] clocksource/drivers/npcm: fix GENMASK and timer operation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Daniel,

It seems more clear now :)

Good to know about the need for Fixes tag.

On Wed, Aug 21, 2019 at 1:11 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 29/07/2019 19:03, Avi Fishman wrote:
> > NPCM7XX_Tx_OPER GENMASK bits where wrong,
> > Since NPCM7XX_REG_TICR0 register reset value of those bits was 0,
> > it did not cause an issue.
> > in npcm7xx_timer_oneshot() the original NPCM7XX_REG_TCSR0 register was
> > read again after masking it with ~NPCM7XX_Tx_OPER so the masking didn't
> > take effect.
> >
> > npcm7xx_timer_periodic() was not wrong but it wrote to NPCM7XX_REG_TICR=
0
> > in a middle of read modify write to NPCM7XX_REG_TCSR0 which is
> > confusing.
> > npcm7xx_timer_oneshot() did wrong calculation
> >
> > Signed-off-by: Avi Fishman <avifishman70@gmail.com>
>
> I've applied the patch and massaged the changelog [1].
>
> Let me know if you disagree with it.
>
> Please, in the future take care of adding the Fixes tag.
>
> Thanks
>
>   -- Daniel
>
> [1]
> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=3Dclocke=
vents/next&id=3Da5f6679fc81e42fcbef0184770d8a3b04c0f153e
>
> > ---
> >  drivers/clocksource/timer-npcm7xx.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/=
timer-npcm7xx.c
> > index 8a30da7f083b..9780ffd8010e 100644
> > --- a/drivers/clocksource/timer-npcm7xx.c
> > +++ b/drivers/clocksource/timer-npcm7xx.c
> > @@ -32,7 +32,7 @@
> >  #define NPCM7XX_Tx_INTEN             BIT(29)
> >  #define NPCM7XX_Tx_COUNTEN           BIT(30)
> >  #define NPCM7XX_Tx_ONESHOT           0x0
> > -#define NPCM7XX_Tx_OPER                      GENMASK(27, 3)
> > +#define NPCM7XX_Tx_OPER                      GENMASK(28, 27)
> >  #define NPCM7XX_Tx_MIN_PRESCALE              0x1
> >  #define NPCM7XX_Tx_TDR_MASK_BITS     24
> >  #define NPCM7XX_Tx_MAX_CNT           0xFFFFFF
> > @@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct clock_event_d=
evice *evt)
> >
> >       val =3D readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >       val &=3D ~NPCM7XX_Tx_OPER;
> > -
> > -     val =3D readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >       val |=3D NPCM7XX_START_ONESHOT_Tx;
> >       writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >
> > @@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct clock_even=
t_device *evt)
> >       struct timer_of *to =3D to_timer_of(evt);
> >       u32 val;
> >
> > +     writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0=
);
> > +
> >       val =3D readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >       val &=3D ~NPCM7XX_Tx_OPER;
> > -
> > -     writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0=
);
> >       val |=3D NPCM7XX_START_PERIODIC_Tx;
> > -
> >       writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >
> >       return 0;
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>


--=20
Regards,
Avi
