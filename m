Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A96C47404
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C074C222D3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfJFC6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 22:58:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38688 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJFC6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 22:58:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id m16so8949194oic.5;
        Sat, 05 Oct 2019 19:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWw0lYDY32jNGOFLM6rYC2BSg5ztUuuBTYWobvBXk+4=;
        b=kvt/O56meOHdt6b4RGYX6tXMGFUjD5JRCpBIRBXHGeBrZdC/EwZZ/Pj1Sjtm87WmEW
         +60gNrGrCoX0mej39CtuYAXUhpUN8EZOznj8T7oK5wrGqt0c6wNgoopzCjCeEsRd88ds
         7L/mZNGTKwshI7ZQD+4njHqdokh7Zlat+KPqHUObSBKwsuExbLTGxb+xaGi1TPZOFifZ
         AabV2zRcz+QBZF2G7TnzvFDd7ej5aESBIGfexg8VlJdzYvSNUyDw9RlDGHTu5A+Sp/Zs
         RMf3322V92GOATS4ENuEYUcDAuN8MbsMrgXDECnhQe9RCFwZge+mzbEM8T/9NV2LKveq
         PgDw==
X-Gm-Message-State: APjAAAXjEYUFQPYPS08tledaoV7mpUoIGAAGiIOZJnXrZoFVzhTAgthW
        HzkZ3U7Y6VPOEWLWnPejTSm51qHQ
X-Google-Smtp-Source: APXvYqxlXC5bkYV2zLmGgjRVVrN413H2G7X3Ugq7e0WeMNdnu/kGCmwi3ZCXW4wDSDknVuVMnP4wPQ==
X-Received: by 2002:aca:5443:: with SMTP id i64mr13603069oib.112.1570330704052;
        Sat, 05 Oct 2019 19:58:24 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 21sm3044249oin.26.2019.10.05.19.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 19:58:23 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id i16so8948643oie.4;
        Sat, 05 Oct 2019 19:58:23 -0700 (PDT)
X-Received: by 2002:aca:e005:: with SMTP id x5mr12668230oig.51.1570330703340;
 Sat, 05 Oct 2019 19:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190909090244.42543-1-yinbo.zhu@nxp.com> <20191006025450.GO7150@dragon>
In-Reply-To: <20191006025450.GO7150@dragon>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Sat, 5 Oct 2019 21:58:12 -0500
X-Gmail-Original-Message-ID: <CADRPPNQpGXf8kEGzP3ux7Zxu-Z_ztz6CRdr-B=3hWJdCg8gFFQ@mail.gmail.com>
Message-ID: <CADRPPNQpGXf8kEGzP3ux7Zxu-Z_ztz6CRdr-B=3hWJdCg8gFFQ@mail.gmail.com>
Subject: Re: [PATCH v1] usb: dwc3: enable otg mode for dwc3 usb ip on layerscape
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Yinbo Zhu <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 9:56 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Sep 09, 2019 at 05:02:44PM +0800, Yinbo Zhu wrote:
> > layerscape otg function should be supported HNP SRP and ADP protocol
> > accroing to rm doc, but dwc3 code not realize it and use id pin to
> > detect who is host or device(0 is host 1 is device) this patch is to
> > enable OTG mode on ls1028ardb ls1088ardb and ls1046ardb in dts
> >
> > Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
>
> The patch prefix should be something like: 'arm64: dts: ...'
>
> @Leo, do you agree with the changes?

No.  The USB mode of operation should be defined at board level.

>
> Shawn
>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
> >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 7975519b4f56..5810d0400dbc 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -320,7 +320,7 @@
> >                       compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
> >                       reg = <0x0 0x3110000 0x0 0x10000>;
> >                       interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> > -                     dr_mode = "host";
> > +                     dr_mode = "otg";
> >                       snps,dis_rxdet_inp3_quirk;
> >                       snps,quirk-frame-length-adjustment = <0x20>;
> >                       snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > index b0ef08b090dd..ecce6151b9b0 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > @@ -582,7 +582,7 @@
> >                       compatible = "snps,dwc3";
> >                       reg = <0x0 0x3000000 0x0 0x10000>;
> >                       interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> > -                     dr_mode = "host";
> > +                     dr_mode = "otg";
> >                       snps,quirk-frame-length-adjustment = <0x20>;
> >                       snps,dis_rxdet_inp3_quirk;
> >                       snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > index dacd8cf03a7f..4b5413f7c90c 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > @@ -385,7 +385,7 @@
> >                       compatible = "snps,dwc3";
> >                       reg = <0x0 0x3110000 0x0 0x10000>;
> >                       interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
> > -                     dr_mode = "host";
> > +                     dr_mode = "otg";
> >                       snps,quirk-frame-length-adjustment = <0x20>;
> >                       snps,dis_rxdet_inp3_quirk;
> >                       status = "disabled";
> > --
> > 2.17.1
> >
