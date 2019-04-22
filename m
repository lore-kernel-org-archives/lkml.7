Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A48C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9518206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVH7IQE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDVL0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:26:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37704 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfDVL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:26:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id f53so9220885ede.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmcqzRYJAi/8nreTg3ExaX3WI1tolmLmFrA1haHMPCc=;
        b=OVH7IQE72/Lxb/raIh9iz3EUtHdzRTrMTptkZpSLGfwG+4tPB5uA4TB6zZR3/eLmNt
         SpzQj+6Fp1GAbEr+c+2DRn6b0kO9A6471NqIEBAYcURpqdE3pXfkKpCC0O2ULL5dqKeo
         ou9ZEXEbc7vhLo9QI7PEO1ychtmNuiT2+9h8Alv/qWFQN2McYXUlLPAutbirsnJEkKuO
         mV/aoM7NxbfM+7w/Gg7//tQg1IhGd0pJmkD22dY1DY4DdAxDtj0AKPabEK+hWJUiJIXM
         MVv1XuTIJy+lM2Eyv6B2eS6ETgQ4ydt1wsF8SUWl/joYEt+eOanH5JiCFDPs475CcJK5
         Gz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmcqzRYJAi/8nreTg3ExaX3WI1tolmLmFrA1haHMPCc=;
        b=DM6fOH/0A5+O6xRhBIRS4ClDWekDLMu2SSHllDT1Ii55wLqNVJoIiCFpkpCsd/dQHS
         IuYEgURDFzVHWriCMYwl7AYIGUXg5RRCi7HjqNvOD+BBj1kwsjCHLpZ5efZDuSw7tgRU
         jtqOYlJGqUGBVy0y0lS/BMl/03jy7Q8w4TdYjVRYBuRD1WSbxh29P/WC00l2IF/r8AHG
         FAt1zLlQsmnsy8rwaLquPCseCJieZhejEANNMx2ss+D6Z+QKQSAKEaJJ3Wp3XrMObJJi
         odo3VZN1l6Xhi1t4FMeGJk3gQfcv6MdB1fruDfebj0nuD6YpAhDZ7LIgmIa33Wzsr+fQ
         grvg==
X-Gm-Message-State: APjAAAVJWKbKjMTMZINnTd0JYgcVvd/6iR1y0CbiOoPZzk7TvaOSjT+Y
        AckOZn5yNPIXMbno5CdK9a2WRdppHfNuVG8UMlg=
X-Google-Smtp-Source: APXvYqy+0/Gu+egkjtx6yfKhgY1pNM+p9HvFgtY4K03YPIg3byruhJvQb671K2g83yWNUrkbPxkh4Zcjn19oQNrSAMc=
X-Received: by 2002:a05:6402:552:: with SMTP id i18mr2605656edx.67.1555932371386;
 Mon, 22 Apr 2019 04:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190421193853.10188-1-daniel.baluta@nxp.com> <20190421193853.10188-4-daniel.baluta@nxp.com>
 <1555931172.31656.6.camel@nxp.com>
In-Reply-To: <1555931172.31656.6.camel@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 22 Apr 2019 14:25:59 +0300
Message-ID: <CAEnQRZBrpD=mG7JmSFYVarv05hHHgApEDYNu9x2GLHO1NEvRiw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/3 v3] ASoC: fsl_sai: Move clock operation
 to PM runtime
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 2:07 PM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Hi Daniel,
>
> On Du, 2019-04-21 at 19:39 +0000, Daniel Baluta wrote:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > Turn off/on clocks when device enters suspend/resume. This
> > can help saving power.
> >
> > As a further optimization, we turn off/on mclk only when SAI
> > is in master mode because otherwise mclk is externally provided.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 60 ++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 50 insertions(+), 10 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 8623b7f882b9..13a462360ed3 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -596,15 +596,8 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> >  {
> >       struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> >       bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> > -     struct device *dev = &sai->pdev->dev;
> >       int ret;
> >
> > -     ret = clk_prepare_enable(sai->bus_clk);
> > -     if (ret) {
> > -             dev_err(dev, "failed to enable bus clock: %d\n", ret);
> > -             return ret;
> > -     }
> > -
> >       regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
> >                          FSL_SAI_CR3_TRCE);
> >
> > @@ -621,8 +614,6 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
> >       bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> >
> >       regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE, 0);
> > -
> > -     clk_disable_unprepare(sai->bus_clk);
> >  }
> >
> >  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> > @@ -932,6 +923,16 @@ static int fsl_sai_runtime_suspend(struct device *dev)
> >  {
> >       struct fsl_sai *sai = dev_get_drvdata(dev);
> >
> > +     if (!sai->is_slave_mode) {
> This check is redundant as the bits in sai->mclk_streams are set/unset for master
> mode only, please check fsl_sai_hw_params and fsl_sai_hw_free functions.

Hi Viorel,

I think you make a very good point here. Will fix and send v3.

Thanks!
