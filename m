Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B6BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E07820880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CjA6pbUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436835AbfHBR7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:59:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32968 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406492AbfHBR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:59:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so33847181plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OVqucGi6mCgtuzFb+mM0I54hdxnF7iQT16DRkPLbzfw=;
        b=CjA6pbUuaMPDMwcOs1NU1RiCZ3DR8v3r3TDpISfRp+sa+efn/P6rt3PH/uZnyP2ZnZ
         qriwMeECuq/cObFfAIzcDKwqO9kg5UXXdlagupGgYXVp1Nzi/TI2S8IS8UT/sY/wP4ct
         HjvPLaDl0To+ZtkRiw10XQrLFbXCLXCiBEIdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OVqucGi6mCgtuzFb+mM0I54hdxnF7iQT16DRkPLbzfw=;
        b=NK6jwAM39hyFx8mwshSDckb2zR8YgNRty3Aao6p91hYxlfibt+hLLAmtqEmFeei+GY
         7GKPOLkYrZTUqKLBFuYu9hYG+7Qpneo6VH9Aw/cZw7wIzNvg6ayrqdyQYrcc4PZYqupW
         hmvdIho8F3yy88MjX3sEqzzAJEhf+SookXLA6Je96UU6wUDhzkKUhET+dqjUGhDP5rSd
         y4Kwfc6BqYU/36l1lSWPaoigFu0PLygZU9oay2WxZG/qmGihsd7IaEP1Rz16TVaHNrgi
         UI1s1okik0omNEWmHcnH21TAnLjvO/iwuPJG+URHUrisbPNwlOrpOdOJDSKQNbPypygM
         1IuQ==
X-Gm-Message-State: APjAAAWC6BV3WjZ3yQ1LOtBR8sXwnnGOTIcUdzzDTu5qgj8I3irES9Qs
        iCS5IuwVkZqvU/SoLU0DGH5iqg==
X-Google-Smtp-Source: APXvYqwEB0rTsAhxiTa/i+1acy/zxoYQ//dir91uDgoORP0CSaaYnGoNXT6j/HgT+qMctyliELEGGg==
X-Received: by 2002:a17:902:204:: with SMTP id 4mr45618964plc.178.1564768762354;
        Fri, 02 Aug 2019 10:59:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v184sm75225172pfb.82.2019.08.02.10.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 10:59:20 -0700 (PDT)
Date:   Fri, 2 Aug 2019 10:59:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 2/4] net: phy: Add function to retrieve LED
 configuration from the DT
Message-ID: <20190802175918.GK250418@google.com>
References: <20190801190759.28201-1-mka@chromium.org>
 <20190801190759.28201-3-mka@chromium.org>
 <20190802163810.GL2099@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802163810.GL2099@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 06:38:10PM +0200, Andrew Lunn wrote:
> On Thu, Aug 01, 2019 at 12:07:57PM -0700, Matthias Kaehlcke wrote:
> > Add a phylib function for retrieving PHY LED configuration that
> > is specified in the device tree using the generic binding. LEDs
> > can be configured to be 'on' for a certain link speed or to blink
> > when there is TX/RX activity.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v4:
> > - patch added to the series
> > ---
> >  drivers/net/phy/phy_device.c | 50 ++++++++++++++++++++++++++++++++++++
> >  include/linux/phy.h          | 15 +++++++++++
> >  2 files changed, 65 insertions(+)
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 6b5cb87f3866..b4b48de45712 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -2188,6 +2188,56 @@ static bool phy_drv_supports_irq(struct phy_driver *phydrv)
> >  	return phydrv->config_intr && phydrv->ack_interrupt;
> >  }
> >  
> > +int of_get_phy_led_cfg(struct phy_device *phydev, int led,
> > +		       struct phy_led_config *cfg)
> > +{
> > +	struct device_node *np, *child;
> > +	const char *trigger;
> > +	int ret;
> > +
> > +	if (!IS_ENABLED(CONFIG_OF_MDIO))
> > +		return -ENOENT;
> > +
> > +	np = of_find_node_by_name(phydev->mdio.dev.of_node, "leds");
> > +	if (!np)
> > +		return -ENOENT;
> > +
> > +	for_each_child_of_node(np, child) {
> > +		u32 val;
> > +
> > +		if (!of_property_read_u32(child, "reg", &val)) {
> > +			if (val == (u32)led)
> > +				break;
> > +		}
> > +	}
> 
> Hi Matthias
> 
> This is leaking references to np and child. In the past we have not
> cared about this too much, but we are now getting patches adding the
> missing releases. So it would be good to fix this.

Good point, I'll fix it in the next revision.

Thanks

Matthias
