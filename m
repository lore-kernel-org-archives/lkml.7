Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B8DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6024E217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfDYHAI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:00:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:21469 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfDYHAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:00:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="318806327"
Received: from kmsmsx154.gar.corp.intel.com ([172.21.73.14])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2019 00:00:04 -0700
Received: from pgsmsx103.gar.corp.intel.com ([169.254.2.111]) by
 KMSMSX154.gar.corp.intel.com ([169.254.12.227]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:00:03 +0800
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
        Jose Abreu <joabreu@synopsys.com>
Subject: RE: [PATCH 0/7] net: stmmac: enable EHL SGMII
Thread-Topic: [PATCH 0/7] net: stmmac: enable EHL SGMII
Thread-Index: AQHU+n5wFvkvAdhEOk+HJjCp5i3NMqZMctGQ
Date:   Thu, 25 Apr 2019 07:00:02 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC8146EF060@PGSMSX103.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
In-Reply-To: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2Y4MWEwYTktZDUzMS00NTc3LTk5NGYtZjNiMWY2ODQ1OGFhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMzZNaE90ampXOEVNdjBNN01iZFVES1NoRWl2dmYwSDZraWN0VFwvSzNiXC9LUnlFNUswQXBhMHFYQkVJUVBIZ2R3In0=
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

> From: "Voon, Weifeng" <weifeng.voon@intel.com@intel.com>
> 
> This patch-set is to enable Ethernet controller (DW Ethernet QoS and DW
> Ethernet PCS) with SGMII interface in Elkhart Lake. The DW Ethernet PCS is
> the Physical Coding Sublayer that is between Ethernet MAC and PHY and
> uses MDIO Clause-45 as Communication.
> 
> Kweh Hock Leong (1):
>   net: stmmac: enable clause 45 mdio support
> 
> Ong Boon Leong (3):
>   net: stmmac: introducing support for DWC xPCS logics
>   net: stmmac: add xpcs function hooks into main driver and ethtool
>   net: stmmac: add xPCS functions for device with DWMACv5.1
> 
> Weifeng Voon (3):
>   net: stmmac: add EHL SGMII 1Gbps platform data and PCI ID
>   net: stmmac: dma channel control register need to be init first
>   net: stmmac: add xPCS platform data for EHL
> 
>  drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h      | 288
> +++++++++++++++++++++
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  67 +++++
>  drivers/net/ethernet/stmicro/stmmac/hwif.c         |  31 ++-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  18 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 +
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  14 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  58 ++++-
> drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  36 ++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 108 ++++++++
>  include/linux/phy.h                                |   2 +
>  include/linux/stmmac.h                             |   3 +
>  11 files changed, 616 insertions(+), 11 deletions(-)  create mode 100644
> drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h
> 
> --
> 1.9.1

++ stmmac maintainers and c45 experts
