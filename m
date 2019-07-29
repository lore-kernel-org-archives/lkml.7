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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81237C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE2020679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE5wQkOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfG2U1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:27:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54529 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG2U1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:27:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so54990878wme.4;
        Mon, 29 Jul 2019 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBY1KbZOnMvZrZHmdH2FrpwIL93ExhkFfwDFt85kHsI=;
        b=IE5wQkOHnUoztkMpJoQ2nn1zzhDvX5O97XUsPLi2aDMdVW+n+layGvyv6MI3mNPOpp
         ZAJMazltzWyWYKegr6OGfe3uxyJmHEHpZ4E+9wJTnNxnB/UaCWJHPDmU7r8dUsxi9EE4
         n8ra8Z/eVyvZ4upnCQ+YSxREA5nB4Np1YDoUlVWuLsr2ZAwyZpDhuUKg9soY3VrtbYcY
         YfDx8oMBTIl2q/QzwFto3oNayCEXD4ib7J052e93WO3LCIntgBRZF7ZGNLU3a2imXmSi
         yj3LbFX7yXoGiSMT9MDTahHz7WBnGesQVGct1FzZtJ3dQlCDDFfPqsInFvTiQkzt6qBm
         4gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBY1KbZOnMvZrZHmdH2FrpwIL93ExhkFfwDFt85kHsI=;
        b=jUQOOHGsR30IDdl1pWENj4d4WWyDpk1/WKVibyFUH49AV/XjUm0XUZNaM0jX6r2jON
         LNGjOl/3CJUFETnV+9vXhlwxTohox25pJPT8hopL0fihXRsVZgmRp6Ts8zkXPNaY8JTz
         VVJjdG9M1W7fVHfD19L8ln10IEks751Fn+NOG9wpbDTE5GJ0JP4oM9o3KxXkm2NP+ZeM
         2/04z8svEDdmL5TPPKcj9+GiXL7w2gpwazpynQHt5r1YBsLOVB6wCKKHJY8H8piG3+cX
         CeQ+0Vwyvpt2SovBDSR2Qlh6r5iUh1Mg/4L5Wxr41fJkV3OkHdPLjRK7l9Kx1IzAAXHq
         LMag==
X-Gm-Message-State: APjAAAWkyrjQqpC2+PHme+bwvD2Sc2oTqFJ6cVSJTX7yXmNFvdk5HVzh
        +liV3nOgIrqFO2DIV6vvGfHBaSeAv5BAfQDtfn0=
X-Google-Smtp-Source: APXvYqxXecdIIZhY5Beq3TXPDd+pnZWkNdeBaugff95dcv/OvRG57PB34sVze96jsSmVe3AVrs6vnWFMTEzHAb47VFA=
X-Received: by 2002:a1c:18d:: with SMTP id 135mr100779974wmb.171.1564432048929;
 Mon, 29 Jul 2019 13:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-5-daniel.baluta@nxp.com>
 <20190729201508.GB20594@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190729201508.GB20594@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 29 Jul 2019 23:27:17 +0300
Message-ID: <CAEnQRZCxi9Jo_-MrHaLarX_6uiKaSmJuVgRSA23P+vE305jAuA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Document dl-mask property
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:15 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Jul 28, 2019 at 10:24:26PM +0300, Daniel Baluta wrote:
> > SAI supports up to 8 data lines. This property let the user
> > configure how many data lines should be used per transfer
> > direction (Tx/Rx).
>
> This sounds a bit less persuasive to me as we are adding a
> DT property that's used to describe a hardware connections
> and it would be probably better to mention that the mapping
> between the mask and the data lines could be more flexible
> than consecutive active data lines as you said previously.
>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > index 2e726b983845..2b38036a4883 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > @@ -49,6 +49,13 @@ Optional properties:
> >
> >    - big-endian               : Boolean property, required if all the SAI
> >                         registers are big-endian rather than little-endian.
> > +  - fsl,dl-mask              : list of two integers (bitmask, first for RX, second
>
> I am leaving this naming to DT maintainer.
>
> > +                       for TX) representing enabled datalines. Bit 0
> > +                       represents first data line, bit 1 represents second
> > +                       data line and so on. Data line is enabled if
> > +                       corresponding bit is set to 1. By default, if property
> > +                       not present, only dataline 0 is enabled for both
> > +                       directions.
>
> To make this patch more convincing, could we add an example
> as well in the Example section of this binding file? Like:
>         /* RX data lines 0/1 and TX data lines 0/2 are connected */
>         fsl,dl-mask = <0x3 0x5>;

Sure, will add an example.
