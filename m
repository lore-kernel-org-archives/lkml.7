Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEB8FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79D62067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2WMA4dKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405628AbfJPN46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:56:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48452 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404394AbfJPN45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Yel5A7Nlk1GVVO5BMmxqt3XQopVkil3k1QScmPuKwqk=; b=2WMA4dKWSgbOpDLPcqYua4TJSL
        GusKDS1F4eOR4BmyTEkYtyigdtONrcKJ3iFYSQzVz+ih6OovLQuCH28TJcfnCJnju92Em/K3CdYTM
        eY4pJGcYpQHWKJEBSC8XxFrjzk2KA3Ec60wo58fFo3Hu931ynjkSOsi6D8vUxpM2xJk4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iKjnJ-0007ix-1m; Wed, 16 Oct 2019 15:56:53 +0200
Date:   Wed, 16 Oct 2019 15:56:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, olteanv@gmail.com,
        rmk+kernel@armlinux.org.uk, cphealy@gmail.com,
        Jose Abreu <joabreu@synopsys.com>
Subject: Re: [PATCH net-next 1/2] net: phy: Use genphy_loopback() by default
Message-ID: <20191016135653.GB17013@lunn.ch>
References: <20191015224953.24199-1-f.fainelli@gmail.com>
 <20191015224953.24199-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015224953.24199-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:49:52PM -0700, Florian Fainelli wrote:
> The standard way of putting a PHY device into loopback is most often
> suitable for testing. This is going to be necessary in a subsequent
> patch that adds RGII debugging capability using the loopback feature.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/phy/phy_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 9d2bbb13293e..c2e66b9ec161 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1514,7 +1514,7 @@ int phy_loopback(struct phy_device *phydev, bool enable)
>  	if (phydev->drv && phydrv->set_loopback)
>  		ret = phydrv->set_loopback(phydev, enable);
>  	else
> -		ret = -EOPNOTSUPP;
> +		ret = genphy_loopback(phydev, enable);

Hi Florian

I think you need to differentiate between C22 and C45 somewhere.

  Andrew
