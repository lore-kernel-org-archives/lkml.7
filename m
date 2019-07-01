Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A97CC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369AA205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKagJn6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGAWLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:11:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34959 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAWLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 18:11:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so8018994plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 15:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HdrP+5n5nJbtYjgIlEc+YGa9TEsVBxE5SMpV5kWYO54=;
        b=JKagJn6S47sY856SpNzPiGzHVpWjDL+ebHQwSACOzykVzvXyzGHcQLHUTqVHawCix6
         rC4s3KAQVm18SbrOWBSC3X9VYjPifrRstjmJTWP9cu/pkojCW18IHa1i3L+PVr88Nz6Z
         +eZelq7nzPP1TUKGOqtyd52Cd+CJlZF3kgPxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HdrP+5n5nJbtYjgIlEc+YGa9TEsVBxE5SMpV5kWYO54=;
        b=KD2IeyWXDCL6jVbnYdXJ3YWlnoGFlAFHSgHX34CDttoFb+Xar0qTCYTc2VYzEnsOJx
         EUq6Mwuxo1OjrStf21tgZibpk7MDIl8ur4wT1y9Fkjehs+qTiKOSQpn3q3trZWzLjw6U
         vcPbdD6I+p1jZQmB/SJWVt//fCVmh8MZ/Iv4PNrdvQ1q/CuIxEEqiOzqOTwnGSzdJ+m0
         fBftKIb05aWfwk7o3jYAc0auGqaHFatvzqoq/CkKSZj4ZAmGK5qQxGx/GTh7fKMsRG7e
         OPCqXm+HMiDVpzNR55v7iwkWYq+mChkxzJtcW3P1MLeX2EY7qq5SIncULBBBOlqjEXeW
         ZVFA==
X-Gm-Message-State: APjAAAUv6OH4tk8CQjrWlo8q1jHA7/cjH1nD2QAe+0GHFxzQjhaF8Cuw
        JvwAmwgzUX+gWD/FV9pkVLskMQ==
X-Google-Smtp-Source: APXvYqz06zuULBLTFE1ez0fbfhzDyTWB/DJY0xO9Mb6EE/MT2PdTDwBE7MPtcjYDNo22x5YKVDkx7A==
X-Received: by 2002:a17:902:704c:: with SMTP id h12mr31681479plt.214.1562019066802;
        Mon, 01 Jul 2019 15:11:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y68sm12874496pfy.164.2019.07.01.15.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 15:11:05 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:11:04 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/3] net: phy: realtek: Support SSC for the RTL8211E
Message-ID: <20190701221104.GC250418@google.com>
References: <20190701195225.120808-1-mka@chromium.org>
 <20190701195225.120808-3-mka@chromium.org>
 <8adbb2b8-6747-b876-f85d-75e54f1978cb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8adbb2b8-6747-b876-f85d-75e54f1978cb@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:49:45PM +0200, Heiner Kallweit wrote:
> On 01.07.2019 21:52, Matthias Kaehlcke wrote:
> > By default Spread-Spectrum Clocking (SSC) is disabled on the RTL8211E.
> > Enable it if the device tree property 'realtek,enable-ssc' exists.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/net/phy/realtek.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index dfc2e20ef335..b617169ccc8c 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -9,8 +9,10 @@
> >   * Copyright (c) 2004 Freescale Semiconductor, Inc.
> >   */
> >  #include <linux/bitops.h>
> > -#include <linux/phy.h>
> > +#include <linux/device.h>
> > +#include <linux/of.h>
> >  #include <linux/module.h>
> > +#include <linux/phy.h>
> >  
> >  #define RTL821x_PHYSR				0x11
> >  #define RTL821x_PHYSR_DUPLEX			BIT(13)
> > @@ -28,6 +30,8 @@
> >  
> >  #define RTL8211E_EXT_PAGE			7
> >  #define RTL8211E_EPAGSR				0x1e
> > +#define RTL8211E_SCR				0x1a
> > +#define RTL8211E_SCR_DISABLE_RXC_SSC		BIT(2)
> >  
> >  #define RTL8211F_INSR				0x1d
> >  
> > @@ -87,8 +91,8 @@ static int rtl821e_restore_page(struct phy_device *phydev, int oldpage, int ret)
> >  	return ret;
> >  }
> >  
> > -static int __maybe_unused rtl8211e_modify_ext_paged(struct phy_device *phydev,
> > -				    int page, u32 regnum, u16 mask, u16 set)
> > +static int rtl8211e_modify_ext_paged(struct phy_device *phydev, int page,
> > +				     u32 regnum, u16 mask, u16 set)
> >  {
> >  	int ret = 0;
> >  	int oldpage;
> > @@ -114,6 +118,22 @@ static int __maybe_unused rtl8211e_modify_ext_paged(struct phy_device *phydev,
> >  	return rtl821e_restore_page(phydev, oldpage, ret);
> >  }
> >  
> > +static int rtl8211e_probe(struct phy_device *phydev)
> > +{
> > +	struct device *dev = &phydev->mdio.dev;
> > +	int err;
> > +
> > +	if (of_property_read_bool(dev->of_node, "realtek,enable-ssc")) {
> > +		err = rtl8211e_modify_ext_paged(phydev, 0xa0, RTL8211E_SCR,
> > +						RTL8211E_SCR_DISABLE_RXC_SSC,
> > +						0);
> > +		if (err)
> > +			dev_err(dev, "failed to enable SSC on RXC: %d\n", err);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int rtl8201_ack_interrupt(struct phy_device *phydev)
> >  {
> >  	int err;
> > @@ -372,6 +392,7 @@ static struct phy_driver realtek_drvs[] = {
> >  		.config_init	= &rtl8211e_config_init,
> >  		.ack_interrupt	= &rtl821x_ack_interrupt,
> >  		.config_intr	= &rtl8211e_config_intr,
> > +		.probe          = rtl8211e_probe,
> 
> I'm not sure whether this setting survives soft reset and power-down.
> Maybe it should be better applied in the config_init callback.

Sounds reasonable, I'll change it in the next revision, thanks!
