Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8528520656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfDXJQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:16:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:1102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfDXJQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:16:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 02:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="145260854"
Received: from wvoon-ilbpg2.png.intel.com ([10.88.227.88])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2019 02:16:30 -0700
From:   Weifeng Voon <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>,
        Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 0/7] net: stmmac: enable EHL SGMII
Date:   Thu, 25 Apr 2019 01:17:14 +0800
Message-Id: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Voon, Weifeng" <weifeng.voon@intel.com@intel.com>

This patch-set is to enable Ethernet controller (DW Ethernet QoS
and DW Ethernet PCS) with SGMII interface in Elkhart Lake. The
DW Ethernet PCS is the Physical Coding Sublayer that is between
Ethernet MAC and PHY and uses MDIO Clause-45 as Communication.

Kweh Hock Leong (1):
  net: stmmac: enable clause 45 mdio support

Ong Boon Leong (3):
  net: stmmac: introducing support for DWC xPCS logics
  net: stmmac: add xpcs function hooks into main driver and ethtool
  net: stmmac: add xPCS functions for device with DWMACv5.1

Weifeng Voon (3):
  net: stmmac: add EHL SGMII 1Gbps platform data and PCI ID
  net: stmmac: dma channel control register need to be init first
  net: stmmac: add xPCS platform data for EHL

 drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h      | 288 +++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  67 +++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |  31 ++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  18 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  14 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  58 ++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  36 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 108 ++++++++
 include/linux/phy.h                                |   2 +
 include/linux/stmmac.h                             |   3 +
 11 files changed, 616 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw_xpcs.h

--
1.9.1

