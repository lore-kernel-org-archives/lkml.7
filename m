Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA9C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C3A2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucGBCVwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfGOPsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:48:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44308 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbfGOPsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:48:52 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so34762670iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2ekqYXyWScZdGL4/IuVQy9DAJhZ8DCtVpPL9rbaqvU=;
        b=ucGBCVwecdtUME+/YMeojNAwXZakBMGomin0nC9x95dHz5KQWKy9gXTcoyw8E6fg3b
         CWkR/aAVtbNnslyfoP0cLRICgvftKEgRUSA36BDa3LFP9HVAd//Xrgld9bpJcFNsbqPk
         n1FBLBPhZqmQ7aSSbFNgpB0B1yrGC4JGBtUIk42U8jJqFKlOz2q4dH0qsLE3q8hlf5JB
         v07NBeI1jXhnIaKe30/HtIUoOfpk90slS+/MzpK7YNTNhxwp7Rs6wPc+RHI9JCL3WSc+
         RwndnjrIIr63JSK30QtIONNkeICalsol8ZDl1UxeAcNAd/nMqS/8uAUdKAsO2I2HiljZ
         hi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2ekqYXyWScZdGL4/IuVQy9DAJhZ8DCtVpPL9rbaqvU=;
        b=g9U9fP5f3GKxBmthXDGqXbtFvOX7y6u7lamBhAyFtnPud6aKUCx9OlUpnJbmla4rEq
         XMY1W5d/epX7QsquBcCo4cKP7Ib8ehg/IiJdTE4Vak2hYxp85P16DkjX7aLP85b9Vcsr
         2PgnyVcSzxVVJP7uQXros+zFzMGh6XEwNAFIrddgh72GVubM7d+tf4eWMjGWdNg0+RWu
         69N6phL/qpCFU5m5wyvrIOzpKroRNGA36q7mZ1SywPm9TbR7wgTdu44Ipgp2reamabMf
         r7o2QACuhBMz1bm0NcTA3MFSsFuAD/UQjOK7dLXlIzUptoWDIsLEJ/hJjPaiKnwtZXTf
         JMSQ==
X-Gm-Message-State: APjAAAV8snsX2ZiuWsdT4rNhCFoWtffc2t2YBfv7JdP3Va3WmoyVix8m
        rxvVpL0Rge02NLtA2IxQnduMLAEL3+LtFmJSSg==
X-Google-Smtp-Source: APXvYqwRwyiP1lrPEyznFken0LaG2OqD8WsDYAhciMSRlzbZcHf2ce5cX3NvhLV+/DYi5sYuazpvzpL43Hn2E3LAQF8=
X-Received: by 2002:a5e:a712:: with SMTP id b18mr25034142iod.220.1563205732236;
 Mon, 15 Jul 2019 08:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKbWA6S7KotAFtLO=ow=XYnLL2Ny5Mz2kcgM1cs+j=5mHQNmw@mail.gmail.com>
 <CAKKbWA5nwsa5kcZ8GCuC3WKJptb6RtZ65izFphd=KaALqeg+BA@mail.gmail.com> <f758b14c5d8343de778f9a6ccdcb29c43778d3f2.camel@perches.com>
In-Reply-To: <f758b14c5d8343de778f9a6ccdcb29c43778d3f2.camel@perches.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 15 Jul 2019 18:48:05 +0300
Message-ID: <CAKKbWA7-EyYHQA_yLz5OJRpZSq4Nh-RMwn_zd0C_LKKzc5wErw@mail.gmail.com>
Subject: Re: [PATCH] [v2] clocksource/drivers/npcm: fix GENMASK and timer operation
To:     Joe Perches <joe@perches.com>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 6:25 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2019-07-15 at 18:19 +0300, Avi Fishman wrote:
> > clocksource/drivers/npcm: fix GENMASK and timer operation
> >
> > NPCM7XX_Tx_OPER GENMASK() changed from (27, 3) to (28, 27)
> >
> > in npcm7xx_timer_oneshot() the original NPCM7XX_REG_TCSR0 register was
> > read again after masking it with ~NPCM7XX_Tx_OPER so the masking didn't
> > take effect.
> >
> > npcm7xx_timer_periodic() was not wrong but it wrote to NPCM7XX_REG_TICR0
> > in a middle of read modify write to NPCM7XX_REG_TCSR0 which is
> > confusing.
>
> You might mention how the original use of GENMASK(3, 27)
> was defective or correct without effect.

Done, see v3 of this patch.

>
> > Signed-off-by: Avi Fishman <avifishman70@gmail.com>
> > ---
> >  drivers/clocksource/timer-npcm7xx.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-npcm7xx.c
> > b/drivers/clocksource/timer-npcm7xx.c
> > index 8a30da7f083b..9780ffd8010e 100644
> > --- a/drivers/clocksource/timer-npcm7xx.c
> > +++ b/drivers/clocksource/timer-npcm7xx.c
> > @@ -32,7 +32,7 @@
> >  #define NPCM7XX_Tx_INTEN               BIT(29)
> >  #define NPCM7XX_Tx_COUNTEN             BIT(30)
> >  #define NPCM7XX_Tx_ONESHOT             0x0
> > -#define NPCM7XX_Tx_OPER                        GENMASK(27, 3)
> > +#define NPCM7XX_Tx_OPER                        GENMASK(28, 27)
> >  #define NPCM7XX_Tx_MIN_PRESCALE                0x1
> >  #define NPCM7XX_Tx_TDR_MASK_BITS       24
> >  #define NPCM7XX_Tx_MAX_CNT             0xFFFFFF
> > @@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct
> > clock_event_device *evt)
> >
> >         val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >         val &= ~NPCM7XX_Tx_OPER;
> > -
> > -       val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >         val |= NPCM7XX_START_ONESHOT_Tx;
> >         writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >
> > @@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct
> > clock_event_device *evt)
> >         struct timer_of *to = to_timer_of(evt);
> >         u32 val;
> >
> > +       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
> > +
> >         val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >         val &= ~NPCM7XX_Tx_OPER;
> > -
> > -       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
> >         val |= NPCM7XX_START_PERIODIC_Tx;
> > -
> >         writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
> >
> >         return 0;
> >
>


-- 
Regards,
Avi
