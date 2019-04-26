Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998DEC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C5B2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUVg7aT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfDZU0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:26:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37939 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZU0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:26:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so4068095ljg.5;
        Fri, 26 Apr 2019 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NRf6fPRoDtmC1o02fDkHSeAWw3aoCmwF1enhAPvBMZ8=;
        b=fUVg7aT/Gihxi1r/XcoOhMIYKImP0SOyREvZh7YYj5/R4pZ+gzajeUIZyqMd1dDoCz
         Rco2KWE0pyl/DJZ16WOMsBsXL0o4YrK6dthhmBgO+6OLMHub6eiuYEj5rPd9utKVDzwI
         0DE4xN7zymvUsJ3HmfWjZXJ0Cu7cvQ7xSEf+t7IpbJjb5UAHOIxvFNiavW0pInRHHfoJ
         +8hvRbvzHl2TV7zMHNlA4A+s889zxamnJQw0m0kjsKG/A4EXpoL8rah95XJFQfGbriKO
         9Kwg/tnJ7yaVRGonDkVXz8STatpLPvyO2nhUsng5Ucap5XaTEUL83UUMA9pEYGSnYteT
         Tj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NRf6fPRoDtmC1o02fDkHSeAWw3aoCmwF1enhAPvBMZ8=;
        b=MN7ACUD+LJzRBDl0txiVeZAiJcWs+FMO6gEcOG5oXLEC1lLadThE9c6bV1WqHn4N1w
         KTF2IjXJUeZF8ktze29w1FhWCdRyDKIqBfOYpI6njTy7DIOTDgd5C7pcE3hkSX8eLZ3n
         dRQJsnueP0Z20uw8TCMABq+KWTPxxMesF2kGUeFgeHhYS+GNkgn+dKz8C+LwJ9YlRscq
         7IokcNHfBv5+dvnfmsWOKJKL9G0oUn2OZfGijidwlwst68Ijku+gPY4AjZOs2gVZi5ye
         6tqNrOep+RkYYG/6Svv72GWwPs4rwQbnWecZSvBc0WnxPfe8OdFJfl361ezW941yezxT
         ZF1A==
X-Gm-Message-State: APjAAAWifIJdESibM39Fyw8845Aaiq83GZDFIxlGAiOf/hg2YRTL6Xxf
        iUt9P1Fv6Gi6mRxDkndokqM=
X-Google-Smtp-Source: APXvYqxk1kI13fNo+Sbl2a7NK7J3ZtIDBK8dYDqM6XO0auUN56TUuvFSfMgKFBmuxD8478VVK9z7pA==
X-Received: by 2002:a2e:6e01:: with SMTP id j1mr2915219ljc.85.1556310387427;
        Fri, 26 Apr 2019 13:26:27 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id s26sm5419162ljj.52.2019.04.26.13.26.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 13:26:26 -0700 (PDT)
Date:   Fri, 26 Apr 2019 23:26:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: Add rtl8211e rx/tx delays config
Message-ID: <20190426202623.y4xoirlzcb7fmdjs@mobilestation>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <1393dc97-4211-bc9e-7284-5121c237e96b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393dc97-4211-bc9e-7284-5121c237e96b@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 07:17:44PM +0200, Heiner Kallweit wrote:
> On 26.04.2019 11:30, Serge Semin wrote:
> > There are two chip pins named TXDLY and RXDLY which actually addes
> > the 2ns delays to TXC and RXC for TXD/RXD latching. Alas it is only
> > documented info regarding the RGMII timing control configurations
> > the PHY provides. It turnes out the same settings can be setup
> > via MDIO registers hidden in the extension pages layout.
> > Particularly the extension page 0xa4 provides a register 0x1c,
> > which bits 1 and 2 control the described delays. They are used
> > to implemet the "rgmii-{id,rxid,txid}" phy-mode.
> > 
> There are few typos in the commit message.
> 

I'll fix them in v2. Thank you.

> > The hidden RGMII configs register utilization was found in the
> > rtl8211e U-boot driver:
> > https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99
> > 
> > There is also a freebsd discussion regarding this register:
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
> > ---
> >  drivers/net/phy/realtek.c | 44 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index 10df52ccddfe..8776b94d91ed 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -23,11 +23,14 @@
> >  
> >  #define RTL821x_INSR				0x13
> >  
> > +#define RTL821x_EXT_PAGE_SELECT			0x1e
> >  #define RTL821x_PAGE_SELECT			0x1f
> >  
> >  #define RTL8211F_INSR				0x1d
> >  
> >  #define RTL8211F_TX_DELAY			BIT(8)
> > +#define RTL8211E_TX_DELAY			BIT(1)
> > +#define RTL8211E_RX_DELAY			BIT(2)
> >  
> >  #define RTL8201F_ISR				0x1e
> >  #define RTL8201F_IER				0x13
> > @@ -174,6 +177,46 @@ static int rtl8211f_config_init(struct phy_device *phydev)
> >  	return phy_modify_paged(phydev, 0xd08, 0x11, RTL8211F_TX_DELAY, val);
> >  }
> >  
> > +static int rtl8211e_config_init(struct phy_device *phydev)
> > +{
> > +	int ret, oldpage;
> > +	u16 val = 0;
> > +
> > +	ret = genphy_config_init(phydev);
> 
> There's no need to call genphy_config_init().
> 

Right. I'll fix it in v2. It's working even with calling the function though.

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
> > +
> > +	/* According to a sample driver there is a 0x1c config register on
> > +	 * a 0xa4 extension page (0x7) layout. It can be used to disable/enable
> > +	 * the RX/TX delays otherwise controlled by hardware strobes. It can
> > +	 * also be used to customize the whole configuration register:
> > +	 * 8:6 = PHY Address, 5:4 = Auto-Negotiation, 3 = Interface Mode Select,
> > +	 * 2 = RX Delay, 1 = TX Delay, 0 = SELRGV (see original PHY datasheet
> > +	 * for details).
> > +	 */
> > +	oldpage = phy_select_page(phydev, 0x7);
> > +	if (oldpage < 0)
> > +		goto err_restore_page;
> > +
> > +	ret = phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0xa4);
> > +	if (!ret)
> 
> I think this should be: if (ret)
> 

My goodness. What a shame on me to miss this! I ported this function from an older
kernel, and apparently didn't do this accurate enough. Sorry for this awful
bug. I'll fix it in the next patch revision.

-Sergey

> > +		goto err_restore_page;
> > +
> > +	ret = phy_modify(phydev, 0x1c, RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
> > +			 val);
> > +
> > +err_restore_page:
> > +	return phy_restore_page(phydev, oldpage, ret);
> > +}
> > +
> >  static int rtl8211b_suspend(struct phy_device *phydev)
> >  {
> >  	phy_write(phydev, MII_MMD_DATA, BIT(9));
> > @@ -257,6 +300,7 @@ static struct phy_driver realtek_drvs[] = {
> >  		PHY_ID_MATCH_EXACT(0x001cc915),
> >  		.name		= "RTL8211E Gigabit Ethernet",
> >  		.features	= PHY_GBIT_FEATURES,
> > +		.config_init	= &rtl8211e_config_init,
> >  		.ack_interrupt	= &rtl821x_ack_interrupt,
> >  		.config_intr	= &rtl8211e_config_intr,
> >  		.suspend	= genphy_suspend,
> > 
> 
