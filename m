Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7E5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A05B20862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XmxapkPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfJCSvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:51:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59848 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfJCSvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T4fywLW8Q5aOkFepYb8mXUm9qSbytBCKKHIreCOKRDM=; b=XmxapkPTSK9yTgIPoekBzSez8G
        XKZQCn35swnyuM2C18RDnV8gvfWArhptIyowMwOr61wnUaxSQwZDsktxEbSvLvZ/+T435VLZ9qYb6
        GSIPRvt6YkRb0/JEudn4o6CtNbL2WhD5ltizLHD+xb68ZVuS+SMRfGmiePNvsj29CKlA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iG6C4-0005lA-7V; Thu, 03 Oct 2019 20:51:16 +0200
Date:   Thu, 3 Oct 2019 20:51:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        manasa.mudireddy@broadcom.com, ray.jui@broadcom.com,
        olteanv@gmail.com, rafal@milecki.pl
Subject: Re: [PATCH 0/2] net: phy: broadcom: RGMII delays fixes
Message-ID: <20191003185116.GA21875@lunn.ch>
References: <20191003184352.24356-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003184352.24356-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 11:43:50AM -0700, Florian Fainelli wrote:
> Hi all,
> 
> This patch series fixes the BCM54210E RGMII delay configuration which
> could only have worked in a PHY_INTERFACE_MODE_RGMII configuration.

Hi Florian

So any DT blob which incorrectly uses one of the other RGMII modes is
now going to break, where as before it was ignored.

Maybe we should let this sit in net-next for a while, before back
porting, so we get an idea of how many platforms we might be about to
break?

   Andrew
