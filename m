Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6C6C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6529420640
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gmzGM8P1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfDYMiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:38:07 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43886 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfDYMiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=q927ClLw5w7p3pAVrQBCiop8lcGdhcp8l7/mkTAxFOE=; b=gmzGM8P1AuUAVsJndC8h4lcGxK
        p056K208kRPR60Ngg9tr7JTiaIMydJgWFLLfDUohuHw65p+zYMHrC2Fy3otGryBbWQsele2KPIoLG
        5YzkNjlwlfNAXIi/Fj3ZD7rFd/L7n7qywocsneycqFeVTP5LlWRmzCeTB0Fn6mxZ3aI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJddZ-0002d4-H7; Thu, 25 Apr 2019 14:38:01 +0200
Date:   Thu, 25 Apr 2019 14:38:01 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Voon, Weifeng" <weifeng.voon@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>
Subject: Re: [PATCH 0/7] net: stmmac: enable EHL SGMII
Message-ID: <20190425123801.GD8117@lunn.ch>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <20190424134854.GP28405@lunn.ch>
 <D6759987A7968C4889FDA6FA91D5CBC8146EF128@PGSMSX103.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6759987A7968C4889FDA6FA91D5CBC8146EF128@PGSMSX103.gar.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 07:27:51AM +0000, Voon, Weifeng wrote:
> > > This patch-set is to enable Ethernet controller (DW Ethernet QoS and
> > > DW Ethernet PCS) with SGMII interface in Elkhart Lake.
> > 
> > Can the hardware also do 1000BaseX?
> 
> Yes, it is able to do 1000BaseX.

I Voon

That means you should not really hard code it to SGMII. Somebody is
going to connect an SFP or an Ethernet switch and want to use
1000BaseX.

At minimum, please add support for phy-mode in the device tree.

Also, when the adjust_link callback passed to phy_connect() is called,
you can look at the interface type to know if you need to configure it
to SGMII or 1000BaseX. A copper PHY in an SFP module generally wants
SGMII, but an optical module wants 1000BaseX. But to properly support
SPFs the driver needs to swap to phylink, rather than phylib.

     Andrew
