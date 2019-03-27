Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ECD2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8i0UaMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbfC0Ivl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:51:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37930 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfC0Ivk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:51:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id q14so13246810edr.5;
        Wed, 27 Mar 2019 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/XQxAuhgKLd5prKMJwqk8HEKiHyTEH02WMFD0lVrj8=;
        b=o8i0UaMaXT5JkTOhMI7/imRX0rl9+IJbJPqrt4QhXXyaWw9eNT+y2x5z2vY38th2/D
         oLyDFPGt9dKnPPlC/97euM4cTqSuQjkNd8+mHu/9nb70m7R+R3GOdx4D6yvlrn4CEQP1
         /ERO9imJt9UAJZTk2BCl3hjkDH/qM2rq+LCJIyKCbIYYhbofsTc8OTmT+Pn/81ZcDdK5
         p5Q7iEk0y5E7jDmtsoN/1n/sGk/u9Mf/Y3pAnZNtlVB9SoJC6X5NAN2aF6HH2WUW8FHI
         8qGVK1d5QjBVu39VjeNgc6kRGYOW/jzfkTJMMLgITFJApmjadXrCOiUw9xxv3XNZvxwo
         XXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/XQxAuhgKLd5prKMJwqk8HEKiHyTEH02WMFD0lVrj8=;
        b=qyB3cuFj7VMUcWuIyyRFdWQcYDhGDvb55/IHj8nPhoajlfgC7Sg0rNG0Ejw2SbQLqX
         aLXcTc1YUkKQ157/vNwgljIhWP60yPkzb6VlkVy778boIsKsp3xohO6n3ldd9+4DHeFR
         R9URUzIe3Vhbu+2Vw1JxYNqLhismxB0wd89m4ks6Qmr1DsDryYBkD3hZqqf028Ph30S+
         5rjJSTb+68GofTwYm3Mw9KdigXWcAZmCsUOpOw2ojGWDdvonHFKXDfn8EvHbXiY++kRf
         URmm7pmj/4kJKA1lcc80zyyeWkFOo8gs89I7j563/FVgMwDw/C7tCcsTjSJ/Byt6mJY1
         ggsw==
X-Gm-Message-State: APjAAAVvXWWQJ1Zyryq2GfKI/VJJ+G6FfSAH7AmWl53EE2rafRkDuEJP
        J9T/eciKVH12TTFdhpE85tNIEZosSvzm5+VtuoU=
X-Google-Smtp-Source: APXvYqxY7xcWVwtavxvvgnYvYDMFHg2odjqBehYQGaPHFoK/ScEeF139z4Xo+H2i9tcDZpABVlBiOP99ySVhA9ZwkCA=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr23090460edc.67.1553676698981;
 Wed, 27 Mar 2019 01:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190326094239.5910-1-daniel.baluta@nxp.com> <20190326094239.5910-3-daniel.baluta@nxp.com>
 <VI1PR04MB4222A8DBC2312E72AAD3AFAE805F0@VI1PR04MB4222.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4222A8DBC2312E72AAD3AFAE805F0@VI1PR04MB4222.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 27 Mar 2019 10:51:22 +0200
Message-ID: <CAEnQRZCb=rZMdBYyYCSCQ3Dba5Nk43BvV6whHx-vNPmox-OOSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Teo Hall <teo.hall@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 3:31 PM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > From: Daniel Baluta
> > Sent: Tuesday, March 26, 2019 5:43 PM
> >
> > i.MX8QXP contains a total of 4 EDMA controllers of which two are primarily
> > for audio components and the other two are for non-audio periperhals.
> >
> > This patch adds the EDMA0/EDMA1 nodes used by audio peripherals.
> >
> > EDMA0 contains channels for:
> >       * ASRC0
> >       * ESAI0
> >       * SPDIF0
> >       * SAI0, SAI1, SAI2, SAI3
> >
> > EDMA1 contains channels for:
> >       * ASRC1
> >       * SAI4, SAI5
> >
> > See chapter Audio DMA Memory Maps (2.2.3) from i.MX8QXP RM [1]
> >
> > This patch is based on the dtsi file initially submitted by Teo Hall in i.MX NXP
> > internal tree.
> >
> > [1] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
> >
> > Cc: Teo Hall <teo.hall@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 72
> > ++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > index 0cb939861a60..9e959deb2499 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -182,6 +182,78 @@
> >                       #clock-cells = <1>;
> >               };
> >
> > +             edma0: dma-controller@591f0000 {
> > +                     compatible = "fsl,imx8qm-edma";

Thanks for the comment Aisheng!

>
> Should this be "fsl,imx8qxp-edma"?

Yes, I think that's the more clear approach although in
our internal tree the edma driver uses only the "fsl,imx8qm-edma
compatible.

I will go with your suggestion.


> or
> "fsl,imx8qxp-edma", "fsl,imx8qm-edma"?

One thing that it is not clear for me is why there are places
where we use two compatible strings?

I understand the situation where are two distinct drivers, but is there
any other reason to add multiple compatible strings for a node in dts?

thanks,
Daniel.
