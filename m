Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C55C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0D3218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z3G1IUwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfCTWfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:35:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36297 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCTWfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:35:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id p10so2947202pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KQIlEavj5s6FklOKBJjNRjeV3z3XMzzHQszKqrgpYfA=;
        b=Z3G1IUwopW8X4sDrMJ6abqzTEDYCRfs3VaclaOD0zJumiMi1BkUGXPb7C+k51OQKuZ
         2xQ/SgHq3GOoWf4xL/4pwvbg6CJ5A+ZdYb76qZVu62J+86GteXuQXHI+LY8eze6ybjAT
         180CwTasE8C9DIWkOaIJd38RywRVQmDDDiRLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KQIlEavj5s6FklOKBJjNRjeV3z3XMzzHQszKqrgpYfA=;
        b=WlWH2kkwx92WiJFuN3N7Pm4dK9VqhH8ecyQ41jN15ANcuPfgZpg1xd69GI0d24OjyC
         OZOVJXBRuN89pV6F47VITjEmKNBbsqpWRYubsBDwy6j9yitAqMQigkkTa7KzQxNC5nrb
         Q+/5MTxw72DzAIAqY8BBpFQDOj3VLKPQzsbplhn60rEEgVLCPbfMSENQda+FNk/1Q642
         Z8f+sN1EjiDHuOV//rY3UtVTmVhFnJQza9sVafeUwPC3q55YGXCS9uP+Rb3fmsly83JI
         OKVL5Sg92g+yTJfGyhfUtQx8dMk1sncADtaDbp/S2Lr8RjQMAFdIlOlD101NpLq+Onbn
         A+vQ==
X-Gm-Message-State: APjAAAVr4ezYGBO/viIf5ahFeadWjzFjAmhIXTBWex0zRPwVtZAQCJXi
        F99wBmw25gkGNixs/ciWqZs6AQ==
X-Google-Smtp-Source: APXvYqzipXb4IeFpNM/kYp3I0ZDjTYdmuunJiibOHFOPpfCiwtJMorjcf1uaUoZM3J96y8hAK0kEIw==
X-Received: by 2002:a63:f212:: with SMTP id v18mr341709pgh.261.1553121337930;
        Wed, 20 Mar 2019 15:35:37 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 202sm4174229pfc.86.2019.03.20.15.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 15:35:37 -0700 (PDT)
Subject: Re: [PATCH net-next 2/2] net: phy: Move Omega PHY entry to Cygnus PHY
 driver
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        murali.policharla@broadcom.com, arun.parameswaran@broadcom.com
References: <20190320195313.15658-1-f.fainelli@gmail.com>
 <20190320195313.15658-3-f.fainelli@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <8f0d3799-8e14-1706-38a3-e9576dd0ba30@broadcom.com>
Date:   Wed, 20 Mar 2019 15:35:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320195313.15658-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Florian.

