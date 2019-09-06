Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A828C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7C1206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeUe7NOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391691AbfIFGq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:46:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41566 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfIFGq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:46:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so4285011wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1veQAzAhBh/8QLIcBHhhy6Oq2ECmt8ium3T+Z509bU=;
        b=SeUe7NOO3XyJdM9wgMxo3VlFHkTcgKkIklKcVLAVhSnoFSbqswSZa06jkCJ0y6W7cO
         ERIUfV/TXKkO2e9cAoNoE8cUQq8ZzrgdGiyhBZR6vg+qCb1dRjn/tpsvrtcOat1iFwxP
         c/xJ8tPPdNnOAE4LHJKpWOa0Gd4AQsJrXM1KsdRpQvtuDsTL4f9DVemQuNIrqtruyMoH
         EfqmdGfe+vPx6+ymXuI1GJ4iEcD5vnfCzzhqaCnBL+xGgRQMzlr9sZ0k3MHXNR/B89Ct
         RqRdjvbZF0JoqjHYOucLg981x1R5RdgkIL3VOUBo6p/fHMDw2ywAoAi1dC6nevH5oDvC
         E5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1veQAzAhBh/8QLIcBHhhy6Oq2ECmt8ium3T+Z509bU=;
        b=OSPZqVCb6uBykL0YvoQJII1phcrSGK6/hpvR7YThRLUdcffGboAIOlZ5hW2NToG+zc
         Ww6XEADbw3axnCRmKsht3QIapE/SvWEn7Tla8S06lighYq7fpUtWxZYJtSnWcyfjUt3/
         5HX+IUUCAM9BctiP4efcG4JlemUFBJI9QtigTroP/+2hDFpk9SjQsEVFhT85B/PycS9K
         oa5hv9stFDi/Td39y1Ox4vp3I3lUciUJ7z3oUaW61A6SD2gdw92H3c+Dh34JrkzGza67
         aLRgDevoD5cIKAlSlR7f3RsTqBikAk8sJhTIRPbfNwCOdbQbcBODsbZm+dDhYzGFiwLz
         2v4w==
X-Gm-Message-State: APjAAAVjW9bc8hQbL9bjWH0bKyo8dZwMihmzPz+AFgQyrGk25/DjKcvD
        VpHMkzJ/aDBX1QkUzT9xQ/w1nTahRrIxGQcvyzE=
X-Google-Smtp-Source: APXvYqzLJ9EmC5C5FvIEJ1CyAUI4KLcua0kk3t5HRvkuQYnAEihajdKHH9lVT8HGznM+fO771PFTOy3b3Gd/R3vurrs=
X-Received: by 2002:a5d:6703:: with SMTP id o3mr5533975wru.335.1567752384937;
 Thu, 05 Sep 2019 23:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190830200900.19668-1-daniel.baluta@nxp.com> <20190906012438.GA17926@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190906012438.GA17926@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 6 Sep 2019 09:46:12 +0300
Message-ID: <CAEnQRZBTc=beU7CX747RsM7KEsJethfZ0fPv=CkLQ1e3ofHMkA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Fix noise when using EDMA
To:     Nicolin Chen <nicoleotsuka@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 4:25 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Aug 30, 2019 at 11:09:00PM +0300, Daniel Baluta wrote:
> > From: Mihai Serban <mihai.serban@nxp.com>
> >
> > EDMA requires the period size to be multiple of maxburst. Otherwise the
> > remaining bytes are not transferred and thus noise is produced.
> >
> > We can handle this issue by adding a constraint on
> > SNDRV_PCM_HW_PARAM_PERIOD_SIZE to be multiple of tx/rx maxburst value.
> >
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
> >  sound/soc/fsl/fsl_sai.h |  1 +
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 728307acab90..fe126029f4e3 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -612,6 +612,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> >                          FSL_SAI_CR3_TRCE_MASK,
> >                          FSL_SAI_CR3_TRCE);
> >
> > +     /*
> > +      * some DMA controllers need period size to be a multiple of
> > +      * tx/rx maxburst
> > +      */
> > +     if (sai->soc_data->use_constraint_period_size)
> > +             snd_pcm_hw_constraint_step(substream->runtime, 0,
> > +                                        SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> > +                                        tx ? sai->dma_params_tx.maxburst :
> > +                                        sai->dma_params_rx.maxburst);
>
> I feel that PERIOD_SIZE could be used for some other cases than
> being related to maxburst....
>
> >  static const struct of_device_id fsl_sai_ids[] = {
> > diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> > index b89b0ca26053..3a3f6f8e5595 100644
> > --- a/sound/soc/fsl/fsl_sai.h
> > +++ b/sound/soc/fsl/fsl_sai.h
> > @@ -157,6 +157,7 @@
> >
> >  struct fsl_sai_soc_data {
> >       bool use_imx_pcm;
> > +     bool use_constraint_period_size;
>
> ....so maybe the soc specific flag here could be something like
>         bool use_edma;
>
> What do you think?

I think your suggestion is a little bit better than what we have. But what if
in the future another DMA controler (not eDMA) will need the same constraint.

Wouldn't it be confusing?
