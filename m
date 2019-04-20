Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4FAC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F232087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy1i4P8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfDTMOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:14:35 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35673 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDTMOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:14:35 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so11913791itc.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fphgyWKbqViu/pj7GY3RUNNMls9BoBesSIAe3IcTvKc=;
        b=Qy1i4P8gEnqcmyqeh0pf4yZI2j+HV8xj7CGkOVwfoC8UkEfBvlQHV3kaY+89+aIEQo
         4aNab6+Qr/56KgesV9lddO7O0o1Y2ElQSgzJSRwcMnwPlvSoZvAAcx0YPYLB7PSvpynM
         aMbsHKc6L9zhaaE9eQhyhekn1i5WDFpNcRj3J3gRQzqnitpMqGFVGazHvT9/zjMBLl8S
         vSFEZXUq38oIQai7N1D23nE2UqHstg8CbfixQMaHKW3VBPYFTLBx1CtyXu+kby9m3CAj
         2/x1LiR0eG5S2Cbhehf0yzFV5uhzsIIrL6b/u+w/wxDJOrh8worFoWjgY6awG963oM9f
         dt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fphgyWKbqViu/pj7GY3RUNNMls9BoBesSIAe3IcTvKc=;
        b=P/cldohXWC91XI+MNq+hp1zMAboG2n2jJPAc03E5yQw25vy/rm9ilD6FSv5AL4lSp3
         hqQrXqx8LMUQkDHYwZ0zqnGhtxUMHWtvRItqLfFIZ5TO3qwJzciBybyiaJ1x7nSAGhoL
         XhmYvoWERMjgXsryku1szTAGoIHmVfFMpKrwiVg8SiRXA7EnUEg6b95/hvaHnkky1Fuf
         oHQ2lwmJ+Kq9ffwS/sn2n5BrQw5glRmDBp2hlJOSa7pVrqufGlP8Mj2mOmiCiW+tbyN3
         j3a8dPCSNlEuP0cmVKIvOZV1vHADPAjle2d7BiL1cl0NnbFibak8uFZrZfeiDehhMOek
         iD6w==
X-Gm-Message-State: APjAAAW/yt/hxpXDk047P7VreTgAH9aTtmXPC1xCe9fV2af14rshJBDH
        7uT82cMOX3r8cZo+R0RiCsELRknwmooxrczVD/I=
X-Google-Smtp-Source: APXvYqx27kNqSNhGwhWXgCVROvSHDI+llyzlYuB6w2SBu65/MOX/OQqZaYfCoTdCWNWKjtE0vsGZ9Lwl56Sv4i3n69w=
X-Received: by 2002:a24:24cc:: with SMTP id f195mr5678364ita.168.1555762474219;
 Sat, 20 Apr 2019 05:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190329064924.8728-1-andrew.smirnov@gmail.com> <20190411023008.GK26817@dragon>
In-Reply-To: <20190411023008.GK26817@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 20 Apr 2019 07:14:26 -0500
Message-ID: <CAHCN7xLczbdXx+TEQhsY1L3z09wPubvxX5SDO3Z1OzavPie0=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as
 "ipg" clock to SDMA
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 9:30 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Thu, Mar 28, 2019 at 11:49:16PM -0700, Andrey Smirnov wrote:
> > Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
> > clock to determine if it needs to configure the IP block as operating
> > at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
> > clocks as IMX6QDL_CLK_SDMA results in driver incorrectly thinking that
> > ratio is 1:1 which results in broken SDMA funtionality(this at least
> > breaks RAVE SP serdev driver on RDU2). Fix the code to specify
> > IMX6QDL_CLK_IPG as "ipg" clock for SDMA, to avoid detecting incorrect
> > clock ratio.
> >
> > Fixes: 25aaa75df1e6 ("dmaengine: imx-sdma: add clock ratio 1:1 check")
>
> Since we have a fix in the dma driver, I dropped the Fixes tag here.
>
> Applied all, thanks.

Do you know if the SDMA fixes will be back-ported to 5.0.y branch?  To
get 5.0 working, I need to manually apply the patches.

thanks

adam
>
> Shawn
>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index 9f9aa6e7ed0e..354feba077b2 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -949,7 +949,7 @@
> >                               compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
> >                               reg = <0x020ec000 0x4000>;
> >                               interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
> > -                             clocks = <&clks IMX6QDL_CLK_SDMA>,
> > +                             clocks = <&clks IMX6QDL_CLK_IPG>,
> >                                        <&clks IMX6QDL_CLK_SDMA>;
> >                               clock-names = "ipg", "ahb";
> >                               #dma-cells = <3>;
> > --
> > 2.20.1
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
