Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD666C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4720675
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i4BThc/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfD1Vgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 17:36:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47818 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfD1Vgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 17:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sNLTtMpLfiCg0JHlqA74ro0TLCE0R75diXWV66fsyvs=; b=i4BThc/7ZQrBMZ9MjVf43xKkd9
        rhdeY3pPFHKHaiaOOlioQR9QwyMOVG9S2oU3yZYKO3IZWXTvt68zZAEe0GhvD5289wuoabHXhW81V
        tBHUZbjuz+RnOihXHjyqrxK32PVniJqD+gPs755dg93XdgkqQuEFSOjSbbL8NLGWLMbk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hKrTU-00032d-Pc; Sun, 28 Apr 2019 23:36:40 +0200
Date:   Sun, 28 Apr 2019 23:36:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>
Subject: Re: [PATCH v2 3/4] net: macb: Drop nvmem_get_mac_address usage
Message-ID: <20190428213640.GB10772@lunn.ch>
References: <1556456002-13430-1-git-send-email-ynezz@true.cz>
 <1556456002-13430-4-git-send-email-ynezz@true.cz>
 <20190428165637.GJ23059@lunn.ch>
 <20190428210814.GA346@meh.true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428210814.GA346@meh.true.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> so if I understand this correctly, it probably means, that this approach with
> modified of_get_mac_address is dead end as current of_get_mac_address users
> don't expect and handle possible -EPROBE_DEFER error, so I would need to
> change all the current users, which is nonsense.

Hi Petr

I would not say it is dead, it just needs a bit more work.

The current users should always be checking for a NULL pointer.  You
just need to change that to !IS_ERR(). You can then return
ERR_PTR(-PROBE_DEFER) from the NVMEM operation.

And i agree, wrapping this all up inside of_get_mac_address() is the
correct way to do this.

     Andrew
