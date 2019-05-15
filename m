Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877A3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5309320862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfEOHcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:32:24 -0400
Received: from verein.lst.de ([213.95.11.211]:50418 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEOHcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:32:24 -0400
Received: by newverein.lst.de (Postfix, from userid 107)
        id E204B68C65; Wed, 15 May 2019 09:32:03 +0200 (CEST)
Received: from blackhole.lan (p5B33F92B.dip0.t-ipconnect.de [91.51.249.43])
        by newverein.lst.de (Postfix) with ESMTPSA id A72FF68AFE;
        Wed, 15 May 2019 09:31:33 +0200 (CEST)
Date:   Wed, 15 May 2019 09:31:41 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge
 on Teres-I
Message-ID: <20190515093141.41016b11@blackhole.lan>
In-Reply-To: <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com>
References: <20190514155911.6C0AC68B05@newverein.lst.de>
        <20190514160241.9EAC768C7B@newverein.lst.de>
        <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com>
Organization: LST e.V.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 10:48:40 -0700
Vasily Khoruzhick <anarsoul@gmail.com> wrote:

> > +       anx6345: anx6345@38 {
> > +               compatible = "analogix,anx6345";
> > +               reg = <0x38>;
> > +               reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24
> > */
> > +               dvdd25-supply = <&reg_dldo2>;
> > +               dvdd12-supply = <&reg_dldo3>;
> > +
> > +               port {
> > +                       anx6345_in: endpoint {
> > +                               remote-endpoint =
> > <&tcon0_out_anx6345>;
> > +                       };
> > +               };
> 
> It doesn't comply with bindings document. You need to add out endpoint

It does comply with the bindings. The ports are all optional.
As far as DT is concerned, the signal path ends here. This is also the
final component _required_ to get the Linux kernel DRI up and running.

> as well, and to do so you need to add bindings for eDP connector first
> and then implement panel driver.
> See Rob's suggestions here: http://patchwork.ozlabs.org/patch/1042593/

Well, one *could* extend the hardware description down to the actual
panel if necessary, but on the Teres-I it is not. I assume the panel
they ship provides proper EDID to the anx6345, because the display
works fine here with this DT.

Do I understand this correctly that the (3 different?) pinebook panels
are not that easy to handle? I try to include the pinebook wherever
possible, just because it's so similar, but here I'm a bit lost, so I
had to omit these parts.

Should I also have added a Tested-by: ? ;-)

	Torsten
