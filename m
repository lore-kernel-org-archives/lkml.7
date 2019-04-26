Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736BAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A47520656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQQFJUUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDZTTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:19:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34818 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZTTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:19:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so3937986ljj.2;
        Fri, 26 Apr 2019 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sSVq9CKxlPvvusLhLt8D7cvVcrqvQwt5oo6mkN2190g=;
        b=GQQFJUUNd8KQ6QTmwqM7E7yf8PRkM9k5KZFRCxZSqNHaXT7pFyoLUyx3+8dKJ73dr4
         M7IJC+DsljbB3/VDWZpjRX3om8AMC44abdqD6N5TRYai5ga8SNFaoN5+JXA02EctXuCB
         Oft8DuqWqMERJs1FdrGufKhycwZMKmxH41H74I7p0KjXzVim3SztTwad5cYlmZqCvWy5
         nkVZbiWZlKIvd68bbo4ADN6yJV+lFLeJeGdotZPpeP5dGXhjiQJrNVnGrkk+B5fUnyP9
         22/YXbM+xAHYOLGVRZ62va58fw3yYUOeCfcWYIpkrAn4fd2VoKK3CKFOm6A8DC36Xnpq
         Daaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sSVq9CKxlPvvusLhLt8D7cvVcrqvQwt5oo6mkN2190g=;
        b=sS5ppJ9S/lpUIcYQ9F5FyET2EMrLvXgsyIDUmi2El4lLGTWUuZKL5lfXmjnUjXTRP0
         rPi/VPFB5U44LNEAYQ31/riApxb4O+Q2RmLInMHXtQiTJ80E8FYrMipy27yRpYc++xOC
         9Eg+u4ABkTdxpAKvx6ZUoez8HwED38QSPxikLXvWudqlfzoUDt4sbOOtBmFmC7qlnaXL
         qqLI7UbbbJPv27ncfqMt1NdgTPFVhYRW7zOTRraX1qwaI0+6Pi8mmOvl7Kl+MZYy+99n
         iDefTTTWMxGF0WvFAOJnUV6KecVtfJWI+N89lXdOB4KtMhdcm7KRaY5bw/eGRiXyccUP
         HXYw==
X-Gm-Message-State: APjAAAVRnkGqGohvBVCB5spOhc1lpejMT+rWYSPHzhBgD9f6C9uwRBmw
        ASHdK4du/OLPmtL+pO0HIqI=
X-Google-Smtp-Source: APXvYqyPJ+YoPbBM8XDgocOpjX07UPXBM5gbDQrkdLP8iAcgnZNHZUUlZkMtch94RhdJrQyojhs8Xg==
X-Received: by 2002:a2e:9bcc:: with SMTP id w12mr4929924ljj.72.1556306379522;
        Fri, 26 Apr 2019 12:19:39 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id o1sm2637293ljd.74.2019.04.26.12.19.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 12:19:38 -0700 (PDT)
Date:   Fri, 26 Apr 2019 22:19:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: Add rtl8211e rx/tx delays config
Message-ID: <20190426191935.ihppqlmtpemzp3kr@mobilestation>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426132821.GB14432@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426132821.GB14432@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 03:28:21PM +0200, Andrew Lunn wrote:
> On Fri, Apr 26, 2019 at 12:30:10PM +0300, Serge Semin wrote:
> > The hidden RGMII configs register utilization was found in the
> > rtl8211e U-boot driver:
> > https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99
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
> 
> > +static int rtl8211e_config_init(struct phy_device *phydev)
> > +{
> > +	int ret, oldpage;
> > +	u16 val = 0;
> > +
> > +	ret = genphy_config_init(phydev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* enable TX/RX delay for rgmii-* modes, otherwise disable it */
> > +	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
> > +		val = RTL8211E_TX_DELAY | RTL8211E_RX_DELAY;
> > +	else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
> > +		val = RTL8211E_TX_DELAY;
> > +	else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID)
> > +		val = RTL8211E_RX_DELAY;
> 
> Hi Serge
> 
> You need to look for PHY_INTERFACE_MODE_RGMII and disable the bits.
> For any other value, and in particular PHY_INTERFACE_MODE_NA, you
> should leave the bits alone.
> 
> As you found out, u-boot knows how to program these bits. There are
> probably boards out there which rely on u-boot doing this, and the PHY
> driver then not messing with the bits. The way to indicate it should
> not mess with the bits is to not have a phy-mode property in DT, which
> results in PHY_INTERFACE_MODE_NA.
> 

Hello Andrew

Thanks for the comment. I'll alter the code the way you said. The mode will
be changed by the config_init-function only if the interface is selected to be
rgmii-like (rgmii, rgmii-id, rgmii-txid and rgmii-rxid), otherwise it will
be left as is.

But I've got a question regarding this then. What about for instance rtl8211f
phy config_init-method? It setups the delay config in any case, no matter
whether interface is configured to be of rgmii or another mode. Is it correct
to configure rtl8211e and rtl8211f differently? Especially seeing the U-boot
driver also perform the rtl8211f phy configuration.

-Sergey

> 	Andrew
