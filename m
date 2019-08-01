Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C78C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22F9206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ed/qRiSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfHAEGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 00:06:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52958 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfHAEGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0nEIRUfN3zxsNAh48LslJgJUypuGqC8H3HJtRe8muw4=; b=Ed/qRiSwHqaqhTMRwJLrcoWg42
        SMVd6TmaE41zAaBb6SGmyGCHZm5ShtqqJYzCOueWexv7cnO9CAkY964OCQhgmLQtaF9OBUglTP0SH
        dXgfmyJrC4ejwk71xvV5iQqrdbMte5S+WfZP5JeMn9RsFLwg76O09D2zXFIUzQWbKjb0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1ht2Ma-0001XR-44; Thu, 01 Aug 2019 06:06:48 +0200
Date:   Thu, 1 Aug 2019 06:06:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH 2/2] net: gmii2rgmii: Switch priv field in mdio device
 structure
Message-ID: <20190801040648.GJ2713@lunn.ch>
References: <1564565779-29537-1-git-send-email-harini.katakam@xilinx.com>
 <1564565779-29537-3-git-send-email-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564565779-29537-3-git-send-email-harini.katakam@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:06:19PM +0530, Harini Katakam wrote:
> Use the priv field in mdio device structure instead of the one in
> phy device structure. The phy device priv field may be used by the
> external phy driver and should not be overwritten.

Hi Harini

I _think_ you could use dev_set_drvdata(&mdiodev->dev) in xgmiitorgmii_probe() and
dev_get_drvdata(&phydev->mdiomdio.dev) in _read_status()

       Andrew
