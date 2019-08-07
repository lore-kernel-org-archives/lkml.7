Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4907FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128362173C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJOajrac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfHGBNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:13:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37703 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfHGBNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:13:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so42461709pfa.4;
        Tue, 06 Aug 2019 18:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u4CFBN9jcxG6CFNFBBtApHbFd9s1AZ+ekko2NJrvock=;
        b=SJOajracFAt3ijWVg+xaCoFsDiOS0z6dXguBR3ct2tWASXNXm3ND0eBFc5aiQEqlkv
         Rx/XTPj2KqEB9hOzAc93i82xzgazlJevAuiGXOQ2J58m2isIRtl/whLs5CFd96GA7mvS
         YHrurPGFvI3f+Wq0N2QEzro2LC7QfjOWwvuMkQy0Q/OTQvX1oKsxm/p/jZ69o2ZmmGuz
         yJCycoVPICxMZKW5yANTPmkS/TcyZ3Ti1veEQ7TPNp+nT2EUIlJLK4MjQjTGwXDM48Qj
         lgpaPxWI+tV8jJnP73RbFBNWoZ37eYZiY96I+fKpgnBMA3tmyZKKELFCnxTz3fZtlrNW
         Ie3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u4CFBN9jcxG6CFNFBBtApHbFd9s1AZ+ekko2NJrvock=;
        b=jt7F9YLA+2JTVXzVH8yihPjIl8BQvnTqLCLH/b4j4pJw3MUBhgqnrhL70Mg2bKn+ug
         zJ0+hiXezLM43zKPbtOTFLVnd/DWdjjW6W59K5Y51Jq/SQUjxDYYU7qeCmyXUxGJpPzU
         578IwU52MxKe7C+BZboQhA4iURYt4ScqfsqKFOuUmKZyUVuSzEzRpN/rTbXP60nmEmZu
         FoG4YXpncsJ0biXk2+9EJ8t4n8MaGHtHyiGS5UoEkSk+yyGHgi3rv9orQ0mqKyMX5Lz2
         08+/J9cploGdsjOJc/DTFaotX5qLJ9nijBs2yYnREuts46bctMsh7dTIWg95smUzSmXi
         URhQ==
X-Gm-Message-State: APjAAAURUWOZcwGwDZPuCy4Zw2C4PxFmiIBAyP5jhqfSeviT3rvCD3+N
        kSBDcLjC/eZqzP4XqAm85Pk=
X-Google-Smtp-Source: APXvYqw8kAF7UlF/qKmSi5AAFuHDbAWLLnoX4Lh+1nADuqi9UM9xsAI2PZwM/lrArwNjUY3moTd4iQ==
X-Received: by 2002:a62:174a:: with SMTP id 71mr6866238pfx.140.1565140426593;
        Tue, 06 Aug 2019 18:13:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r6sm49734116pjb.22.2019.08.06.18.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 18:13:46 -0700 (PDT)
Date:   Tue, 6 Aug 2019 18:14:41 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
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
Subject: Re: [PATCH v2 3/7] ASoC: fsl_sai: Add support to enable multiple
 data lines
Message-ID: <20190807011441.GC8938@Asurada-Nvidia.nvidia.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-4-daniel.baluta@nxp.com>
 <20190729202154.GC20594@Asurada-Nvidia.nvidia.com>
 <CAEnQRZBN5Y+75cpgS2h3LwDj5BkF5cesqu6=V3GuPU4=5pgn6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEnQRZBN5Y+75cpgS2h3LwDj5BkF5cesqu6=V3GuPU4=5pgn6A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:23:27PM +0300, Daniel Baluta wrote:
> On Mon, Jul 29, 2019 at 11:22 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Sun, Jul 28, 2019 at 10:24:25PM +0300, Daniel Baluta wrote:
> > > SAI supports up to 8 Rx/Tx data lines which can be enabled
> > > using TCE/RCE bits of TCR3/RCR3 registers.
> > >
> > > Data lines to be enabled are read from DT fsl,dl-mask property.
> > > By default (if no DT entry is provided) only data line 0 is enabled.
> > >
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  sound/soc/fsl/fsl_sai.c | 11 ++++++++++-
> > >  sound/soc/fsl/fsl_sai.h |  4 +++-
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > > index 637b1d12a575..5e7cb7fd29f5 100644
> > > --- a/sound/soc/fsl/fsl_sai.c
> > > +++ b/sound/soc/fsl/fsl_sai.c
> > > @@ -601,7 +601,7 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> > >
> > >       regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> > >                          FSL_SAI_CR3_TRCE_MASK,
> > > -                        FSL_SAI_CR3_TRCE);
> > > +                        FSL_SAI_CR3_TRCE(sai->soc_data->dl_mask[tx]);
> > >
> > >       ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
> > >                       SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
> > > @@ -888,6 +888,15 @@ static int fsl_sai_probe(struct platform_device *pdev)
> > >               }
> > >       }
> > >
> > > +     /*
> > > +      * active data lines mask for TX/RX, defaults to 1 (only the first
> > > +      * data line is enabled
> > > +      */
> > > +     sai->dl_mask[RX] = 1;
> > > +     sai->dl_mask[TX] = 1;
> > > +     of_property_read_u32_index(np, "fsl,dl-mask", RX, &sai->dl_mask[RX]);
> > > +     of_property_read_u32_index(np, "fsl,dl-mask", TX, &sai->dl_mask[TX]);
> >
> > Just curious what if we enable 8 data lines through DT bindings
> > while an audio file only has 1 or 2 channels. Will TRCE bits be
> > okay to stay with 8 data channels configurations? Btw, how does
> > DMA work for the data registers? ESAI has one entry at a fixed
> > address for all data channels while SAI seems to have different
> > data registers.
> 
> Hi Nicolin,
> 
> I have sent v3 and removed this patch from the series because we
> need to find a better solution.

Ack. I was in that private mail thread. So it's totally fine.

> 
> I think we should enable TCE based on the number of available datalines
> and the number of active channels.  Will come with a RFC patch later.

Yea, that's exactly what I suspected during patch review and
what I suggested previously too. Look forward to your patch.

> Pasting here the reply of SAI Audio IP owner regarding to your question above,
> just for anyone to have more info of our private discussion:
> 
> If all 8 datalines are enabled using TCE then the transmit FIFO for
> all 8 datalines need to be serviced, otherwise a FIFO underrun will be
> generated.
> Each dataline has a separate transmit FIFO with a separate register to
> service the FIFO, so each dataline can be serviced separately. Note
> that configuring FCOMB=2 would make it look like ESAI with a common
> address for all FIFOs.
> When performing DMA transfers to multiple datalines, there are a
> couple of options:
>     * Use 1 DMA channel to copy first slot for each dataline to each
> FIFO and then update the destination address back to the first
> register.
>     * Configure separate DMA channel for each dataline and trigger the
> first one by the DMA request and the subsequent channels by DMA
> linking or scatter/gather.
>     * Configure FCOMB=2 and treat it the same as the ESAI. This is
> almost the same as 1, but don’t need to update the destination
> address.
> 
> Thanks,
> Daniel.
