Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39ECA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64544205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0eRAHdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfJ3Iii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:38:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46091 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfJ3Iii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:38:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id f19so979185pgn.13;
        Wed, 30 Oct 2019 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v2hRD77Xa+8VszcX+WELl2gUUJHpsHwPoC3bm/BbZJM=;
        b=O0eRAHdD3DBS5qT2uOGdJxD2ejyrVV4ujntxZVDXHK2ooTcUnKP/k7bUbI0NaeUM1u
         YdR7lGqW/eh/55fHGUltUpJYU583TNyN5vHE2+2RMDKHOhEJLyHilGDL7KR8Bt4N0iJg
         YXUQQ6iF3vSXDedenuRHCs6BVYYKCd2PAPbJvDtwVLgafZ82mnpo5yazIPYEjo5+0ESQ
         QTvFjFmodYnnwwZzV/mkcPJDMrgCHFfn9yPlsg27NkywsIll1sk0i4eWYlZb+HazgjpP
         1rPrIafhLPFMcndMvBiGq3ANbJxOMBZcimO8VkU0ZFyMePGUEZ1ygvBIM91Ik+Ezq07A
         arCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v2hRD77Xa+8VszcX+WELl2gUUJHpsHwPoC3bm/BbZJM=;
        b=D7lehUO3rdPMBKvnr75hQYZO4rc09yL5Fey1leyCfmP5hBrach4x19OQDT/1J5y7J3
         7uy9d9osRJ5mnUeF9VXIqlGvlsecTK2RrH+jkvwcuVhkBYcFqA+YYVOmgO4bKq7eUT0k
         5+v6/4G3Z6MoEO0CxNUWO9xqMIVexGQBuFue+OWayknpwtu73YPP4HjfBrN+dDPZhcZy
         feEfAOPPTBeymhuMK5nQebh/pnC3W7BNRDNtASt0gotOD+WKzZy5trTBt0NYPJA4swel
         YaByj3NmLq+zoQfRgeuDlSuy1gXgK/KZ6MqOxul3mI+/SBlRGY8vz/bhMJNGUJOCkRPu
         NO1w==
X-Gm-Message-State: APjAAAX9FWUgAwLFZEpoKM4mAkJVm7F6aMa3wK2ABB6SX8nOz7MmtyAS
        MYCcwdCMrHB1P5f+VZQEPQ4=
X-Google-Smtp-Source: APXvYqwahN/PAT9+SXrRtJkw50qD6UZNdHbCE8Z8QKgQmJfmTZRDGvMaddupYSRIAemYyM1TezVClw==
X-Received: by 2002:a65:6713:: with SMTP id u19mr5515149pgf.358.1572424716728;
        Wed, 30 Oct 2019 01:38:36 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id b26sm1617680pfo.179.2019.10.30.01.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 01:38:36 -0700 (PDT)
Date:   Wed, 30 Oct 2019 01:38:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: fsl_asrc: Add support for imx8qm
Message-ID: <20191030083813.GA9924@Asurada>
References: <VE1PR04MB64795758EBC0C898FBFFB3A5E3600@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64795758EBC0C898FBFFB3A5E3600@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 03:20:35AM +0000, S.j. Wang wrote:
> Hi
> 
> > 
> > On Tue, Oct 29, 2019 at 05:17:09PM +0800, Shengjiu Wang wrote:
> > > There are two asrc module in imx8qm, each module has different clock
> > > configuration, and the DMA type is EDMA.
> > >
> > > So in this patch, we define the new clocks, refine the clock map, and
> > > include struct fsl_asrc_soc_data for different soc usage.
> > >
> > > The EDMA channel is fixed with each dma request, one dma request
> > > corresponding to one dma channel. So we need to request dma channel
> > > with dma request of asrc module.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  sound/soc/fsl/fsl_asrc.c     | 91 +++++++++++++++++++++++++++++-------
> > >  sound/soc/fsl/fsl_asrc.h     | 65 +++++++++++++++++++++++++-
> > >  sound/soc/fsl/fsl_asrc_dma.c | 39 ++++++++++++----
> > >  3 files changed, 167 insertions(+), 28 deletions(-)
> > 
> > > diff --git a/sound/soc/fsl/fsl_asrc_dma.c
> > > b/sound/soc/fsl/fsl_asrc_dma.c index d6146de9acd2..dbb07a486504
> > 100644
> > > --- a/sound/soc/fsl/fsl_asrc_dma.c
> > > +++ b/sound/soc/fsl/fsl_asrc_dma.c
> > > @@ -199,19 +199,40 @@ static int fsl_asrc_dma_hw_params(struct
> > > snd_soc_component *component,
> > >
> > >       /* Get DMA request of Back-End */
> > >       tmp_chan = dma_request_slave_channel(dev_be, tx ? "tx" : "rx");
> > > -     tmp_data = tmp_chan->private;
> > > -     pair->dma_data.dma_request = tmp_data->dma_request;
> > > -     dma_release_channel(tmp_chan);
> > > +     /* tmp_chan may be NULL for it is already allocated by Back-End */
> > > +     if (tmp_chan) {
> > > +             tmp_data = tmp_chan->private;
> > > +             if (tmp_data)
> > > +                     pair->dma_data.dma_request =
> > > + tmp_data->dma_request;
> > 
> > If this patch is supposed to add a !tmp_chan case for EDMA, we probably
> > shouldn't mute the !tmp_data case because dma_request will be NULL,
> > although the code previously didn't have a check either. I mean we might
> > need to error-out for !tmp_chan. Or...
> > is this intentional?
> > 
> 
> Yes, intentional. May be we can change to 
> 
>         if (!asrc_priv->soc->use_edma) {
>                 /* Get DMA request of Back-End */
>                 tmp_chan = dma_request_slave_channel(dev_be, tx ? "tx" : "rx");
>                 tmp_data = tmp_chan->private;
>                 pair->dma_data.dma_request = tmp_data->dma_request;
>                 dma_release_channel(tmp_chan);
> 
>                 /* Get DMA request of Front-End */
>                 tmp_chan = fsl_asrc_get_dma_channel(pair, dir);
>                 tmp_data = tmp_chan->private;
>                 pair->dma_data.dma_request2 = tmp_data->dma_request;
>                 pair->dma_data.peripheral_type = tmp_data->peripheral_type;
>                 pair->dma_data.priority = tmp_data->priority;
>                 dma_release_channel(tmp_chan);
>         }

Oh...now I understand..yea, I think this would be better.

Would you please change it in v2?

I am fine with other places, so may add:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
