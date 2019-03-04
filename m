Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDACC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7EC206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oEs2t+W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCDPo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:44:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45898 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfCDPo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BVn4/Yl2l7LD3pOif82KMm787kwaCWO4/tMOxCP7jso=; b=oEs2t+W8m/Tihe8T680k6w3/Yf
        p3cQukLar1spyOeUux+0oyH/l+ZtRvuIaL9XjtIusDtVijPJl9tWYAgslXP1jveLQRi9X4Z4J1E0d
        bYUAjsT3KeGaBcrg3sMWjIFmksNi0GZpu487mT6MoUFc2643ilUrVnTpJpyTNZ1E9IPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h0plv-0005CW-22; Mon, 04 Mar 2019 16:44:55 +0100
Date:   Mon, 4 Mar 2019 16:44:55 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net 2/2] net: phy: Use C45 Helpers in PHY_FORCING state
Message-ID: <20190304154455.GD18622@lunn.ch>
References: <cover.1551437561.git.joabreu@synopsys.com>
 <8480c38d6f3bc5c4f6c332a788bc82999266aab7.1551437561.git.joabreu@synopsys.com>
 <20190301135302.GB19813@lunn.ch>
 <97425bd9-3ea5-b2c3-abc1-e5285a3e677e@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97425bd9-3ea5-b2c3-abc1-e5285a3e677e@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 03:07:24PM +0000, Jose Abreu wrote:
> Hi Andrew,
> 
> On 3/1/2019 1:53 PM, Andrew Lunn wrote:
> > On Fri, Mar 01, 2019 at 11:54:24AM +0100, Jose Abreu wrote:
> >> +static inline int phy_update_link(struct phy_device *phydev)
> >> +{
> >> +	if (!phydev->drv)
> >> +		return -EIO;
> >> +
> >> +	if (phydev->drv->read_status)
> >> +		return phydev->drv->read_status(phydev);
> >> +	else if (phydev->is_c45)
> >> +		return gen10g_read_status(phydev);
> >> +	else
> >> +		return genphy_update_link(phydev);
> >> +}
> > 
> > Hi Jose
> > 
> > The asymmetry here could be an issue.  We might fall into the trap
> > that a c45 PHY has the full state in phydev updated, were as a c22
> > only has the link updated. Somebody testing on C45 might miss a bug
> > for a C22 device.
> 
> Notice that this phy_update_link() is called from PHY_FORCING
> state which in my case happens when autoneg is not enabled / is
> not supported.
> 
> I think it makes sense, in this case, to only update link status,
> no ?
 
Hi Jose

It is actually quite difficult to determine when the link is up. I
personally would not trust gen10g_read_status() to get this right, and
would always implement the read_status callback.

Which PHY driver are you using, which does not support
read_status(). All the mainline PHY drivers do seem to have
read_status implemented.

    Andrew
