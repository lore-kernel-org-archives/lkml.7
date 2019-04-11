Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77788C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF5A21871
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDKMsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:48:05 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48189 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDKMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:48:03 -0400
X-Originating-IP: 90.88.18.121
Received: from aptenodytes (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 81D9120018;
        Thu, 11 Apr 2019 12:47:53 +0000 (UTC)
Message-ID: <4c9aa6a850d76533ff693a44ef95b68241836751.camel@bootlin.com>
Subject: Re: [PATCH 4/6] ARM: dts: sun8i: a83t: Add device node for CSI
 (Camera Sensor Interface)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     =?UTF-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Date:   Thu, 11 Apr 2019 14:47:52 +0200
In-Reply-To: <20190409220040.3sx456gefmjq3t3g@core.my.home>
References: <20190408165744.11672-1-wens@kernel.org>
         <20190408165744.11672-5-wens@kernel.org>
         <20190409075804.4zrwjil7ie2gjigu@flea>
         <CAGb2v64CYV68Q0a7x5p-XabS74vaQWP3paPopodmqQPTOrq2gQ@mail.gmail.com>
         <20190409082818.z33mq2qrxethldzf@flea>
         <20190409220040.3sx456gefmjq3t3g@core.my.home>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 10 avril 2019 à 00:00 +0200, Ondřej Jirman a écrit :
> On Tue, Apr 09, 2019 at 10:28:18AM +0200, Maxime Ripard wrote:
> > On Tue, Apr 09, 2019 at 04:07:34PM +0800, Chen-Yu Tsai wrote:
> > > On Tue, Apr 9, 2019 at 3:58 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > On Tue, Apr 09, 2019 at 12:57:42AM +0800, Chen-Yu Tsai wrote:
> > > > > From: Chen-Yu Tsai <wens@csie.org>
> > > > > 
> > > > > The A83T SoC has a camera sensor interface (known as CSI in Allwinner
> > > > > lingo), which is similar to the one found on the A64 and H3. The only
> > > > > difference seems to be that support of MIPI CSI through a connected
> > > > > MIPI CSI-2 bridge.
> > > > > 
> > > > > Add a device node for it, and pinctrl nodes for the commonly used MCLK
> > > > > and 8-bit parallel interface. The property /omit-if-no-ref/ is added to
> > > > > the pinctrl nodes to keep the device tree blob size down if they are
> > > > > unused.
> > > > > 
> > > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > > ---
> > > > >  arch/arm/boot/dts/sun8i-a83t.dtsi | 31 +++++++++++++++++++++++++++++++
> > > > >  1 file changed, 31 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > > index f739b88efb53..0c52f945fd5f 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > > @@ -682,6 +682,20 @@
> > > > >                       #interrupt-cells = <3>;
> > > > >                       #gpio-cells = <3>;
> > > > > 
> > > > > +                     /omit-if-no-ref/
> > > > > +                     csi_8bit_parallel_pins: csi-8bit-parallel-pins {
> > > > > +                             pins = "PE0", "PE2", "PE3", "PE6", "PE7",
> > > > > +                                    "PE8", "PE9", "PE10", "PE11",
> > > > > +                                    "PE12", "PE13";
> > > > > +                             function = "csi";
> > > > > +                     };
> > > > > +
> > > > > +                     /omit-if-no-ref/
> > > > > +                     csi_mclk_pin: csi-mclk-pin {
> > > > > +                             pins = "PE1";
> > > > > +                             function = "csi";
> > > > > +                     };
> > > > > +
> > > > >                       emac_rgmii_pins: emac-rgmii-pins {
> > > > >                               pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
> > > > >                                      "PD11", "PD12", "PD13", "PD14", "PD18",
> > > > > @@ -994,6 +1008,23 @@
> > > > >                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> > > > >               };
> > > > > 
> > > > > +             csi: camera@1cb0000 {
> > > > > +                     compatible = "allwinner,sun8i-a83t-csi";
> > > > > +                     reg = <0x01cb0000 0x1000>;
> > > > > +                     interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +                     clocks = <&ccu CLK_BUS_CSI>,
> > > > > +                              <&ccu CLK_CSI_SCLK>,
> > > > > +                              <&ccu CLK_DRAM_CSI>;
> > > > > +                     clock-names = "bus", "mod", "ram";
> > > > > +                     resets = <&ccu RST_BUS_CSI>;
> > > > > +                     status = "disabled";
> > > > > +
> > > > > +                     csi_in: port {
> > > > > +                             #address-cells = <1>;
> > > > > +                             #size-cells = <0>;
> > > > 
> > > > If we expect a single enpoint, then we don't need the address-cells
> > > > and size-cells properties.
> > > 
> > > I wouldn't bet on anything. The way the Q8 tablets did front/back cameras
> > > is kind of genius if not very hacky. They have two "identical" sensors
> > > on the same I2C bus and CSI bus, with shared reset line but separate
> > > shutdown lines. Since they are identical, they also have the same I2C
> > > address. I haven't figured out how to model this in the device tree.
> > > 
> > > The point is, it's perfectly possible to have two or more sensors use
> > > the same controller, provided only one be active at a time.
> > 
> > Right, but I guess the common case would be to have a single sensor,
> > where that wouldn't be needed.
> > 
> > In odd cases, we can always specify it in the DTS, and if it becomes
> > common enough, we can move it to the DTSI.
> 
> I'm planning on having two sensors there, in a less arcane setup,
> though - no shared resets, and different I2C addresses.
> 
> Anyway, I can confirm that CSI driver works fine on A83T with just
> a DTSI patch, even without the clock patch in this series. I've been
> running it for quite a while that way without any issues (different
> camera chip than the ones being used by wens).

That's quite nice to hear! I would be interested in getting some
insight on which sensors are known to work and which are broken or have
limitations.

Would you happen to have a list of the sensors that you tested and
whether you encountered such issues with them?

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

