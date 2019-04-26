Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79950C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F46C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgaWIYQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDZXpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:45:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44392 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfDZXpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 19:45:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so4355437ljg.11;
        Fri, 26 Apr 2019 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CdWPjc0qLahLl4UGeEnInzJxeTMxgYrydP5xRWP12qg=;
        b=HgaWIYQVcBtV0x6xtew0Tm1bFcM4TepLDmWS3tGBxOw6j5ycThRn6JXiYBiq90Jo80
         tUV/ZQYx04YgzckAXs7iMuDICSyKdj6HTLiRWcNywUEDPPhC2MLaXHWssN/C/GallvgN
         PDA0qOW9mbZcit/FKF6v1zmLXu/d2U0xQdwpLj7F/57IZF1n8MibBLoscwOXKW1tbKNh
         ESqH8ThddqUQU752c6s3g9eF56gJqDS+6ljJ9etZL8cZe+cy8wTYq+jfqohN8qqGOzxk
         2kUuBW6kex60rUOVz4YWO/O5Y3Z+CI4Qbm5hkzTfFBw0P1JJcSirRh3nFR56sQLGcqzZ
         iBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CdWPjc0qLahLl4UGeEnInzJxeTMxgYrydP5xRWP12qg=;
        b=RP6uO73v0Uq3MsAL5UzG9LFC088l306F5hUX9XDX0N2g1VxcJ1BTHnPI+z3Ww+Gcbf
         fO2GVxVH3yoHjlb2ocz02N6cqAdE2tpd7vR4GF+jQ18wdLfqOAQ+ba5cSR2AGxQvVqX5
         PtAPsVeNkH203H0g91k8JmGEF7vfn9EnQAWBVc8QFV+MBJEZag7SnnUEQq4e6/VZ2lR/
         VdHJyNBynJEHKeQm7WgM+To4D3mjtlwwRWDDr146Mbr5hI3Yktzs8kc0LcW8WpsGAsT0
         nlkotCtOMY4IoF/kJVhgismHa99P2gbjwK5ZLy9pj/7XuaXw/I1YGu97ppJiIEiWkpwL
         dmrg==
X-Gm-Message-State: APjAAAWD/9vADAAIiSuSksJWSm0EbMhirjzU8cWC/u3nl9XElijfMbT/
        vc/AxnDu3OU/Engdy4O5JDs=
X-Google-Smtp-Source: APXvYqzfKH4P0h9+dewdZ7o6E8OXsa2LO4w/WYsCqVSe2tLqPJwPWdQrlH0quLWucIhMFq2PPyFXkw==
X-Received: by 2002:a2e:9bcc:: with SMTP id w12mr5485572ljj.72.1556322306913;
        Fri, 26 Apr 2019 16:45:06 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id n1sm559023ljg.84.2019.04.26.16.45.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 16:45:06 -0700 (PDT)
Date:   Sat, 27 Apr 2019 02:45:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: phy: realtek: Add rtl8211e rx/tx delays
 config
Message-ID: <20190426234503.y6nm5hekyclmgftc@mobilestation>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426212112.5624-1-fancer.lancer@gmail.com>
 <20190426214050.GU4041@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426214050.GU4041@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:40:50PM +0200, Andrew Lunn wrote:
> On Sat, Apr 27, 2019 at 12:21:11AM +0300, Serge Semin wrote:
> > There are two chip pins named TXDLY and RXDLY which actually adds the 2ns
> > delays to TXC and RXC for TXD/RXD latching. Alas this is the only
> > documented info regarding the RGMII timing control configurations the PHY
> > provides. It turns out the same settings can be setup via MDIO registers
> > hidden in the extension pages layout. Particularly the extension page 0xa4
> > provides a register 0x1c, which bits 1 and 2 control the described delays.
> > They are used to implement the "rgmii-{id,rxid,txid}" phy-mode.
> > 
> > The hidden RGMII configs register utilization was found in the rtl8211e
> > U-boot driver:
> > https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99
> > 
> > There is also a freebsd-folks discussion regarding this register:
> > https://reviews.freebsd.org/D13591
> > 
> > It confirms that the register bits field must control the so called
> > configuration pins described in the table 12-13 of the official PHY
> > datasheet:
> > 8:6 = PHY Address
> > 5:4 = Auto-Negotiation
> > 3 = Interface Mode Select
> > 2 = RX Delay
> > 1 = TX Delay
> > 0 = SELRGV
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> 
> Hi Serge
> 
> Next time please include a patch 0 containing a cover note explaining
> the who series.
> 

Sure as long as the patchset gets to be much bigger than two small
patches with an obvious reason to be merged.

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 

Thanks.)

-Sergey

>     Andrew
