Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B0AC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F982075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfKFTxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:53:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:8750 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfKFTw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:52:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="232995622"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 11:52:56 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/3] mei: abstract fw status register read.
Date:   Thu,  7 Nov 2019 00:38:41 +0200
Message-Id: <20191106223841.15802-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106223841.15802-1-tomas.winkler@intel.com>
References: <20191106223841.15802-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to allow working with mei devices embedded within
another pci device, where mei device is represented
as a platform child device and fw status registers
are not necessarily resident in the device pci config space.

Bump the copyright year to 2019 on the modified files.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c   | 24 ++++++++++++++++--------
 drivers/misc/mei/hw-me.h   |  2 ++
 drivers/misc/mei/hw-txe.c  | 10 +++++++---
 drivers/misc/mei/init.c    |  6 ++++--
 drivers/misc/mei/mei_dev.h |  8 ++++----
 drivers/misc/mei/pci-me.c  |  8 ++++++++
 6 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 23606d0ddcd6..0ec55431e26b 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -183,20 +183,19 @@ static inline void mei_me_d0i3c_write(struct mei_device *dev, u32 reg)
 static int mei_me_fw_status(struct mei_device *dev,
 			    struct mei_fw_status *fw_status)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	struct mei_me_hw *hw = to_me_hw(dev);
 	const struct mei_fw_status *fw_src = &hw->cfg->fw_status;
 	int ret;
 	int i;
 
-	if (!fw_status)
+	if (!fw_status || !hw->read_fws)
 		return -EINVAL;
 
 	fw_status->count = fw_src->count;
 	for (i = 0; i < fw_src->count && i < MEI_FW_STATUS_MAX; i++) {
-		ret = pci_read_config_dword(pdev, fw_src->status[i],
-					    &fw_status->status[i]);
-		trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HSF_X",
+		ret = hw->read_fws(dev, fw_src->status[i],
+				   &fw_status->status[i]);
+		trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HFS_X",
 				       fw_src->status[i],
 				       fw_status->status[i]);
 		if (ret)
