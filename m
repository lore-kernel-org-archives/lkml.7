Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936FAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A7120842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b2XZiyEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbfCANxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:53:07 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43206 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387877AbfCANxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Bb0FdK7wlKalmwwf5akDQd7YXSDiXQOEOXvyxrkezq0=; b=b2XZiyEARMwvzxZulMYYr+aFQ8
        GMGPjwIUH4o4zXLV0o/LeYMdc3jUqZ5N39R6tYUxwUabqCSRJUuMubn+JYKYZAMJwyhshQ2iCwRDU
        QgALjGWHV1yAE7u9BA6vpQNxtQ1Hxk8YLnSZNWx+QFRZWnDZTphm1GyGsJpWqnmVb7x0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gzib1-0005YY-0E; Fri, 01 Mar 2019 14:53:03 +0100
Date:   Fri, 1 Mar 2019 14:53:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net 2/2] net: phy: Use C45 Helpers in PHY_FORCING state
Message-ID: <20190301135302.GB19813@lunn.ch>
References: <cover.1551437561.git.joabreu@synopsys.com>
 <8480c38d6f3bc5c4f6c332a788bc82999266aab7.1551437561.git.joabreu@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8480c38d6f3bc5c4f6c332a788bc82999266aab7.1551437561.git.joabreu@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:54:24AM +0100, Jose Abreu wrote:
> +static inline int phy_update_link(struct phy_device *phydev)
> +{
> +	if (!phydev->drv)
> +		return -EIO;
> +
> +	if (phydev->drv->read_status)
> +		return phydev->drv->read_status(phydev);
> +	else if (phydev->is_c45)
> +		return gen10g_read_status(phydev);
> +	else
> +		return genphy_update_link(phydev);
> +}

Hi Jose

The asymmetry here could be an issue.  We might fall into the trap
that a c45 PHY has the full state in phydev updated, were as a c22
only has the link updated. Somebody testing on C45 might miss a bug
for a C22 device.

Maybe this should be called phy_read_state(), and calls
genphy_read_status() not genphy_update_link().

     Andrew
