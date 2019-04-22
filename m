Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74C0C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964AA20811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlTmgH93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfDVGvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:51:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42489 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:51:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id u23so8421265eds.9;
        Sun, 21 Apr 2019 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+t6Q7fv81q+1B4hKSJz2wKQkCSzBAWUA+nqXWE510k=;
        b=WlTmgH93xgNZyGjRMWLMeq5JFm6qOJ1+EQGMAqyUTWeTko4HZZ2SlSkLlGHAL0myC7
         P6DIxalNvNkxq1/wFMLiAD62wfHaO4d7SYEtqtYQVXXasfE56dsqkPwTETyUIpPZJq2x
         VrKzl+6gpAVa9QUkV0Px3jZrXN1up3aLTQx+TuiuaV/LBiKlRQVLp6DKLMoaVvx5ma2y
         d3df2HO6CR+16aX7+/t6rbh5T3K9rv/CctV8RosS4hXCVCn6rNMMI0epV9CJiabaUsCC
         uPWZdUufN3e97bIXiwYVcat9vx4krRAuaehaOTjqTbgMYh0cgfY5adcjhHWQWcLt/wn1
         rfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+t6Q7fv81q+1B4hKSJz2wKQkCSzBAWUA+nqXWE510k=;
        b=T1SS+SGIw5zvADSU0ot20RsRSWT+CEVpDqU3cF8U6hGlfN8bC/VbNrTSYAf7NW6vjC
         9QgLBelCRGGPc0GZUB3+OkN6M3t7xN0tIYgybi6FDLP0Sy26yCTKh+iHKrQeHRZiWUwf
         EYKS2OqLEfqjwuIMKBhOOUvoIEQRNvelk8Xsxfn2Y8cVuWHOD77wDv+wm8x7mJp4m2Pf
         RJVPXM4lY8ksujbmyNlcU+F1D6fLdXARE+ell0ezCYX/v4FA4Cqx0OmxqEzKbYFycNhK
         aDx4diYTEi6dGaLmKrqZFbJAmmSVcfSuMVjo1nr9m1xuZIdzPK9Z/XSiZueNFltTJRXk
         GA8A==
X-Gm-Message-State: APjAAAU0Mx1tZMK/BE+3Agb/Uy80Cr2P2YsdCGKS1+8VhNBGnWfed9NQ
        fJ+TaDfhtSCVTueLgR2kNa9X+SspcNVl4NmCNlQ=
X-Google-Smtp-Source: APXvYqw1ks30fRtbavq0DpgvODh4Dgq3yMNWfoBqiSg7l1CpOQwRJxFBgsi9f15XrbdY5Om+dyx/VeyM1pTA5QDbMjY=
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr8860352eju.14.1555915909183;
 Sun, 21 Apr 2019 23:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190419202024.27314-1-daniel.baluta@nxp.com> <20190419202024.27314-2-daniel.baluta@nxp.com>
 <20190422024427.GU19962@dragon>
In-Reply-To: <20190422024427.GU19962@dragon>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 22 Apr 2019 09:51:37 +0300
Message-ID: <CAEnQRZAA9_Worz8taLC_zWanx2vdujb8YWqi+1VV99bRTueWow@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Add SAI nodes
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 5:45 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Apr 19, 2019 at 08:20:39PM +0000, Daniel Baluta wrote:
> > i.MX8MM has 5 SAI instances with the following base
> > addresses according to RM.
> >
> > SAI1 base address: 3001_0000h
> > SAI2 base address: 3002_0000h
> > SAI3 base address: 3003_0000h
> > SAI5 base address: 3005_0000h
> > SAI6 base address: 3006_0000h
> >
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 68 +++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index de3498c2dd44..e9a0b2b6063a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -171,6 +171,74 @@
> >                       #size-cells = <1>;
> >                       ranges;
> >
> > +                     sai1: sai@30010000 {
> > +                             compatible = "fsl,imx8mq-sai",
>
> Should be "fsl,imx8mm-sai"?

SAI IP on imx8mm is identical with the one on imx8mq. There is no need
to differentiate with a compatible string.

What is the common practice for such cases?
