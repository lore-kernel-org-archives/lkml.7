Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425AEC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1275821A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNgoAJZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405673AbfIITdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 15:33:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45476 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731005AbfIITdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:33:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so9809787pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RaRE1Iu5KUHw2kF5I9xN2ziSWnzUpRlWSz3BZK7PqtY=;
        b=SNgoAJZV+5ID24jcq/ogL56EPLG4XLHTtbcwvdtCs9cUwEwB2vLUrcHV4GJlssFvXQ
         Md/WdrXDCljdGL5we81h69jFBMqoPNiL8xqYd0364AOhk8+o+QbJWMEx5hbwlU84qjFg
         Se/5NSBh8EzJau8pPX4eQCSWUrg2iGs2/Dz0I0v6WCqFN1MT0i2DwRay31CUK4cRQeW7
         WaDsUaXSWQBsJGlzFuoSOEa978uMLZtLAfv0aP2IlV4mANsWdhVHMaXESBnmAoEINP/T
         Z10c1D1HtdFkDYDvEy/N0cqnZrWc+ENOwCwUtbqIUNO7/DZP5nD+2/aqg5+kDjUtlgnJ
         wJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RaRE1Iu5KUHw2kF5I9xN2ziSWnzUpRlWSz3BZK7PqtY=;
        b=Py9K/jrin/2Qmmtied1iW//zUndnLxnznCAE7IuSuWsLAxiroSYqnqX289YmMlz9sj
         gmkfZXmHXo/bD63rH0XkKoY5+/20VI8XSSXUETB4+p5c9KQalPHeyskOtbCdURX2gQPY
         qgeK9LJbwBjusQtRimXXpEvY8/FPNX3LOPeMdYMvhOHb52zLTYxhnMSsY42c8K5mupVK
         akp+WRUw1DGzEA0nzjYKVjzsavsaK/j7a8M+Y+BaO3856Xqi2Gqup8nWzZG7fqAJ7Wah
         o5YVXis6O7Lcq049WeWR5u8aApc+s9AU/grZsHHpHzJbE8qHhi3z3Tqh6OKNfPejNJvg
         kgJg==
X-Gm-Message-State: APjAAAVNLVZPBPCLAgS3Ru+HmuSRikblGApZ+r7mXv87mxxzOzfMIJBx
        H+lupaEXsScWTI2qbxrnVYmaf3L/
X-Google-Smtp-Source: APXvYqzuJVmL1KvgW96Px+WaNpFc/h8svQlg6lkb9PFH4vxlAq1B2IJsKu8U1pC/pdAjqH18ms2EnA==
X-Received: by 2002:a65:63c4:: with SMTP id n4mr7060143pgv.44.1568057585214;
        Mon, 09 Sep 2019 12:33:05 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w11sm19308266pfd.116.2019.09.09.12.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Sep 2019 12:33:05 -0700 (PDT)
Date:   Mon, 9 Sep 2019 12:32:38 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mihai Serban <mihai.serban@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mihai Serban <mihai.serban@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Fix noise when using EDMA
Message-ID: <20190909193238.GA10344@Asurada-Nvidia.nvidia.com>
References: <20190830200900.19668-1-daniel.baluta@nxp.com>
 <20190906012438.GA17926@Asurada-Nvidia.nvidia.com>
 <CAEnQRZBTc=beU7CX747RsM7KEsJethfZ0fPv=CkLQ1e3ofHMkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZBTc=beU7CX747RsM7KEsJethfZ0fPv=CkLQ1e3ofHMkA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 09:46:12AM +0300, Daniel Baluta wrote:
> On Fri, Sep 6, 2019 at 4:25 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Fri, Aug 30, 2019 at 11:09:00PM +0300, Daniel Baluta wrote:
> > > From: Mihai Serban <mihai.serban@nxp.com>
> > >
> > > EDMA requires the period size to be multiple of maxburst. Otherwise the
> > > remaining bytes are not transferred and thus noise is produced.
> > >
> > > We can handle this issue by adding a constraint on
> > > SNDRV_PCM_HW_PARAM_PERIOD_SIZE to be multiple of tx/rx maxburst value.
> > >
> > > Cc: NXP Linux Team <linux-imx@nxp.com>
> > > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
> > >  sound/soc/fsl/fsl_sai.h |  1 +
> > >  2 files changed, 16 insertions(+)
> > >
> > > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > > index 728307acab90..fe126029f4e3 100644
> > > --- a/sound/soc/fsl/fsl_sai.c
> > > +++ b/sound/soc/fsl/fsl_sai.c
> > > @@ -612,6 +612,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> > >                          FSL_SAI_CR3_TRCE_MASK,
> > >                          FSL_SAI_CR3_TRCE);
> > >
> > > +     /*
> > > +      * some DMA controllers need period size to be a multiple of
> > > +      * tx/rx maxburst
> > > +      */
> > > +     if (sai->soc_data->use_constraint_period_size)
> > > +             snd_pcm_hw_constraint_step(substream->runtime, 0,:
> > > +                                        SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> > > +                                        tx ? sai->dma_params_tx.maxburst :
> > > +                                        sai->dma_params_rx.maxburst);
> >
> > I feel that PERIOD_SIZE could be used for some other cases than
> > being related to maxburst....
> >
> > >  static const struct of_device_id fsl_sai_ids[] = {
> > > diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> > > index b89b0ca26053..3a3f6f8e5595 100644
> > > --- a/sound/soc/fsl/fsl_sai.h
> > > +++ b/sound/soc/fsl/fsl_sai.h
> > > @@ -157,6 +157,7 @@
> > >
> > >  struct fsl_sai_soc_data {
> > >       bool use_imx_pcm;
> > > +     bool use_constraint_period_size;
> >
> > ....so maybe the soc specific flag here could be something like
> >         bool use_edma;
> >
> > What do you think?
> 
> I think your suggestion is a little bit better than what we have. But what if

The better part of using "edma" word, I felt, is to match this
"soc" word in the structure name.

> in the future another DMA controler (not eDMA) will need the same constraint.

That sounds like a valid point to me, I don't feel it'd happen
that often though. I'd be okay if you insist to keep yours :)
