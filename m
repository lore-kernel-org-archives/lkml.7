Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD63C19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5AA20844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ktHMOT70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHDOwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 10:52:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59766 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfHDOwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 10:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=j8VdqIQ8dJCQg66t0XShnIYIOvNwsHrmT7xHQgMAnSQ=; b=ktHMOT70nx8YWSJEVkNw8K/kv2
        wHIlsypDeYfKw0tUOlKLoU1zAqvRRX5JXBoUY99mfGyTh8LcXzSXyA30Td/wJhHdYraetkAXTZtXa
        qLRELuRtqYfPdpBZr45N4o+Wd/LB5QPA1VZm801lifTunI5j/ctHRIKIxE1SKs2ldQQ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1huHrU-0001qV-Cu; Sun, 04 Aug 2019 16:51:52 +0200
Date:   Sun, 4 Aug 2019 16:51:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tao Ren <taoren@fb.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net-next v3] net: phy: broadcom: add 1000Base-X support
 for BCM54616S
Message-ID: <20190804145152.GA6800@lunn.ch>
References: <20190802215419.313512-1-taoren@fb.com>
 <CA+h21hrOEape89MTqCUyGFt=f6ba7Q-2KcOsN_Vw2Qv8iq86jw@mail.gmail.com>
 <53e18a01-3d08-3023-374f-2c712c4ee9ea@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e18a01-3d08-3023-374f-2c712c4ee9ea@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The patchset looks better now. But is it ok, I wonder, to keep
> > PHY_BCM_FLAGS_MODE_1000BX in phydev->dev_flags, considering that
> > phy_attach_direct is overwriting it?
> 

> I checked ftgmac100 driver (used on my machine) and it calls
> phy_connect_direct which passes phydev->dev_flags when calling
> phy_attach_direct: that explains why the flag is not cleared in my
> case.

Yes, that is the way it is intended to be used. The MAC driver can
pass flags to the PHY. It is a fragile API, since the MAC needs to
know what PHY is being used, since the flags are driver specific.

One option would be to modify the assignment in phy_attach_direct() to
OR in the flags passed to it with flags which are already in
phydev->dev_flags.

	Andrew
