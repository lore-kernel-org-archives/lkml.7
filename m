Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F39C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 03:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30B5216C8
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 03:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eUp19m/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfG0DCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 23:02:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41242 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfG0DCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 23:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tN/4dk4E58XistgDJ6zOTKtSRYqHTx/a1QOwwGKZMmk=; b=eUp19m/y/Qg1oORIbOZgd/lgOH
        dU1x4yAORlsvB70utYGcZLTwWnbrpNdkE7MYvHycUmKDhdJNay1C1zWz9TrPxN3INRKVF9XHSSupf
        aBX961lzv4uzmUhvzpmGFQZqpRpzlpaSNm7sKFvaywt+8zVZA/E+URoyEHPR5rlto02w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hrCyV-0007ol-5S; Sat, 27 Jul 2019 05:02:23 +0200
Date:   Sat, 27 Jul 2019 05:02:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: Allow bridge to joing multicast groups
Message-ID: <20190727030223.GA29731@lunn.ch>
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
 <7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
 <eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
 <20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
 <b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
 <e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
 <20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
 <20190726134613.GD18223@lunn.ch>
 <20190726195010.7x75rr74v7ph3m6m@lx-anielsen.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726195010.7x75rr74v7ph3m6m@lx-anielsen.microsemi.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As you properly guessed, this model is quite different from what we are used to.

Yes, it takes a while to get the idea that the hardware is just an
accelerator for what the Linux stack can already do. And if the switch
cannot do some feature, pass the frame to Linux so it can handle it.

You need to keep in mind that there could be other ports in the bridge
than switch ports, and those ports might be interested in the
multicast traffic. Hence the CPU needs to see the traffic. But IGMP
snooping can be used to optimise this. But you still need to be
careful, eg. IPv6 Neighbour discovery has often been broken on
mv88e6xxx because we have been too aggressive with filtering
multicast.

	Andrew
