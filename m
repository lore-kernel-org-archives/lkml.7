Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EA6C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1E321019
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 15:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="22VYp0HB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfKIPKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 10:10:05 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:58118 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfKIPKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 10:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aK1/Bynq/S5FJwndRe1A0tkeecA2rpo7jhzcq7s2SFY=; b=22VYp0HBQPgOAD4jdGXUI4g8OJ
        JZ26IupiPr6t0vQXGD5tWwfBBEruyp17X170YTvZktUq6nICEPC6fLS6YFA6z+CLcCJisPR2EGqA/
        j/JMr6c0eZmzgqobKm8D4/MBVPmzB7FviNp5rvBbPYY9uXOWhVUjdGV3uuZuprjYaR30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iTSN7-0002cV-Ry; Sat, 09 Nov 2019 16:09:53 +0100
Date:   Sat, 9 Nov 2019 16:09:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     shawnguo@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021a-tsn: Use interrupts for the SGMII PHYs
Message-ID: <20191109150953.GJ22978@lunn.ch>
References: <20191109105642.30700-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109105642.30700-1-olteanv@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2019 at 12:56:42PM +0200, Vladimir Oltean wrote:
> On the LS1021A-TSN board, the 2 Atheros AR8031 PHYs for eth0 and eth1
> have interrupt lines connected to the shared IRQ2_B LS1021A pin.
> 
> The interrupts are active low, but the GICv2 controller does not support
> active-low and falling-edge interrupts, so the only mode it can be
> configured in is rising-edge.

Hi Vladimir

So how does this work? The rising edge would occur after the interrupt
handler has completed? What triggers the interrupt handler?

	Andrew
