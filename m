Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA6CC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E20F208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2gu2xkzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfHERQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:16:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34982 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHERQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=P468JIvKTHpxW0j9GxTuaBtEZ/w1z4jhlMC0MApa2iE=; b=2gu2xkzybISE/BT8TBNeC/2uU9
        pap2ksw1BgLyapATDF3GhRrx2FHCYVhREn9x25IJqHkrYhZaQecITJNlJ8yGcCfnpWgO5ntJS/tsY
        mdPzhu/X4D+/v/KtV0e/ZM1i4ndZxGMHGZPp8EqSZdyvQfZ9bAHXpO+6ry/Z961muptY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hugb9-0000BE-FF; Mon, 05 Aug 2019 19:16:39 +0200
Date:   Mon, 5 Aug 2019 19:16:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harinik@xilinx.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        David Miller <davem@davemloft.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: net: macb: Add new property for PS
 SGMII only
Message-ID: <20190805171639.GV24275@lunn.ch>
References: <1564566033-676-1-git-send-email-harini.katakam@xilinx.com>
 <1564566033-676-2-git-send-email-harini.katakam@xilinx.com>
 <20190804145633.GB6800@lunn.ch>
 <CAFcVECL6cvCjeo+fn1NDyMDZyZXDrWyhD9djvcVXiLVLiLgGeA@mail.gmail.com>
 <20190805132045.GC24275@lunn.ch>
 <CAFcVECLUNYRC-iZbKvvq2_XMLfXg7E10yAU5J_8GaEB3ExWRxg@mail.gmail.com>
 <CAFcVECLVHY5X=wctxVqRqDTDyG7Zavkt5ui4RtFBLP8g8MW1SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcVECLVHY5X=wctxVqRqDTDyG7Zavkt5ui4RtFBLP8g8MW1SA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Even with the use of this interrupt, the link status actions (link print and
> netif ops) will still be required. And also the need for macb_open to
> proceed without phydev. Could you please let me know if that is acceptable
> to patch or if there's a cleaner way to
> report this link status?

It sounds like you need to convert to phylink, so you get full sfp
support. phylib does not handle hotplug of PHYs.

Please look at the comments Russell gave the last time this was
attempted.

    Andrew
