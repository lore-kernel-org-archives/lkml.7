Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C8CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78F820644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfH1Rr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:47:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:20452 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfH1Rrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:47:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 10:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="192675389"
Received: from glass.png.intel.com ([172.30.181.95])
  by orsmga002.jf.intel.com with ESMTP; 28 Aug 2019 10:47:31 -0700
From:   Ong Boon Leong <boon.leong.ong@intel.com>
To:     davem@davemloft.net, linux@armlinux.org.uk,
        mcoquelin.stm32@gmail.com, joabreu@synopsys.com,
        f.fainelli@gmail.com, andrew@lunn.ch
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        weifeng.voon@intel.com
Subject: [RFC net-next v2 2/5] net: phy: introduce mdiobus_get_mdio_device
Date:   Thu, 29 Aug 2019 01:47:19 +0800
Message-Id: <20190828174722.6726-3-boon.leong.ong@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190828174722.6726-1-boon.leong.ong@intel.com>
References: <20190828174722.6726-1-boon.leong.ong@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the function to get mdio_device based on the mdio addr.

Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 drivers/net/phy/mdio_bus.c | 6 ++++++
 include/linux/mdio.h       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 06658d9197a1..96ef94f87ff1 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -130,6 +130,12 @@ struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr)
 }
 EXPORT_SYMBOL(mdiobus_get_phy);
 
+struct mdio_device *mdiobus_get_mdio_device(struct mii_bus *bus, int addr)
+{
+	return bus->mdio_map[addr];
+}
+EXPORT_SYMBOL(mdiobus_get_mdio_device);
+
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr)
 {
 	return bus->mdio_map[addr];
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index e8242ad88c81..e0ccd56a7ac0 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -315,6 +315,7 @@ int mdiobus_register_device(struct mdio_device *mdiodev);
 int mdiobus_unregister_device(struct mdio_device *mdiodev);
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr);
 struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr);
+struct mdio_device *mdiobus_get_mdio_device(struct mii_bus *bus, int addr);
 
 /**
  * mdio_module_driver() - Helper macro for registering mdio drivers
-- 
2.17.0

