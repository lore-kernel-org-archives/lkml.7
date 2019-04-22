Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC54C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B3E206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyedyfjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfDVTJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:09:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36585 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfDVTJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:09:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id u57so10300621edm.3;
        Mon, 22 Apr 2019 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4jGFbqJYYrNaSYVPVLYTem5IQkbcTJ9uW/zhvpVlM4=;
        b=kyedyfjQZCwZfBEjJ6K+0LREEnGfs/FiRxJ7SOdBju3D9ubsZhpGudc80LSSZst3lp
         9whOd6/RLfP8vB3H3TbeFUNHBltxk7tpTwuiviatmD3TgkmNBasJ5P+NQaOzHiKOIbcC
         l2W+lHLBtCkyllrWrYpC4Z2U2rnb5K3kM2V6QW1uvSGYDbHjIRZzbRYzNEFx9MSeN/cJ
         8RN6goDScgelUW2ffCLXtqHGrIiyTzEgC/UY974mDvYg4LOE7xcwX7s7KX8xOFWd0FO/
         7390flZpUCyLeaeJzXPtGoB/MAJWGrXP1IPWiMo3FpUu9/S289blJ+JIBeAAWUFmnVe6
         G2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4jGFbqJYYrNaSYVPVLYTem5IQkbcTJ9uW/zhvpVlM4=;
        b=QGNRC/bKPn9qQpKqgaBU+P/aYzXxvp+bIDI8S8D6AcSk9ETUxUrmmyBc7WB2dENePP
         ql+sil/QzgwCLhauzGDtOUyuf5U23kEHWFOzWo6p9Hw6hGCHvzx0upEwECqc9UDAYZz6
         29o/ggDKpxfSnpNjvIGXGSBZEsA289SP7nNJo2vF3kuOB9MA6ucRDLnVd2CBNpsPN7g4
         7d6EE+npScPwY5bRsOoUOabU3SSxuuk0nRikU42qGr23NnpH1LUoS5lD+XsLHYuIxpCC
         iSvc54q62M/g+P99ZlBh1NwWOhAz7MpIyFzVUXLUJaBS4C7DFVFHHeT6Z2bfSUGCN60x
         DaOQ==
X-Gm-Message-State: APjAAAWr11aNe34uwrQTAtuGv+gvNjIIwDSvMrz2+vQLSXG3ecLQ48zf
        rPlCvs5c86evfySpE+U0nR4kG+TKDuj6+WrE/us=
X-Google-Smtp-Source: APXvYqw3/Ol5qHFWpXExuqnMCFuUVif4lJKlKJ0yazmeNIMAf5GKmoDZfQU4jCFnzlSuX15kQlpD6B4Pr2o0eQXUbNg=
X-Received: by 2002:a17:906:1249:: with SMTP id u9mr5872114eja.58.1555960176365;
 Mon, 22 Apr 2019 12:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190419202024.27314-1-daniel.baluta@nxp.com> <20190419202024.27314-2-daniel.baluta@nxp.com>
 <20190422024427.GU19962@dragon> <CAEnQRZAA9_Worz8taLC_zWanx2vdujb8YWqi+1VV99bRTueWow@mail.gmail.com>
In-Reply-To: <CAEnQRZAA9_Worz8taLC_zWanx2vdujb8YWqi+1VV99bRTueWow@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 22 Apr 2019 22:09:25 +0300
Message-ID: <CAEnQRZAZ4b2ykdfMc-egdT6rbq+uxbqzC8RwQEcd_uRWY3UWmQ@mail.gmail.com>
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

On Mon, Apr 22, 2019 at 9:51 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Mon, Apr 22, 2019 at 5:45 AM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Fri, Apr 19, 2019 at 08:20:39PM +0000, Daniel Baluta wrote:
> > > i.MX8MM has 5 SAI instances with the following base
> > > addresses according to RM.
> > >
> > > SAI1 base address: 3001_0000h
> > > SAI2 base address: 3002_0000h
> > > SAI3 base address: 3003_0000h
> > > SAI5 base address: 3005_0000h
> > > SAI6 base address: 3006_0000h
> > >
> > > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 68 +++++++++++++++++++++++
> > >  1 file changed, 68 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index de3498c2dd44..e9a0b2b6063a 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -171,6 +171,74 @@
> > >                       #size-cells = <1>;
> > >                       ranges;
> > >
> > > +                     sai1: sai@30010000 {
> > > +                             compatible = "fsl,imx8mq-sai",
> >
> > Should be "fsl,imx8mm-sai"?
>
> SAI IP on imx8mm is identical with the one on imx8mq. There is no need
> to differentiate with a compatible string.

On a second thought sai on i.MX8M is not compatible with SAI on i.MX6.
So, the correct
compatbile should be:

     compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";

Will fix this in v2.
