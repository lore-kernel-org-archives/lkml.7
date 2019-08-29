Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB8C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC244233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BdWiBLYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfH2N0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:26:19 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40736 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfH2N0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UTDvZ2Lzi29K8AW5de07/8rgh6jmhbyZB+/k1sHFNh0=; b=BdWiBLYhoPJ8E/2KnS1JNO3IZB
        VeaYh4dwDR81JwLVv57FC2kJVWtJc7TFDGRS8Q9ZftlVB/tAxOJEDmrsPETF8C4Qo81JygYozy0fX
        rk5HhhRwcjvIMWQFomX7CcGSngZCwcqQonBb0qydxX9CEETn8wX47AumTmhyw8FOp7Y0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i3KRH-0002Ja-QQ; Thu, 29 Aug 2019 15:26:11 +0200
Date:   Thu, 29 Aug 2019 15:26:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, allan.nielsen@microchip.com,
        ivecera@redhat.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Message-ID: <20190829132611.GC6998@lunn.ch>
References: <1567070549-29255-1-git-send-email-horatiu.vultur@microchip.com>
 <1567070549-29255-2-git-send-email-horatiu.vultur@microchip.com>
 <20190829095100.GH2312@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829095100.GH2312@nanopsycho>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> NACK
> 
> This is invalid usecase for switchdev infra. Switchdev is there for
> bridge offload purposes only.

Hi Jiri

I would argue this is for bridge offload. In another email, you say
promisc is promisc. Does that mean the Mellonox hardware forwards
every frame ingressing a port to the CPU by default as soon as it is
enslaved to a bridge and promisc mode turned on? Or course not. At the
moment, every switchdev driver wrongly implement promisc mode.

This patchset is about correctly implementing promisc mode, so that
applications can use it as expected. And that means configuring the
hardware bridge to also forward a copy of frames to the CPU.

I see trap as a different use case. tcpdump/pcap is not going to use
traps.

	Andrew
