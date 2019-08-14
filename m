Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB68DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEF22133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdGANqTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfHNOCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:02:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35432 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfHNOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:02:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so25367503wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BCsaT/ypWtdhsmfXKzhWUE99AeirQdOEW2jeMnFuhQ=;
        b=hdGANqTQ9F21qw3u2Ego2JScgA5oHNpiXRoKNozB7yNZReqYDa7LJmrxWHn8/BjFZA
         VJcIcgSCiwFebMJ6Wtunw9n3td5KB8oF2KoPTxrozb5S9wPP2eysU9YFtFwLKO1ILLlG
         jQZKIyxO1J99qglc+9rCgLVT8PBm7dz6RLjVXXvvqyF5mNtqHCr7TVDtUNZuSWfLZIwy
         W7b58nIVz03ZjHRkydJi9TxhYyhV65qrJCm3UPE3NUxx8FS/tXQRvwTOGX92IlEb3a1r
         5d2ZPTWM+Js2wa1jV7NZysCGy2pKT1lHA9sYZZQOb4mAMnJn2ywplnG9+Nf5MB/bPrUr
         cShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BCsaT/ypWtdhsmfXKzhWUE99AeirQdOEW2jeMnFuhQ=;
        b=sEhp50mCvbhzVeU3+US8OBpXpQEpsyrgqBERNxmbGjyFkTwgUURkohAGl0kWX7ZQXl
         blsipr/jnkTqHge2Ycovkyof+C4LNTWQpimOXFKzIKLMkX49YVt66Zb9CzyNr+3f1LoU
         x9f63FPHNOnz0jjhSs7zlbrPKUF6s9voYAmwMEJO3x8zN2Dpfwccgiz6yfnhpOVQgMIT
         FSfcBbDe56i4w9t8bKfO1FN/KA9a/X3kQ5lQ5+FR9a3wysetHIUM+fEURH4diBFS3t3N
         HiH+2fAKbQ4LhxK9QCaCkDSj4xIUjSyqmBvj1tj7jEOfgDfQcTJiphIy3oWZoBPlMafR
         XhRg==
X-Gm-Message-State: APjAAAWKnpfKymZjSAmk2TOPGy7mvvjxM4do9oZ3FVXf9eWpX4sSp60O
        rNanzVNW9Ktwkbjw6ojVwsTco4xoR330ddO6UL8=
X-Google-Smtp-Source: APXvYqxrhrONJQxS57JXyI89+iJAt6ObBY3ZfCskyIyx9vmteh564auNmoefwSfggsdTluXOxALfO9/LgPUpUfVMun0=
X-Received: by 2002:a5d:4310:: with SMTP id h16mr45630912wrq.212.1565791362736;
 Wed, 14 Aug 2019 07:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190811195545.32606-1-daniel.baluta@nxp.com> <20190814013916.GB13398@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190814013916.GB13398@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 14 Aug 2019 17:02:31 +0300
Message-ID: <CAEnQRZAQGdci_WtCKHqR-h9zid-COO1FaWWv-MPUkE_sYFszmg@mail.gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl_sai: Enable data lines based on input channels
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:39 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Aug 11, 2019 at 10:55:45PM +0300, Daniel Baluta wrote:
> > An audio data frame consists of a number of slots one for each
> > channel. In the case of I2S there are 2 data slots / frame.
> >
> > The maximum number of SAI slots / frame is configurable at
> > IP integration time. This affects the width of Mask Register.
> > SAI supports up to 32 slots per frame.
> >
> > The number of datalines is also configurable (up to 8 datalines)
> > and affects TCE/RCE and the number of data/FIFO registers.
> >
> > The number of needed data lines (pins) is computed as follows:
> >
> > * pins = channels / slots.
> >
> > This can be computed in hw_params function so lets move TRCE bits
> > seting from startup to hw_params.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 34 +++++++++++++---------------------
> >  sound/soc/fsl/fsl_sai.h |  2 +-
> >  2 files changed, 14 insertions(+), 22 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 69cf3678c859..b70032c82fe2 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
>
> > @@ -480,13 +483,17 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>
> > -     regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << channels) - 1));
> > +     regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << slots) - 1));
>
> Would this break mono channel audio?

Indeed, this isn't good for mono. I see in our internal tree that we
have min(channels, slots).
This would fix mono, let me think if this is really the right solution.

>
> >  static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
>
> > @@ -881,6 +872,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
> >               return -ENOMEM;
> >
> >       sai->pdev = pdev;
> > +
>
> Seemly unnecessary

Oh, ok. Will fix in next version.
