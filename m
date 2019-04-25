Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85449C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57152217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbfDYHIJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:08:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:57035 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfDYHII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:08:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:08:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="226513946"
Received: from kmsmsx157.gar.corp.intel.com ([172.21.138.134])
  by orsmga001.jf.intel.com with ESMTP; 25 Apr 2019 00:08:06 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.111]) by
 kmsmsx157.gar.corp.intel.com ([169.254.5.17]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:07:26 +0800
From:   "Voon, Weifeng" <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Andrew Lunn" <andrew@lunn.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Giuseppe Cavallaro" <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>
Subject: RE: [PATCH 5/7] net: stmmac: add xpcs function hooks into main
 driver and ethtool
Thread-Topic: [PATCH 5/7] net: stmmac: add xpcs function hooks into main
 driver and ethtool
Thread-Index: AQHU+n5zN7f92vLfPkuw4BdXkHVRgaZMdeYg
Date:   Thu, 25 Apr 2019 07:07:25 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC8146EF0B8@PGSMSX103.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-6-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1556126241-2774-6-git-send-email-weifeng.voon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjI0ZjQ3OTMtZmYzYy00ZTU3LTk1ZWMtNjNkOGU3YjgxNDI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU3NsVFlwQ2RZRnFaemo4VEd5MnQ2U2FzSG5qRnY5aGpiU0lJUFlyR0FjNUhUTnlEMkpIdHRVeUhJRVpBa01kNSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ong Boon Leong <boon.leong.ong@intel.com>
> 
> With xPCS functions now ready, we add them into the main driver and
> ethtool logics. To differentiate from EQoS MAC PCS and DWC Ethernet xPCS,
> we introduce 'has_xpcs' in platform data as a mean to indicate whether GBE
> controller includes xPCS or not.
> 
> To support platform-specific C37 AN PCS mode selection for MII MMD, we
> introduce 'pcs_mode' in platform data.
> 
> The basic framework for xPCS interrupt handling is implemented too.
> 
> Reviewed-by: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
> Reviewed-by: Voon Weifeng <weifeng.voon@intel.com>
> Reviewed-by: Kweh Hock Leong <hock.leong.kweh@intel.com>
> Reviewed-by: Baoli Zhang <baoli.zhang@intel.com>
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 14 ++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 50
> ++++++++++++++++++++++
>  include/linux/stmmac.h                             |  2 +
>  4 files changed, 68 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index dd95d95..0b8460a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -36,6 +36,7 @@ struct stmmac_resources {
>  	const char *mac;
>  	int wol_irq;
>  	int lpi_irq;
> +	int xpcs_irq;
>  	int irq;
>  };
> 
> @@ -168,6 +169,7 @@ struct stmmac_priv {
>  	int clk_csr;
>  	struct timer_list eee_ctrl_timer;
>  	int lpi_irq;
> +	int xpcs_irq;
>  	int eee_enabled;
>  	int eee_active;
>  	int tx_lpi_timer;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 3c749c3..0c146b3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -392,6 +392,10 @@ static int stmmac_ethtool_get_link_ksettings(struct
> net_device *dev,
> 
>  		mutex_lock(&priv->lock);
>  		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, priv->hw->ps, 0);
> +
> +		if (priv->plat->has_xpcs)
> +			stmmac_xpcs_ctrl_ane(priv, dev, 1, 0);
> +
>  		mutex_unlock(&priv->lock);
> 
>  		return 0;
> @@ -457,6 +461,11 @@ static void stmmac_ethtool_gregs(struct net_device
> *dev,
>  		pause->autoneg = 1;
>  		if (!adv_lp.pause)
>  			return;
> +	} else if (priv->plat->has_xpcs &&
> +		   !stmmac_xpcs_get_adv_lp(priv, netdev, &adv_lp)) {
> +		pause->autoneg = 1;
> +		if (!adv_lp.pause)
> +			return;
>  	} else {
>  		if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT,
>  				       netdev->phydev->supported) || @@ -
> 488,6 +497,11 @@ static void stmmac_ethtool_gregs(struct net_device *dev,
>  		pause->autoneg = 1;
>  		if (!adv_lp.pause)
>  			return -EOPNOTSUPP;
> +	} else if (priv->plat->has_xpcs &&
> +		   !stmmac_xpcs_get_adv_lp(priv, netdev, &adv_lp)) {
> +		pause->autoneg = 1;
> +		if (!adv_lp.pause)
> +			return -EOPNOTSUPP;
>  	} else {
>  		if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT,
>  				       phy->supported) ||
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ec031e3..d6e315f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -112,6 +112,7 @@
>  MODULE_PARM_DESC(chain_mode, "To use chain instead of ring mode");
> 
>  static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
> +static irqreturn_t xpcs_interrupt(int irq, void *dev_id);
> 
>  #ifdef CONFIG_DEBUG_FS
>  static int stmmac_init_fs(struct net_device *dev); @@ -2538,6 +2539,10 @@
> static int stmmac_hw_setup(struct net_device *dev, bool init_ptp)
>  	/* Initialize MTL*/
>  	stmmac_mtl_configuration(priv);
> 
> +	/* Initialize the xPCS PHY */
> +	if (priv->plat->has_xpcs)
> +		stmmac_xpcs_init(priv, dev, priv->plat->pcs_mode);
> +
>  	/* Initialize Safety Features */
>  	stmmac_safety_feat_configuration(priv);
> 
> @@ -2579,6 +2584,9 @@ static int stmmac_hw_setup(struct net_device
> *dev, bool init_ptp)
>  	if (priv->hw->pcs)
>  		stmmac_pcs_ctrl_ane(priv, priv->hw, 1, priv->hw->ps, 0);
> 
> +	if (priv->plat->has_xpcs)
> +		stmmac_xpcs_ctrl_ane(priv, dev, 1, 0);
> +
>  	/* set TX and RX rings length */
>  	stmmac_set_rings_length(priv);
> 
> @@ -2696,11 +2704,27 @@ static int stmmac_open(struct net_device *dev)
>  		}
>  	}
> 
> +	/* xPCS IRQ line */
> +	if (priv->xpcs_irq > 0) {
> +		ret = request_irq(priv->xpcs_irq, xpcs_interrupt,
> IRQF_SHARED,
> +				  dev->name, dev);
> +		if (unlikely(ret < 0)) {
> +			netdev_err(priv->dev,
> +				   "%s: ERROR: allocating the xPCS IRQ %d
> (%d)\n",
> +				   __func__, priv->xpcs_irq, ret);
> +			goto xpcsirq_error;
> +		}
> +	}
> +
>  	stmmac_enable_all_queues(priv);
>  	stmmac_start_all_queues(priv);
> 
>  	return 0;
> 
> +xpcsirq_error:
> +	if (priv->lpi_irq > 0)
> +		free_irq(priv->lpi_irq, dev);
> +
>  lpiirq_error:
>  	if (priv->wol_irq != dev->irq)
>  		free_irq(priv->wol_irq, dev);
> @@ -3774,6 +3798,31 @@ static irqreturn_t stmmac_interrupt(int irq, void
> *dev_id)
>  	return IRQ_HANDLED;
>  }
> 
> +/**
> + *  xPCS_interrupt - xPCS ISR
> + *  @irq: interrupt number.
> + *  @dev_id: to pass the net device pointer.
> + *  Description: this is the xPCS interrupt service routine.
> + */
> +static irqreturn_t xpcs_interrupt(int irq, void *dev_id) {
> +	irqreturn_t ret = IRQ_NONE;
> +	struct net_device *ndev = (struct net_device *)dev_id;
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +
> +	if (unlikely(!ndev)) {
> +		netdev_err(priv->dev, "%s: invalid dev pointer\n",
> +			   __func__);
> +		return ret;
> +	}
> +
> +	/* To handle xPCS interrupts */
> +	if (priv->plat->has_xpcs)
> +		ret = stmmac_xpcs_irq_status(priv, ndev, &priv->xstats);
> +
> +	return ret;
> +}
> +
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>  /* Polling receive - used by NETCONSOLE and other diagnostic tools
>   * to allow network I/O with interrupts disabled.
> @@ -4263,6 +4312,7 @@ int stmmac_dvr_probe(struct device *device,
>  	priv->dev->irq = res->irq;
>  	priv->wol_irq = res->wol_irq;
>  	priv->lpi_irq = res->lpi_irq;
> +	priv->xpcs_irq = res->xpcs_irq;
> 
>  	if (res->mac)
>  		memcpy(priv->dev->dev_addr, res->mac, ETH_ALEN); diff --
> git a/include/linux/stmmac.h b/include/linux/stmmac.h index
> b00e795..2adb78c 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -189,6 +189,8 @@ struct plat_stmmacenet_data {
>  	struct reset_control *stmmac_rst;
>  	struct stmmac_axi *axi;
>  	int has_gmac4;
> +	int has_xpcs;
> +	int pcs_mode;
>  	bool has_sun8i;
>  	bool tso_en;
>  	int mac_port_sel_speed;
> --
> 1.9.1

++ stmmac maintainers and c45 experts
