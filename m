Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA24C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C147321872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfCOIpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:45:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfCOIpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:45:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBC7330832EA;
        Fri, 15 Mar 2019 08:45:17 +0000 (UTC)
Received: from ceranb.redhat.com (ovpn-204-143.brq.redhat.com [10.40.204.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4536C60BF4;
        Fri, 15 Mar 2019 08:45:16 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] ixgbe: fix mdio bus registration
Date:   Fri, 15 Mar 2019 09:45:15 +0100
Message-Id: <20190315084515.22983-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 15 Mar 2019 08:45:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ixgbe ignores errors returned from mdiobus_register() and leaves
adapter->mii_bus non-NULL and MDIO bus state as MDIOBUS_ALLOCATED.
This triggers a BUG from mdiobus_unregister() during ixgbe_remove() call.

Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index cc4907f9ff02..2fb97967961c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -905,13 +905,12 @@ s32 ixgbe_mii_bus_init(struct ixgbe_hw *hw)
 	struct pci_dev *pdev = adapter->pdev;
 	struct device *dev = &adapter->netdev->dev;
 	struct mii_bus *bus;
+	int err = -ENODEV;
 
-	adapter->mii_bus = devm_mdiobus_alloc(dev);
-	if (!adapter->mii_bus)
+	bus = devm_mdiobus_alloc(dev);
+	if (!bus)
 		return -ENOMEM;
 
-	bus = adapter->mii_bus;
-
 	switch (hw->device_id) {
 	/* C3000 SoCs */
 	case IXGBE_DEV_ID_X550EM_A_KR:
@@ -949,12 +948,15 @@ s32 ixgbe_mii_bus_init(struct ixgbe_hw *hw)
 	 */
 	hw->phy.mdio.mode_support = MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22;
 
-	return mdiobus_register(bus);
+	err = mdiobus_register(bus);
+	if (!err) {
+		adapter->mii_bus = bus;
+		return 0;
+	}
 
 ixgbe_no_mii_bus:
 	devm_mdiobus_free(dev, bus);
-	adapter->mii_bus = NULL;
-	return -ENODEV;
+	return err;
 }
 
 /**
-- 
2.19.2

