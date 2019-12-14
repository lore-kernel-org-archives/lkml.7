Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE09C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C167214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="lK+yU5+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfLNAeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:34:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34495 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfLNAeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 19:34:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so556082lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 16:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=AcKpSh1z8nexb80XCULmvBhMzvVCXcH0i/wbt+zGUhM=;
        b=lK+yU5+bFuHaU9D3W6qUlPNk8AOj4NREd87YAzkJ6aYmKJIM2/QYqq2R2hkOGh6KPv
         3q/yU7JUS23gE0olzVlBatTDM50fNZYaBjaETH23XoHylecROnklEkESAS76EpqdT70P
         /dhkb4vT36tbmylUCmYZ9ezX9UU9sSGYRvzSFHP2jltZ7CZ9jJA98BpxpjOg/VPdZtBU
         s4B5odIpY9nWRdp2NHwNJd0E5jt0TxsbYoldhf2oY3OljEOjMXmxmS6kBKVuKRLrSOTG
         n8LyAki+kY2hsM3UomuEMBjmQMEqdPdonVdNw7SMrCIUk0cFVSmhqYPUj1nExJ1eV935
         KxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=AcKpSh1z8nexb80XCULmvBhMzvVCXcH0i/wbt+zGUhM=;
        b=UZciQeE4dVEESzpXO6BKi4tff8uDdGlt0NiduBknEZhNmMu0aG+k2djMYJbZtGwv/v
         bp+v+32LTGVIHZGgWGCsoXhlQPudwoA0WxyVNtXXcJ/9HEWRRgmfQ62AX+LyZujkY1j3
         X1JrM9mr29xgXcwrBGUDMJZtynQavduj0i4KzjKHMCWxn9veWMH3fMlquSh/TdZz4V5V
         gt7IuBhHEg6s0D3AenfNv37M6Bnsb7GcrERz6+qujV3pv6YIrv488mL7O5Wku66rzMyx
         ztFtYFXDV1RX+jPZ9qzVXATWhJjQOIsFsW0i0M5FskwFi8/iCn04zucofP8wE8rJG5eu
         WfdQ==
X-Gm-Message-State: APjAAAVPXdAkGlun9HZcqiM9r8XBnCR4hn54L4biuh+MZVl+zT0Sv+ur
        GLOK2BS2CCcV0N5csBhExEhi3Faq45E=
X-Google-Smtp-Source: APXvYqyPhtKh1Kb3nOzkfa72SVdezx6QGgtN1MFmoihXUZRaDylBiZhiVDUFt59vZIi5CyWD8Y4DKg==
X-Received: by 2002:ac2:4946:: with SMTP id o6mr10591734lfi.170.1576283651956;
        Fri, 13 Dec 2019 16:34:11 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z3sm5658532ljh.83.2019.12.13.16.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 16:34:11 -0800 (PST)
Date:   Fri, 13 Dec 2019 16:34:03 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Willy Tarreau <w@1wt.eu>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        maxime.chevallier@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: marvell: mvpp2: phylink requires the link
 interrupt
Message-ID: <20191213163403.2a054262@cakuba.netronome.com>
In-Reply-To: <E1ieo41-00023K-2O@rmk-PC.armlinux.org.uk>
References: <E1ieo41-00023K-2O@rmk-PC.armlinux.org.uk>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 22:33:05 +0000, Russell King wrote:
> phylink requires the MAC to report when its link status changes when
> operating in inband modes.  Failure to report link status changes
> means that phylink has no idea when the link events happen, which
> results in either the network interface's carrier remaining up or
> remaining permanently down.
> 
> For example, with a fiber module, if the interface is brought up and
> link is initially established, taking the link down at the far end
> will cut the optical power.  The SFP module's LOS asserts, we
> deactivate the link, and the network interface reports no carrier.
> 
> When the far end is brought back up, the SFP module's LOS deasserts,
> but the MAC may be slower to establish link.  If this happens (which
> in my tests is a certainty) then phylink never hears that the MAC
> has established link with the far end, and the network interface is
> stuck reporting no carrier.  This means the interface is
> non-functional.
> 
> Avoiding the link interrupt when we have phylink is basically not
> an option, so remove the !port->phylink from the test.
> 
> Tested-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Tested-by: Antoine Tenart <antoine.tenart@bootlin.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Fixes: 4bb043262878 ("net: mvpp2: phylink support") ?

Seems like you maybe didn't want this backported to stable hence 
no fixes tag?

Please advise :)

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 111b3b8239e1..ef44c6979a31 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3674,7 +3674,7 @@ static int mvpp2_open(struct net_device *dev)
>  		valid = true;
>  	}
>  
> -	if (priv->hw_version == MVPP22 && port->link_irq && !port->phylink) {
> +	if (priv->hw_version == MVPP22 && port->link_irq) {
>  		err = request_irq(port->link_irq, mvpp2_link_status_isr, 0,
>  				  dev->name, port);
>  		if (err) {

