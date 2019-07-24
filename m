Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD53C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B3F217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKSuVhkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfGXI6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:58:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42202 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfGXI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:58:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so31054883wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RGbZm1eciu20PQ8K6tF6H+QNRIWNrVYIPAsS3IZOGw=;
        b=gKSuVhkAPXEHjSfyv7hCFaAwcimAC12QQb//SoVNMVfDYgdlJh0/u6za13CaJi1KNK
         Yhe88wKGs1Fbw0gsRtEV6VwOjTePgaWP/LBYhE4HSiflOGU6ocw7DnSkFBw1tJ2s0VSx
         tEydSi1ZE1R1YiURro6utx0GyKHQRRMB0pLSWCLDMj9Qyx6eY+pyAW1J5EfnmGFYg3bF
         SrnWQ9tzbl4Kj2f79Yhig7nDPqX6Dnvre4xtHcPQyGLjuYeL78NLKifDFMaFaJUSHVOw
         RK/dqeONWggH88EXgWfSIM15ssSrMYL82V7or3/mdcA2sb8ZPv5NlG+UwtSmYOB0Mxhd
         bZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RGbZm1eciu20PQ8K6tF6H+QNRIWNrVYIPAsS3IZOGw=;
        b=IfnI6dnzm5hWJo4RPWYH2F33/mzgISqe23DPkPhiRTvl8lo7uf3pE6Ql9YYyurBSYl
         kHDKrWBqSO8gmRoEuS/99s8Nf2ogOJOuMfLvpnRdIWxNT8m4mdCbaxSN3l+yFlDb3Hy5
         kd8ZG5zq3WBbYd2QYdhp9g/UEwzvv8+/6L6+4Bnbk3OA89/rS/7MF443Qkpif2sCtwX7
         obgETlsC4k832RghNfMutLm1naefz+qQvPy7ZBYdlGFDQxVPruhGeAesIuMgNbdCxs9F
         IOiAGpPYZN02BRw0DjAmRPj+kbgcSpx93PC7GfJ9HU4i8qQYX2bUHL+qe9R3nEZcmNHm
         6vOQ==
X-Gm-Message-State: APjAAAVbeS1Ae+8gp0f3f3RByQ31I7skOwsK01IIgv9gZhg9Q4FBZY9t
        LLLgokraXGHFk8O56svZkEjBnI+oPt/k/UK3mUo=
X-Google-Smtp-Source: APXvYqyPfV+wRoNminVBPIYU0k3mTByronNa0d5GsaFz0875MLgxFgsfvzSD0QjUkklYPTRcf4r/DD3UHxMnXvpGh2w=
X-Received: by 2002:adf:db46:: with SMTP id f6mr35916182wrj.212.1563958695456;
 Wed, 24 Jul 2019 01:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-6-daniel.baluta@nxp.com>
 <1563800148.2311.9.camel@pengutronix.de>
In-Reply-To: <1563800148.2311.9.camel@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 24 Jul 2019 11:58:04 +0300
Message-ID: <CAEnQRZB+g0pmv_Kkf37Vj_Ln_gPSc6cq77yAZQQ+9yUzhhMT5A@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 05/10] ASoC: fsl_sai: Add support to enable
 multiple data lines
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:58 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Montag, den 22.07.2019, 15:48 +0300 schrieb Daniel Baluta:
> > SAI supports up to 8 Rx/Tx data lines which can be enabled
> > using TCE/RCE bits of TCR3/RCR3 registers.
> >
> > Data lines to be enabled are read from DT fsl,dl_mask property.
> > By default (if no DT entry is provided) only data line 0 is enabled.
> >
> > Note:
> > We can only enable consecutive data lines starting with data line #0.
>
> Why is the property a bitmask then? To me this sounds like we want to
> have the number of lanes in the DT and convert to the bitmask inside
> the driver.

Actually my comment might be wrong. I have read the documentation again
and it seems that: We can only enable consecutive data lines
*ONLY* if combine mode is enabled.

Thus, if combine mode is disabled we can independently enable any data
line. I will clarify this with IP owner and correct the patch accordingly.

>
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 10 +++++++++-
> >  sound/soc/fsl/fsl_sai.h |  6 ++++--
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 768341608695..d0fa02188b7c 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -601,7 +601,7 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> >
> > >     regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> > >                        FSL_SAI_CR3_TRCE_MASK,
> > > -                      FSL_SAI_CR3_TRCE);
> > > +                      FSL_SAI_CR3_TRCE(sai->soc_data->dl_mask[tx]);
> >
> > >     ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
> > >                     SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
> > @@ -887,6 +887,14 @@ static int fsl_sai_probe(struct platform_device *pdev)
> > >             }
> > >     }
> >
> > > +   /* active data lines mask for TX/RX, defaults to 1 (only the first
> > > +    * data line is enabled
> > +      */
>
> Comment style not in line with Linux coding style.

Will fix. Thanks Lucas for review.
Should be like this, right?
/*
 * comment
 */

checkpatch.pl warned me only about the end of the comment :).
