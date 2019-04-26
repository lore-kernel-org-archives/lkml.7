Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3128C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E455212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pObUwen/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfDZRR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:17:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36787 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDZRR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:17:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id b1so5464085wru.3;
        Fri, 26 Apr 2019 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uRlmqbsy9AlHWA5lA20w40XlV/SVimhS1euM8k4c3rE=;
        b=pObUwen/SMTK7HuAHFFy7NlIqyubfqjmF7nhGn/yx77MzInfFgmEE3i1MpjxCHUd/N
         lkvZ1Fn3xR4NjSlFnDEMmnOFgT3Synos0KCzHcTbeJ5QNGzYh5sIxqPdJIR4O/5gy2KW
         whQLqlYJNp0J4dovqLCpbbEzGbBSUjrsxp2nSJCtFe16YC5rfX8XSvXyTUYx9ga76Ciz
         WAuTuXvc1p9CxpW9fexs7wmQhmX641h1X7d6VRd6xAUMWL4mKcb/M79r/BTexcN0r9At
         RdZhAZqpTpB0G9KIsleUdndk5CazfwniQ3gYTZyi9RcEL2wNQvn/GYN4s55yIX4YMlMG
         BwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uRlmqbsy9AlHWA5lA20w40XlV/SVimhS1euM8k4c3rE=;
        b=ralaSlt7qR1xGcIgFX+3B/oS8j31hDNXZ79kfjlZx8S1KZY9moycwTgN+J13QeEoL6
         4q1ecmwYfPRRakKW5dyf595MFSXTOKuZJdPlYEukbqIv8ODHi3i2R7aS7fd78NISJDrq
         X43jli0sLvqYlFrL15jhndPU+Eh5/1IUo50mP+QQE7gZwsmatIBg2X3HLCNy0z9TLhIt
         bycBcDKqS0y83fPFVkHoKW+I2mIFm5/o4M70x82gy1LSuvxRw0Pev3yLgyFC69luAERl
         WQuqFXEVSKiv9nlew2tkUDp+q1vx+ydWUf8CldKnx3hjIFLNjp0p1LbBIi6IWN4NY2Dh
         kz+g==
X-Gm-Message-State: APjAAAUyd1pM1n8Y5ZCOajcl0ddrNe38z521vrMIOdNBQBPvFuOnv9Cc
        t7VpdTnKvEVYwWagLDzUEzPGrRi3qTo=
X-Google-Smtp-Source: APXvYqyEAHz76k41ihnaLDUY029P22Z3NcyifHQ60YXeuFIi/FAmN39siZS2bfDofp+ALPGNJ4aNQw==
X-Received: by 2002:adf:e288:: with SMTP id v8mr29608681wri.7.1556299074570;
        Fri, 26 Apr 2019 10:17:54 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:49f9:abd6:1a89:5e12? (p200300EA8BD4570049F9ABD61A895E12.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:49f9:abd6:1a89:5e12])
        by smtp.googlemail.com with ESMTPSA id s2sm21549403wmc.7.2019.04.26.10.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 10:17:53 -0700 (PDT)
Subject: Re: [PATCH] net: phy: realtek: Add rtl8211e rx/tx delays config
To:     Serge Semin <fancer.lancer@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <1393dc97-4211-bc9e-7284-5121c237e96b@gmail.com>
Date:   Fri, 26 Apr 2019 19:17:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426093010.9609-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.2019 11:30, Serge Semin wrote:
> There are two chip pins named TXDLY and RXDLY which actually addes
> the 2ns delays to TXC and RXC for TXD/RXD latching. Alas it is only
> documented info regarding the RGMII timing control configurations
> the PHY provides. It turnes out the same settings can be setup
> via MDIO registers hidden in the extension pages layout.
> Particularly the extension page 0xa4 provides a register 0x1c,
> which bits 1 and 2 control the described delays. They are used
> to implemet the "rgmii-{id,rxid,txid}" phy-mode.
> 
There are few typos in the commit message.

> The hidden RGMII configs register utilization was found in the
> rtl8211e U-boot driver:
> https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99
> 
> There is also a freebsd discussion regarding this register:
> https://reviews.freebsd.org/D13591
> 
> It confirms that the register bits field must control the so called
> configuration pins described in the table 12-13 of the official PHY
> datasheet:
> 8:6 = PHY Address
> 5:4 = Auto-Negotiation
> 3 = Interface Mode Select
> 2 = RX Delay
> 1 = TX Delay
> 0 = SELRGV
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 44 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 10df52ccddfe..8776b94d91ed 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -23,11 +23,14 @@
>  
>  #define RTL821x_INSR				0x13
>  
> +#define RTL821x_EXT_PAGE_SELECT			0x1e
>  #define RTL821x_PAGE_SELECT			0x1f
>  
>  #define RTL8211F_INSR				0x1d
>  
>  #define RTL8211F_TX_DELAY			BIT(8)
> +#define RTL8211E_TX_DELAY			BIT(1)
> +#define RTL8211E_RX_DELAY			BIT(2)
>  
>  #define RTL8201F_ISR				0x1e
>  #define RTL8201F_IER				0x13
> @@ -174,6 +177,46 @@ static int rtl8211f_config_init(struct phy_device *phydev)
>  	return phy_modify_paged(phydev, 0xd08, 0x11, RTL8211F_TX_DELAY, val);
>  }
>  
> +static int rtl8211e_config_init(struct phy_device *phydev)
> +{
> +	int ret, oldpage;
> +	u16 val = 0;
> +
> +	ret = genphy_config_init(phydev);

There's no need to call genphy_config_init().

> +	if (ret < 0)
> +		return ret;
> +
> +	/* enable TX/RX delay for rgmii-* modes, otherwise disable it */
> +	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
> +		val = RTL8211E_TX_DELAY | RTL8211E_RX_DELAY;
> +	else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
> +		val = RTL8211E_TX_DELAY;
> +	else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID)
> +		val = RTL8211E_RX_DELAY;
> +
> +	/* According to a sample driver there is a 0x1c config register on
> +	 * a 0xa4 extension page (0x7) layout. It can be used to disable/enable
> +	 * the RX/TX delays otherwise controlled by hardware strobes. It can
> +	 * also be used to customize the whole configuration register:
> +	 * 8:6 = PHY Address, 5:4 = Auto-Negotiation, 3 = Interface Mode Select,
> +	 * 2 = RX Delay, 1 = TX Delay, 0 = SELRGV (see original PHY datasheet
> +	 * for details).
> +	 */
> +	oldpage = phy_select_page(phydev, 0x7);
> +	if (oldpage < 0)
> +		goto err_restore_page;
> +
> +	ret = phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0xa4);
> +	if (!ret)

I think this should be: if (ret)

> +		goto err_restore_page;
> +
> +	ret = phy_modify(phydev, 0x1c, RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
> +			 val);
> +
> +err_restore_page:
> +	return phy_restore_page(phydev, oldpage, ret);
> +}
> +
>  static int rtl8211b_suspend(struct phy_device *phydev)
>  {
>  	phy_write(phydev, MII_MMD_DATA, BIT(9));
> @@ -257,6 +300,7 @@ static struct phy_driver realtek_drvs[] = {
>  		PHY_ID_MATCH_EXACT(0x001cc915),
>  		.name		= "RTL8211E Gigabit Ethernet",
>  		.features	= PHY_GBIT_FEATURES,
> +		.config_init	= &rtl8211e_config_init,
>  		.ack_interrupt	= &rtl821x_ack_interrupt,
>  		.config_intr	= &rtl8211e_config_intr,
>  		.suspend	= genphy_suspend,
> 

