Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E532C31E50
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11603217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfFNXFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:05:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46040 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfFNXFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 19:05:36 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbvGB-00084E-SQ; Sat, 15 Jun 2019 01:05:27 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Justin Swartz <justin.swartz@risingedge.co.za>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH 3/4] ARM: dts: rockchip: add display nodes for rk322x
Date:   Sat, 15 Jun 2019 01:05:27 +0200
Message-ID: <5617164.NpQ99z5SQI@phil>
In-Reply-To: <20190614203610.959DA217F9@mail.kernel.org>
References: <20190614165454.13743-1-heiko@sntech.de> <13456600.FWPkgmLa5g@phil> <20190614203610.959DA217F9@mail.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

Am Freitag, 14. Juni 2019, 22:36:09 CEST schrieb Stephen Boyd:
> Quoting Heiko Stuebner (2019-06-14 12:33:12)
> > Am Freitag, 14. Juni 2019, 20:32:35 CEST schrieb Justin Swartz:
> > > On 2019-06-14 19:45, Stephen Boyd wrote:
> > > >> diff --git a/arch/arm/boot/dts/rk322x.dtsi 
> > > >> b/arch/arm/boot/dts/rk322x.dtsi
> > > >> index da102fff96a2..148f9b5157ea 100644
> > > >> --- a/arch/arm/boot/dts/rk322x.dtsi
> > > >> +++ b/arch/arm/boot/dts/rk322x.dtsi
> > > >> @@ -143,6 +143,11 @@
> > > >> #clock-cells = <0>;
> > > >> };
> > > >> 
> > > >> +       display_subsystem: display-subsystem {
> > > >> +               compatible = "rockchip,display-subsystem";
> > > >> +               ports = <&vop_out>;
> > > >> +       };
> > > >> +
> > > > 
> > > > What is this? It doesn't have a reg property so it looks like a virtual
> > > > device. Why is it in DT?
> > > 
> > > This is a virtual device.
> > > 
> > > I assumed it would be acceptable to it find in a device tree due to 
> > > binding documentation, 
> > > "Documentation/devicetree/bindings/display/rockchip/rockchip-drm.txt, 
> > > which states:
> > > 
> > > <quote>
> > > The Rockchip DRM master device is a virtual device needed to list all
> > > vop devices or other display interface nodes that comprise the
> > > graphics subsystem.
> > > </quote>
> > > 
> > > Without the "display_subsystem" device node, the HDMI PHY and 
> > > rockchipdrmfb frame buffer device are not initialized.
> > > 
> > > Perhaps I should have included this in my commit message? :)
> > 
> > As Justin said, that is very much common as the root of the components
> > that make up the drm device and pretty much common in a lot of devicetrees
> > for the last 5 years and longer ;-) .
> > 
> > Also gpio-keys also don't have a reg property ;-) .
> > 
> 
> Do you have a SoC node? If so, this virtual device should live in the
> root, away from the nodes that have reg properties and are thus in the
> SoC node.

no we don't have any soc node and that display-subsystem is really the
same on _all_ currently supported Rockchip socs ... has gone through
dt-reviews numerous times for multiple socs, so I'm somewhat
confident that we're not doing something terrible wrong.

Heiko