On 2019-03-20 12:53 p.m., Florian Fainelli wrote:
> Cygnus and Omega are part of the same business unit and product line, it
> makes sense to group PHY entries by products such that a platform can
> select only the drivers that it needs. Bring all the functionality that
> the BCM7XXX_28NM_GPHY() macro hides for us and remove the Omega PHY
> entry from bcm7xxx.c.
>
> As an added bonus, we now have a proper mdio_device_id entry to permit
> auto-loading.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/net/phy/Kconfig      |   5 +-
>   drivers/net/phy/bcm-cygnus.c | 147 ++++++++++++++++++++++++++++++++++-
>   drivers/net/phy/bcm7xxx.c    |   1 -
>   3 files changed, 149 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 071869db44cf..0973f0b81ce4 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -271,12 +271,13 @@ config BCM87XX_PHY
>   
>   config BCM_CYGNUS_PHY
>   	tristate "Broadcom Cygnus SoC internal PHY"
> -	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
> +	depends on ARCH_BCM_IPROC || COMPILE_TEST
>   	depends on MDIO_BCM_IPROC
> +	tristate "Broadcom Cygnus/Omega SoC internal PHY"
>   	select BCM_NET_PHYLIB
>   	---help---
>   	  This PHY driver is for the 1G internal PHYs of the Broadcom
> -	  Cygnus Family SoC.
> +	  Cygnus and Omega Family SoC.
>   
>   	  Currently supports internal PHY's used in the BCM11300,
>   	  BCM11320, BCM11350, BCM11360, BCM58300, BCM58302,
> diff --git a/drivers/net/phy/bcm-cygnus.c b/drivers/net/phy/bcm-cygnus.c
> index ab8e12922bf9..625b7cb76285 100644
> --- a/drivers/net/phy/bcm-cygnus.c
> +++ b/drivers/net/phy/bcm-cygnus.c
> @@ -10,6 +10,10 @@
>   #include <linux/netdevice.h>
>   #include <linux/phy.h>
>   
> +struct bcm_omega_phy_priv {
> +	u64	*stats;
> +};
> +
>   /* Broadcom Cygnus Phy specific registers */
>   #define MII_BCM_CYGNUS_AFE_VDAC_ICTRL_0  0x91E5 /* VDAL Control register */
>   
> @@ -121,6 +125,130 @@ static int bcm_cygnus_resume(struct phy_device *phydev)
>   	return genphy_config_aneg(phydev);
>   }
>   
> +static int bcm_omega_config_init(struct phy_device *phydev)
> +{
> +	u8 count, rev;
> +	int ret = 0;
> +
> +	rev = phydev->phy_id & ~phydev->drv->phy_id_mask;
> +
> +	pr_info_once("%s: %s PHY revision: 0x%02x\n",
> +		     phydev_name(phydev), phydev->drv->name, rev);
> +
> +	/* Dummy read to a register to workaround an issue upon reset where the
> +	 * internal inverter may not allow the first MDIO transaction to pass
> +	 * the MDIO management controller and make us return 0xffff for such
> +	 * reads.
> +	 */
> +	phy_read(phydev, MII_BMSR);
> +
> +	switch (rev) {
> +	case 0x00:
> +		ret = bcm_phy_28nm_a0b0_afe_config_init(phydev);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = bcm_phy_downshift_get(phydev, &count);
> +	if (ret)
> +		return ret;
> +
> +	/* Only enable EEE if Wirespeed/downshift is disabled */
> +	ret = bcm_phy_set_eee(phydev, count == DOWNSHIFT_DEV_DISABLE);
> +	if (ret)
> +		return ret;
> +
> +	return bcm_phy_enable_apd(phydev, true);
> +}
> +
> +static int bcm_omega_resume(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* Re-apply workarounds coming out suspend/resume */
> +	ret = bcm_omega_config_init(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* 28nm Gigabit PHYs come out of reset without any half-duplex
> +	 * or "hub" compliant advertised mode, fix that. This does not
> +	 * cause any problems with the PHY library since genphy_config_aneg()
> +	 * gracefully handles auto-negotiated and forced modes.
> +	 */
> +	return genphy_config_aneg(phydev);
> +}
> +
> +static int bcm_omega_get_tunable(struct phy_device *phydev,
> +				 struct ethtool_tunable *tuna, void *data)
> +{
> +	switch (tuna->id) {
> +	case ETHTOOL_PHY_DOWNSHIFT:
> +		return bcm_phy_downshift_get(phydev, (u8 *)data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int bcm_omega_set_tunable(struct phy_device *phydev,
> +				 struct ethtool_tunable *tuna,
> +				 const void *data)
> +{
> +	u8 count = *(u8 *)data;
> +	int ret;
> +
> +	switch (tuna->id) {
> +	case ETHTOOL_PHY_DOWNSHIFT:
> +		ret = bcm_phy_downshift_set(phydev, count);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Disable EEE advertisement since this prevents the PHY
> +	 * from successfully linking up, trigger auto-negotiation restart
> +	 * to let the MAC decide what to do.
> +	 */
> +	ret = bcm_phy_set_eee(phydev, count == DOWNSHIFT_DEV_DISABLE);
> +	if (ret)
> +		return ret;
> +
> +	return genphy_restart_aneg(phydev);
> +}
> +
> +static void bcm_omega_get_phy_stats(struct phy_device *phydev,
> +				    struct ethtool_stats *stats, u64 *data)
> +{
> +	struct bcm_omega_phy_priv *priv = phydev->priv;
> +
> +	bcm_phy_get_stats(phydev, priv->stats, stats, data);
> +}
> +
> +static int bcm_omega_probe(struct phy_device *phydev)
> +{
> +	struct bcm_omega_phy_priv *priv;
> +
> +	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	phydev->priv = priv;
> +
> +	priv->stats = devm_kcalloc(&phydev->mdio.dev,
> +				   bcm_phy_get_sset_count(phydev), sizeof(u64),
> +				   GFP_KERNEL);
> +	if (!priv->stats)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>   static struct phy_driver bcm_cygnus_phy_driver[] = {
>   {
>   	.phy_id        = PHY_ID_BCM_CYGNUS,
> @@ -132,10 +260,27 @@ static struct phy_driver bcm_cygnus_phy_driver[] = {
>   	.config_intr   = bcm_phy_config_intr,
>   	.suspend       = genphy_suspend,
>   	.resume        = bcm_cygnus_resume,
> -} };
> +}, {
> +	.phy_id		= PHY_ID_BCM_OMEGA,
> +	.phy_id_mask	= 0xfffffff0,
> +	.name		= "Broadcom Omega Combo GPHY",
> +	.features	= PHY_GBIT_FEATURES,
> +	.flags		= PHY_IS_INTERNAL,
> +	.config_init	= bcm_omega_config_init,
> +	.suspend	= genphy_suspend,
> +	.resume		= bcm_omega_resume,
> +	.get_tunable	= bcm_omega_get_tunable,
> +	.set_tunable	= bcm_omega_set_tunable,
> +	.get_sset_count	= bcm_phy_get_sset_count,
> +	.get_strings	= bcm_phy_get_strings,
> +	.get_stats	= bcm_omega_get_phy_stats,
> +	.probe		= bcm_omega_probe,
> +}
> +};
>   
>   static struct mdio_device_id __maybe_unused bcm_cygnus_phy_tbl[] = {
>   	{ PHY_ID_BCM_CYGNUS, 0xfffffff0, },
> +	{ PHY_ID_BCM_OMEGA, 0xfffffff0, },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(mdio, bcm_cygnus_phy_tbl);
> diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
> index dddeffa23aa1..a75e1b283541 100644
> --- a/drivers/net/phy/bcm7xxx.c
> +++ b/drivers/net/phy/bcm7xxx.c
> @@ -590,7 +590,6 @@ static struct phy_driver bcm7xxx_driver[] = {
>   	BCM7XXX_28NM_GPHY(PHY_ID_BCM7439, "Broadcom BCM7439"),
>   	BCM7XXX_28NM_GPHY(PHY_ID_BCM7439_2, "Broadcom BCM7439 (2)"),
>   	BCM7XXX_28NM_GPHY(PHY_ID_BCM7445, "Broadcom BCM7445"),
> -	BCM7XXX_28NM_GPHY(PHY_ID_BCM_OMEGA, "Broadcom Omega Combo GPHY"),
>   	BCM7XXX_40NM_EPHY(PHY_ID_BCM7346, "Broadcom BCM7346"),
>   	BCM7XXX_40NM_EPHY(PHY_ID_BCM7362, "Broadcom BCM7362"),
>   	BCM7XXX_40NM_EPHY(PHY_ID_BCM7425, "Broadcom BCM7425"),
