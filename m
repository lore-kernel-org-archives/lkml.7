Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D12C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7135D20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZMvf6fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfC1IyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:54:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43380 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfC1IyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:54:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id d26so16452823ede.10;
        Thu, 28 Mar 2019 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46Byn9ex+ViYUukfUFDLIOxP1MiEtq1L0dVm0v4e4xM=;
        b=HZMvf6fjfdIMXS4z1LgasrrD+T9XFThM55vD5St0rMGkT59Y6ubEcqLDT0mJoE5ZPI
         /8eg3Lr3Cru772jvLBouA1WSfyStR/rR/v6ylBPHWY2oPiT4ts4Ma11VLnenvQJwul4z
         H9woc8qboAnjcVqwEd269LZ29tjpFZK9ISASSuz2Og9VST2bwEszkazxEQMhVZpg4gGO
         qT6m1TmNAgqsTJjz8CiHdBrDU1XAVXsF2sAuLlGdyZh1fWm8Cz8IM9Yh8rIxkYXmEcF+
         2FEB4InIYQKf9r3csk/KZAUkp/dzGFYCXMknA8ctZ3lPKkx/SgIECItuOoiBhCiXHzLO
         GitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46Byn9ex+ViYUukfUFDLIOxP1MiEtq1L0dVm0v4e4xM=;
        b=a7kMbPlWWXzsCq7aKQg2l58KgwGvbeP9YIYfpA34ls0Tg9+E3Dl4RHkyV/bHbs2WJk
         nUIdCJ4tGfKTpT3eRDT4v7k0rAbx7Z/mJsGRfkyV8+NP778d91xpDh6koDH+r9ULrMCI
         ylzmVCYG/slBYc4m9nyLxKeZ+b4wbwozHxWyTU3o6XaHE8xk94sDl7+GaMREI9KRUitl
         vam3cnOQSxoIRC2G9uuG1zMUZkVXI0Px92GPTp6hgeqwVeEUTinFEYvQHpGDmW9102F0
         flxY05MwIBRv/RoUh5xqaGEmSV6d2TGEgXc049jypBHgW4eFaPmaopeIYpvAACVhk+LI
         naMA==
X-Gm-Message-State: APjAAAU4dh8V/pUa6wuhhi4bmbs476DoUyS/CfzIhqDV2IPwa02nF7BM
        8eY+mPG13KNYew13d9PWQ9DYvg2Sbff13VIkzQdJ2axQ
X-Google-Smtp-Source: APXvYqx4nv0AlBHRExf5Bp5KVImfc2N+HjdduRzlT3LqlT7XceJ3OmKHb52aCJ7ErJ7SPiS6EicvELpcBkefOv9XkbE=
X-Received: by 2002:a50:b615:: with SMTP id b21mr27194936ede.175.1553763251645;
 Thu, 28 Mar 2019 01:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190327190244.9208-1-daniel.baluta@nxp.com> <20190327190244.9208-3-daniel.baluta@nxp.com>
 <AM0PR04MB4211B89650EA1AC9133F4EBE80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211B89650EA1AC9133F4EBE80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 28 Mar 2019 10:53:59 +0200
Message-ID: <CAEnQRZB8f4rHhsUoefKUB6PN_aRPtSB4y8O_D8N0_s-Zq0_8Vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
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
        Teo Hall <teo.hall@nxp.com>, yibin.gong@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 4:32 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > From: Daniel Baluta
> > Sent: Thursday, March 28, 2019 3:03 AM
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
> > index 0cb939861a60..84c7c3eca1a1 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -182,6 +182,78 @@
> >                       #clock-cells = <1>;
> >               };
> >
> > +             edma0: dma-controller@591f0000 {
> > +                     compatible = "fsl,imx8qxp-edma";
> > +                     reg = <0x59200000 0x10000>,   /* asrc0 pair A input req */
> > +                             <0x59210000 0x10000>, /* asrc0 pair B input req */
> > +                             <0x59220000 0x10000>, /* asrc0 pair C input req */
> > +                             <0x59230000 0x10000>, /* asrc0 pair A output req */
> > +                             <0x59240000 0x10000>, /* asrc0 pair B output req */
> > +                             <0x59250000 0x10000>, /* asrc0 pair C output req */
> > +                             <0x59260000 0x10000>, /* esai0 rx */
> > +                             <0x59270000 0x10000>, /* esai0 tx */
> > +                             <0x59280000 0x10000>, /* spdif0 rx */
> > +                             <0x59290000 0x10000>, /* spdif0 tx */
> > +                             <0x592c0000 0x10000>, /* sai0 rx */
> > +                             <0x592d0000 0x10000>, /* sai0 tx */
> > +                             <0x592e0000 0x10000>, /* sai1 rx */
> > +                             <0x592f0000 0x10000>, /* sai1 tx */
> > +                     #dma-cells = <3>;
>
> In binding doc, it's 2.
> - #dma-cells : Must be <2>.
>         The 1st cell specifies the DMAMUX(0 for DMAMUX0 and 1 for DMAMUX1).
>         Specific request source can only be multiplexed by specific channels
>         group called DMAMUX.
>         The 2nd cell specifies the request source(slot) ID.
>
> Need update binding doc?
>
> > +                     shared-interrupt;
>
> Undocumented property?
>
> Checkpatch did not complain?

Thanks Aisheng for this comment. I think we might need to delay a little bit
this patch because (as pointed by Yibin) on i.MX8 QXP/QM we use
fsl-edma-v3 which *is not* yet upstream.

So, lets get back to adding the nodes after Yibin sends edma-v3 patches.

thanks,
Daniel.
