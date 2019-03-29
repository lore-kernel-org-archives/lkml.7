Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C27C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CE52070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KDUJxq8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfC2QA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:00:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55254 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfC2QA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:00:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TG0npH126072;
        Fri, 29 Mar 2019 11:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553875249;
        bh=w7hNtxngprovcFi4YdsKhToPrwPgD4DUhwcVVMeOvAo=;
        h=From:To:CC:Subject:Date;
        b=KDUJxq8HMIaxd5DiB+EGPQXswwLq8bMSXATJnedqLzJgwD8padlOVMDALHNMEioRO
         D4bQc9Gh04eplzBWBzb3JGIBqeJbZivap3Pc6oOEE761vVvNH9bLMBy+jnpU53dhHX
         jE4gFjJIryVOtKPi/qCb4UEjmb8FvA7X4R8xKdPE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TG0nRA037234
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 11:00:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 11:00:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 11:00:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TG0mt4093431;
        Fri, 29 Mar 2019 11:00:48 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 net-next] net: ethernet: ti: davinci_mdio: switch to readl/writel()
Date:   Fri, 29 Mar 2019 17:58:34 +0200
Message-ID: <1553875114-14249-1-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to readl/writel() APIs, because this is recommended
API and the MDIO block is reused on Keystone 2 SoCs
where LE/BE modes are supported.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
changes in v2:
- use readl/writel() as recommended

 drivers/net/ethernet/ti/davinci_mdio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index a98aedae1b41..c2740dbe9154 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -140,7 +140,7 @@ static void davinci_mdio_init_clk(struct davinci_mdio_data *data)
 static void davinci_mdio_enable(struct davinci_mdio_data *data)
 {
 	/* set enable and clock divider */
-	__raw_writel(data->clk_div | CONTROL_ENABLE, &data->regs->control);
+	writel(data->clk_div | CONTROL_ENABLE, &data->regs->control);
 }
 
 static int davinci_mdio_reset(struct mii_bus *bus)
@@ -159,7 +159,7 @@ static int davinci_mdio_reset(struct mii_bus *bus)
 	msleep(PHY_MAX_ADDR * data->access_time);
 
 	/* dump hardware version info */
-	ver = __raw_readl(&data->regs->version);
+	ver = readl(&data->regs->version);
 	dev_info(data->dev,
 		 "davinci mdio revision %d.%d, bus freq %ld\n",
 		 (ver >> 8) & 0xff, ver & 0xff,
@@ -169,7 +169,7 @@ static int davinci_mdio_reset(struct mii_bus *bus)
 		goto done;
 
 	/* get phy mask from the alive register */
-	phy_mask = __raw_readl(&data->regs->alive);
+	phy_mask = readl(&data->regs->alive);
 	if (phy_mask) {
 		/* restrict mdio bus to live phys only */
 		dev_info(data->dev, "detected phy mask %x\n", ~phy_mask);
@@ -196,11 +196,11 @@ static inline int wait_for_user_access(struct davinci_mdio_data *data)
 	u32 reg;
 
 	while (time_after(timeout, jiffies)) {
-		reg = __raw_readl(&regs->user[0].access);
+		reg = readl(&regs->user[0].access);
 		if ((reg & USERACCESS_GO) == 0)
 			return 0;
 
-		reg = __raw_readl(&regs->control);
+		reg = readl(&regs->control);
 		if ((reg & CONTROL_IDLE) == 0) {
 			usleep_range(100, 200);
 			continue;
@@ -216,7 +216,7 @@ static inline int wait_for_user_access(struct davinci_mdio_data *data)
 		return -EAGAIN;
 	}
 
-	reg = __raw_readl(&regs->user[0].access);
+	reg = readl(&regs->user[0].access);
 	if ((reg & USERACCESS_GO) == 0)
 		return 0;
 
@@ -263,7 +263,7 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
 		if (ret < 0)
 			break;
 
-		__raw_writel(reg, &data->regs->user[0].access);
+		writel(reg, &data->regs->user[0].access);
 
 		ret = wait_for_user_access(data);
 		if (ret == -EAGAIN)
@@ -271,7 +271,7 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
 		if (ret < 0)
 			break;
 
-		reg = __raw_readl(&data->regs->user[0].access);
+		reg = readl(&data->regs->user[0].access);
 		ret = (reg & USERACCESS_ACK) ? (reg & USERACCESS_DATA) : -EIO;
 		break;
 	}
@@ -307,7 +307,7 @@ static int davinci_mdio_write(struct mii_bus *bus, int phy_id,
 		if (ret < 0)
 			break;
 
-		__raw_writel(reg, &data->regs->user[0].access);
+		writel(reg, &data->regs->user[0].access);
 
 		ret = wait_for_user_access(data);
 		if (ret == -EAGAIN)
@@ -472,9 +472,9 @@ static int davinci_mdio_runtime_suspend(struct device *dev)
 	u32 ctrl;
 
 	/* shutdown the scan state machine */
-	ctrl = __raw_readl(&data->regs->control);
+	ctrl = readl(&data->regs->control);
 	ctrl &= ~CONTROL_ENABLE;
-	__raw_writel(ctrl, &data->regs->control);
+	writel(ctrl, &data->regs->control);
 	wait_for_idle(data);
 
 	return 0;
-- 
2.17.1

