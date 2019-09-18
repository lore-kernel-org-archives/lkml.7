Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79396C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4769921924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bhCpG04t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfIROTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:19:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52920 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfIROTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=q+7hkrjDeRvydgivfqWDtfqISOMXJILurtfe4WctF+c=; b=bhCpG04tKsAOPktNu8YQ+JiaNj
        sPknDJaZc7nAwCa8+EVQXXlTwevPtOIEvs2jrTksqw7OE+9ongtz/64buGDuqW3hMhHDMC97p/PK9
        S7sEhKY/D/XsgdzxAMBuvPTGvkJBTMHSrL0aoYT7lcf18T4yBlTVn8ZTXylNLRF6W8dE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1iAanr-0008An-Ib; Wed, 18 Sep 2019 16:19:31 +0200
Date:   Wed, 18 Sep 2019 16:19:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Peter Mamonov <pmamonov@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/phy: fix DP83865 10 Mbps HDX loopback disable
 function
Message-ID: <20190918141931.GK9591@lunn.ch>
References: <20190918140340.21032-1-pmamonov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918140340.21032-1-pmamonov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 05:03:40PM +0300, Peter Mamonov wrote:
> According to the DP83865 datasheet "The 10 Mbps HDX loopback can be
> disabled in the expanded memory register 0x1C0.1." The driver erroneously
> used bit 0 instead of bit 1.
> 
> Signed-off-by: Peter Mamonov <pmamonov@gmail.com>
> ---
>  drivers/net/phy/national.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/national.c b/drivers/net/phy/national.c
> index 2addf1d3f619..4892e785dbf3 100644
> --- a/drivers/net/phy/national.c
> +++ b/drivers/net/phy/national.c
> @@ -110,11 +110,14 @@ static void ns_giga_speed_fallback(struct phy_device *phydev, int mode)
>  
>  static void ns_10_base_t_hdx_loopack(struct phy_device *phydev, int disable)
>  {
> +	u16 lb_dis = 1 << 1;

Hi Peter

Please use the BIT() macro.

> +
>  	if (disable)
> -		ns_exp_write(phydev, 0x1c0, ns_exp_read(phydev, 0x1c0) | 1);
> +		ns_exp_write(phydev, 0x1c0,
> +			     ns_exp_read(phydev, 0x1c0) | lb_dis);
>  	else
>  		ns_exp_write(phydev, 0x1c0,
> -			     ns_exp_read(phydev, 0x1c0) & 0xfffe);
> +			     ns_exp_read(phydev, 0x1c0) & ~lb_dis);
>  
>  	pr_debug("10BASE-T HDX loopback %s\n",
>  		 (ns_exp_read(phydev, 0x1c0) & 0x0001) ? "off" : "on");

Isn't this also wrong?

      Andrew
