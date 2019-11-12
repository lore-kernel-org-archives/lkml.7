Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208F4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED545222CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ecuofFtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfKLOaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:30:00 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49916 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfKLO3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:29:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACET5RG091978;
        Tue, 12 Nov 2019 08:29:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568945;
        bh=S3rvdYTSsVnyShvPa0DbdG4o71q2iB1tvJuQ4YR2MPY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ecuofFtZqxqs4wmuhTmCxO8C7+zIXlCdzwBg9mkNvKLK5DCZiGUpSdVG/Rqgbjgns
         CqOwtN3qyAudLWxSNmDxLONmFguq3kQ8POpwerZCTKuig7Rz91mTmFqTR8tFj1fyJw
         dJZ8Nok4Gk1lxuiHl6nap2e7MKGvWB2iCDWgA8IE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACET5lO027100
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:29:05 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:29:04 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:28:47 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriK044422;
        Tue, 12 Nov 2019 08:29:05 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>, Jyri Sarha <jsarha@ti.com>
Subject: [Patch v3 08/20] media: ti-vpe: cal: add CSI2 PHY LDO errata support
Date:   Tue, 12 Nov 2019 08:31:40 -0600
Message-ID: <20191112143152.23176-9-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112143152.23176-1-bparrot@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply Errata i913 every time the functional clock is enabled.
This should take care of suspend/resume case as well.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c      | 57 +++++++++++++++++++++++-
 drivers/media/platform/ti-vpe/cal_regs.h | 27 +++++++++++
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index eb3727ba185d..3b04aff6c778 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -282,6 +282,12 @@ static const struct cal_data dra72x_cal_data = {
 	.num_csi2_phy = ARRAY_SIZE(dra72x_cal_csi_phy),
 };
 
+static const struct cal_data dra72x_es1_cal_data = {
+	.csi2_phy_core = dra72x_cal_csi_phy,
+	.num_csi2_phy = ARRAY_SIZE(dra72x_cal_csi_phy),
+	.flags = DRA72_CAL_PRE_ES2_LDO_DISABLE,
+};
+
 /*
  * there is one cal_dev structure in the driver, it is shared by
  * all instances.
@@ -567,9 +573,52 @@ static void cal_get_hwinfo(struct cal_dev *dev)
 		hwinfo);
 }
 
-static inline int cal_runtime_get(struct cal_dev *dev)
+/*
+ *   Errata i913: CSI2 LDO Needs to be disabled when module is powered on
+ *
+ *   Enabling CSI2 LDO shorts it to core supply. It is crucial the 2 CSI2
+ *   LDOs on the device are disabled if CSI-2 module is powered on
+ *   (0x4845 B304 | 0x4845 B384 [28:27] = 0x1) or in ULPS (0x4845 B304
+ *   | 0x4845 B384 [28:27] = 0x2) mode. Common concerns include: high
+ *   current draw on the module supply in active mode.
+ *
+ *   Errata does not apply when CSI-2 module is powered off
+ *   (0x4845 B304 | 0x4845 B384 [28:27] = 0x0).
+ *
+ * SW Workaround:
+ *	Set the following register bits to disable the LDO,
+ *	which is essentially CSI2 REG10 bit 6:
+ *
+ *		Core 0:  0x4845 B828 = 0x0000 0040
+ *		Core 1:  0x4845 B928 = 0x0000 0040
+ */
+static void i913_errata(struct cal_dev *dev, unsigned int port)
 {
-	return pm_runtime_get_sync(&dev->pdev->dev);
+	u32 reg10 = reg_read(dev->cc[port], CAL_CSI2_PHY_REG10);
+
+	set_field(&reg10, CAL_CSI2_PHY_REG0_HSCLOCKCONFIG_DISABLE,
+		  CAL_CSI2_PHY_REG10_I933_LDO_DISABLE_MASK);
+
+	cal_dbg(1, dev, "CSI2_%d_REG10 = 0x%08x\n", port, reg10);
+	reg_write(dev->cc[port], CAL_CSI2_PHY_REG10, reg10);
+}
+
+static int cal_runtime_get(struct cal_dev *dev)
+{
+	int r;
+
+	r = pm_runtime_get_sync(&dev->pdev->dev);
+
+	if (dev->flags & DRA72_CAL_PRE_ES2_LDO_DISABLE) {
+		/*
+		 * Apply errata on both port eveytime we (re-)enable
+		 * the clock
+		 */
+		i913_errata(dev, 0);
+		i913_errata(dev, 1);
+	}
+
+	return r;
 }
 
 static inline void cal_runtime_put(struct cal_dev *dev)
