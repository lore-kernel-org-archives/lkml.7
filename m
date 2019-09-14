Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F99CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E18D206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5/xUEQVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfINPXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 11:23:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46034 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfINPXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 11:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rJv35b0pJHg/6Z5tXigg7knHqLWFVyRzDDlE1Gb2COA=; b=5/xUEQVhB1skg2aPFRqZG9zCMu
        ba+k3RO2pChp4c6sG2uyZAlZPUvl0VSXnwrmR//TxRM436JkN95/umVFCOT16InQKCRONHHus3iRI
        d9t9DyHGw81sXMlftNmmqNpch8LOzBReYpviNy7pToqfAWke3EIaiKtCZaOcV59+tjL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i99th-00088s-TY; Sat, 14 Sep 2019 17:23:37 +0200
Date:   Sat, 14 Sep 2019 17:23:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, b.spranger@linutronix.de,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: b53: Add support for
 port_egress_floods callback
Message-ID: <20190914152337.GI27922@lunn.ch>
References: <20190913032841.4302-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913032841.4302-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 08:28:39PM -0700, Florian Fainelli wrote:
> Add support for configuring the per-port egress flooding control for
> both Unicast and Multicast traffic.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Beneditk,
> 
> Do you mind re-testing, or confirming that this patch that I sent much
> earlier does work correctly for you? Thanks!
> 
>  drivers/net/dsa/b53/b53_common.c | 33 ++++++++++++++++++++++++++++++++
>  drivers/net/dsa/b53/b53_priv.h   |  2 ++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 7d328a5f0161..ac2ec08a652b 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -342,6 +342,13 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
>  	b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
>  	mgmt |= B53_MII_DUMB_FWDG_EN;
>  	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
> +
> +	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
> +	 * frames should be flooed or not.

Hi Florian

s/flooed/flooded 

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
