Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CF1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D91A2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sNx1AHlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCVV0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:26:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:35449 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCVV0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zRtH7CxO3VITksqiNhcsPyxw/QZJND2ubKCgubb5DJ8=; b=sNx1AHlFOI8wwuzZUKbxsgJfRc
        7JdbQrC7DaJoIyV3G10O9wbLhattnQ+J5jwzrQjYdsXd2AEfsR0d5FW23062L8FN3Oo2VxfBM0sKy
        fXdVZOXp95dVtQwm3e9EJcByHT88TwN58KO/r4XjiVtfAmfmB8HsDq4USu6irKqL3RLg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h7Rfp-0005Or-Ez; Fri, 22 Mar 2019 22:25:57 +0100
Date:   Fri, 22 Mar 2019 22:25:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED, REGRESSION] Broken networking on MIPS/OCTEON
 EdgeRouter Lite
Message-ID: <20190322212557.GF16623@lunn.ch>
References: <20190322002125.GD7872@darkstar.musicnaut.iki.fi>
 <20190322064506.GB5348@vkoul-mobl>
 <20190322205059.GA29013@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322205059.GA29013@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The OCTEON HW code knows only about RGMII. And looking at
> octeon ethernet staging driver it does phy connect always with
> PHY_INTERFACE_MODE_GMII. I did some experimentation, and it seems that
> with PHY_INTERFACE_MODE_RGMII_RXID it starts to work.. In the DT we have
> for ethernet for this board:
> 
> 	rx-delay = <0>;
> 	tx-delay = <0x10>;

These are not PHY properties. 

Looking at the code, it looks like these control delays the MAC
inserts. I don't see a binding document for these properties, so i've
no idea what 0x10 means. Before this driver moves out of staging,
these values should be changed to be in ns.

However, PHY_INTERFACE_MODE_RGMII_RXID would make sense if 0x10 is
sufficient to add the TX delay.

What the driver should however do is call of_of_get_phy_mode() to get
the phy-mode from the DT blob and pass that to of_phy_connect().

    Andrew
