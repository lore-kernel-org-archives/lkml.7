Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71133C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496072087B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfERPHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 11:07:17 -0400
Received: from mailoutvs17.siol.net ([185.57.226.208]:54194 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728516AbfERPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 11:07:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0CAD3520CA6;
        Sat, 18 May 2019 17:07:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5YviEmiBTKUs; Sat, 18 May 2019 17:07:12 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B1759520CBE;
        Sat, 18 May 2019 17:07:12 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id E64AC520CA6;
        Sat, 18 May 2019 17:07:11 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i-h3: Fix wifi in Beelink X2 DT
Date:   Sat, 18 May 2019 17:07:11 +0200
Message-ID: <36237813.UWQAqNRFN9@jernej-laptop>
In-Reply-To: <20190517073048.y6mzgbhhryfmuckl@flea>
References: <20190516161039.18534-1-jernej.skrabec@siol.net> <20190517073048.y6mzgbhhryfmuckl@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 17. maj 2019 ob 09:30:48 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Thu, May 16, 2019 at 06:10:39PM +0200, Jernej Skrabec wrote:
> > mmc1 node where wifi module is connected doesn't have properly defined
> > power supplies so wifi module is never powered up. Fix that by
> > specifying additional power supplies.
> > 
> > Additionally, this STB may have either Realtek or Broadcom based wifi
> > module. One based on Broadcom module also needs external clock to work
> > properly. Fix that by adding clock property to wifi_pwrseq node.
> > 
> > Fixes: e582b47a9252 ("ARM: dts: sun8i-h3: Add dts for the Beelink X2 STB")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts index
> > 6277f13f3eb3..6a0ac85b4616 100644
> > --- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > @@ -89,7 +89,10 @@
> > 
> >  	wifi_pwrseq: wifi_pwrseq {
> >  	
> >  		compatible = "mmc-pwrseq-simple";
> > 
> > +		pinctrl-names = "default";
> 
> pinctrl-names only make sense with another pinctrl-[0-255]
> property. Did you forgot something here?

No, I just took BananaPi M2+ as a example, which has pinctrl-names property 
too and no "pinctrl-*". But digging through history of this DT, it seems that 
this is just leftover which somebody forgot to remove.

I'll send v2.

Best regards,
Jernej


