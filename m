Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F11CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455AC2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="hAop2vP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDALeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:34:36 -0400
Received: from vps.xff.cz ([195.181.215.36]:57422 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554118474; bh=89FjOYUNqERl6OhtF0+u99Sl9W6d06HO2w/ZdVwXZYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hAop2vP2dIbiWzv8DaZNR+3nn51Lt/JlfO9jou1YW9kCrUeMquNWclVaSdBV2RgRZ
         HRPSkPA7zWa+dCdUlba936NAM1REVoFUNGsu3vbyx4PO4I932qI+oTdwmKsPIxxb0L
         L5Ew2pBqgXdHEkj8R6OqNxwJ5JxcIgrSr849o9GU=
Date:   Mon, 1 Apr 2019 13:34:33 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh@kernel.org, johan@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/7] ARM: dts: sun8i: tbs-a711: Add node for BMA250
 accelerometer
Message-ID: <20190401113433.z2dps2s5vszt37n7@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime.ripard@bootlin.com>, wens@csie.org,
        robh@kernel.org, johan@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20190327001843.2420-1-megous@megous.com>
 <20190327001843.2420-3-megous@megous.com>
 <20190401063049.h2as3qllpelkxkbb@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401063049.h2as3qllpelkxkbb@flea>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Mon, Apr 01, 2019 at 08:30:49AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Mar 27, 2019 at 01:18:38AM +0100, megous@megous.com wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > A711 tablet has BMA250 accelerometer connected to I2C1 bus. Enable
> > both the I2C1 bus and add the accelerometer device to it.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > index 6aae70c89a1e..347fc0c31fa4 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > @@ -156,6 +156,21 @@
> >  	status = "okay";
> >  };
> >
> > +&i2c1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c1_pins>;
> 
> It's there already

I see, I'll drop it. Thanks.

> > +	clock-frequency = <400000>;
> > +	status = "okay";
> > +
> > +	/* Accelerometer */
> > +	bma250@18 {
> 
> The node name should be the class of the device, not its model, so
> something like accelerometer.

I'll rename this.

thank you,
  Ondrej

> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