@@ -210,19 +209,26 @@ static int mei_me_fw_status(struct mei_device *dev,
  * mei_me_hw_config - configure hw dependent settings
  *
  * @dev: mei device
+ *
+ * Return:
+ *  * -EINVAL when read_fws is not set
+ *  * 0 on success
+ *
  */
-static void mei_me_hw_config(struct mei_device *dev)
+static int mei_me_hw_config(struct mei_device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	struct mei_me_hw *hw = to_me_hw(dev);
 	u32 hcsr, reg;
 
+	if (WARN_ON(!hw->read_fws))
+		return -EINVAL;
+
 	/* Doesn't change in runtime */
 	hcsr = mei_hcsr_read(dev);
 	hw->hbuf_depth = (hcsr & H_CBD) >> 24;
 
 	reg = 0;
-	pci_read_config_dword(pdev, PCI_CFG_HFS_1, &reg);
+	hw->read_fws(dev, PCI_CFG_HFS_1, &reg);
 	trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HFS_1", PCI_CFG_HFS_1, reg);
 	hw->d0i3_supported =
 		((reg & PCI_CFG_HFS_1_D0I3_MSK) == PCI_CFG_HFS_1_D0I3_MSK);
@@ -233,6 +239,8 @@ static void mei_me_hw_config(struct mei_device *dev)
 		if (reg & H_D0I3C_I3)
 			hw->pg_state = MEI_PG_ON;
 	}
+
+	return 0;
 }
 
 /**
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index c45b32a7cc46..3352d19b8e85 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -46,6 +46,7 @@ struct mei_cfg {
  * @pg_state: power gating state
  * @d0i3_supported: di03 support
  * @hbuf_depth: depth of hardware host/write buffer in slots
+ * @read_fws: read FW status register handler
  */
 struct mei_me_hw {
 	const struct mei_cfg *cfg;
@@ -54,6 +55,7 @@ struct mei_me_hw {
 	enum mei_pg_state pg_state;
 	bool d0i3_supported;
 	u8 hbuf_depth;
+	int (*read_fws)(const struct mei_device *dev, int where, u32 *val);
 };
 
 #define to_me_hw(dev) (struct mei_me_hw *)((dev)->hw)
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index 5e58656b8e19..785b260b3ae9 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2013-2014, Intel Corporation. All rights reserved.
+ * Copyright (c) 2013-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -660,14 +660,16 @@ static int mei_txe_fw_status(struct mei_device *dev,
 }
 
 /**
- *  mei_txe_hw_config - configure hardware at the start of the devices
+ * mei_txe_hw_config - configure hardware at the start of the devices
  *
  * @dev: the device structure
  *
  * Configure hardware at the start of the device should be done only
  *   once at the device probe time
+ *
+ * Return: always 0
  */
-static void mei_txe_hw_config(struct mei_device *dev)
+static int mei_txe_hw_config(struct mei_device *dev)
 {
 
 	struct mei_txe_hw *hw = to_txe_hw(dev);
@@ -677,6 +679,8 @@ static void mei_txe_hw_config(struct mei_device *dev)
 
 	dev_dbg(dev->dev, "aliveness_resp = 0x%08x, readiness = 0x%08x.\n",
 		hw->aliveness, hw->readiness);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index b9fef773e71b..bcee77768b91 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2012-2018, Intel Corporation. All rights reserved.
+ * Copyright (c) 2012-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -190,7 +190,9 @@ int mei_start(struct mei_device *dev)
 	/* acknowledge interrupt and stop interrupts */
 	mei_clear_interrupts(dev);
 
-	mei_hw_config(dev);
+	ret = mei_hw_config(dev);
+	if (ret)
+		goto err;
 
 	dev_dbg(dev->dev, "reset in start the mei device.\n");
 
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 0f2141178299..e0ac660c96e7 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (c) 2003-2018, Intel Corporation. All rights reserved.
+ * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -287,7 +287,7 @@ struct mei_hw_ops {
 	bool (*hw_is_ready)(struct mei_device *dev);
 	int (*hw_reset)(struct mei_device *dev, bool enable);
 	int (*hw_start)(struct mei_device *dev);
-	void (*hw_config)(struct mei_device *dev);
+	int (*hw_config)(struct mei_device *dev);
 
 	int (*fw_status)(struct mei_device *dev, struct mei_fw_status *fw_sts);
 	enum mei_pg_state (*pg_state)(struct mei_device *dev);
@@ -614,9 +614,9 @@ void mei_irq_compl_handler(struct mei_device *dev, struct list_head *cmpl_list);
  */
 
 
-static inline void mei_hw_config(struct mei_device *dev)
+static inline int mei_hw_config(struct mei_device *dev)
 {
-	dev->ops->hw_config(dev);
+	return dev->ops->hw_config(dev);
 }
 
 static inline enum mei_pg_state mei_pg_state(struct mei_device *dev)
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 6233b3ca1c1d..1de6daf38602 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -121,6 +121,13 @@ static inline void mei_me_set_pm_domain(struct mei_device *dev) {}
 static inline void mei_me_unset_pm_domain(struct mei_device *dev) {}
 #endif /* CONFIG_PM */
 
+static int mei_me_read_fws(const struct mei_device *dev, int where, u32 *val)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	return pci_read_config_dword(pdev, where, val);
+}
+
 /**
  * mei_me_quirk_probe - probe for devices that doesn't valid ME interface
  *
@@ -200,6 +207,7 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw = to_me_hw(dev);
 	hw->mem_addr = pcim_iomap_table(pdev)[0];
 	hw->irq = pdev->irq;
+	hw->read_fws = mei_me_read_fws;
 
 	pci_enable_msi(pdev);
 
-- 
2.21.0

