Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993D620854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL1TGIU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfJOUCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:02:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38680 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfJOUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:02:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id y18so15890573wrn.5;
        Tue, 15 Oct 2019 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=05m1cn/KotINUoHlyo9YC+EDTkfB7CJrGG+iKU+PxSc=;
        b=fL1TGIU6joMydk42hUtjYANbOXSnI5S1b2AMxCBdhcqjnGBKiDyJ1OKd85k/QpoPmo
         6+lSiKEmjwjDT1rqySzjnmhY1c4cZm7s9+TYRQgXJ0ygJAsYNG8UZ54KUCye+jS8gE2N
         WkUk0P1UcWNIetAzMxSaRPSd02iuC7TJTWdsp8KUq3AN9Hb28OXOnOncEkQASFQIdtKw
         LjDx9CUOJ/ycd+3hXWZNdfSx53pxysUbpp3fPZYVBpUECY9XLuW/patGwQtC9RIAafoZ
         zG5mcFp2CzMK3/Zq4j1yJ+1+5hDfCx7vBFZPlbigl+z0rHZ6QbyW/TKdcA6XBGqicybC
         /JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05m1cn/KotINUoHlyo9YC+EDTkfB7CJrGG+iKU+PxSc=;
        b=dzJgWiZiZXMZj3zxAP4r5KSnHsi/8Mlf4Ufak5H+gDfW7U1VLcdPpY6Hk+fMxOrZo4
         B63nQKJFm1KRX12E6FztTh+EbBFbhytBwCa7uuObiwMGSlZTSbjIQ5/bCb9Emece2Rss
         j7sucEwj+4llc7WO/S0PvEc62k5UTROARPtybC8ezCVQA7VHlumG4KbQcJOn5lToo3jN
         PteUsMquSD6VDGA/4751L9hm/URGcm75WYD4jrZTMPHPZjq3ClIR1+oIlcv7OxjLzffD
         YfvFA85G3ldSQDfwdKod57A8BWAMij56SV9NNiGMVOuYompXHDuKjHvC0/rGBJ8Odse2
         OqNA==
X-Gm-Message-State: APjAAAVFNZPF9+H3Kw7X9B2sRHCPLDrUKxadi2BgLgJqlr3NzrDtj1Yh
        SI8/iavurjjLmzlcnOS03yQHQn7J
X-Google-Smtp-Source: APXvYqwmHrOEr80wF1njd/2UOS1FNYtF43EfX03AWC5TQyycxWc8OqHXCoWjgcYEl1OgHiC4GQDwNA==
X-Received: by 2002:a5d:40c6:: with SMTP id b6mr16985262wrq.90.1571169753799;
        Tue, 15 Oct 2019 13:02:33 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:44d1:b396:5862:c59e? (p200300EA8F26640044D1B3965862C59E.dip0.t-ipconnect.de. [2003:ea:8f26:6400:44d1:b396:5862:c59e])
        by smtp.googlemail.com with ESMTPSA id n8sm444969wma.7.2019.10.15.13.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 13:02:33 -0700 (PDT)
Subject: Re: [RFC PATCH V2 net] net: phy: Fix "link partner" information
 disappear issue
To:     Yonglong Liu <liuyonglong@huawei.com>, davem@davemloft.net,
        andrew@lunn.ch
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, shiju.jose@huawei.com
References: <1571057797-37602-1-git-send-email-liuyonglong@huawei.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4a281b6d-1531-eac6-dcc5-8306d342caa4@gmail.com>
Date:   Tue, 15 Oct 2019 22:02:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571057797-37602-1-git-send-email-liuyonglong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.2019 14:56, Yonglong Liu wrote:
> Some drivers just call phy_ethtool_ksettings_set() to set the
> links, for those phy drivers that use genphy_read_status(), if
> autoneg is on, and the link is up, than execute "ethtool -s
> ethx autoneg on" will cause "link partner" information disappear.
> 
> The call trace is phy_ethtool_ksettings_set()->phy_start_aneg()
> ->linkmode_zero(phydev->lp_advertising)->genphy_read_status(),
> the link didn't change, so genphy_read_status() just return, and
> phydev->lp_advertising is zero now.
> 
> This patch moves the clear operation of lp_advertising from
> phy_start_aneg() to genphy_read_lpa()/genphy_c45_read_lpa(), and
> if autoneg on and autoneg not complete, just clear what the
> generic functions care about.
> 
> Fixes: 88d6272acaaa ("net: phy: avoid unneeded MDIO reads in genphy_read_status")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> 
Looks good to me, two small nits below.


> ---
> change log:
> V2: moves the clear operation of lp_advertising from
> phy_start_aneg() to genphy_read_lpa()/genphy_c45_read_lpa(), and
> if autoneg on and autoneg not complete, just clear what the
> generic functions care about. Suggested by Heiner Kallweit.
> ---
> ---
This line seems to be duplicated.

>  drivers/net/phy/phy-c45.c    |  2 ++
>  drivers/net/phy/phy.c        |  3 ---
>  drivers/net/phy/phy_device.c | 12 +++++++++++-
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 7935593..a1caeee 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -323,6 +323,8 @@ int genphy_c45_read_pma(struct phy_device *phydev)
>  {
>  	int val;
>  
> +	linkmode_zero(phydev->lp_advertising);
> +
>  	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1);
>  	if (val < 0)
>  		return val;
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 119e6f4..105d389b 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -572,9 +572,6 @@ int phy_start_aneg(struct phy_device *phydev)
>  	if (AUTONEG_DISABLE == phydev->autoneg)
>  		phy_sanitize_settings(phydev);
>  
> -	/* Invalidate LP advertising flags */
> -	linkmode_zero(phydev->lp_advertising);
> -
>  	err = phy_config_aneg(phydev);
>  	if (err < 0)
>  		goto out_unlock;
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 9d2bbb1..4b43466 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1787,7 +1787,14 @@ int genphy_read_lpa(struct phy_device *phydev)
>  {
>  	int lpa, lpagb;
>  
> -	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
> +	if (phydev->autoneg == AUTONEG_ENABLE) {
> +		if (!phydev->autoneg_complete) {
> +			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
> +							0);
> +			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
> +			return 0;
> +		}
> +
>  		if (phydev->is_gigabit_capable) {
>  			lpagb = phy_read(phydev, MII_STAT1000);
>  			if (lpagb < 0)
> @@ -1816,6 +1823,9 @@ int genphy_read_lpa(struct phy_device *phydev)
>  
>  		mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, lpa);
>  	}
> +	else {

"} else {" should be on one line.

> +		linkmode_zero(phydev->lp_advertising);
> +	}
>  
>  	return 0;
>  }
> 

