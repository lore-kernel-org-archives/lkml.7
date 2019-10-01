Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E960ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C81215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVFlNzI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfJASlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:41:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35552 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfJASlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:41:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so4362090wmi.0;
        Tue, 01 Oct 2019 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ek0gsYfi3Vy1gMb097xVuwnyeFGprTy5gNSWZoQS5SY=;
        b=cVFlNzI702y9/ozLuMS34tSwJRDl5PhxryYoPGQlPaO1ZdwvSk+sO0fiysjVTQnLQF
         YH+Lr1TXLqIXF3feccdF0AKdt1tGRDYkDWWkBw6lR05tRPPmA2+UiRfzffhJkUVRgIN/
         E79kqfx6MmDs9IXtnUjX/xRWFY0xRjfASEmITFv3RpkHPNvsW0X15P4D0+Q1wNLdz4xj
         rW1VjGUzG6sgiGtB/HSoj2l+CsO3nnljSWN0YB4Q9e6htjZZReKt5KmNF3V/5BzUjEjI
         gh4OqFdLDkIZrNj/NJI50pdn1uin6k5UgPSOeGoyguee7svrkRq13iBn3nNSPeNB6j1M
         PRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ek0gsYfi3Vy1gMb097xVuwnyeFGprTy5gNSWZoQS5SY=;
        b=tTeGeD42GR1KowGmDJI0JYsWyo0P5lpKNJGMjtp96jgLaO9eVdVL5elHjGgY4wGQvX
         b53xBDWoW5tNxyj4ekKXDBV804ywwzuhdTqVVWpQUaT7b30LKL5e/B/6tKvl1fr/uJNy
         e4xszR2mxSGc+s+VSNIgy94U6KkL0nRXN8Q+cbLsw7TGuip+rRpKAKwoOtp3RWOGdnhY
         TuJEfK2TPxd/Fn/FjWyDI6KOjTrt0ZBUFFt9zm+mvib0OFu50uuSwUfOOG8wsKcorM5i
         mcoULO9t0KnO3rEczXRXqhEbfCTyn8g5kENMg0DCv9R0uyEnDLeWYrdbFH4GzZX3NKND
         GutA==
X-Gm-Message-State: APjAAAUthr/b7/TL6Nw4j6K4Sj3xcbrkK4FN5MKNmPJNRUcLMJr6ovie
        qKVTcbdLSfQBkcEdtPfiTKEaNotz
X-Google-Smtp-Source: APXvYqzsuQ2zQo9SyF/Wm4NkXsrQuAIwe12oC6nZoHwWjetEXlfkkAQnjv9PlL+QtdS2jT93xRXs0Q==
X-Received: by 2002:a1c:96cd:: with SMTP id y196mr4825765wmd.67.1569955260767;
        Tue, 01 Oct 2019 11:41:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:ad11:16fb:d8da:de15? (p200300EA8F266400AD1116FBD8DADE15.dip0.t-ipconnect.de. [2003:ea:8f26:6400:ad11:16fb:d8da:de15])
        by smtp.googlemail.com with ESMTPSA id g185sm4921556wme.10.2019.10.01.11.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 11:41:00 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] net: phy: at803x: remove probe and struct
 at803x_priv
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191001060811.24291-1-o.rempel@pengutronix.de>
 <20191001060811.24291-4-o.rempel@pengutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <2a451415-39a1-67fe-7125-92a3b12a87df@gmail.com>
Date:   Tue, 1 Oct 2019 20:40:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001060811.24291-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.2019 08:08, Oleksij Rempel wrote:
> struct at803x_priv is never used in this driver. So remove it
> and the probe function allocating it.
> 
> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/at803x.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 42492f83c8d7..e64f77e152f4 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -63,10 +63,6 @@ MODULE_DESCRIPTION("Atheros 803x PHY driver");
>  MODULE_AUTHOR("Matus Ujhelyi");
>  MODULE_LICENSE("GPL");
>  
> -struct at803x_priv {
> -	bool phy_reset:1;
> -};
> -
>  struct at803x_context {
>  	u16 bmcr;
>  	u16 advertise;
> @@ -232,20 +228,6 @@ static int at803x_resume(struct phy_device *phydev)
>  	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE, 0);
>  }
>  
> -static int at803x_probe(struct phy_device *phydev)
> -{
> -	struct device *dev = &phydev->mdio.dev;
> -	struct at803x_priv *priv;
> -
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -
> -	phydev->priv = priv;
> -
> -	return 0;
> -}
> -
>  static int at803x_config_init(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -367,7 +349,6 @@ static struct phy_driver at803x_driver[] = {
>  	/* ATHEROS 8035 */
>  	PHY_ID_MATCH_EXACT(ATH8035_PHY_ID),
>  	.name			= "Atheros 8035 ethernet",
> -	.probe			= at803x_probe,
>  	.config_init		= at803x_config_init,
>  	.set_wol		= at803x_set_wol,
>  	.get_wol		= at803x_get_wol,
> @@ -380,7 +361,6 @@ static struct phy_driver at803x_driver[] = {
>  	/* ATHEROS 8030 */
>  	PHY_ID_MATCH_EXACT(ATH8030_PHY_ID),
>  	.name			= "Atheros 8030 ethernet",
> -	.probe			= at803x_probe,
>  	.config_init		= at803x_config_init,
>  	.link_change_notify	= at803x_link_change_notify,
>  	.set_wol		= at803x_set_wol,
> @@ -394,7 +374,6 @@ static struct phy_driver at803x_driver[] = {
>  	/* ATHEROS 8031 */
>  	PHY_ID_MATCH_EXACT(ATH8031_PHY_ID),
>  	.name			= "Atheros 8031 ethernet",
> -	.probe			= at803x_probe,
>  	.config_init		= at803x_config_init,
>  	.set_wol		= at803x_set_wol,
>  	.get_wol		= at803x_get_wol,
> 

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

