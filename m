Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA6C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED402077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrLqAyVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDZXfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:35:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43471 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfDZXfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 19:35:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id i68so3524338lfi.10;
        Fri, 26 Apr 2019 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/kwsg6pV4937XQsbZ01+kDrHX4d+JvRzQOsL+fVr2Q4=;
        b=TrLqAyVi4U0JTk6kj44IbgGSsaX2J3ZiKxRZW8kaeBDFdxusiOrvVmnsdn/cSuWeAP
         XfcmXpY4eaP2eV8q7r/QJYzUweIcI+Q3TMRPBm+MD/vot51RBnjZuRgU0z9Q/m5AVigR
         T+4UBJ8wj6giiyCkKGjC3YLUR/TlhBiM20IwkVypyMk2j5aJSgiwYNJ221fnfHqrjc12
         hfwpB3D+DhlpJzQ8J5IBhSE2apZL8Xb/wr6Q57Tw9lCWr3Qop1lzgNdu4tRtULCR13Jb
         s3rqWHuBPy7lWNEVxwbUEe+YKdLTsdA801YKGJxoQI7X53/NlKbNh3T3RQ6JS1bUZXhG
         UQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/kwsg6pV4937XQsbZ01+kDrHX4d+JvRzQOsL+fVr2Q4=;
        b=tfHRMKRKMHuiEcs8IsS8qFP6n3iDh8k+YwayPD6d0/bNIRzM1S88Tg/rerkFlXdCeu
         1ycTYsLebgTS4Lmmo/1gUmmpqcLw2gFFrnE+3/NbSYBs3PUm141jDELs8Fa5QVkd3uSL
         TcdFXvYZpLOx5Qfer2Cz5SrnP6sLoZzN+qG7rQOahxtSwtAKqtK+KCzr4Buaw+8lGeKt
         1sKIkS92uPUXKf/tVGTV0hSNIlHltxhtD3HZnvYMvEp5isMdTC/1ElssxL4e0jo6fIZv
         VMA6xLT5FL2TM0UgUKm3Ohcd/SDvHUp1ifeGXcELww4OFGDDYgJWc1SfVn7tQyt6z+xn
         141Q==
X-Gm-Message-State: APjAAAUBiXjzGEg0jpn5aivm6TTsOZsLlKiQkr4Rc5AvG8ebxCt+f30s
        1PemmBZ7QIIBAjhcJaV2pAg=
X-Google-Smtp-Source: APXvYqzAiWp2vT38OST2PmIRrzV6LYqwPw1+KjkZQJ2v/qN3jnY5dIYn1/A2C3txqeJKIit7mqYltQ==
X-Received: by 2002:ac2:44b2:: with SMTP id c18mr25181949lfm.86.1556321716509;
        Fri, 26 Apr 2019 16:35:16 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w12sm1795665ljj.11.2019.04.26.16.35.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 16:35:15 -0700 (PDT)
Date:   Sat, 27 Apr 2019 02:35:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: phy: realtek: Change TX-delay setting for
 RGMII modes only
Message-ID: <20190426233511.qnkgz75ag7axt5lp@mobilestation>
References: <20190426212112.5624-1-fancer.lancer@gmail.com>
 <20190426212112.5624-2-fancer.lancer@gmail.com>
 <20190426214631.GV4041@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426214631.GV4041@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:46:31PM +0200, Andrew Lunn wrote:
> On Sat, Apr 27, 2019 at 12:21:12AM +0300, Serge Semin wrote:
> > It's prone to problems if delay is cleared out for other than RGMII
> > modes. So lets set/clear the TX-delay in the config register only
> > if actually RGMII-like interface mode is requested.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > ---
> >  drivers/net/phy/realtek.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index ab567a1923ad..a18cb01158f9 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -163,16 +163,24 @@ static int rtl8211c_config_init(struct phy_device *phydev)
> >  static int rtl8211f_config_init(struct phy_device *phydev)
> >  {
> >  	int ret;
> > -	u16 val = 0;
> > +	u16 val;
> >  
> >  	ret = genphy_config_init(phydev);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	/* enable TX-delay for rgmii-id and rgmii-txid, otherwise disable it */
> > -	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
> > -	    phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
> > +	/* enable TX-delay for rgmii-id/rgmii-txid, and disable it for rgmii */
> > +	switch (phydev->interface) {
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +		val = 0;
> > +		break;
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> >  		val = RTL8211F_TX_DELAY;
> > +		break;
> > +	default: /* the rest of the modes imply leaving delay as is. */
> > +		return 0;
> > +	}
> 
> So there is no control of the RX delay?
> 

As you can see it hasn't been there even before this change. So I suppose
either the hardware just doesn't support it (although the openly available
datasheet states that there is an RXD pin) or the original driver developer
decided to set TX-delay only.

Just to make sure you understand. I am not working for realtek and don't
posses any inside info regarding these PHYs. I was working on a project,
which happened to utilize a rtl8211e PHY. We needed to find a way to
programmatically change the delays setting. So I searched the Internet
and found the U-boot rtl8211f driver and freebsd-folks discussion. This
info has been used to write the config_init method for Linux version of the
PHY' driver. That's it.

> That means PHY_INTERFACE_MODE_RGMII_ID and
> PHY_INTERFACE_MODE_RGMII_RXID are not supported, and you should return
> -EINVAL.
> 

Apparently the current config_init method doesn't support RXID setting.
The patch introduced current function code was submitted by
Martin Blumenstingl in 2016:
https://patchwork.kernel.org/patch/9447581/
and was reviewed by Florian. So we'd better ask him why it was ok to mark
the RGMII_ID as supported while only TX-delay could be set.
I also failed to find anything regarding programmatic rtl8211f delays setting
in the Internet. So at this point we can set TX-delay only for f-model of the PHY.

Anyway lets clarify the situation before to proceed further. You are suggesting
to return an error in case if either RGMII_ID or RGMII_RXID interface mode is
requested to be enabled for the PHY. It's fair seeing the driver can't fully
support either of them. But what about the rest of the modes like GMII, MII
and others? Shouldn't we also return an error instead of leaving a default
delay value?

The same question can be actually asked regarding the config_init method of
rtl8211e PHY, which BTW you already tagged as Reviewed-by.

> This is where we get into interesting backwards compatibility
> issues. Are there any broken DT blobs with rgmii-id or rgmii-rxid,
> which will break with such a change?
> 

Not that I am aware of and which simple grep rtl8211 could find. Do you
know about one?

-Sergey

> 	Andrew
