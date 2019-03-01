Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D95C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E71120850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1qYl0gkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbfCAOT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:19:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43265 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfCAOT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=r0b2oemYV3/pznRtJrgjg+k5w6OwEbEJxnXKf8pEDy4=; b=1qYl0gkLaQfrW82ZeVB01jmXke
        /mxYeDXTTdEJ8G828L0rBc7L8ih/FVMkxlfd4bSP4dFCCY5YBJITSckuyB6b5RD9IVyhRpjUDWpc/
        Za7hj5ZJZMcvsfHm5muWLOSOdX7++IEgOB7BGc9gsDrGDUhK9OA9NJ0lERdGQIiJgP2A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gzj0z-0006Pf-AS; Fri, 01 Mar 2019 15:19:53 +0100
Date:   Fri, 1 Mar 2019 15:19:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, linux@armlinux.org.uk, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 3/3] net: phy: marvell10g: set the PHY in low
 power by default
Message-ID: <20190301141953.GF19813@lunn.ch>
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
 <20190301110047.20257-4-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301110047.20257-4-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 12:00:47PM +0100, Antoine Tenart wrote:
> When the Marvell 10G PHYs are set out of reset, the LPOWER bit is set
> depending on an hardware configuration choice. We also do not know what
> is the PHY state at boot time. Hence, set the PHY in low power by
> default when this driver probes.

Hi Antoine

Florian did some work for c22 PHYs so that the existing link state
could be used at boot. So for example, the bootloader configured the
PHY up and it got link, there is no need to down/up the PHY when linux
takes control. The networking comes up faster that way.

Can this work for this PHY?

    Andrew
