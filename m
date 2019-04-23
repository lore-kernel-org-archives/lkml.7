Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF75C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE6920811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfDWQM0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:12:26 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52189 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:12:25 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 9A3F24000C;
        Tue, 23 Apr 2019 16:12:22 +0000 (UTC)
Date:   Tue, 23 Apr 2019 18:12:21 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo =?utf-8?Q?Sebasti=C3=A1n?= Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] ARM: dts: sun8i: v40: bananapi-m2-berry: Add
 Bluetooth device node
Message-ID: <20190423161221.27rvt3zvlobbmptn@flea>
References: <1555600282-9405-1-git-send-email-pgreco@centosproject.org>
 <1555600282-9405-6-git-send-email-pgreco@centosproject.org>
 <20190418155613.shiv7geoqyzfy4kf@flea>
 <bc5d7e91-74c5-103a-db72-6cb1f3ef53b9@centosproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <bc5d7e91-74c5-103a-db72-6cb1f3ef53b9@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 01:14:35PM -0300, Pablo Sebastián Greco wrote:
>
> El 18/4/19 a las 12:56, Maxime Ripard escribió:
> > On Thu, Apr 18, 2019 at 12:11:20PM -0300, Pablo Greco wrote:
> > > Since the bananapi-m2-ultra and the bananapi-m2-berry have the same
> > > WiFi/Bluetooth, add the required nodes to the bananapi-m2-berry.
> > >
> > > Signed-off-by: Pablo Greco <pgreco@centosproject.org>
> > > ---
> > >   arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 26 +++++++++++++++++++++++
> > >   1 file changed, 26 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> > > index 78f4a1a..3d0bb7e 100644
> > > --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> > > +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
> > > @@ -96,6 +96,8 @@
> > >   	wifi_pwrseq: wifi_pwrseq {
> > >   		compatible = "mmc-pwrseq-simple";
> > >   		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
> > > +		clocks = <&ccu CLK_OUTA>;
> > > +		clock-names = "ext_clock";
> > >   	};
> > >   };
> > >
> > > @@ -171,6 +173,11 @@
> > >   	status = "okay";
> > >   };
> > >
> > > +&pio {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&clk_out_a_pin>;
> > > +};
> > > +
> > I'm not sure you answered my question about why that is needed?
> Because it is the same case as https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts?id=1e5f1db4ccd8348a21da55bff82f4263000879ef
> I can repeat that info in this commit log

Yes, please.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
