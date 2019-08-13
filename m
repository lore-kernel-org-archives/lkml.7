Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8CCC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093C620673
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfHMFo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 01:44:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56277 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMFo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:44:29 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4F59DC0006;
        Tue, 13 Aug 2019 05:44:27 +0000 (UTC)
Date:   Tue, 13 Aug 2019 07:44:26 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: How to add multiple example with conflicting includes
Message-ID: <20190813054426.73ret73tmkrkyqfo@flea>
References: <20190726181108.GA17767@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726181108.GA17767@Red>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Jul 26, 2019 at 08:11:08PM +0200, Corentin Labbe wrote:
> When I try to check the following examples of a devicetree schema:
> examples:
>   - |
>     #include <dt-bindings/interrupt-controller/arm-gic.h>
>     #include <dt-bindings/clock/sun50i-a64-ccu.h>
>     #include <dt-bindings/reset/sun50i-a64-ccu.h>
>
>     crypto: crypto@1c15000 {
>       compatible = "allwinner,sun8i-h3-crypto";
>       reg = <0x01c15000 0x1000>;
>       interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>       clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
>       clock-names = "ahb", "mod";
>       resets = <&ccu RST_BUS_CE>;
>       reset-names = "ahb";
>     };
>
>   - |
>     #include <dt-bindings/interrupt-controller/arm-gic.h>
>     #include <dt-bindings/clock/sun50i-h6-ccu.h>
>     #include <dt-bindings/reset/sun50i-h6-ccu.h>
>
>     crypto: crypto@1904000 {
>       compatible = "allwinner,sun50i-h6-crypto";
>       reg = <0x01904000 0x1000>;
>       interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>       clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>, <&ccu CLK_MBUS_CE>;
>       clock-names = "ahb", "mod", "mbus";
>       resets = <&ccu RST_BUS_CE>;
>       reset-names = "ahb";
>     };
>
> I get:
> In file included from Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.example.dts:42:
> /linux-next/scripts/dtc/include-prefixes/dt-bindings/clock/sun50i-h6-ccu.h:9: warning: "CLK_PLL_PERIPH0" redefined
>  #define CLK_PLL_PERIPH0  3
> [...]
>
> So how can I add multiple examples which need somes conflicting
> #include to be validated.

I'm having the same issue right now, is there a proper fix /
workaround?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
