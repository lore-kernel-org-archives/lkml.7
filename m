Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A682087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K4zfPaqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfHBQiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:38:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57416 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbfHBQiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vxCsCNQWqLeWrA3y8RCekTBrHa/5LhPIa+3s2OFLSmI=; b=K4zfPaquorQ1qToZfbnPnAHCjJ
        gowUkVGA0TobpliIakmVAGlTfhhaDct7irgPiZNi818VclwpD8b6E+FgUw+lIqadzrf14EXvfNr6/
        Hr/SJ32kpgmGGnvTFCMSbZreAMvuSGcW7pn9Jg7J7CtAeRBI/9H0WrFn1vydtCCg6pA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1htaZG-0002JS-Jr; Fri, 02 Aug 2019 18:38:10 +0200
Date:   Fri, 2 Aug 2019 18:38:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 2/4] net: phy: Add function to retrieve LED
 configuration from the DT
Message-ID: <20190802163810.GL2099@lunn.ch>
References: <20190801190759.28201-1-mka@chromium.org>
 <20190801190759.28201-3-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801190759.28201-3-mka@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:07:57PM -0700, Matthias Kaehlcke wrote:
> Add a phylib function for retrieving PHY LED configuration that
> is specified in the device tree using the generic binding. LEDs
> can be configured to be 'on' for a certain link speed or to blink
> when there is TX/RX activity.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v4:
> - patch added to the series
> ---
>  drivers/net/phy/phy_device.c | 50 ++++++++++++++++++++++++++++++++++++
>  include/linux/phy.h          | 15 +++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 6b5cb87f3866..b4b48de45712 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2188,6 +2188,56 @@ static bool phy_drv_supports_irq(struct phy_driver *phydrv)
>  	return phydrv->config_intr && phydrv->ack_interrupt;
>  }
>  
> +int of_get_phy_led_cfg(struct phy_device *phydev, int led,
> +		       struct phy_led_config *cfg)
> +{
> +	struct device_node *np, *child;
> +	const char *trigger;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_OF_MDIO))
> +		return -ENOENT;
> +
> +	np = of_find_node_by_name(phydev->mdio.dev.of_node, "leds");
> +	if (!np)
> +		return -ENOENT;
> +
> +	for_each_child_of_node(np, child) {
> +		u32 val;
> +
> +		if (!of_property_read_u32(child, "reg", &val)) {
> +			if (val == (u32)led)
> +				break;
> +		}
> +	}

Hi Matthias

This is leaking references to np and child. In the past we have not
cared about this too much, but we are now getting patches adding the
missing releases. So it would be good to fix this.

	Andrew
