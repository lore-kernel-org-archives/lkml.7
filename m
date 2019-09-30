Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3F0C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1F720842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bwfp+J5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfI3NUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:20:46 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54410 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731214AbfI3NUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QKGHtGGZYx5PmIm0H778adLOapt9EArFPSKaXfErBIk=; b=bwfp+J5c4S86vr++NupdgY57NL
        w2qUlT7VMwyDNjsh3CFEiZXNMA9r7/dWkyjz0jphs9u0UvyKf/vAchWumWj7zdEW1SB68+abE8d7b
        2fIAEZGoynGrQUXlzosrjsk9FlRGFP/1Bn1hn2Bbm3x2sxipAarVn6gE3MHDvFwpfhus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iEvbV-0003oP-BW; Mon, 30 Sep 2019 15:20:41 +0200
Date:   Mon, 30 Sep 2019 15:20:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: at803x: add ar9331 support
Message-ID: <20190930132041.GE13301@lunn.ch>
References: <20190930092710.32739-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930092710.32739-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 11:27:10AM +0200, Oleksij Rempel wrote:
> Mostly this hardware can work with generic PHY driver, but this change
> is needed to provided interrupt handling support.
> Tested with dsa ar9331-switch driver.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/at803x.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 6ad8b1c63c34..d62a77adb8e7 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -53,6 +53,7 @@
>  #define AT803X_DEBUG_REG_5			0x05
>  #define AT803X_DEBUG_TX_CLK_DLY_EN		BIT(8)
>  
> +#define AR9331_PHY_ID 0x004dd041
>  #define ATH8030_PHY_ID 0x004dd076
>  #define ATH8031_PHY_ID 0x004dd074
>  #define ATH8035_PHY_ID 0x004dd072

Hi Oleksij

I wonder if we should call this ATH9331_PHY_ID, to keep with the
naming convention? Why did you choose AR, not ATH?

Thanks
	Andrew
