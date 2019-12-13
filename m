Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C352C50704
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2482474C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B022IG0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfLMNrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:47:32 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51698 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfLMNrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=awCXz0GwD1LDcWzOjDMp0h+d0sdlS80mO4Nbpi4KuV0=; b=B022IG0f4HXZeMBlMNrforMruq
        dFK7znmRa1CpiTRnP5y5JakiioHQ+FdeEMCHwk2Gj0/OgbKerI8jebCoeNmN1LuX1Yu+7UNmUTTXy
        MGKwep3ErD6V9+pLSXg9iuy7P0DRSQDYOfxGJpzrOZ0+YYKV7JvJNzXUQvMMLC7dJSiw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iflHg-00019i-1C; Fri, 13 Dec 2019 14:47:08 +0100
Date:   Fri, 13 Dec 2019 14:47:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     biao huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yt.shen@mediatek.com
Subject: Re: [PATCH 1/2] net-next: stmmac: mediatek: add more suuport for RMII
Message-ID: <20191213134708.GA4286@lunn.ch>
References: <20191212024145.21752-1-biao.huang@mediatek.com>
 <20191212024145.21752-2-biao.huang@mediatek.com>
 <20191212132520.GB9959@lunn.ch>
 <1576200981.29387.13.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576200981.29387.13.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The clock labeled as "rmii_internal" is needed only in RMII(when MAC provides
> reference clock), and useless for RGMII/MII/RMII(when phy provides reference
> clock).
> 
> So, add a boolean flag to indicate where the RMII reference clock is from, MAC
> or PHY, if MAC, enable the "rmii_internal", or disable it.
> and this clock already documented in dt-binding in PATCH 2/2.
> 
> For power saving, it should not be enabled in default, so can't add it to the
> existing list of clocks directly.
> 
> Any advice for this special case?

O.K. Add the boolean, but also add the clock to the list of clocks in
DT. Don't hard code the clock name in the driver.

    Andrew
