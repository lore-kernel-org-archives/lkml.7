Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82CEC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCB0216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfEHTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:00:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51175 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfEHTA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:00:28 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hORnL-0001aA-PC; Wed, 08 May 2019 19:00:00 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] nvme-pci: Use non-operational power state instead of D3 on Suspend-to-Idle
Date:   Thu,  9 May 2019 02:59:55 +0800
Message-Id: <20190508185955.11406-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several NVMes consume lots of power during Suspend-to-Idle.

According to the NVMe vendors, APST should be used and there are two
things that should be prevented:
- Controller shutdown (CC.SHN)
- PCI D3

I think that's because the Windows Modern Standby design document [1]
states below as a requirement:
"
Akin to AHCI PCIe SSDs, NVMe SSDs need to provide the host with a
non-operational power state that is comparable to DEVSLP (<5mW draw,
<100ms exit latency) in order to allow the host to perform appropriate
transitions into Modern Standby. Should the NVMe SSD not expose such a
non-operational power state, autonomous power state transitions (APST)
is the only other option to enter Modern Standby successfully.
"

D3 wasn't mentioned at all, though for some vendors D3 still put the
device into a low power state, others disable APST after trasition to
D3.

So instead of disabling NVMe controller in suspend callback we do the
following instead:
- Make sure all IRQs are quiesced
- Stop all queues
- Prevent the device entering D3
- Use memory barrier to make sure DMA operations are flushed on HMB devices

This patch has been verified on several different NVMes:
- Intel
- Hynix
- LiteOn
- Micron
- WDC
- Samsung
- Tohiba

With the new suspend routine, the laptop I tested use roughly 0.8W
under Suspend-to-Idle, and resume time is faster than the original
D3 scheme.

The only one exception so far is Toshiba XG5, which works with the old
suspend routine, so introduce a new quirk for XG5.
We are working with Toshiba to root cause the issue on XG5.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/part-selection#ssd-storage

Tested-by: Lucien Kao <Lucien_kao@compal.com>
Tested-by: Mice Lin <mice_lin@wistron.com>
Tested-by: Jason Tan <LiangChuan.Tan@wdc.com>
Tested-by: Cody Liu (codyliu) <codyliu@micron.com>
Tested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/nvme/host/core.c |   8 +++
 drivers/nvme/host/nvme.h |   8 +++
 drivers/nvme/host/pci.c  | 102 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6644a2c3ef7..929db749da98 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3903,6 +3903,14 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
 }
 
+void nvme_enter_deepest(struct nvme_ctrl *ctrl)
+{
+	int ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ctrl->npss,
+				    NULL, 0, NULL);
+	if (ret)
+		dev_warn(ctrl->device, "failed to set deepest non-operational state (%d)\n", ret);
+}
+EXPORT_SYMBOL_GPL(nvme_enter_deepest);
 
 static int __init nvme_core_init(void)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5ee75b5ff83f..ea40a83314ae 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -92,6 +92,11 @@ enum nvme_quirks {
 	 * Broken Write Zeroes.
 	 */
 	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
+
+	/*
+	 * Use D3 on S2I regardless of NPSS.
+	 */
+	NVME_QUIRK_USE_D3_ON_S2I		= (1 << 10),
 };
 
 /*
@@ -229,6 +234,7 @@ struct nvme_ctrl {
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
 	bool apst_enabled;
+	bool suspend_to_idle;
 
 	/* PCIe only: */
 	u32 hmpre;
@@ -467,6 +473,8 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 		void *log, size_t size, u64 offset);
 
+void nvme_enter_deepest(struct nvme_ctrl *ctrl);
+
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3e4fb891a95a..dea42b41f9a8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -23,6 +23,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/suspend.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -2828,12 +2829,98 @@ static void nvme_remove(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static void nvme_do_suspend_to_idle(struct pci_dev *pdev)
+{
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+
+	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+	ndev->ctrl.suspend_to_idle = true;
+
+	nvme_start_freeze(&ndev->ctrl);
+	nvme_wait_freeze_timeout(&ndev->ctrl, NVME_IO_TIMEOUT);
+	nvme_stop_queues(&ndev->ctrl);
+
+	nvme_enter_deepest(&ndev->ctrl);
+
+	if (ndev->ctrl.queue_count > 0) {
+		nvme_disable_io_queues(ndev);
+		nvme_poll_irqdisable(&ndev->queues[0], -1);
+	}
+
+	nvme_suspend_io_queues(ndev);
+	nvme_suspend_queue(&ndev->queues[0]);
+	pci_free_irq_vectors(pdev);
+
+	blk_mq_tagset_busy_iter(&ndev->tagset, nvme_cancel_request, &ndev->ctrl);
+	blk_mq_tagset_busy_iter(&ndev->admin_tagset, nvme_cancel_request, &ndev->ctrl);
+
+	/* Make sure all HMB DMA operations are done */
+	mb();
+}
+
+static int nvme_do_resume_from_idle(struct pci_dev *pdev)
+{
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	int result;
+
+	pdev->dev_flags &= ~PCI_DEV_FLAGS_NO_D3;
+	ndev->ctrl.suspend_to_idle = false;
+
+	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (result < 0)
+		goto out;
+
+	result = nvme_pci_configure_admin_queue(ndev);
+	if (result)
+		goto out;
+
+	result = nvme_alloc_admin_tags(ndev);
+	if (result)
+		goto out;
+
+	ndev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
+	ndev->ctrl.max_segments = NVME_MAX_SEGS;
+	mutex_unlock(&ndev->shutdown_lock);
+
+	result = nvme_init_identify(&ndev->ctrl);
+	if (result)
+		goto out;
+
+	result = nvme_setup_io_queues(ndev);
+	if (result)
+		goto out;
+
+	if (ndev->online_queues < 2) {
+		dev_warn(ndev->ctrl.device, "IO queues not created\n");
+		nvme_kill_queues(&ndev->ctrl);
+		nvme_remove_namespaces(&ndev->ctrl);
+	} else {
+		nvme_start_queues(&ndev->ctrl);
+		nvme_wait_freeze(&ndev->ctrl);
+		nvme_dev_add(ndev);
+		nvme_unfreeze(&ndev->ctrl);
+	}
+
+	nvme_start_ctrl(&ndev->ctrl);
+
+	return 0;
+
+ out:
+	nvme_remove_dead_ctrl(ndev, result);
+	return result;
+}
+
 static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_dev_disable(ndev, true);
+	if (IS_ENABLED(CONFIG_ACPI) && pm_suspend_via_s2idle() &&
+	    ndev->ctrl.npss && !(ndev->ctrl.quirks & NVME_QUIRK_USE_D3_ON_S2I))
+		nvme_do_suspend_to_idle(pdev);
+	else
+		nvme_dev_disable(ndev, true);
+
 	return 0;
 }
 
@@ -2841,9 +2928,16 @@ static int nvme_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	int result = 0;
 
-	nvme_reset_ctrl(&ndev->ctrl);
-	return 0;
+	if (ndev->ctrl.suspend_to_idle) {
+		result = nvme_do_resume_from_idle(pdev);
+		if (result)
+			dev_warn(dev, "failed to resume from idle state (%d)\n", result);
+	} else
+		nvme_reset_ctrl(&ndev->ctrl);
+
+	return result;
 }
 #endif
 
@@ -2921,6 +3015,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS |
 				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1179, 0x0116),	/* Toshiba XG5 */
+		.driver_data = NVME_QUIRK_USE_D3_ON_S2I, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
-- 
2.17.1

