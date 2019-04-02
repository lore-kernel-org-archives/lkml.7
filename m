Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3154BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E211820674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iyFIYMLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDBVDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:03:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47774 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfDBVDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PrkHMRc+aH88H65hxbZYmEGFOtyGP0sAJWpdMSZ8PPU=; b=iyFIYMLm/bvbVu9VU0dp6zWv0i
        ZVEp6mwZ3JMsagE5DbvwUHv2k1AXM6u8oRnz4nrU6gPQwutojR8AJdEMBbN6bzKijBo1bsoeoq5DS
        zf2cjhFpkwsCHq/DSFDsZA6X7WzHObpEIFA/JyQNuuKXI2HfdlqZ2vSWC5SBBEw1Qg4o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hBQZR-00014g-NL; Tue, 02 Apr 2019 23:03:49 +0200
Date:   Tue, 2 Apr 2019 23:03:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        georg.waibel@sensor-technik.de
Subject: Re: [PATCH net-next 06/17] net: dsa: Call driver's setup callback
 after setting up its switchdev notifier
Message-ID: <20190402210349.GG22349@lunn.ch>
References: <20190331174232.22060-1-olteanv@gmail.com>
 <20190331174232.22060-7-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331174232.22060-7-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 08:42:21PM +0300, Vladimir Oltean wrote:
> This allows the driver to perform some manipulations of its own during
> setup, using generic code.
> One current usage scenario is for the driver to request DSA to set up
> 802.1Q based switch tagging for its ports.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/dsa/dsa2.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
> index c00ee464afc7..5beceb18b7e2 100644
> --- a/net/dsa/dsa2.c
> +++ b/net/dsa/dsa2.c
> @@ -360,14 +360,14 @@ static int dsa_switch_setup(struct dsa_switch *ds)
>  	if (err)
>  		return err;
>  
> -	err = ds->ops->setup(ds);
> -	if (err < 0)
> -		return err;
> -
>  	err = dsa_switch_register_notifier(ds);
>  	if (err)
>  		return err;

It seems that notifiers are the important thing here? Maybe state that
in the commit message?

I'm also wondering how safe this is in general. If we have not yet
called the driver setup, the switch is potentially not yet ready to
actually handle an requests that come via the notifier. If such
notifiers can only come from the driver itself, it should be
safe. However, if they could come from the rest of the stack, i could
see bad things happening.

    Andrew
