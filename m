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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016AFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83D42133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uK+xdp1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfHNOTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:19:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53822 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfHNOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:19:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so4749729wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+M3bORKLKAWji4t/1b27E8YGuL0UUMU6Vuc1niTHH0=;
        b=uK+xdp1o9KE1LeGPJ/z5MmXkfhr5zcLEa8laZc/8KAdh8Sls7tHcHWhl6cvtbHt9Jn
         ZSPvgkKd+3FvPDOVl+lmzLlEc4PbLvwPq9p3HuPonaALQyzK06islJp3cEB/ioaxlZwV
         Qe+SLgl2WIAGClCLAnWBZKODFqNZEhHyaeZiLeeOuIan2ExYL2EB439eWPIukCutTxdA
         YTsw9lzlN/M/i2o0bj8DDaNgqSxoaJyQlutpZk0KNEIWbpUMzn4QbbxTK71rsvi1wqI/
         eMptbZWvnoxV98Duh0ItgBbK0AISiy8GB7czONXONMnEqBjjcmzdSdFneBEqIzy2yuAB
         u6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+M3bORKLKAWji4t/1b27E8YGuL0UUMU6Vuc1niTHH0=;
        b=tI0d0KmV+DknlrKegobiaolTaP8owqMMAEo2QTGTU4RLvhAec+KPVyOVTSAsaKKRjj
         eTK68fbS1/4XlTwbV7W37p8G7aJWIXM4fPZ1OiShmnLlRShoH8ooR3ZPlUmtljiPwAzH
         dJX3DoO0AvSvXM2FWy792y5VHJGRx517/cMRNPy6go+Nl/wk1AMuOPCGY9iNEtWp1ufd
         +ctkkZWevEhy4nRNldjKuAaEu1N7zlOZaineGILJJ78dh+OgzBak55wqQOMqYnscH/95
         yhJiviBejcIAEDhuAqCX96CUASkQDcGSQO9YjrA8Ym4ZpHEaWJTuFjRr6C4oj9H9RpMF
         bhPA==
X-Gm-Message-State: APjAAAWfh8i9VOfDNcDNoI/otJhP7fSIiblpNMQuq1//dNdUORENH7c/
        ms/y+wPR6wD/wRNlATTDVKTJdE0+wsAdDXrnXoU=
X-Google-Smtp-Source: APXvYqx4LyqfB/FxgXbLvQzVMEBLPiCgr+Yu5cbHNXgTaMqRhmb/PwuyUUKjbYG20t7oR4dDWKZ3GNyOHOyvXdu4ybg=
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr8121235wmc.87.1565792356275;
 Wed, 14 Aug 2019 07:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190811194517.19314-1-daniel.baluta@nxp.com> <20190814010215.GA13398@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190814010215.GA13398@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 14 Aug 2019 17:19:04 +0300
Message-ID: <CAEnQRZA+G8ZD7JY1b6Bd7wXYzSqnFhye4hEx0zn4ATyTRHJ+uQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Handle slave mode per TX/RX direction
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:01 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Aug 11, 2019 at 10:45:17PM +0300, Daniel Baluta wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> >
> > The SAI interface can be a clock supplier or consumer
> > as a function of stream direction. e.g SAI can be master
> > for Tx and slave for Rx.
> >
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 18 +++++++++---------
> >  sound/soc/fsl/fsl_sai.h |  2 +-
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 4a346fcb5630..69cf3678c859 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -273,18 +273,18 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
>
> This function is called for both TX and RX at the same time from
> fsl_sai_set_dai_fmt() so I don't actually see how it can operate
> in two opposite directions from this change alone. Anything that
> I have missed?

Good catch. I'm missing a patch that updates fmt after the first call
of fsl_sai_set_dai_fmt_tr.
Let me update the patch and resend.
