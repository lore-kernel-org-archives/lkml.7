Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF66C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E5A20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554799258;
	bh=lCYFy+l9aaH2Ie6+hy59R5nimLfZVzVRkgfRf9dhzTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i689vT4AUJiKPhaeAabgn0Ta+c1XkA50I74gN5sT7JF5E7RuH3BB6ql2Sm/PXBHIW
	 RUGHdl7PCtf1p3oyNSX1Nq1iCCNBbFXWkdDfoLeY8vp1KMRxYExxU3tmWs3jkeQ/Ia
	 v/COKek5+hKuseqv+MMwQyHIxqlR1L2+7vioe11k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDIIk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbfDIIk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:40:57 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EAB920833;
        Tue,  9 Apr 2019 08:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554799255;
        bh=lCYFy+l9aaH2Ie6+hy59R5nimLfZVzVRkgfRf9dhzTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gs7fNFW628tOd+BoyJERW47BzPlEeeE7XNxXtrjMqPJPgtWF0R+rBl+q2An7evkI2
         L9ezKn/lieXJEerRPQhXwTNtGXCNyYJ4C3dVm+6ifZPGC0OQFTCyd7On2zvJAZxrp1
         cAB3AWK8sZYm9VfhP62nXGbjH5H49fbyN808SrZk=
Received: by mail-wm1-f54.google.com with SMTP id z24so2279291wmi.5;
        Tue, 09 Apr 2019 01:40:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXoWBak0fDWXN4eY+t3vPu8kx2zRuw9LcaJtBECKXU4QBtp6KM0
        bIV30O/Oq2rncZ4e84cWh4tvumxoFzp/yP+gfm4=
X-Google-Smtp-Source: APXvYqzX6Ahfxoj2ItPmYqhsJMHobIiDIxNq71DX2zXCKsGgbKcRi1So8xKDzwZt/RaJMYLXmJa0MPZ/1W/Y4DbJDNs=
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr20863891wml.24.1554799253809;
 Tue, 09 Apr 2019 01:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190408165744.11672-1-wens@kernel.org> <20190408165744.11672-5-wens@kernel.org>
 <20190409075804.4zrwjil7ie2gjigu@flea> <CAGb2v64CYV68Q0a7x5p-XabS74vaQWP3paPopodmqQPTOrq2gQ@mail.gmail.com>
 <20190409082818.z33mq2qrxethldzf@flea>
In-Reply-To: <20190409082818.z33mq2qrxethldzf@flea>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 9 Apr 2019 16:40:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v67pX+7ccihmGEWPKrXg8mMhht-vh37p2auWYgt=qGDA6A@mail.gmail.com>
Message-ID: <CAGb2v67pX+7ccihmGEWPKrXg8mMhht-vh37p2auWYgt=qGDA6A@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: dts: sun8i: a83t: Add device node for CSI
 (Camera Sensor Interface)
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 4:28 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Apr 09, 2019 at 04:07:34PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Apr 9, 2019 at 3:58 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > On Tue, Apr 09, 2019 at 12:57:42AM +0800, Chen-Yu Tsai wrote:
> > > > From: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > The A83T SoC has a camera sensor interface (known as CSI in Allwinner
> > > > lingo), which is similar to the one found on the A64 and H3. The only
> > > > difference seems to be that support of MIPI CSI through a connected
> > > > MIPI CSI-2 bridge.
> > > >
> > > > Add a device node for it, and pinctrl nodes for the commonly used MCLK
> > > > and 8-bit parallel interface. The property /omit-if-no-ref/ is added to
> > > > the pinctrl nodes to keep the device tree blob size down if they are
> > > > unused.
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > ---
> > > >  arch/arm/boot/dts/sun8i-a83t.dtsi | 31 +++++++++++++++++++++++++++++++
> > > >  1 file changed, 31 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > index f739b88efb53..0c52f945fd5f 100644
> > > > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > @@ -682,6 +682,20 @@
> > > >                       #interrupt-cells = <3>;
> > > >                       #gpio-cells = <3>;
> > > >
> > > > +                     /omit-if-no-ref/
> > > > +                     csi_8bit_parallel_pins: csi-8bit-parallel-pins {
> > > > +                             pins = "PE0", "PE2", "PE3", "PE6", "PE7",
> > > > +                                    "PE8", "PE9", "PE10", "PE11",
> > > > +                                    "PE12", "PE13";
> > > > +                             function = "csi";
> > > > +                     };
> > > > +
> > > > +                     /omit-if-no-ref/
> > > > +                     csi_mclk_pin: csi-mclk-pin {
> > > > +                             pins = "PE1";
> > > > +                             function = "csi";
> > > > +                     };
> > > > +
> > > >                       emac_rgmii_pins: emac-rgmii-pins {
> > > >                               pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
> > > >                                      "PD11", "PD12", "PD13", "PD14", "PD18",
> > > > @@ -994,6 +1008,23 @@
> > > >                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> > > >               };
> > > >
> > > > +             csi: camera@1cb0000 {
> > > > +                     compatible = "allwinner,sun8i-a83t-csi";
> > > > +                     reg = <0x01cb0000 0x1000>;
> > > > +                     interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                     clocks = <&ccu CLK_BUS_CSI>,
> > > > +                              <&ccu CLK_CSI_SCLK>,
> > > > +                              <&ccu CLK_DRAM_CSI>;
> > > > +                     clock-names = "bus", "mod", "ram";
> > > > +                     resets = <&ccu RST_BUS_CSI>;
> > > > +                     status = "disabled";
> > > > +
> > > > +                     csi_in: port {
> > > > +                             #address-cells = <1>;
> > > > +                             #size-cells = <0>;
> > >
> > > If we expect a single enpoint, then we don't need the address-cells
> > > and size-cells properties.
> >
> > I wouldn't bet on anything. The way the Q8 tablets did front/back cameras
> > is kind of genius if not very hacky. They have two "identical" sensors
> > on the same I2C bus and CSI bus, with shared reset line but separate
> > shutdown lines. Since they are identical, they also have the same I2C
> > address. I haven't figured out how to model this in the device tree.
> >
> > The point is, it's perfectly possible to have two or more sensors use
> > the same controller, provided only one be active at a time.
>
> Right, but I guess the common case would be to have a single sensor,
> where that wouldn't be needed.
>
> In odd cases, we can always specify it in the DTS, and if it becomes
> common enough, we can move it to the DTSI.

Makes sense. Do you want me to re-spin?
