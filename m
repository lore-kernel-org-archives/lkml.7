Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3449EC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE96920863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4tOtx72Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCBOMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 09:12:01 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:44343 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfCBOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 09:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=svz5PFqb/JtDVjrGSzNstLmNgbDp1h1gdJasLry7ZIU=; b=4tOtx72Y3/4TWgp7a++TvCe8L/
        EbKOqsCb9Gw73K6hHMoD9NJJUsqF3o9GDr6FYrT/6v7OlxyJTtZl/2PaUsaPDMALIwiw2X/cp6E7D
        pAQFPBp8uU10qsvFs+INc19CbXWg8E4JINFgja/IPUeKPloZHuq3bFqvWUAZVo+mdeFw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h05Mq-0000qD-Fs; Sat, 02 Mar 2019 15:11:56 +0100
Date:   Sat, 2 Mar 2019 15:11:56 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jose Abreu <jose.abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net 1/2] net: phy: Use C45 Helpers in phy_read_status()
Message-ID: <20190302141156.GG19813@lunn.ch>
References: <cover.1551437561.git.joabreu@synopsys.com>
 <27b3e9f2318c87aac928165b8dfe7d98e272f3d1.1551437561.git.joabreu@synopsys.com>
 <237f5214-c49e-53f9-65f0-479951f62d4a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237f5214-c49e-53f9-65f0-479951f62d4a@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 07:14:20PM -0800, Florian Fainelli wrote:
> 
> 
> On 3/1/2019 2:54 AM, Jose Abreu wrote:
> > Currently phy_read_status() considers that either the PHY driver has the
> > read_status() callback or uses the generic callback.
> > 
> > For C45 PHYs we need to use the gen10g_read_status() callback.
> 
> Right, so we could expect your C45 PHY driver to assign the read_status
> callback to gen10g_read_status() if it is appropriate. So far most of
> the 10g PHY drivers (cortina, marvell10g, aquantia) have to define their
> own read_status() callback to be feature complete. Unlike C22 PHYs that
> can really be driven with a simple generic PHY driver model for standard
> features, C45 PHYs seem to be quirky enough this does not work anymore.

Hi Jose

Does your PHY support 1000Base-T? If so you need read_status() because
the registers for that link mode don't appear to be standardized.

    Andrew
