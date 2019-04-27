Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4DCC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC37B2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHxawAOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfD0HoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:44:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46535 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0HoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:44:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so4914727ljk.13;
        Sat, 27 Apr 2019 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fU/YyIYtT67oIv9Ays4cK727ZEZOoSabk8SptF70TRo=;
        b=tHxawAOmJivxwsoNdVO53arEk/hzwZO3F62Sr02H1tNVBbw0mzLavech68nNpgdvfV
         qaGcR5LkO9r6S/FH6inkuW9L8ae+X5K5cciGQWJjOWZYLQ1qx2rtT8O3QqQFTW/5sng8
         cIW5kbXYD4C/hFJ93bnvGmQtcH2l8FDt5cieeoGlYilQkn1sLa6XzgA/9BUEWyiQDv+h
         FasuK/X0+9QIqf9vzN6l4Wm8IBV2LAlfUoEa+tqTRz4mq6t48JeTVjEa8gExhSURbrOw
         im+JAP5Ybn/8k0hl/VLzY3E6A7f/ogmLJL0kYcY1iIqAq7rb2StPb5B8CoLv3+5kPkLz
         gl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fU/YyIYtT67oIv9Ays4cK727ZEZOoSabk8SptF70TRo=;
        b=Gu2cUxC+cPN7yPOJBncpiuwV/E6TanPurspBdwg2mgyjrrfTY+5IabV6zQq0O10Jti
         hgzm66Ko5OQW6SMk+tOQn/INaROMVJ6Kul2ynxnlRaH6qOFtLzjvl1FFySfmISNC2vkF
         LYP6tbK7cx/Qc16k+jTMWM/vvnEbkXlguVrmcHVLGnbFOvsaGjsIqsrmXBZJrpAWGEgZ
         BrFX2LVkmed3b9/PFkt4Axy+dMYe6tgdgAlD4/DumbdtiDmRq/sf4CCGBW/B9PmIpJmE
         2bav14ayVA11pgHFgIOykOCR2p6juBnVQpN1hN7aqD+VXw9Fx49XXFiP+AyOVmmwRwBj
         eJLQ==
X-Gm-Message-State: APjAAAViFJvbCIRUr1PZ4h9YOtoIV1Jqi750PvBALQ0tohlqK69zD0y2
        hjZUPJnu0lyXNnpoQZsxttlCOCUh
X-Google-Smtp-Source: APXvYqzp3+8dGdTZJLpkWShbCaXqFKB+Glf1P7mcCMrGS6Fhbt5N6gF9fJaHP7nlIZoZJoEgxk8tIg==
X-Received: by 2002:a2e:988e:: with SMTP id b14mr2433082ljj.126.1556351044357;
        Sat, 27 Apr 2019 00:44:04 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id a11sm5828874ljf.68.2019.04.27.00.44.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Apr 2019 00:44:03 -0700 (PDT)
Date:   Sat, 27 Apr 2019 10:44:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: phy: realtek: Add rtl8211e rx/tx delays
 config
Message-ID: <20190427074400.is2hbij2k57f5daz@mobilestation>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426212112.5624-1-fancer.lancer@gmail.com>
 <20190426214050.GU4041@lunn.ch>
 <20190426234503.y6nm5hekyclmgftc@mobilestation>
 <fbf2ff24-a435-fe69-abcc-1f9326e1d61d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf2ff24-a435-fe69-abcc-1f9326e1d61d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 08:11:50PM -0700, Florian Fainelli wrote:
> 
> 
> On 4/26/2019 4:45 PM, Serge Semin wrote:
> > On Fri, Apr 26, 2019 at 11:40:50PM +0200, Andrew Lunn wrote:
> >> On Sat, Apr 27, 2019 at 12:21:11AM +0300, Serge Semin wrote:
> >>> There are two chip pins named TXDLY and RXDLY which actually adds the 2ns
> >>> delays to TXC and RXC for TXD/RXD latching. Alas this is the only
> >>> documented info regarding the RGMII timing control configurations the PHY
> >>> provides. It turns out the same settings can be setup via MDIO registers
> >>> hidden in the extension pages layout. Particularly the extension page 0xa4
> >>> provides a register 0x1c, which bits 1 and 2 control the described delays.
> >>> They are used to implement the "rgmii-{id,rxid,txid}" phy-mode.
> >>>
> >>> The hidden RGMII configs register utilization was found in the rtl8211e
> >>> U-boot driver:
> >>> https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99
> >>>
> >>> There is also a freebsd-folks discussion regarding this register:
> >>> https://reviews.freebsd.org/D13591
> >>>
> >>> It confirms that the register bits field must control the so called
> >>> configuration pins described in the table 12-13 of the official PHY
> >>> datasheet:
> >>> 8:6 = PHY Address
> >>> 5:4 = Auto-Negotiation
> >>> 3 = Interface Mode Select
> >>> 2 = RX Delay
> >>> 1 = TX Delay
> >>> 0 = SELRGV
> >>>
> >>> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >>
> >>
> >> Hi Serge
> >>
> >> Next time please include a patch 0 containing a cover note explaining
> >> the who series.
> >>
> > 
> > Sure as long as the patchset gets to be much bigger than two small
> > patches with an obvious reason to be merged.
> 
> netdev likes to have a cover letter for patch count >= 1, probably
> something to be added to netdev-FAQ.rst.
> -- 
> Florian

Hello Florian
Really, even with count = 1? So just one patch with cover-letter? Doesn't it
seem redundant since at least a single patch can be thoroughly described in
it' commit message?

-Sergey
