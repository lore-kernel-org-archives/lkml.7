Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4254C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F7B2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XHZKZXih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDBVit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:38:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47816 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfDBVis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xC5VVpi9LAQPc7IBo51ydAnnitOEpX+Jfp+75ujUPlA=; b=XHZKZXihROeHICPCc/JLg4aOGh
        VOnimhDcSG/ZmO3NrmdAtNIzic8TsUzRhS27yP4u87xR4onTrl4mzp4KOJ19J5ai9SUyw3CVTnFKQ
        2E+hu5PWL53/vx/owYyVsN0xNeuHfU5dJ7VUhb8WXK7QIG4jVM3s6m0zdGw1tu+rEQyk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hBR7F-0001Sa-Vw; Tue, 02 Apr 2019 23:38:45 +0200
Date:   Tue, 2 Apr 2019 23:38:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        georg.waibel@sensor-technik.de
Subject: Re: [PATCH net-next 17/17] dt-bindings: net: dsa: Add documentation
 for NXP SJA1105 driver
Message-ID: <20190402213845.GI22349@lunn.ch>
References: <20190331174232.22060-1-olteanv@gmail.com>
 <20190331174232.22060-18-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331174232.22060-18-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +Optional properties:
> +
> +- sja1105,mac-mode, sja1105,phy-mode: Boolean properties that can be assigned
> +  under each port node that is MII or RMII (has no effect for RGMII).  By
> +  default (unless otherwise specified) a port is configured as MAC if it is
> +  driving a PHY (phy-handle is present) or as PHY if it is PHY-less (fixed-link
> +  specified, presumably because it is connected to a MAC).  These properties
> +  are required in the case where SJA1105 ports are at both ends of an MII/RMII
> +  PHY-less setup. One end would need to have sja1105,mac-mode, while the other
> +  sja1105,phy-mode.

Hi Vladimir

phy-mode has a well known meaning, indicating mii, gmii, sqmii, rmii,
rxaud, etc.

The meaning here is quite different. To maybe avoid confusion, could
we flip the name around?

sja1105,mode-mac and sja1105,mode-phy?

> +			port@4 {
> +				/* Internal port connected to eth2 */
> +				ethernet = <&enet2>;
> +				phy-mode = "rgmii";
> +				reg = <4>;
> +				/* Implicit "sja1105,phy-mode;" */
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +		};
> +	};
> +};


> +&enet2 {
> +	phy-connection-type = "rgmii";

You don't see this used much, phy-mode is preferred. Do you have a
reason for this?

Also, you have the MAC using RGMII and the port using RGMII. Neither
is inserting delays. That implies the delays are added by the track
layout of the PCB. It would be good to add a comment about
this. Anybody copying this using a design without the delays via PCB
are probably going to get it wrong to start with and not realise they
need to change one end to RGMII-ID.

Thanks
     Andrew
