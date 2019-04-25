Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62374C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E23620644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yw44UV94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfDYPXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:23:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44082 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfDYPXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IfXae5Do95l2YpscX6fCkTeSRVMeJtOrWVmlMWdqnEc=; b=Yw44UV94rLzoofip90r6FCQ0zL
        I4uYGYkfFP1YA6VZPG3V9w7daB9tsu88Fets4D6Q+kJQlV7mMznbXRMT5nA4jyoPY2b5OVg5kyw6e
        3WpjhfLiSAtnUXc9TGjF/OXtr6GbEiUh0PK2SmChw28gosmdQCUuKr4KJtE+AAhn3jkU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJgDk-0004Zj-Fu; Thu, 25 Apr 2019 17:23:32 +0200
Date:   Thu, 25 Apr 2019 17:23:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Ong, Boon Leong" <boon.leong.ong@intel.com>
Cc:     "Voon, Weifeng" <weifeng.voon@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>
Subject: Re: [PATCH 0/7] net: stmmac: enable EHL SGMII
Message-ID: <20190425152332.GD23779@lunn.ch>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <20190424134854.GP28405@lunn.ch>
 <D6759987A7968C4889FDA6FA91D5CBC8146EF128@PGSMSX103.gar.corp.intel.com>
 <20190425123801.GD8117@lunn.ch>
 <AF233D1473C1364ABD51D28909A1B1B75C0B205D@pgsmsx114.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF233D1473C1364ABD51D28909A1B1B75C0B205D@pgsmsx114.gar.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> > > This patch-set is to enable Ethernet controller (DW Ethernet QoS and
> >> > > DW Ethernet PCS) with SGMII interface in Elkhart Lake.
> >> >
> >> > Can the hardware also do 1000BaseX?
> >>
> >> Yes, it is able to do 1000BaseX.
> >
> >I Voon
> >
> >That means you should not really hard code it to SGMII. Somebody is
> >going to connect an SFP or an Ethernet switch and want to use
> >1000BaseX.
> 
> Hi Andrew,
> 
> The Ethernet controller consists of two ways to connect to external PHY,
> RGMII and SGMII. The selection is done through soft strap.
> The patch-series is to enable SGMII interface. The DW xPCS IP is
> configured to operate in 1000BASE-X mode. The xPCS IP is external
> connected through internal PHY interface which presents externally
> as SGMII interface. To help illustrate the connection:-
> 
>       <-----------------GBE Controller----------------->|<--External PHY chip-->
> 
>       +----------+                    +----+          +---+                          +-----------------+
>       |   EQoS   | <-GMII->|xPCS|<--> | L1 | <-- SGMII --> | External GbE |
>       |   MAC    |                 |         |       |PHY|                         | PHY Chip        |
>       +----------+                    +----+          +---+                          +-----------------+
>             
> In future, we will submit the changes for the RGMII connection that
> bypasses DW xPCS.  

The ASCII art get messed up somewhere.

What you are implementing looks like:


       <-----------------GBE Controller------------>|<--External PHY chip-->
 
       +----------+                    +----+                 +---+
       |   EQoS   | <-GMII->|xPCS|<--> | L1 | <-- SGMII -->   |PHY|
       |   MAC    |                    |    |                 +---+
       +----------+                    +----+                      

With the Ethernet controller, the MAC connects to the xPCS. Out of the
xPCS you have a SERDES connection, running the SGMII protocol. That
connects to external pins of the SoC. These are then connected to a
copper PHY which also supports SGMII.

What i'm trying to understand is if the following is possible:

       <-----------------GBE Controller------------->|<--External SFP cage/module-->
 
       +----------+                    +----+                   +---+
       |   EQoS   | <-GMII->|xPCS|<--> | L1 | <-- 1000BaseX --> |SPF|
       |   MAC    |                    |    |                   +---+
       +----------+                    +----+                      

Rather than use a Copper PHY, an SFP cage+module is used. The same
SERDES interface is used, but 1000BaseX runs over it.

Generally, an xPCS which can run SGMII can also do 1000BaseX, because
SGMII is just some Cisco Proprietary extensions to 1000BaseX.

If the xPCS can do 1000BaseX over the SERDES, you should not hard code
it to SGMII, but allow it to be configured.

      Andrew
