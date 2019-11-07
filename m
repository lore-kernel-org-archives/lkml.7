Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F775C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50CD21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKGH67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:58:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:44304 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfKGH67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:58:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 23:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="196479307"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2019 23:58:55 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: add trc detection register to sysfs
Date:   Thu,  7 Nov 2019 12:44:45 +0200
Message-Id: <20191107104445.19101-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The glitch detection HW (TRC) save it status information into
TRC status register.
Make it available to user-space via read-only sysfs file.
The TRC register is availab for PCH15 gen and newer, for older
platforms reading the sysfs file will fail with EOPNOTSUPP.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/ABI/testing/sysfs-class-mei | 10 +++++++
 drivers/misc/mei/hw-me-regs.h             |  3 +-
 drivers/misc/mei/hw-me.c                  | 34 +++++++++++++++++++++++
 drivers/misc/mei/hw-me.h                  |  4 +++
 drivers/misc/mei/main.c                   | 24 ++++++++++++++++
 drivers/misc/mei/mei_dev.h                | 10 +++++++
 drivers/misc/mei/pci-me.c                 |  4 +--
 7 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mei b/Documentation/ABI/testing/sysfs-class-mei
index a92d844f806e..e9dc110650ae 100644
--- a/Documentation/ABI/testing/sysfs-class-mei
+++ b/Documentation/ABI/testing/sysfs-class-mei
@@ -80,3 +80,13 @@ Description:	Display the ME device state.
 		DISABLED
 		POWER_DOWN
 		POWER_UP
+
+What:		/sys/class/mei/meiN/trc
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	Display trc status register content
+
+		The ME FW writes Glitch Detection HW (TRC)
+		status information into trc status register
+		for BIOS and OS to monitor fw health.
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index b359f06f05e7..7cd67fb2365d 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -163,7 +163,8 @@ access to ME_CBD */
 #define ME_IS_HRA         0x00000002
 /* ME Interrupt Enable HRA - host read only access to ME_IE */
 #define ME_IE_HRA         0x00000001
-
+/* TRC control shadow register */
+#define ME_TRC            0x00000030
 
 /* H_HPG_CSR register bits */
 #define H_HPG_CSR_PGIHEXR 0x00000001
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 0ec55431e26b..668418d7ea77 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -172,6 +172,27 @@ static inline void mei_me_d0i3c_write(struct mei_device *dev, u32 reg)
 	mei_me_reg_write(to_me_hw(dev), H_D0I3C, reg);
 }
 
