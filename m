Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44A7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VFz1W5Hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfC1RKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:10:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47720 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1RKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:10:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2SH9ubt096125;
        Thu, 28 Mar 2019 12:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553792996;
        bh=U3h4mp3jF3EAHlloOzRA/9eCZT9FtS7Tr+5hg4Tfiug=;
        h=From:To:CC:Subject:Date;
        b=VFz1W5HiVWlHBcOoLwt2kMPBNccPR5rT1SfsMvQukpLxWxSvjLTVtEhN+BLnSDXvI
         4tbsHutiPoAMxn6Sa5BtkjARLJMpruZaRbc+hVgLVWu/LUXSR9U6v0oL8rtuzSr9RJ
         KPwasYB87b7yzM05F51mTBgtL12kUouPZKLmh3iE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2SH9ujk048096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Mar 2019 12:09:56 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 28
 Mar 2019 12:09:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 28 Mar 2019 12:09:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2SH9sTD130155;
        Thu, 28 Mar 2019 12:09:55 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next] net: ethernet: ti: davinci_mdio: switch to readl/writel_relaxed()
Date:   Thu, 28 Mar 2019 19:09:53 +0200
Message-ID: <1553792993-7722-1-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to readl/writel_relaxed() APIs, because this is recommended
API and the MDIO block is reused on Keystone 2 SoCs
where LE/BE modes are supported.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index a98aedae1b41..64776b47799b 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -140,7 +140,7 @@ static void davinci_mdio_init_clk(struct davinci_mdio_data *data)
 static void davinci_mdio_enable(struct davinci_mdio_data *data)
 {
 	/* set enable and clock divider */
-	__raw_writel(data->clk_div | CONTROL_ENABLE, &data->regs->control);
+	writel_relaxed(data->clk_div | CONTROL_ENABLE, &data->regs->control);
 }
 
 static int davinci_mdio_reset(struct mii_bus *bus)
@@ -159,7 +159,7 @@ static int davinci_mdio_reset(struct mii_bus *bus)
 	msleep(PHY_MAX_ADDR * data->access_time);
 
 	/* dump hardware version info */
-	ver = __raw_readl(&data->regs->version);
+	ver = readl_relaxed(&data->regs->version);
 	dev_info(data->dev,
 		 "davinci mdio revision %d.%d, bus freq %ld\n",
 		 (ver >> 8) & 0xff, ver & 0xff,
@@ -169,7 +169,7 @@ static int davinci_mdio_reset(struct mii_bus *bus)
 		goto done;
 
 	/* get phy mask from the alive register */
-	phy_mask = __raw_readl(&data->regs->alive);
+	phy_mask = readl_relaxed(&data->regs->alive);
 	if (phy_mask) {
 		/* restrict mdio bus to live phys only */
 		dev_info(data->dev, "detected phy mask %x\n", ~phy_mask);
@@ -196,11 +196,11 @@ static inline int wait_for_user_access(struct davinci_mdio_data *data)
 	u32 reg;
 
 	while (time_after(timeout, jiffies)) {
-		reg = __raw_readl(&regs->user[0].access);
+		reg = readl_relaxed(&regs->user[0].access);
 		if ((reg & USERACCESS_GO) == 0)
 			return 0;
 
-		reg = __raw_readl(&regs->control);
+		reg = readl_relaxed(&regs->control);
 		if ((reg & CONTROL_IDLE) == 0) {
 			usleep_range(100, 200);
 			continue;
@@ -216,7 +216,7 @@ static inline int wait_for_user_access(struct davinci_mdio_data *data)
 		return -EAGAIN;
 	}
 
-	reg = __raw_readl(&regs->user[0].access);
+	reg = readl_relaxed(&regs->user[0].access);
 	if ((reg & USERACCESS_GO) == 0)
 		return 0;
 
@@ -263,7 +263,7 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
 		if (ret < 0)
 			break;
 
-		__raw_writel(reg, &data->regs->user[0].access);
+		writel_relaxed(reg, &data->regs->user[0].access);
 
 		ret = wait_for_user_access(data);
 		if (ret == -EAGAIN)
@@ -271,7 +271,7 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
 		if (ret < 0)
 			break;
 
-		reg = __raw_readl(&data->regs->user[0].access);
+		reg = readl_relaxed(&data->regs->user[0].access);
 		ret = (reg & USERACCESS_ACK) ? (reg & USERACCESS_DATA) : -EIO;
 		break;
 	}
@@ -307,7 +307,7 @@ static int davinci_mdio_write(struct mii_bus *bus, int phy_id,
 		if (ret < 0)
 			break;
 
-		__raw_writel(reg, &data->regs->user[0].access);
+		writel_relaxed(reg, &data->regs->user[0].access);
 
 		ret = wait_for_user_access(data);
 		if (ret == -EAGAIN)
@@ -472,9 +472,9 @@ static int davinci_mdio_runtime_suspend(struct device *dev)
 	u32 ctrl;
 
 	/* shutdown the scan state machine */
-	ctrl = __raw_readl(&data->regs->control);
+	ctrl = readl_relaxed(&data->regs->control);
 	ctrl &= ~CONTROL_ENABLE;
-	__raw_writel(ctrl, &data->regs->control);
+	writel_relaxed(ctrl, &data->regs->control);
 	wait_for_idle(data);
 
 	return 0;
-- 
2.17.1

