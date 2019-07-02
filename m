Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB517C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A238F206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZmsk2ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfGBNdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:33:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40894 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfGBNdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:33:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so17866152wre.7;
        Tue, 02 Jul 2019 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0OYaXyIMcAAJ4gBJEOEXLofDRzjGVAncXahqHJtr3g=;
        b=jZmsk2apK9wWaC1Jwi8eJ+VpNeeqK9vyCI2z4YLKZy0UMQiklfvEJVTrYVsIE1tAoL
         Y0mxMn9PXmVbH/NBkukGPC7y0H/BBRFTvNqfGcb6L2DEcT68IJb+Tno6Sy2dbcfXF35q
         EYTpbUzAwTBib2rn38pMmYI7wgZXsOBsHf7d12NDK5rlNm1mLqrrvfLa0bpKw++S3JJW
         nmGOJnDN4flQWKyQ2INLpigpyMPRSa9KHhhIMB3wFazz2VGW/XO6KJlsgowT23b+pR+w
         +XCGBbRduRTbvzTTfwVMn2bBa69lj94fYKOEH8G7r345mzWJr0kHUuhILLc9d0GFZdHN
         ZeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0OYaXyIMcAAJ4gBJEOEXLofDRzjGVAncXahqHJtr3g=;
        b=l8esMl3Vl5/RvA0eFg4q2t5xYbfFBtcGPce3pWDJRrKLfaZN2Aqgo4Qn/Aitk169Ep
         UWP7WzX94QdZ/3sP4hGx7VdmNzMZyxze8RP+gWVGfPygV1mmlqFhOI5E6p0cumqWhEM+
         8+tRIDPMcKlvw9TMkL1rKWsSgOeChvuoGdWKTLHVA/4JYToKEdJ/2C+j7EUCWtGqlX92
         nd4pmyT2HYLdTx0ng5B5PdcQc51C+nn05+pVX5h3wEny7KKBq+3Q7IrqFDpatnd8Yoyn
         sK5DbWOuj9FYTzcA5nou9SPmTe2Cn7nx1rmt1GCXA7MH4ZcsBXRLY8T02e2zGQgSl5O4
         MTIA==
X-Gm-Message-State: APjAAAW8kGU4rknYTk8BAKGMsQtQ350RD4aq+9YccifXwMotnU+5WxxX
        cVamGFzRXPqEeG+B87edpRoMjx65tgQMD8fl1os=
X-Google-Smtp-Source: APXvYqwoFV/2mmIUnIen+iGNTWGL2iKe81qUb57QjAm12sViws9Te4KN/ERYebT9jYy+13diP//7AXRCkx/uQgDHlLE=
X-Received: by 2002:adf:db12:: with SMTP id s18mr23027525wri.335.1562074397596;
 Tue, 02 Jul 2019 06:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <1561469191-26840-1-git-send-email-abel.vesa@nxp.com>
 <CAEnQRZCVQ0+pRh6akiZJXU-fRugEXmnthZp8Q2=aXFXCO3vcUg@mail.gmail.com> <20190702132647.3kyfl5gx6ghdiizl@fsr-ub1664-175>
In-Reply-To: <20190702132647.3kyfl5gx6ghdiizl@fsr-ub1664-175>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 2 Jul 2019 16:33:06 +0300
Message-ID: <CAEnQRZDn83HDR+k101UA9MVnCmQevAQcFTCRoS__Xf0PwCCSFQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Init rates and parents configs for clocks
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 4:26 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On 19-06-26 15:45:15, Daniel Baluta wrote:
> > On Tue, Jun 25, 2019 at 4:42 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> > >
> > > Add the initial configuration for clocks that need default parent and rate
> > > setting. This is based on the vendor tree clock provider parents and rates
> > > configuration except this is doing the setup in dts rather than using clock
> > > consumer API in a clock provider driver.
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 36 +++++++++++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index 232a741..ab92108 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -451,6 +451,42 @@
> > >                                          <&clk_ext3>, <&clk_ext4>;
> > >                                 clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
> > >                                               "clk_ext3", "clk_ext4";
> > > +                               assigned-clocks = <&clk IMX8MM_CLK_AUDIO_AHB>,
> > > +                                               <&clk IMX8MM_CLK_IPG_AUDIO_ROOT>,
> > > +                                               <&clk IMX8MM_SYS_PLL3>,
> > > +                                               <&clk IMX8MM_VIDEO_PLL1>,
> > > +                                               <&clk IMX8MM_CLK_NOC>,
> > > +                                               <&clk IMX8MM_CLK_PCIE1_CTRL>,
> > > +                                               <&clk IMX8MM_CLK_PCIE1_PHY>,
> > > +                                               <&clk IMX8MM_CLK_CSI1_CORE>,
> > > +                                               <&clk IMX8MM_CLK_CSI1_PHY_REF>,
> > > +                                               <&clk IMX8MM_CLK_CSI1_ESC>,
> > > +                                               <&clk IMX8MM_CLK_DISP_AXI>,
> > > +                                               <&clk IMX8MM_CLK_DISP_APB>;
> > > +                               assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>,
> > > +                                               <0>,
> > Isn't there a macro for 0? (dummy clock?)
>
> I don't know about any such macro. If you're referring to IMX8MM_CLK_DUMMY,
> that can't be used here since all I want here is to skip setting a parent to
> the  IMX8MM_CLK_IPG_AUDIO_ROOT. If I use IMX8MM_CLK_DUMMY (along with &clk)
> it will set the parent to IMX8MM_CLK_DUMMY and that's not what's needed here.
>
> This is in accordance to the documentation:
>
> Documentation/devicetree/bindings/clock/clock-bindings.txt:
>
> "To skip setting parent or rate of a clock its corresponding entry should be
> set to 0, or can be omitted if it is not followed by any non-zero entry."

You are right. Thanks for the explanation!
