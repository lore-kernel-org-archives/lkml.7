Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F30AC32754
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5D62070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wkr5gpVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbfHFPXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:23:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37632 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfHFPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:23:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so63242938wrr.4;
        Tue, 06 Aug 2019 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=odr/LwwtS4mPalaN6ESbuLoaV9Tj61vBV+Buti6dQKs=;
        b=Wkr5gpVUBwPFtwe7aMYlXu0QCRyLrLWrpwVBqLAGNXi7JlcjK14f5Eyxlh2YYXO3uX
         hl2G9AogPdxljXjx9HiCAlDxkkKISy/OiNlkAQvn7fxLYl17PYB36zwF+0aQlt8yt2eJ
         93Tan+2FxKZ/+VerPk81ksBL0ms3wrw1cqVmHmiOppGELU7gzpkQQ3mSivu9Sn3Ti7W3
         17cz1PjB2gSF4vzREVSJPL+mpgu5gplQvh3OPQZzwWSaPYxNmwcQPSj8zCcQpjBQUsi7
         6l7LmL7mONcX007+Mh04YXNQp8KWxXxmXWbYopYoiob3lYS/E2JhuiLOJtRhKNmB8Zv3
         UsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=odr/LwwtS4mPalaN6ESbuLoaV9Tj61vBV+Buti6dQKs=;
        b=qyIJOsD9W4R+hjfKe9gZhO2NgKKYeJa2XsCEPvkdhmHcglVOSCQ5WKc8Cy82y4PBHX
         UUXz4GVJnXtP7jWY6239v4+NTC8E6Elwn07CJ4YHewxkDye8uTgyjvzXQiXJfYX8Ug35
         70zkyzYwK3LYJw/fxG//uIWiOl9pE/Y6klrIdkqYVJZ7A86DvPjT/EZoD698h0SxHj69
         wGtKiDR4/2kt8DeLVCD5ZeezwAktKvxREJGVIET9Y8JULkas7JvBANyRspcYsd2zrdl4
         TlxBgqboTzhcxkiZkJsPChbJkSBu+EoY7Z+tSf+jdN/nJrb8quMuAxKeCLNYJlx3JdTT
         jFFg==
X-Gm-Message-State: APjAAAWJdR7+M4T4mZb6CL/xqssioXKZIo/8tKIRC6xBvrDH1Vrru5/4
        wJqSeFuRH8TyOQulSb+uRZU+YYJKz6gJdiDJjhyKqIDXaJk=
X-Google-Smtp-Source: APXvYqxeI6GgG7w7v2FCZh3kocax8+++ZYu+tr47LIy/bG8jVs0n5UPlQx0djkr8B/y34PLQDVAHtQztP9qr1yLN/qY=
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr5446454wrx.196.1565105018109;
 Tue, 06 Aug 2019 08:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-4-daniel.baluta@nxp.com>
 <20190729202154.GC20594@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190729202154.GC20594@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 6 Aug 2019 18:23:27 +0300
Message-ID: <CAEnQRZBN5Y+75cpgS2h3LwDj5BkF5cesqu6=V3GuPU4=5pgn6A@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ASoC: fsl_sai: Add support to enable multiple data lines
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mihai Serban <mihai.serban@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Timur Tabi <timur@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:22 PM Nicolin Chen <nicoleotsuka@gmail.com> wrot=
e:
>
> On Sun, Jul 28, 2019 at 10:24:25PM +0300, Daniel Baluta wrote:
> > SAI supports up to 8 Rx/Tx data lines which can be enabled
> > using TCE/RCE bits of TCR3/RCR3 registers.
> >
> > Data lines to be enabled are read from DT fsl,dl-mask property.
> > By default (if no DT entry is provided) only data line 0 is enabled.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 11 ++++++++++-
> >  sound/soc/fsl/fsl_sai.h |  4 +++-
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 637b1d12a575..5e7cb7fd29f5 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -601,7 +601,7 @@ static int fsl_sai_startup(struct snd_pcm_substream=
 *substream,
> >
> >       regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> >                          FSL_SAI_CR3_TRCE_MASK,
> > -                        FSL_SAI_CR3_TRCE);
> > +                        FSL_SAI_CR3_TRCE(sai->soc_data->dl_mask[tx]);
> >
> >       ret =3D snd_pcm_hw_constraint_list(substream->runtime, 0,
> >                       SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraint=
s);
> > @@ -888,6 +888,15 @@ static int fsl_sai_probe(struct platform_device *p=
dev)
> >               }
> >       }
> >
> > +     /*
> > +      * active data lines mask for TX/RX, defaults to 1 (only the firs=
t
> > +      * data line is enabled
> > +      */
> > +     sai->dl_mask[RX] =3D 1;
> > +     sai->dl_mask[TX] =3D 1;
> > +     of_property_read_u32_index(np, "fsl,dl-mask", RX, &sai->dl_mask[R=
X]);
> > +     of_property_read_u32_index(np, "fsl,dl-mask", TX, &sai->dl_mask[T=
X]);
>
> Just curious what if we enable 8 data lines through DT bindings
> while an audio file only has 1 or 2 channels. Will TRCE bits be
> okay to stay with 8 data channels configurations? Btw, how does
> DMA work for the data registers? ESAI has one entry at a fixed
> address for all data channels while SAI seems to have different
> data registers.

Hi Nicolin,

I have sent v3 and removed this patch from the series because we
need to find a better solution.

I think we should enable TCE based on the number of available datalines
and the number of active channels.  Will come with a RFC patch later.

Pasting here the reply of SAI Audio IP owner regarding to your question abo=
ve,
just for anyone to have more info of our private discussion:

If all 8 datalines are enabled using TCE then the transmit FIFO for
all 8 datalines need to be serviced, otherwise a FIFO underrun will be
generated.
Each dataline has a separate transmit FIFO with a separate register to
service the FIFO, so each dataline can be serviced separately. Note
that configuring FCOMB=3D2 would make it look like ESAI with a common
address for all FIFOs.
When performing DMA transfers to multiple datalines, there are a
couple of options:
    * Use 1 DMA channel to copy first slot for each dataline to each
FIFO and then update the destination address back to the first
register.
    * Configure separate DMA channel for each dataline and trigger the
first one by the DMA request and the subsequent channels by DMA
linking or scatter/gather.
    * Configure FCOMB=3D2 and treat it the same as the ESAI. This is
almost the same as 1, but don=E2=80=99t need to update the destination
address.

Thanks,
Daniel.
