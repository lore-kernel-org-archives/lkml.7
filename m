Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB80C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144C0206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hyyYKEUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfDZUFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:05:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45964 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfDZUF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=n8D5SWOR0NCEwB3Adrs41RtWTB1GNLwZRWOWg86mWCk=; b=hyyYKEUT2N21ugLhrRHS/XPqai
        1OjHyql+xtk32rdHnoFvE/SaZmFSgJv9UvFBQsAJXKX95W97YJOc617btXjJonX9WXj2vBNp4Sh3i
        Ba9Y/YqcewBJkaSC6vsi64nXRAqjUzD5IUHcp9WJDLMMhkzUfx/D/6mZOu0i02FX/a+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK761-0004PU-WB; Fri, 26 Apr 2019 22:05:22 +0200
Date:   Fri, 26 Apr 2019 22:05:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: Add rtl8211e rx/tx delays config
Message-ID: <20190426200521.GH4041@lunn.ch>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426132821.GB14432@lunn.ch>
 <20190426191935.ihppqlmtpemzp3kr@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426191935.ihppqlmtpemzp3kr@mobilestation>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello Andrew
> 
> Thanks for the comment. I'll alter the code the way you said. The mode will
> be changed by the config_init-function only if the interface is selected to be
> rgmii-like (rgmii, rgmii-id, rgmii-txid and rgmii-rxid), otherwise it will
> be left as is.
> 
> But I've got a question regarding this then. What about for instance rtl8211f
> phy config_init-method? It setups the delay config in any case, no matter
> whether interface is configured to be of rgmii or another mode. Is it correct
> to configure rtl8211e and rtl8211f differently? Especially seeing the U-boot
> driver also perform the rtl8211f phy configuration.

Hi Sergey

It is not correct and rtl8211f should be changed. Please add a second
patch for that.

We got burnt recently with PHY drivers doing the wrong thing with
respect to RGMII delays. We have learnt from that experience, but
there is code in the kernel which still does things wrong.

      Andrew
