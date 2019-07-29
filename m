Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B010C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D162054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD+gjh4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404173AbfG2T57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:57:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52269 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403935AbfG2T55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:57:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so54931521wms.2;
        Mon, 29 Jul 2019 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfwOpTwqZt49gcWcX/gOxX/yJSmjfwNU2FDs49FnjdU=;
        b=TD+gjh4HFlm0ryoYWHp2SaDQah1BRcGLs588Xg5onWMF/bFCKo3gCcdRjrR7eJMGGm
         VmcPlqWbkKDwrNUh8zlIIYwZuaqfpnpqWXjC8N6f75TNoXUh/j8p0eVt74oBk9ZkZzex
         V1n1HFIE5C4nzA0H7fSPUkflCg8AXut9D8Lsz7PQtKKWqAGP/SYjsEEYFVKlB4P3b48l
         JzQBi3aOTso7ySB63JP0g6QRApO4sA8wRcRzVJ+dusjlz0zUXgelfZtRDojl6kV4tQq5
         RW4HpdbdEqTyFkh6/NLcZF5YWo+AKMq41dRNm/3LgVvXde/R9xBeyIFdwVd7yeAVr1kn
         cTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfwOpTwqZt49gcWcX/gOxX/yJSmjfwNU2FDs49FnjdU=;
        b=QvMhsH99VWImXT0zK/nGlcg71Fvhmj2yrdCnaxFmadFUIkXIvnG3vxf9OHFJK+5Zst
         mji6ys3wAkcjpiEo36+1eDEMKEsiuxN92BDgHOAFBDYNPmUFctdZTUt16hixpSI9HtLg
         N7xk+dTcdA0SQcvdgPmpdB051YH27DPrUPVliN/+yhoha+aj8Mh4IxWPjfHMGOUKRYD6
         poNUGGB19SkN0FBzYMdRuuheJJGveobB1/IkCO2ejDc/2I6lD6q2NMJ6pflmbA2uX8mi
         2J0Cs3SNm9Aij8nDhYvUiEPHdS2W4ahiuB1rOI9OWfipUAVH3/33oNZ8JaTOwXYiGS4F
         iAdw==
X-Gm-Message-State: APjAAAU7dHr7frLd170bUg/SmtA1JGCLAG52fLwCDydbodrT233vdeT/
        /UY5KuIciI9G5+jJ0Z69liH7xtRnjvBhcnXA02M=
X-Google-Smtp-Source: APXvYqyUnyRnpAsu1OzTd7PhLaMC/PpuGRUfvRCL/EifxjOUfhsRaKfdERpgUk7nBbCW+1wTl53GQRoL34cSuARJCfQ=
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr93249558wmd.87.1564430274987;
 Mon, 29 Jul 2019 12:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-2-daniel.baluta@nxp.com>
 <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 29 Jul 2019 22:57:43 +0300
Message-ID: <CAEnQRZDmnAmgUkRGv3V5S7b5EnYTd2BO5NFuME2CfGb1=nAHzQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/7] ASoC: fsl_sai: Add registers
 definition for multiple datalines
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mihai Serban <mihai.serban@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Jul 28, 2019 at 10:24:23PM +0300, Daniel Baluta wrote:
> > SAI IP supports up to 8 data lines. The configuration of
> > supported number of data lines is decided at SoC integration
> > time.
> >
> > This patch adds definitions for all related data TX/RX registers:
> >       * TDR0..7, Transmit data register
> >       * TFR0..7, Transmit FIFO register
> >       * RDR0..7, Receive data register
> >       * RFR0..7, Receive FIFO register
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 76 +++++++++++++++++++++++++++++++++++------
> >  sound/soc/fsl/fsl_sai.h | 36 ++++++++++++++++---
> >  2 files changed, 98 insertions(+), 14 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 6d3c6c8d50ce..17b0aff4ee8b 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
>
> > @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
> >       case FSL_SAI_TCR3:
> >       case FSL_SAI_TCR4:
> >       case FSL_SAI_TCR5:
> > -     case FSL_SAI_TFR:
> > +     case FSL_SAI_TFR0:
> > +     case FSL_SAI_TFR1:
> > +     case FSL_SAI_TFR2:
> > +     case FSL_SAI_TFR3:
> > +     case FSL_SAI_TFR4:
> > +     case FSL_SAI_TFR5:
> > +     case FSL_SAI_TFR6:
> > +     case FSL_SAI_TFR7:
> >       case FSL_SAI_TMR:
> >       case FSL_SAI_RCSR:
> >       case FSL_SAI_RCR1:
>
> A tricky thing here is that those SAI instances on older SoC don't
> support multi data lines physically, while seemly having registers
> pre-defined. So your change doesn't sound doing anything wrong to
> them at all, I am still wondering if it is necessary to apply them
> to newer compatible only though, as for older compatibles of SAI,
> these registers would be useless and confusing if being exposed.
>
> What do you think?

Yes, I thought about this too. But, I tried to keep the code as short
as possible and technically it is not wrong. When 1 data line is supported
for example application will only care about TDR0, TFR0, etc.
