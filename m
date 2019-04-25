Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C7EC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFF82175B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbfDYBpZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:45:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:54400 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388136AbfDYBpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:45:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 18:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,391,1549958400"; 
   d="scan'208";a="145499307"
Received: from pgsmsx112-dag.png.intel.com (HELO PGSMSX112.gar.corp.intel.com) ([10.108.55.234])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2019 18:45:20 -0700
Received: from pgsmsx114.gar.corp.intel.com ([169.254.4.194]) by
 PGSMSX112.gar.corp.intel.com ([169.254.3.40]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 09:45:19 +0800
From:   "Ong, Boon Leong" <boon.leong.ong@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>
Subject: RE: [PATCH 4/7] net: stmmac: introducing support for DWC xPCS logics
Thread-Topic: [PATCH 4/7] net: stmmac: introducing support for DWC xPCS
 logics
Thread-Index: AQHU+n5xnGC+MCh/Wkicfj2ArDC6bKZKy8YAgAFKaOA=
Date:   Thu, 25 Apr 2019 01:45:18 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B75C0B0244@pgsmsx114.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-5-git-send-email-weifeng.voon@intel.com>
 <20190424134136.GO28405@lunn.ch>
In-Reply-To: <20190424134136.GO28405@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmY1MTA1ZDAtZjJkMi00Y2ZhLWFjY2EtNWRmYTU3ZmUxMzU1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNXJrc1lMTXRXQWczV0s0Rm91VlBmTGphTExQc1wvdDJaMHorV0ZSTmZHT3hyUGRYTThvWDRDdklCRWNOS3p4S1QifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andrew Lunn [mailto:andrew@lunn.ch]
>Sent: Wednesday, April 24, 2019 9:42 PM
>To: Voon, Weifeng <weifeng.voon@intel.com>
>Cc: David S. Miller <davem@davemloft.net>; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org; Ong, Boon Leong <boon.leong.ong@intel.com>;
>Kweh, Hock Leong <hock.leong.kweh@intel.com>
>Subject: Re: [PATCH 4/7] net: stmmac: introducing support for DWC xPCS
>logics
>
>On Thu, Apr 25, 2019 at 01:17:18AM +0800, Weifeng Voon wrote:
>> From: Ong Boon Leong <boon.leong.ong@intel.com>
>>
>> xPCS is DWC Ethernet Physical Coding Sublayer that may be integrated
>> into a GbE controller that uses DWC EQoS MAC controller. An example of
>> HW configuration is shown below:-
>>
>>   <-----------------GBE Controller---------->|<--External PHY chip-->
>>
>>   +----------+         +----+    +---+               +--------------+
>>   |   EQoS   | <-GMII->|xPCS|<-->|L1 | <-- SGMII --> | External GbE |
>>   |   MAC    |         |    |    |PHY|               | PHY Chip     |
>>   +----------+         +----+    +---+               +--------------+
>>          ^               ^                                  ^
>>          |               |                                  |
>>          +---------------------MDIO-------------------------+
>>
>> xPCS is a Clause-45 MDIO Manageable Device (MMD) and we need a way to
>> differentiate it from external PHY chip that is discovered over MDIO.
>> Therefore, xpcs_phy_addr is introduced in stmmac platform data
>> (plat_stmmacenet_data) for differentiating xPCS from 'phy_addr' that
>> belongs to external PHY.
>>
>> Basic functionalities for initializing xPCS and configuring auto
>> negotiation (AN), loopback, link status, AN advertisement and Link
>> Partner ability are implemented.
>>
>> xPCS interrupt handling for C37 AN complete is also implemented.
>>
>> Tested-by: Kweh Hock Leong <hock.leong.kweh@intel.com>
>> Reviewed-by: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
>> Reviewed-by: Voon Weifeng <weifeng.voon@intel.com>
>> Reviewed-by: Kweh Hock Leong <hock.leong.kweh@intel.com>
>> Reviewed-by: Baoli Zhang <baoli.zhang@intel.com>
>> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
>
>You need your own signed-off-by here, since you are submitting it.
>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h | 288
>++++++++++++++++++++++++++
>>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  17 ++
>>  include/linux/stmmac.h                        |   1 +
>>  3 files changed, 306 insertions(+)
>>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h
>b/drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h
>> new file mode 100644
>> index 0000000..446b714
>> --- /dev/null
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h
>> @@ -0,0 +1,288 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* dw_xpcs.h: DWC Ethernet Physical Coding Sublayer Header
>> + *
>> + * Copyright (c) 2019, Intel Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of
>MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>License for
>> + * more details.
>> + */
>
>Since you have a SPDX line, you don't need the license boilerplate.
Thanks. Will edit. 

>
>> +#ifndef __DW_XPCS_H__
>> +#define __DW_XPCS_H__
>> +
>> +#include <linux/mdio.h>
>> +#include <linux/bitops.h>
>> +#include "stmmac.h"
>> +
>> +/* XPCS Control & MII MMD Device Addresses */
>> +#define XPCS_MDIO_CONTROL_MMD	MDIO_MMD_VEND1
>> +#define XPCS_MDIO_MII_MMD	MDIO_MMD_VEND2
>> +
>> +/* Control MMD register offsets */
>> +#define MDIO_CONTROL_MMD_CTRL		0x9	/* Control */
>> +
>> +/* Control MMD Control defines */
>> +#define MDIO_CONTROL_MMD_CTRL_MII_MMD_EN	1 /* MII MMD
>Enable */
>> +
>> +/* MII MMD registers offsets */
>> +#define MDIO_MII_MMD_CTRL		0x0	/* Control */
>> +#define MDIO_MII_MMD_ADV		0x4	/* AN Advertisement
>*/
>> +#define MDIO_MII_MMD_LPA		0x5	/* Link Partner Ability
>*/
>
>MII_BMCR, MII_ADVERTISE, MII_LPA.
Ok. Will change.

>
>> +#define MDIO_MII_MMD_DIGITAL_CTRL_1	0x8000	/* Digital Control 1 */
>> +#define MDIO_MII_MMD_AN_CTRL		0x8001	/* AN Control */
>> +#define MDIO_MII_MMD_AN_STAT		0x8002	/* AN Status */
>> +
>> +/* MII MMD Control defines */
>> +#define MDIO_MII_MMD_CTRL_ANE		BIT(12)	/* AN Enable
>*/
>> +#define MDIO_MII_MMD_CTRL_LBE		BIT(14)	/* Loopback Enable */
>> +#define MDIO_MII_MMD_CTRL_RANE		BIT(9)	/* Restart AN
>*/
>
>BMCR_ANENABLE, BMCR_LOOPBACK, BMCR_ANENABLE
>
>If you use the standard names, developers are going to find it easier
>to understand the code.
Ok. Will change.

>
>
>> +/* MII MMD AN Advertisement & Link Partner Ability */
>> +#define MDIO_MII_MMD_HD			BIT(6)	/* Half duplex
>*/
>> +#define MDIO_MII_MMD_FD			BIT(5)	/* Full duplex
>*/
>> +#define MDIO_MII_MMD_PSE_SHIFT		7	/* Pause
>Ability shift */
>> +#define MDIO_MII_MMD_PSE	GENMASK(8, 7)	/* Pause Ability */
>> +
>> +/* MII MMD Digital Control 1 defines */
>> +#define MDIO_MII_MMD_DIGI_CTRL_1_SGMII_PHY_MD	BIT(0) /* SGMII
>PHY mode */
>> +
>> +/* MII MMD AN Control defines */
>> +#define MDIO_MII_MMD_AN_CTRL_TX_CONFIG_SHIFT	3 /* TX Config
>shift */
>> +#define AN_CTRL_TX_CONF_PHY_SIDE_SGMII		0x1 /* PHY
>side SGMII mode */
>> +#define AN_CTRL_TX_CONF_MAC_SIDE_SGMII		0x0 /* MAC
>side SGMII mode */
>> +#define MDIO_MII_MMD_AN_CTRL_PCS_MD_SHIFT	1  /* PCS Mode
>shift */
>> +#define MDIO_MII_MMD_AN_CTRL_PCS_MD	GENMASK(2, 1) /* PCS
>Mode */
>> +#define AN_CTRL_PCS_MD_C37_1000BASEX	0x0	/* C37 AN for
>1000BASE-X */
>> +#define AN_CTRL_PCS_MD_C37_SGMII	0x2	/* C37 AN for SGMII */
>> +#define MDIO_MII_MMD_AN_CTRL_AN_INTR_EN	BIT(0)	/* AN
>Complete Intr Enable */
>
>> +
>> +/* MII MMD AN Status defines for C37 AN SGMII Status */
>> +#define AN_STAT_C37_AN_CMPLT		BIT(0)	/* AN Complete Intr */
>> +#define AN_STAT_C37_AN_FD		BIT(1)	/* Full Duplex */
>> +#define AN_STAT_C37_AN_SPEED_SHIFT	2	/* AN Speed shift */
>> +#define AN_STAT_C37_AN_SPEED		GENMASK(3, 2)	/* AN Speed */
>> +#define AN_STAT_C37_AN_10MBPS		0x0	/* 10 Mbps */
>> +#define AN_STAT_C37_AN_100MBPS		0x1	/* 100 Mbps
>*/
>> +#define AN_STAT_C37_AN_1000MBPS		0x2	/* 1000 Mbps
>*/
>> +#define AN_STAT_C37_AN_LNKSTS		BIT(4)	/* Link Status */
>
>Is these are standardized, not proprietary, consider adding them to
>include/uapi/linux/mii.h so similar.

Yeah, it does look very standardized. However, per DW spec, they are
vendor-specific register set which uses MDIO_MMD_VEND2 to access.

>
>> +
>> +/**
>> + * dw_xpcs_init - To initialize xPCS
>> + * @ndev: network device pointer
>> + * @mode: PCS mode
>> + * Description: this is to initialize xPCS
>> + */
>> +static inline void dw_xpcs_init(struct net_device *ndev, int pcs_mode)
>> +{
>> +	struct stmmac_priv *priv = netdev_priv(ndev);
>> +	int xpcs_phy_addr = priv->plat->xpcs_phy_addr;
>> +
>> +	/* Set SGMII PHY mode control */
>> +	u16 phydata = (u16)mdiobus_read(priv->mii, xpcs_phy_addr,
>> +				    (MII_ADDR_C45 |
>> +				     (XPCS_MDIO_MII_MMD <<
>> +				      MII_DEVADDR_C45_SHIFT) |
>> +				     MDIO_MII_MMD_DIGITAL_CTRL_1));
>> +
>
>Why cast to u16? It return int for a reason.
Will change to u32 here.  

>
>> +	phydata |= MDIO_MII_MMD_DIGI_CTRL_1_SGMII_PHY_MD;
>> +
>> +	mdiobus_write(priv->mii, xpcs_phy_addr,
>> +		      (MII_ADDR_C45 | (XPCS_MDIO_MII_MMD <<
>> +		       MII_DEVADDR_C45_SHIFT) |
>MDIO_MII_MMD_DIGITAL_CTRL_1),
>> +		      (int)phydata);
>
>Maybe add helpers xpcs_read() and xpcs_write()?
Good suggestion. Thanks for your review. 

>
>      Andrew
