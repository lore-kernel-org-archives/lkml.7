Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC4C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6BA20644
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nUctkk4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfD0Q22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:28:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46618 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0Q21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DrSwXGl/m5iWJzAo48ShV8DLblMhoPKvC7H2WjCBtRM=; b=nUctkk4xTAOl5jinKQT8lKygok
        QUvP/wqC49SQQNgptkVZdqqvDW2vm1q/JLe4vKcep5C9zKBuKvl/Pk/n2+hqszJp6i6ZIwgcgxnNS
        e+iSAor25mLLD5TmFIB14aQ6ebperNjxPPO9NO2kAtl1PdOjtwZdI2P3F4L6k6LsZxYs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hKQBb-0002el-V7; Sat, 27 Apr 2019 18:28:23 +0200
Date:   Sat, 27 Apr 2019 18:28:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH 1/4] of_net: Add NVMEM support to of_get_mac_address
Message-ID: <20190427162823.GA9816@lunn.ch>
References: <1556320002-26213-1-git-send-email-ynezz@true.cz>
 <1556320002-26213-2-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556320002-26213-2-git-send-email-ynezz@true.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  /**
> - * Search the device tree for the best MAC address to use.  'mac-address' is
> - * checked first, because that is supposed to contain to "most recent" MAC
> - * address. If that isn't set, then 'local-mac-address' is checked next,
> - * because that is the default address.  If that isn't set, then the obsolete
> - * 'address' is checked, just in case we're using an old device tree.
> + * Search the device tree for the best MAC address to use. Check NVME first as
> + * it should contain the proper MAC address, then 'mac-address' is checked
> + * next, because that is supposed to contain to "most recent" MAC address. If
> + * that isn't set, then 'local-mac-address' is checked next, because that is
> + * the default address.  If that isn't set, then the obsolete 'address' is
> + * checked, just in case we're using an old device tree.

Hi Petr

I'm not sure this is the correct order. I would actually put NVMEM
after mac-address and local-mac-address. These are well established
and used. We don't want to break existing boards with a new
property. By putting NVMEM later, in order to make it used, any
existing mac-address and local-mac-address need to be removed, making
the developers actually think about what they are doing.

	Andrew
