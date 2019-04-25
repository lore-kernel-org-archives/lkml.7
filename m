Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E661C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F85217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbfDYHGu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:06:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:34301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfDYHGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:06:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="164681785"
Received: from kmsmsx153.gar.corp.intel.com ([172.21.73.88])
  by fmsmga002.fm.intel.com with ESMTP; 25 Apr 2019 00:06:45 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.111]) by
 KMSMSX153.gar.corp.intel.com ([169.254.5.36]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:06:44 +0800
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
Subject: RE: [PATCH 4/7] net: stmmac: introducing support for DWC xPCS logics
Thread-Topic: [PATCH 4/7] net: stmmac: introducing support for DWC xPCS
 logics
Thread-Index: AQHU+n5xbsOWDsFOxEOPsl0/LaZavKZMdcAQ
Date:   Thu, 25 Apr 2019 07:06:43 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC8146EF0A8@PGSMSX103.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-5-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1556126241-2774-5-git-send-email-weifeng.voon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzliMGVkOGQtZDcxZC00MTZjLTg3NTQtZTZmZDk0MTZiYTVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRXg0c1RwM1o2Sm9BQmxcL3QrT0RmWSs4QXVOOW4zb2ZyMUkwY1dHeFc2YzZhYVdid0V1WDArQ1NSRkNxTFFyMFYifQ==
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
> xPCS is DWC Ethernet Physical Coding Sublayer that may be integrated into a
> GbE controller that uses DWC EQoS MAC controller. An example of HW
> configuration is shown below:-
> 
>   <-----------------GBE Controller---------->|<--External PHY chip-->
> 
>   +----------+         +----+    +---+               +--------------+
>   |   EQoS   | <-GMII->|xPCS|<-->|L1 | <-- SGMII --> | External GbE |
>   |   MAC    |         |    |    |PHY|               | PHY Chip     |
>   +----------+         +----+    +---+               +--------------+
>          ^               ^                                  ^
>          |               |                                  |
>          +---------------------MDIO-------------------------+
> 
> xPCS is a Clause-45 MDIO Manageable Device (MMD) and we need a way to
> differentiate it from external PHY chip that is discovered over MDIO.
> Therefore, xpcs_phy_addr is introduced in stmmac platform data
> (plat_stmmacenet_data) for differentiating xPCS from 'phy_addr' that
> belongs to external PHY.
> 
> Basic functionalities for initializing xPCS and configuring auto negotiation (AN),
> loopback, link status, AN advertisement and Link Partner ability are
> implemented.
> 
> xPCS interrupt handling for C37 AN complete is also implemented.
> 
> Tested-by: Kweh Hock Leong <hock.leong.kweh@intel.com>
> Reviewed-by: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
> Reviewed-by: Voon Weifeng <weifeng.voon@intel.com>
> Reviewed-by: Kweh Hock Leong <hock.leong.kweh@intel.com>
> Reviewed-by: Baoli Zhang <baoli.zhang@intel.com>
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h | 288
> ++++++++++++++++++++++++++
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  17 ++
>  include/linux/stmmac.h                        |   1 +
>  3 files changed, 306 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h
> b/drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h
> new file mode 100644
> index 0000000..446b714
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h
> @@ -0,0 +1,288 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* dw_xpcs.h: DWC Ethernet Physical Coding Sublayer Header
> + *
> + * Copyright (c) 2019, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> +it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but
> +WITHOUT
> + * ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY
> +or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> +License for
> + * more details.
> + */
> +#ifndef __DW_XPCS_H__
> +#define __DW_XPCS_H__
> +
> +#include <linux/mdio.h>
> +#include <linux/bitops.h>
> +#include "stmmac.h"
> +
> +/* XPCS Control & MII MMD Device Addresses */
> +#define XPCS_MDIO_CONTROL_MMD	MDIO_MMD_VEND1
> +#define XPCS_MDIO_MII_MMD	MDIO_MMD_VEND2
> +
> +/* Control MMD register offsets */
> +#define MDIO_CONTROL_MMD_CTRL		0x9	/* Control */
> +
> +/* Control MMD Control defines */
> +#define MDIO_CONTROL_MMD_CTRL_MII_MMD_EN	1 /* MII MMD
> Enable */
> +
> +/* MII MMD registers offsets */
> +#define MDIO_MII_MMD_CTRL		0x0	/* Control */
> +#define MDIO_MII_MMD_ADV		0x4	/* AN Advertisement
> */
> +#define MDIO_MII_MMD_LPA		0x5	/* Link Partner Ability
> */
> +#define MDIO_MII_MMD_DIGITAL_CTRL_1	0x8000	/* Digital Control 1 */
> +#define MDIO_MII_MMD_AN_CTRL		0x8001	/* AN Control */
> +#define MDIO_MII_MMD_AN_STAT		0x8002	/* AN Status */
> +
> +/* MII MMD Control defines */
> +#define MDIO_MII_MMD_CTRL_ANE		BIT(12)	/* AN Enable */
> +#define MDIO_MII_MMD_CTRL_LBE		BIT(14)	/* Loopback Enable
> */
> +#define MDIO_MII_MMD_CTRL_RANE		BIT(9)	/* Restart AN
> */
> +
> +/* MII MMD AN Advertisement & Link Partner Ability */
> +#define MDIO_MII_MMD_HD			BIT(6)	/* Half duplex
> */
> +#define MDIO_MII_MMD_FD			BIT(5)	/* Full duplex
> */
> +#define MDIO_MII_MMD_PSE_SHIFT		7	/* Pause
> Ability shift */
> +#define MDIO_MII_MMD_PSE	GENMASK(8, 7)	/* Pause
> Ability */
> +
> +/* MII MMD Digital Control 1 defines */
> +#define MDIO_MII_MMD_DIGI_CTRL_1_SGMII_PHY_MD	BIT(0) /*
> SGMII PHY mode */
> +
> +/* MII MMD AN Control defines */
> +#define MDIO_MII_MMD_AN_CTRL_TX_CONFIG_SHIFT	3 /* TX Config
> shift */
> +#define AN_CTRL_TX_CONF_PHY_SIDE_SGMII		0x1 /* PHY
> side SGMII mode */
> +#define AN_CTRL_TX_CONF_MAC_SIDE_SGMII		0x0 /* MAC
> side SGMII mode */
> +#define MDIO_MII_MMD_AN_CTRL_PCS_MD_SHIFT	1  /* PCS Mode shift
> */
> +#define MDIO_MII_MMD_AN_CTRL_PCS_MD	GENMASK(2, 1) /*
> PCS Mode */
> +#define AN_CTRL_PCS_MD_C37_1000BASEX	0x0	/* C37 AN for
> 1000BASE-X */
> +#define AN_CTRL_PCS_MD_C37_SGMII	0x2	/* C37 AN for SGMII
> */
> +#define MDIO_MII_MMD_AN_CTRL_AN_INTR_EN	BIT(0)	/* AN
> Complete Intr Enable */
> +
> +/* MII MMD AN Status defines for C37 AN SGMII Status */
> +#define AN_STAT_C37_AN_CMPLT		BIT(0)	/* AN Complete Intr
> */
> +#define AN_STAT_C37_AN_FD		BIT(1)	/* Full Duplex */
> +#define AN_STAT_C37_AN_SPEED_SHIFT	2	/* AN Speed shift */
> +#define AN_STAT_C37_AN_SPEED		GENMASK(3, 2)	/* AN
> Speed */
> +#define AN_STAT_C37_AN_10MBPS		0x0	/* 10 Mbps */
> +#define AN_STAT_C37_AN_100MBPS		0x1	/* 100 Mbps */
> +#define AN_STAT_C37_AN_1000MBPS		0x2	/* 1000 Mbps
> */
> +#define AN_STAT_C37_AN_LNKSTS		BIT(4)	/* Link Status */
> +
> +/**
> + * dw_xpcs_init - To initialize xPCS
> + * @ndev: network device pointer
> + * @mode: PCS mode
> + * Description: this is to initialize xPCS  */ static inline void
> +dw_xpcs_init(struct net_device *ndev, int pcs_mode) {
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int xpcs_phy_addr = priv->plat->xpcs_phy_addr;
> +
> +	/* Set SGMII PHY mode control */
> +	u16 phydata = (u16)mdiobus_read(priv->mii, xpcs_phy_addr,
> +				    (MII_ADDR_C45 |
> +				     (XPCS_MDIO_MII_MMD <<
> +				      MII_DEVADDR_C45_SHIFT) |
> +				     MDIO_MII_MMD_DIGITAL_CTRL_1));
> +
> +	phydata |= MDIO_MII_MMD_DIGI_CTRL_1_SGMII_PHY_MD;
> +
> +	mdiobus_write(priv->mii, xpcs_phy_addr,
> +		      (MII_ADDR_C45 | (XPCS_MDIO_MII_MMD <<
> +		       MII_DEVADDR_C45_SHIFT) |
> MDIO_MII_MMD_DIGITAL_CTRL_1),
> +		      (int)phydata);
> +
> +	/* Set PHY side SGMII, PCS Mode & Enable C37 AN complete
> interrupt */
> +	phydata = (u16)mdiobus_read(priv->mii, xpcs_phy_addr,
> +				    (MII_ADDR_C45 |
> +				     (XPCS_MDIO_MII_MMD <<
> +				      MII_DEVADDR_C45_SHIFT) |
> +				     MDIO_MII_MMD_AN_CTRL));
> +
> +	phydata &= ~MDIO_MII_MMD_AN_CTRL_PCS_MD;
> +	phydata |= (((pcs_mode <<
> MDIO_MII_MMD_AN_CTRL_PCS_MD_SHIFT) &
> +		    MDIO_MII_MMD_AN_CTRL_PCS_MD) |
> +		    (AN_CTRL_TX_CONF_PHY_SIDE_SGMII <<
> +		    MDIO_MII_MMD_AN_CTRL_TX_CONFIG_SHIFT) |
> +		    MDIO_MII_MMD_AN_CTRL_AN_INTR_EN);
> +
> +	mdiobus_write(priv->mii, xpcs_phy_addr,
> +		      (MII_ADDR_C45 | (XPCS_MDIO_MII_MMD <<
> +		       MII_DEVADDR_C45_SHIFT) |
> MDIO_MII_MMD_AN_CTRL),
> +		      (int)phydata);
> +}
> +
> +/**
> + * dw_xpcs_rane - To restart Auto Negotiation (AN)
> + * @ndev: network device pointer
> + * @restart: to restart AN
> + * Description: this is to restart AN.
> + */
> +static inline void dw_xpcs_rane(struct net_device *ndev, bool restart)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int xpcs_phy_addr = priv->plat->xpcs_phy_addr;
> +
> +	u16 phydata = (u16)mdiobus_read(priv->mii, xpcs_phy_addr,
> +				(MII_ADDR_C45 | (XPCS_MDIO_MII_MMD
> <<
> +				 MII_DEVADDR_C45_SHIFT) |
> +				 MDIO_MII_MMD_CTRL));
> +
> +	if (restart)
> +		phydata |= MDIO_MII_MMD_CTRL_RANE;
> +
> +	mdiobus_write(priv->mii, xpcs_phy_addr,
> +		      (MII_ADDR_C45 | (XPCS_MDIO_MII_MMD <<
> +		       MII_DEVADDR_C45_SHIFT) | MDIO_MII_MMD_CTRL),
> +		      (int)phydata);
> +}
> +
> +/**
> + * dw_xpcs_ctrl_ane - To program the MII MMD Control Register.
> + * @ndev: network device pointer
> + * @ane: to enable the Auto Negotiation
> + * @loopback: to cause the PHY to loopback Tx data into Rx path.
> + * Description: this is the main function to configure the MII MMD
> + * control register and init the AN Enable and select loopback.
> + */
> +static inline void dw_xpcs_ctrl_ane(struct net_device *ndev, bool ane,
> +				    bool loopback)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int xpcs_phy_addr = priv->plat->xpcs_phy_addr;
> +
> +	u16 phydata = (u16)mdiobus_read(priv->mii, xpcs_phy_addr,
> +				(MII_ADDR_C45 | (XPCS_MDIO_MII_MMD
> <<
> +				 MII_DEVADDR_C45_SHIFT) |
> +				 MDIO_MII_MMD_CTRL));
> +
> +	if (ane)
> +		phydata |= (MDIO_MII_MMD_CTRL_ANE |
> MDIO_MII_MMD_CTRL_RANE);
> +
> +	if (loopback)
> +		phydata |= MDIO_MII_MMD_CTRL_LBE;
> +
> +	mdiobus_write(priv->mii, xpcs_phy_addr,
> +		      (MII_ADDR_C45 | (XPCS_MDIO_MII_MMD <<
> +		       MII_DEVADDR_C45_SHIFT) | MDIO_MII_MMD_CTRL),
> +		      (int)phydata);
> +}
> +
> +/**
> + * dw_xpcs_get_adv_lp - Get AN Advertisement and Link Partner Ability
> + * @ndev: network device pointer
> + * @adv_lp: structure to store the adv, lp status
> + * Description: this is to expose the Auto Negotiation Advertisement
> +and
> + * Link partner ability status to ethtool support.
> + */
> +static inline void dw_xpcs_get_adv_lp(struct net_device *ndev,
> +				      struct rgmii_adv *adv_lp)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int xpcs_phy_addr = priv->plat->xpcs_phy_addr;
> +
> +	/* AN Advertisement Ability */
> +	u16 value = (u16)mdiobus_read(priv->mii, xpcs_phy_addr,
> +				(MII_ADDR_C45 | (XPCS_MDIO_MII_MMD
> <<
> +				 MII_DEVADDR_C45_SHIFT) |
> +				 MDIO_MII_MMD_ADV));
> +
> +	if (value & MDIO_MII_MMD_FD)
> +		adv_lp->duplex = DUPLEX_FULL;
> +	if (value & MDIO_MII_MMD_HD)
> +		adv_lp->duplex = DUPLEX_HALF;
> +	adv_lp->pause = (u32)((value & MDIO_MII_MMD_PSE) >>
> +			      MDIO_MII_MMD_PSE_SHIFT);
> +
> +	/* Link Partner Ability */
> +	value = (u16)mdiobus_read(priv->mii, xpcs_phy_addr,
> +				  (MII_ADDR_C45 | (XPCS_MDIO_MII_MMD
> <<
> +				   MII_DEVADDR_C45_SHIFT) |
> +				   MDIO_MII_MMD_LPA));
> +
> +	if (value & MDIO_MII_MMD_FD)
> +		adv_lp->lp_duplex = DUPLEX_FULL;
> +	if (value & MDIO_MII_MMD_HD)
> +		adv_lp->lp_duplex = DUPLEX_HALF;
> +	adv_lp->lp_pause = (u32)((value & MDIO_MII_MMD_PSE) >>
> +				 MDIO_MII_MMD_PSE_SHIFT);
> +}
> +
> +/**
> + * dw_xpcs_get_linkstatus - Get Link Status
> + * @an_stat: C37 AN status value
> + * @x: stmmac extra status
> + * Description: this is to read the link extra status from <C37 AN
> +SGMII
> + * status> field of MII MMD AN Status register.
> + */
> +static inline void dw_xpcs_get_linkstatus(u16 an_stat,
> +					  struct stmmac_extra_stats *x)
> +{
> +	/* Check the link status */
> +	if (an_stat & AN_STAT_C37_AN_LNKSTS) {
> +		int speed_value;
> +
> +		x->pcs_link = 1;
> +
> +		speed_value = ((an_stat & AN_STAT_C37_AN_SPEED) >>
> +				AN_STAT_C37_AN_SPEED_SHIFT);
> +		if (speed_value == AN_STAT_C37_AN_1000MBPS)
> +			x->pcs_speed = SPEED_1000;
> +		else if (speed_value == AN_STAT_C37_AN_100MBPS)
> +			x->pcs_speed = SPEED_100;
> +		else
> +			x->pcs_speed = SPEED_10;
> +
> +		if (an_stat & AN_STAT_C37_AN_FD)
> +			x->pcs_duplex = 1;
> +		else
> +			x->pcs_duplex = 0;
> +
> +		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
> +			x->pcs_duplex ? "Full" : "Half");
> +	} else {
> +		x->pcs_link = 0;
> +		pr_info("Link is Down\n");
> +	}
> +}
> +
> +/**
> + * dw_xpcs_irq_status - Get xPCS IRQ Status
> + * @ndev: network device pointer
> + * @x: stmmac extra status
> + * Description: this is to read the xPCS IRQ status.
> + */
> +static inline int dw_xpcs_irq_status(struct net_device *ndev,
> +				     struct stmmac_extra_stats *x)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int xpcs_phy_addr = priv->plat->xpcs_phy_addr;
> +	int ret = IRQ_NONE;
> +
> +	/* C37 AN status */
> +	u16 an_stat = (u16)mdiobus_read(priv->mii, xpcs_phy_addr,
> +					(MII_ADDR_C45 |
> +					 (XPCS_MDIO_MII_MMD <<
> +					  MII_DEVADDR_C45_SHIFT) |
> +					 MDIO_MII_MMD_AN_STAT));
> +
> +	if (an_stat & AN_STAT_C37_AN_CMPLT) {
> +		x->irq_pcs_ane_n++;
> +		dw_xpcs_get_linkstatus(an_stat, x);
> +
> +		/* Clear C37 AN complete status by writing zero */
> +		mdiobus_write(priv->mii, xpcs_phy_addr,
> +			      (MII_ADDR_C45 | (XPCS_MDIO_MII_MMD <<
> +			       MII_DEVADDR_C45_SHIFT) |
> +			       MDIO_MII_MMD_AN_STAT),
> +			      0);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	return ret;
> +}
> +#endif /* __DW_XPCS_H__ */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 5bb0023..cb7eb48 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -310,6 +310,13 @@ struct stmmac_ops {
>  			     bool loopback);
>  	void (*pcs_rane)(void __iomem *ioaddr, bool restart);
>  	void (*pcs_get_adv_lp)(void __iomem *ioaddr, struct rgmii_adv
> *adv);
> +	/* xPCS calls */
> +	void (*xpcs_init)(struct net_device *ndev, int pcs_mode);
> +	void (*xpcs_ctrl_ane)(struct net_device *ndev, bool ane, bool
> loopback);
> +	void (*xpcs_rane)(struct net_device *ndev, bool restart);
> +	void (*xpcs_get_adv_lp)(struct net_device *ndev, struct rgmii_adv
> *adv);
> +	int (*xpcs_irq_status)(struct net_device *ndev,
> +			       struct stmmac_extra_stats *x);
>  	/* Safety Features */
>  	int (*safety_feat_config)(void __iomem *ioaddr, unsigned int asp);
>  	int (*safety_feat_irq_status)(struct net_device *ndev, @@ -382,6
> +389,16 @@ struct stmmac_ops {
>  	stmmac_do_void_callback(__priv, mac, pcs_rane, __args)  #define
> stmmac_pcs_get_adv_lp(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, pcs_get_adv_lp, __args)
> +#define stmmac_xpcs_init(__priv, __args...) \
> +	stmmac_do_void_callback(__priv, mac, xpcs_init, __args) #define
> +stmmac_xpcs_ctrl_ane(__priv, __args...) \
> +	stmmac_do_void_callback(__priv, mac, xpcs_ctrl_ane, __args)
> #define
> +stmmac_xpcs_rane(__priv, __args...) \
> +	stmmac_do_void_callback(__priv, mac, xpcs_rane, __args) #define
> +stmmac_xpcs_get_adv_lp(__priv, __args...) \
> +	stmmac_do_void_callback(__priv, mac, xpcs_get_adv_lp, __args)
> #define
> +stmmac_xpcs_irq_status(__priv, __args...) \
> +	stmmac_do_callback(__priv, mac, xpcs_irq_status, __args)
>  #define stmmac_safety_feat_config(__priv, __args...) \
>  	stmmac_do_callback(__priv, mac, safety_feat_config, __args)
> #define stmmac_safety_feat_irq_status(__priv, __args...) \ diff --git
> a/include/linux/stmmac.h b/include/linux/stmmac.h index 4335bd7..b00e795
> 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -148,6 +148,7 @@ struct stmmac_txq_cfg {  struct
> plat_stmmacenet_data {
>  	int bus_id;
>  	int phy_addr;
> +	int xpcs_phy_addr;
>  	int interface;
>  	struct stmmac_mdio_bus_data *mdio_bus_data;
>  	struct device_node *phy_node;
> --
> 1.9.1

++ stmmac maintainers and c45 experts
