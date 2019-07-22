Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D6C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59177216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MVRVLB+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbfGVTim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:38:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57162 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfGVTik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W7vnDeoMM/iSr74EeN4MeRse8/vd2A2jqO++8QrETl8=; b=MVRVLB+90AS2iyjSpeb3vvOfx1
        MlFyHG0sFFrwhQ9VZcHRxx3SkeShfLO7lXloVgx0SHvCQmBC86ajgzdlsCauLhpdcL0F2b+gyTbQI
        ux/BkTFmue4zbsFV846raBxFBNkQHp7qbf1G5mgEyeqNxIpDbsZFRnTMRYBWgwHmy0hQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hpe8o-0004wK-41; Mon, 22 Jul 2019 21:38:34 +0200
Date:   Mon, 22 Jul 2019 21:38:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: net: realtek: Add property to
 configure LED mode
Message-ID: <20190722193834.GG8972@lunn.ch>
References: <20190703193724.246854-1-mka@chromium.org>
 <20190703193724.246854-6-mka@chromium.org>
 <e8fe7baf-e4e0-c713-7b93-07a3859c33c6@gmail.com>
 <20190703232331.GL250418@google.com>
 <CAL_JsqL_AU+JV0c2mNbXiPh2pvfYbPbLV-2PHHX0hC3vUH4QWg@mail.gmail.com>
 <20190722171418.GV250418@google.com>
 <20190722190133.GF8972@lunn.ch>
 <20190722191411.GW250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722191411.GW250418@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> as of now it isn't even an API, the phy_device populates a new array
> in its struct with the values from the DT. PHY drivers access the
> array directly. Is it still preferable to post everything together?
> 
> (maybe I'm too concerned about 'noise' from the driver patches while
>  we are figuring out what exactly the binding should be).

We should try to have the DT parsing made generic in phylib, and add
new driver API calls to actually configure the LEDs.

Please also take a look at the Linux generic LED binding. It would be
nice to have something compatible with that. With time, the code could
morph into being part of the generic LED subsystem. So we are mostly
talking about triggers. But we offload the trigger to the hardware,
rather than have software trigger the blinking of the LEDs. So
something like:

ethernet-phy0  {
	reg = <0>;

	leds {
		phy-led@0 {
	     	      reg = <0>
		      label = "left:green";
		      linux,default-trigger = "phy_link_1000_active";
		}
		phy-led@1 {
	     	      reg = <1>
		      label = "right:red";
		      linux,default-trigger = "phy_collision";
		}
	}
}

      Andrew

