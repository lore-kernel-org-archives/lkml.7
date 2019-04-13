Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E3C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAE02084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qi4BLp65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfDMQmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:42:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60342 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfDMQmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JPZfYo3LPJOBslPQwLim6XXf19GaxAFw2vR85TWDR0w=; b=Qi4BLp65pjsiffwvXMUAsL8v62
        +osGMHahDUPNjX96ujpqx+qqNCwZTBbimJrurY0/SLejzAobkyAXa99dF8khT1isgKi6JPGB7GHdi
        IiP8KM8rObEUPTITPbeCLgO0xMbLeWe1ds5S0Bv5w0SQGXWHbtptT6b4VY3ljmjBr63c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFLin-0005Q8-LR; Sat, 13 Apr 2019 18:41:41 +0200
Date:   Sat, 13 Apr 2019 18:41:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 19/24] net: dsa: sja1105: Add support for
 Spanning Tree Protocol
Message-ID: <20190413164141.GH17901@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-20-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-20-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 04:28:17AM +0300, Vladimir Oltean wrote:
> While not explicitly documented as supported in UM10944, compliance with
> the STP states can be obtained by manipulating 3 settings at the
> (per-port) MAC config level: dynamic learning, inhibiting reception of
> regular traffic, and inhibiting transmission of regular traffic.
> 
> In all these modes, transmission and reception of special BPDU frames
> from the stack is still enabled (not inhibited by the MAC-level
> settings).
> 
> On ingress, BPDUs are classified by the MAC filter as link-local
> (01-80-C2-00-00-00) and forwarded to the CPU port.  This mechanism works
> under all conditions (even without the custom 802.1Q tagging) because
> the switch hardware inserts the source port and switch ID into bytes 4
> and 5 of the MAC-filtered frames. Then the DSA .rcv handler needs to put
> back zeroes into the MAC address after decoding the source port
> information.
> 
> On egress, BPDUs are transmitted using management routes from the xmit
> worker thread. Again this does not require switch tagging, as the switch
> port is programmed through SPI to hold a temporary (single-fire) route
> for a frame with the programmed destination MAC (01-80-C2-00-00-00).
> 
> STP is activated using the following commands and was tested by
> connecting two front-panel ports together and noticing that switching
> loops were prevented (one port remains in the blocking state):
> 
> $ ip link add name br0 type bridge stp_state 1 && ip link set br0 up
> $ for eth in $(ls /sys/devices/platform/soc/2100000.spi/spi_master/spi0/spi0.1/net/);
>   do ip link set ${eth} master br0 && ip link set ${eth} up; done
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
