Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADEDC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002E620830
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="orXVAiG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfINP0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 11:26:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46048 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfINP0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 11:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Gu2/E1jQT/djmSN+1Ow/2oKHc/9iBWV1CyLhdr4bwyk=; b=orXVAiG3tVeRtbWR0pUZGHTok+
        ah2TcwUj78C8nCNySp1zL69VoiU53ERg/8BRBMk3doZveVrrBiqlqqJAjsnCq/WyBMaMsG7rYHODl
        SCPcwpix9N1ZQZ879L39xkpgGmV2LRGGQKnzsnEXojKG6ELvo2wlyiJHBz/epmOBxr5M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i99wE-0008C8-Ox; Sat, 14 Sep 2019 17:26:14 +0200
Date:   Sat, 14 Sep 2019 17:26:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, mkubecek@suse.cz
Subject: Re: [PATCH v4 1/2] ethtool: implement Energy Detect Powerdown
 support via phy-tunable
Message-ID: <20190914152614.GJ27922@lunn.ch>
References: <20190912162812.402-1-alexandru.ardelean@analog.com>
 <20190912162812.402-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912162812.402-2-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 07:28:11PM +0300, Alexandru Ardelean wrote:
> The `phy_tunable_id` has been named `ETHTOOL_PHY_EDPD` since it looks like
> this feature is common across other PHYs (like EEE), and defining
> `ETHTOOL_PHY_ENERGY_DETECT_POWER_DOWN` seems too long.
> 
> The way EDPD works, is that the RX block is put to a lower power mode,
> except for link-pulse detection circuits. The TX block is also put to low
> power mode, but the PHY wakes-up periodically to send link pulses, to avoid
> lock-ups in case the other side is also in EDPD mode.
> 
> Currently, there are 2 PHY drivers that look like they could use this new
> PHY tunable feature: the `adin` && `micrel` PHYs.
> 
> The ADIN's datasheet mentions that TX pulses are at intervals of 1 second
> default each, and they can be disabled. For the Micrel KSZ9031 PHY, the
> datasheet does not mention whether they can be disabled, but mentions that
> they can modified.
> 
> The way this change is structured, is similar to the PHY tunable downshift
> control:
> * a `ETHTOOL_PHY_EDPD_DFLT_TX_MSECS` value is exposed to cover a default
>   TX interval; some PHYs could specify a certain value that makes sense
> * `ETHTOOL_PHY_EDPD_NO_TX` would disable TX when EDPD is enabled
> * `ETHTOOL_PHY_EDPD_DISABLE` will disable EDPD
> 
> As noted by the `ETHTOOL_PHY_EDPD_DFLT_TX_MSECS` the interval unit is 1
> millisecond, which should cover a reasonable range of intervals:
>  - from 1 millisecond, which does not sound like much of a power-saver
>  - to ~65 seconds which is quite a lot to wait for a link to come up when
>    plugging a cable
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