@@ -2064,6 +2113,10 @@ static const struct of_device_id cal_of_match[] = {
 		.compatible = "ti,dra72-cal",
 		.data = (void *)&dra72x_cal_data,
 	},
+	{
+		.compatible = "ti,dra72-pre-es2-cal",
+		.data = (void *)&dra72x_es1_cal_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, cal_of_match);
diff --git a/drivers/media/platform/ti-vpe/cal_regs.h b/drivers/media/platform/ti-vpe/cal_regs.h
index 9e6afd0770c8..a40e77f3e977 100644
--- a/drivers/media/platform/ti-vpe/cal_regs.h
+++ b/drivers/media/platform/ti-vpe/cal_regs.h
@@ -10,6 +10,30 @@
 #ifndef __TI_CAL_REGS_H
 #define __TI_CAL_REGS_H
 
+/*
+ * struct cal_dev.flags possibilities
+ *
+ * DRA72_CAL_PRE_ES2_LDO_DISABLE:
+ *   Errata i913: CSI2 LDO Needs to be disabled when module is powered on
+ *
+ *   Enabling CSI2 LDO shorts it to core supply. It is crucial the 2 CSI2
+ *   LDOs on the device are disabled if CSI-2 module is powered on
+ *   (0x4845 B304 | 0x4845 B384 [28:27] = 0x1) or in ULPS (0x4845 B304
+ *   | 0x4845 B384 [28:27] = 0x2) mode. Common concerns include: high
+ *   current draw on the module supply in active mode.
+ *
+ *   Errata does not apply when CSI-2 module is powered off
+ *   (0x4845 B304 | 0x4845 B384 [28:27] = 0x0).
+ *
+ * SW Workaround:
+ *	Set the following register bits to disable the LDO,
+ *	which is essentially CSI2 REG10 bit 6:
+ *
+ *		Core 0:  0x4845 B828 = 0x0000 0040
+ *		Core 1:  0x4845 B928 = 0x0000 0040
+ */
+#define DRA72_CAL_PRE_ES2_LDO_DISABLE BIT(0)
+
 #define CAL_NUM_CSI2_PORTS		2
 
 /* CAL register offsets */
@@ -71,6 +95,7 @@
 #define CAL_CSI2_PHY_REG0		0x000
 #define CAL_CSI2_PHY_REG1		0x004
 #define CAL_CSI2_PHY_REG2		0x008
+#define CAL_CSI2_PHY_REG10		0x028
 
 /* CAL Control Module Core Camerrx Control register offsets */
 #define CM_CTRL_CORE_CAMERRX_CONTROL	0x000
@@ -458,6 +483,8 @@
 #define CAL_CSI2_PHY_REG1_CLOCK_MISS_DETECTOR_STATUS_SUCCESS		0
 #define CAL_CSI2_PHY_REG1_RESET_DONE_STATUS_MASK		GENMASK(29, 28)
 
+#define CAL_CSI2_PHY_REG10_I933_LDO_DISABLE_MASK		BIT(6)
+
 #define CAL_CSI2_PHY_REG2_CCP2_SYNC_PATTERN_MASK		GENMASK(23, 0)
 #define CAL_CSI2_PHY_REG2_TRIGGER_CMD_RXTRIGESC3_MASK		GENMASK(25, 24)
 #define CAL_CSI2_PHY_REG2_TRIGGER_CMD_RXTRIGESC2_MASK		GENMASK(27, 26)
-- 
2.17.1

