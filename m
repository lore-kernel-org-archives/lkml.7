Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E081C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD4420856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjDMGaLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfGYGCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:02:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35230 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfGYGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:02:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so49336325wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pU+mAWOKuT+1icWHPxBVuENuKDz0OQKOsIOlqLtN9d4=;
        b=tjDMGaLuEFwmnP5PNPyUU25EqT5kbEnRrw6KDGkV6Gb97e+iP5mC5KKgA/9r+l4VJf
         VzlSPmG+ybqde7hYfyiy8wQ15slKfYBqHc8co2TKeF5bNk29sNEiSCuIxIe8RmiMtckl
         ruT832weiB0FIxU08Z056Z5OTH0fbtYlNsfC7zBvhggV2X5Cd6Ep4w2ty6eTQo4qn6Mw
         TNoqdzn/0fNab2feocd7K0N9ekjF4zwAVTIa2IzxaUhlUDE4lTANZnmzQaFqbd3IWljy
         88lR2KUYkwMOQS6i3w+XqHHBBQE7raT55qqJKS5V4zfYicQPto5wOsmF4FiwyV1MUQs2
         Di8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pU+mAWOKuT+1icWHPxBVuENuKDz0OQKOsIOlqLtN9d4=;
        b=K2/UnPU4iKjUdv/rPfDCMllUjdwPwnJcm4r6zITz3CLP68stvevL4yEVO7PZeHwJPT
         LzyqVP1x1pRhp7Rcj3jOxwyVp6ljTKP5PKatrGYj0QHos3JdfjnoGjh4bQJEXuKpnvgL
         NxZKaxhZt5EYMRZzJp9LxxT1aUtulq/ZZkmqAwQoai0D4XAnfX/zuFvbn7b+p2JVFIiy
         cy4iYwF7L6XcMKndRNBbNkPT1RegyP0JEvTalBbx1+7G14A1Z3G4DA7W1yeRJxV8FIkw
         sIuQQ1n5JCjsUc9pJ5xsTEPAORKKKrOf8Vjdsn8NpYEMVQF/Ec2UdMlNvmPYM6Lzyp0r
         oDIA==
X-Gm-Message-State: APjAAAWOxObIp8sNjCqygvUIidzM0I6iLK2A4Olblig/Qy/86VO50ySg
        fxW3ZWPPAiaMcVTrfn1FPFzL2qmtuu63NG3Ar3c=
X-Google-Smtp-Source: APXvYqyyHKiyF0F/r/FwIu7Qxo19mAVSEFeS5FNJ3bM5+0ZtoFzpwVF+0XlzchviCc8j+UG6zqtZKP7V/9kKChSpYiA=
X-Received: by 2002:adf:c70e:: with SMTP id k14mr95081636wrg.201.1564034554176;
 Wed, 24 Jul 2019 23:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-9-daniel.baluta@nxp.com>
 <20190724232209.GC6859@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190724232209.GC6859@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 25 Jul 2019 09:02:22 +0300
Message-ID: <CAEnQRZBW7LNZ7=c_h_ef4ZDcbFzEt61h4VAJSLo2Fb80kBqtpw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 08/10] ASoC: dt-bindings: Document fcomb_mode property
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 2:22 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:31PM +0300, Daniel Baluta wrote:
> > This allows combining multiple-data-line FIFOs into a
> > single-data-line FIFO.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++++
>
> This should be sent to devicetree mail-list also.
>
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > index 59f4d965a5fb..ca27afd840ba 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > @@ -54,6 +54,10 @@ Optional properties:
> >                         represents first data line, bit 1 represents second
> >                         data line and so on. Data line is enabled if
> >                         corresponding bit is set to 1.
> > +  - fsl,fcomb_mode   : list of two integers (first for RX, second for TX)
> > +                       representing FIFO combine mode. Possible values for
> > +                       combined mode are: 0 - disabled, 1 - Rx/Tx from shift
> > +                       registers, 2 - Rx/Tx by software, 3 - both.
>
> Looks like a software configuration to me, instead of a device
> property. Is this configurable by user case, or hard-coded by
> SoC/hardware design?

Indeed this is a software configuration and configurable by user case.
Will think of a another way to specify it.