+/**
+ * mei_me_trc_status - read trc status register
+ *
+ * @dev: mei device
+ * @trc: trc status register value
+ *
+ * Return: 0 on success, error otherwise
+ */
+static int mei_me_trc_status(struct mei_device *dev, u32 *trc)
+{
+	struct mei_me_hw *hw = to_me_hw(dev);
+
+	if (!hw->cfg->hw_trc_supported)
+		return -EOPNOTSUPP;
+
+	*trc = mei_me_reg_read(hw, ME_TRC);
+	trace_mei_reg_read(dev->dev, "ME_TRC", ME_TRC, *trc);
+
+	return 0;
+}
+
 /**
  * mei_me_fw_status - read fw status register from pci config space
  *
@@ -1302,6 +1323,7 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 
 static const struct mei_hw_ops mei_me_hw_ops = {
 
+	.trc_status = mei_me_trc_status,
 	.fw_status = mei_me_fw_status,
 	.pg_state  = mei_me_pg_state,
 
@@ -1392,6 +1414,9 @@ static bool mei_me_fw_type_sps(struct pci_dev *pdev)
 	.dma_size[DMA_DSCR_DEVICE] = SZ_128K, \
 	.dma_size[DMA_DSCR_CTRL] = PAGE_SIZE
 
+#define MEI_CFG_TRC \
+	.hw_trc_supported = 1
+
 /* ICH Legacy devices */
 static const struct mei_cfg mei_me_ich_cfg = {
 	MEI_CFG_ICH_HFS,
@@ -1440,6 +1465,14 @@ static const struct mei_cfg mei_me_pch12_cfg = {
 	MEI_CFG_DMA_128,
 };
 
+/* Tiger Lake and newer devices */
+static const struct mei_cfg mei_me_pch15_cfg = {
+	MEI_CFG_PCH8_HFS,
+	MEI_CFG_FW_VER_SUPP,
+	MEI_CFG_DMA_128,
+	MEI_CFG_TRC,
+};
+
 /*
  * mei_cfg_list - A list of platform platform specific configurations.
  * Note: has to be synchronized with  enum mei_cfg_idx.
@@ -1454,6 +1487,7 @@ static const struct mei_cfg *const mei_cfg_list[] = {
 	[MEI_ME_PCH8_CFG] = &mei_me_pch8_cfg,
 	[MEI_ME_PCH8_SPS_CFG] = &mei_me_pch8_sps_cfg,
 	[MEI_ME_PCH12_CFG] = &mei_me_pch12_cfg,
+	[MEI_ME_PCH15_CFG] = &mei_me_pch15_cfg,
 };
 
 const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index 3352d19b8e85..4a8d4dcd5a91 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -21,12 +21,14 @@
  * @quirk_probe: device exclusion quirk
  * @dma_size: device DMA buffers size
  * @fw_ver_supported: is fw version retrievable from FW
+ * @hw_trc_supported: does the hw support trc register
  */
 struct mei_cfg {
 	const struct mei_fw_status fw_status;
 	bool (*quirk_probe)(struct pci_dev *pdev);
 	size_t dma_size[DMA_DSCR_NUM];
 	u32 fw_ver_supported:1;
+	u32 hw_trc_supported:1;
 };
 
 
@@ -78,6 +80,7 @@ struct mei_me_hw {
  *                         servers platforms with quirk for
  *                         SPS firmware exclusion.
  * @MEI_ME_PCH12_CFG:      Platform Controller Hub Gen12 and newer
+ * @MEI_ME_PCH15_CFG:      Platform Controller Hub Gen15 and newer
  * @MEI_ME_NUM_CFG:        Upper Sentinel.
  */
 enum mei_cfg_idx {
@@ -90,6 +93,7 @@ enum mei_cfg_idx {
 	MEI_ME_PCH8_CFG,
 	MEI_ME_PCH8_SPS_CFG,
 	MEI_ME_PCH12_CFG,
+	MEI_ME_PCH15_CFG,
 	MEI_ME_NUM_CFG,
 };
 
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 7310b476323c..4ef6e37caafc 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -700,6 +700,29 @@ static int mei_fasync(int fd, struct file *file, int band)
 	return fasync_helper(fd, file, band, &cl->ev_async);
 }
 
+/**
+ * trc_show - mei device trc attribute show method
+ *
+ * @device: device pointer
+ * @attr: attribute pointer
+ * @buf:  char out buffer
+ *
+ * Return: number of the bytes printed into buf or error
+ */
+static ssize_t trc_show(struct device *device,
+			struct device_attribute *attr, char *buf)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+	u32 trc;
+	int ret;
+
+	ret = mei_trc_status(dev, &trc);
+	if (ret)
+		return ret;
+	return sprintf(buf, "%08X\n", trc);
+}
+static DEVICE_ATTR_RO(trc);
+
 /**
  * fw_status_show - mei device fw_status attribute show method
  *
@@ -887,6 +910,7 @@ static struct attribute *mei_attrs[] = {
 	&dev_attr_tx_queue_limit.attr,
 	&dev_attr_fw_ver.attr,
 	&dev_attr_dev_state.attr,
+	&dev_attr_trc.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(mei);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index e0ac660c96e7..76f8ff5ff974 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -260,6 +260,7 @@ struct mei_cl {
  * @hw_config        : configure hw
  *
  * @fw_status        : get fw status registers
+ * @trc_status       : get trc status register
  * @pg_state         : power gating state of the device
  * @pg_in_transition : is device now in pg transition
  * @pg_is_enabled    : is power gating enabled
@@ -290,6 +291,8 @@ struct mei_hw_ops {
 	int (*hw_config)(struct mei_device *dev);
 
 	int (*fw_status)(struct mei_device *dev, struct mei_fw_status *fw_sts);
+	int (*trc_status)(struct mei_device *dev, u32 *trc);
+
 	enum mei_pg_state (*pg_state)(struct mei_device *dev);
 	bool (*pg_in_transition)(struct mei_device *dev);
 	bool (*pg_is_enabled)(struct mei_device *dev);
@@ -711,6 +714,13 @@ static inline int mei_count_full_read_slots(struct mei_device *dev)
 	return dev->ops->rdbuf_full_slots(dev);
 }
 
+static inline int mei_trc_status(struct mei_device *dev, u32 *trc)
+{
+	if (dev->ops->trc_status)
+		return dev->ops->trc_status(dev, trc);
+	return -EOPNOTSUPP;
+}
+
 static inline int mei_fw_status(struct mei_device *dev,
 				struct mei_fw_status *fw_status)
 {
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 1de6daf38602..c845b7e40f26 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -102,9 +102,9 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
 
-	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_LP, MEI_ME_PCH12_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_LP, MEI_ME_PCH15_CFG)},
 
-	{MEI_PCI_DEVICE(MEI_DEV_ID_MCC, MEI_ME_PCH12_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_MCC, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MCC_4, MEI_ME_PCH8_CFG)},
 
 	/* required last entry */
-- 
2.21.0

