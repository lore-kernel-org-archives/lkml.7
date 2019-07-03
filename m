Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084A5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36CB218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i/PDO53Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGCUcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:32:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42406 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:32:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so1820237plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l7QTIU39WbGgNxpqHk/rQWXH658WW2+nXc1D+IbTyqQ=;
        b=i/PDO53YknvDxsmpUlY5WMTP6lFmxNQVpr7dbtzg14LI26sjTul+WHfmpQsVZ8uvh5
         /B06lochxNQ3zGnLgAwXjyCwVErxqc1b8yyZhJMbnm4t/g4Ehe/YGRp4Hrx+O27HVkaS
         ds6E+hxYF4SQl6TxYO1J3pbD9wwwBSsKEOgDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7QTIU39WbGgNxpqHk/rQWXH658WW2+nXc1D+IbTyqQ=;
        b=aRwm5yWiFSTI+pGatBMCdbwKW4S46Fw7tzLPLPatwg3FdUMSRkxXqnmkykwjpoHh80
         WVn1JpnfbVDbcfqX2B7Q9GMr4dWq+LL1DZAXbLlvcpO933bUDdHUNPhmuUTjxhe7D9kB
         QUIE02PWKMCcPxy9QlB6tPkOGtRQyJNlpZLcksPWmFdek3HdLIBkZOtruuuafY57QFz/
         g76CFXBYvhjLBzX/8AasaE9p7vtl2rk7pDxpN8xB2+Nbm9SMgJ0xIZlMLAhvT4S4UxHx
         xhW+RjcUoQD6Ki1OoLIieiZZ1+Z6WyLCzn8mQzRYzCCMbn+vkmdBx8UorOB79ZttKh6s
         Gycg==
X-Gm-Message-State: APjAAAU2c9KPIxxNZoSfix4yvMgr9UWBV/4SjpiGSB7kU9oYfL0ZXFFf
        niqYGhbjlvkDs9PPz07fxvotqA==
X-Google-Smtp-Source: APXvYqzAEp++YNnisvcoj6zq4UQd893GB9VfCRudl4/qLynhPsEDXlNKQDyXPS6cxdQnfiExwmtHHg==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr43964560pla.89.1562185926577;
        Wed, 03 Jul 2019 13:32:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g6sm2824380pgh.64.2019.07.03.13.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:32:06 -0700 (PDT)
Date:   Wed, 3 Jul 2019 13:32:04 -0700
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
Subject: Re: [PATCH v2 2/7] net: phy: realtek: Allow disabling RTL8211E EEE
 LED mode
Message-ID: <20190703203204.GE250418@google.com>
References: <20190703193724.246854-1-mka@chromium.org>
 <20190703193724.246854-2-mka@chromium.org>
 <743dda1b-532d-175f-1f87-5d80ba4a2e94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <743dda1b-532d-175f-1f87-5d80ba4a2e94@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 03, 2019 at 10:09:39PM +0200, Heiner Kallweit wrote:
> On 03.07.2019 21:37, Matthias Kaehlcke wrote:
> > EEE LED mode is enabled by default on the RTL8211E. Disable it when
> > the device tree property 'realtek,eee-led-mode-disable' exists.
> > 
> > The magic values to disable EEE LED mode were taken from the RTL8211E
> > datasheet, unfortunately they are not further documented.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - patch added to the series
> > ---
> >  drivers/net/phy/realtek.c | 37 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index a669945eb829..eb815cbe1e72 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -9,8 +9,9 @@
> >   * Copyright (c) 2004 Freescale Semiconductor, Inc.
> >   */
> >  #include <linux/bitops.h>
> > -#include <linux/phy.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/phy.h>
> >  
> >  #define RTL821x_PHYSR				0x11
> >  #define RTL821x_PHYSR_DUPLEX			BIT(13)
> > @@ -26,6 +27,10 @@
> >  #define RTL821x_EXT_PAGE_SELECT			0x1e
> >  #define RTL821x_PAGE_SELECT			0x1f
> >  
> > +/* RTL8211E page 5 */
> > +#define RTL8211E_EEE_LED_MODE1			0x05
> > +#define RTL8211E_EEE_LED_MODE2			0x06
> > +
> >  #define RTL8211F_INSR				0x1d
> >  
> >  #define RTL8211F_TX_DELAY			BIT(8)
> > @@ -53,6 +58,35 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
> >  	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
> >  }
> >  
> > +static int rtl8211e_disable_eee_led_mode(struct phy_device *phydev)
> > +{
> 
> You define return type int but AFAICS the return value is never used,
> also in subsequent patches.

ok, I'll change it to void

> > +	int ret = 0;
> > +	int oldpage;
> > +
> > +	oldpage = phy_select_page(phydev, 5);
> > +	if (oldpage < 0)
> > +		goto out;
> > +
> > +	/* write magic values to disable EEE LED mode */
> > +	ret = __phy_write(phydev, RTL8211E_EEE_LED_MODE1, 0x8b82);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = __phy_write(phydev, RTL8211E_EEE_LED_MODE2, 0x052b);
> > +
> > +out:
> > +	return phy_restore_page(phydev, oldpage, ret);
> > +}
> > +
> > +static int rtl8211e_config_init(struct phy_device *phydev)
> > +{
> > +	struct device *dev = &phydev->mdio.dev;
> > +
> > +	if (of_property_read_bool(dev->of_node, "realtek,eee-led-mode-disable"))
> > +		rtl8211e_disable_eee_led_mode(phydev);
> > +
> > +	return 0;
> > +}
> 
> I suppose checkpatch complains about the missing empty line.
> You add it in a later patch, in case of a v3 you could fix that.

Actually checkpatch does not complain, I'll fix it in v3.

Thanks

Matthias
