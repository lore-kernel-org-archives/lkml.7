Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A09C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D7D21872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQIErTu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKNAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:00:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42134 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKNAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:00:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so14507781wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEDRS3N08vMM5wC2R3aZvV9f5xQTSZhcB9bk4IB+bq0=;
        b=gQIErTu0/oszN8lDTz1psUNEDcAdWbU40K8KqpgGYE1+FklD6DWKZARx4jvikbe8hI
         IUbjoTaI7RCucaVZnq9rr+j5jZLuDrtmXsUZ9BjPrKScB1qgY6eLW1z4JLxu/dm2lv2/
         W4vok6LKeW+En4DLuNrPzcUwt48cyFCOmyuko9OkG3X0dRsdhoVovl1BFuzxIh2ydWB8
         tIU7Ygpzc6KjprZLKofyo2NkgvMsjaS7NQ0y81q/kdqNQihyTqzvSiYS64Ys/GRpmbDS
         2Z5q3nwlkf58Hrj2efnLn2nz/0P5TeevFXbfciBBR7nI2Z1xegr1gfkNjIEyflKNDXtc
         lw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEDRS3N08vMM5wC2R3aZvV9f5xQTSZhcB9bk4IB+bq0=;
        b=FBzIrKSL8c0PMVGKTaab6fPlldRQV7HeT67bxGwSQ6bLpFJZWDbx0SJWwGjzkBus8c
         o9e6hGq/VuR6ZyzdvVJitKrE/J5peABrQKK/akVJ553BkoQ28O4y1KEQTshEaZ1GyX9q
         QKLyVrP5egkt36/GNCo6pecpjJvrOQVcLxAUAiDmErCnayY7vfiFIBbz1JiQZypyDZ2h
         0EIL8duAHBgFdLZCHH3mX8UtDwBog+l9g2wJlbTLDdZoFIQbGYvnrfFyZAxOUH79MNe7
         iVycpCJO/QXulGa2AMGX8l9C/RhO7VJZv47SraScUTYO3MqqUR4M5VW8xsVfgRigHnHD
         RfQw==
X-Gm-Message-State: APjAAAVlO5a0yaM1WveSWhPqz36JwSQ9/vkI4VzGeJ1IPy57FvzbCXAV
        ecp3u/4Et0UxazldgZXGEwWyxeXvmnyOKdd8EX0=
X-Google-Smtp-Source: APXvYqxJ8vep/IViuTx4QDVZatw0xHW0xWFo1DYsgxKISpGkP73DqHjKUsinqUDVA+MkD9zjNn8i2eYD0XNxvyZ4khk=
X-Received: by 2002:a5d:5306:: with SMTP id e6mr18900931wrv.187.1573477200508;
 Mon, 11 Nov 2019 05:00:00 -0800 (PST)
MIME-Version: 1.0
References: <AM0PR04MB6468D4D15E471940B1906344E3780@AM0PR04MB6468.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB6468D4D15E471940B1906344E3780@AM0PR04MB6468.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 11 Nov 2019 14:59:49 +0200
Message-ID: <CAEnQRZBfOCH-R-QmY2gB5jEehea1Cn+RnyOkOhMj8=ZJoOADBg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_audmix: Add spin lock to protect tdms
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:54 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:
>
> Hi
> >
> > Hi Shengjiu,
> >
> > Comments inline.
> >
> > On Wed, Nov 6, 2019 at 9:30 AM Shengjiu Wang <shengjiu.wang@nxp.com>
> > wrote:
> > >
> > > Audmix support two substream, When two substream start to run, the
> > > trigger function may be called by two substream in same time, that the
> > > priv->tdms may be updated wrongly.
> > >
> > > The expected priv->tdms is 0x3, but sometimes the result is 0x2, or
> > > 0x1.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  sound/soc/fsl/fsl_audmix.c | 6 ++++++  sound/soc/fsl/fsl_audmix.h | 1
> > > +
> > >  2 files changed, 7 insertions(+)
> > >
> > > diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> > > index c7e4e9757dce..a1db1bce330f 100644
> > > --- a/sound/soc/fsl/fsl_audmix.c
> > > +++ b/sound/soc/fsl/fsl_audmix.c
> > > @@ -286,6 +286,7 @@ static int fsl_audmix_dai_trigger(struct
> > snd_pcm_substream *substream, int cmd,
> > >                                   struct snd_soc_dai *dai)  {
> > >         struct fsl_audmix *priv = snd_soc_dai_get_drvdata(dai);
> > > +       unsigned long lock_flags;
> > >
> > >         /* Capture stream shall not be handled */
> > >         if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> > > @@ -295,12 +296,16 @@ static int fsl_audmix_dai_trigger(struct
> > snd_pcm_substream *substream, int cmd,
> > >         case SNDRV_PCM_TRIGGER_START:
> > >         case SNDRV_PCM_TRIGGER_RESUME:
> > >         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > > +               spin_lock_irqsave(&priv->lock, lock_flags);
> >
> > Why do we need to disable interrupts here? I assume that lock is only
> > used in process context.
> >
> It is in atomic context, so I think it is ok to disable interrupt.

All right thanks for the explanation. Added my Reviewed-by to v2.
