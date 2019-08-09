Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4FAC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714A220B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="EvnTqzJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406096AbfHIJEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:04:46 -0400
Received: from vps.xff.cz ([195.181.215.36]:46300 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfHIJEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1565341484; bh=UgOyVx0PYKqYlPjCl68ial+Co8w66XtUj8b9RpCwBdc=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=EvnTqzJmVGd2jc4hzg6tPa+EoPcdRkTMwd/n/6vScf5kCdRQxLeCr6TioaSQKxl6w
         xK+69M6s2JeCqtvs57+gJtHaqY9I8QlTANjXAQourGbdt2S0TkIPPm0n7ExEyvB3Ii
         w2+gxFPlaVbU2FroS+8V6NzfRXQNlL98MzCi94a0=
Date:   Fri, 9 Aug 2019 11:04:43 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Code Kipper <codekipper@gmail.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH v8 4/4] arm64: dts: allwinner: orange-pi-3:
 Enable HDMI output
Message-ID: <20190809090443.kq5bnsrkgr746l2i@core.my.home>
Mail-Followup-To: Code Kipper <codekipper@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190806155744.10263-1-megous@megous.com>
 <20190806155744.10263-5-megous@megous.com>
 <CAEKpxBn1nF0t-M34iRSy1yYEuUxgNMUXFBhtjXBY8Qk+43zbDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEKpxBn1nF0t-M34iRSy1yYEuUxgNMUXFBhtjXBY8Qk+43zbDQ@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 10:25:32AM +0200, Code Kipper wrote:
> On Tue, 6 Aug 2019 at 17:57, <megous@megous.com> wrote:
> >
> > From: Ondrej Jirman <megous@megous.com>
> >
> > Orange Pi 3 has a DDC_CEC_EN signal connected to PH2, that enables the DDC
> > I2C bus voltage shifter. Before EDID can be read, we need to pull PH2 high.
> > This is realized by the ddc-en-gpios property.
> Great work. Is there any chance you can move this to the
> arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi?, as all the H6
> based orange-pi's have this feature.

I plan to do that as a followup patch, once this is merged.

regards,
	o.

> BR,
> CK
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > index 2c6807b74ff6..01bb1bafe284 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > @@ -22,6 +22,18 @@
> >                 stdout-path = "serial0:115200n8";
> >         };
> >
> > +       connector {
> > +               compatible = "hdmi-connector";
> > +               ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
> > +               type = "a";
> > +
> > +               port {
> > +                       hdmi_con_in: endpoint {
> > +                               remote-endpoint = <&hdmi_out_con>;
> > +                       };
> > +               };
> > +       };
> > +
> >         leds {
> >                 compatible = "gpio-leds";
> >
> > @@ -72,6 +84,10 @@
> >         cpu-supply = <&reg_dcdca>;
> >  };
> >
> > +&de {
> > +       status = "okay";
> > +};
> > +
> >  &ehci0 {
> >         status = "okay";
> >  };
> > @@ -91,6 +107,16 @@
> >         status = "okay";
> >  };
> >
> > +&hdmi {
> > +       status = "okay";
> > +};
> > +
> > +&hdmi_out {
> > +       hdmi_out_con: endpoint {
> > +               remote-endpoint = <&hdmi_con_in>;
> > +       };
> > +};
> > +
> >  &mdio {
> >         ext_rgmii_phy: ethernet-phy@1 {
> >                 compatible = "ethernet-phy-ieee802.3-c22";
> > --
> > 2.22.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190806155744.10263-5-megous%40megous.com.
