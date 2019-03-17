Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFC1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CE020896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWfqbxOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfCQT7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:59:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55201 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfCQT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id f3so11117868wmj.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tXPQoXsUDDClFPrLrlhXmhIUgeeo4b8g8/ML5C9ikzs=;
        b=PWfqbxOe/peo88IB/DS5CNY3ui+LNi8luM0amYMtBdjKWIBgoVs2DjH89qk86UjRPo
         k6BytZhHo8i4eg5vOZRDHiZk+wy2tZCLvvWtWOf31MWDfYRAdixJruW9LH8VdjynOEoE
         SvDrH6uW11zIvqaew2XimpbKpqqxv9N/KJh9SJdzKv3NKvsBDFFohiz4+wS1E/BCCqyl
         QYR6AGAPrqstEpluw9JAATZcae09eF9jva8tLvDJXmcQBe1f4LVsuRZ3BlpT/Jv7XtcF
         iBPQNdd6+wlFM9jRgVhJ+KUgTmVnHSxR9ppyNs8m5uk1uvarCrryzNIcDjsm+Wc/Wwpe
         9iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tXPQoXsUDDClFPrLrlhXmhIUgeeo4b8g8/ML5C9ikzs=;
        b=iLFxee5AuSkac93KrLBPRUoGhdhgpBe8OoC/W+9mENQGlppg6xAq3JCXdjkwfOKd+W
         Hk1mmBntlqLf+OZd5bFMnMNoYFygdNL7EKZ+++hS3iApicsp3b4PNP9ZU8jijSwLiLup
         O10Jv4e5D1fncTGfRaPW0Zj5JeoZmJKtpZ3RbYtZXPTmDGAI+R1skQOwHIH9GVNkgHrL
         5lwHUJEQb3pHiaTbKcz0vgAU6wTY5Wz2Qs4Up8T6ZSgJYVQVAqhtE5TmGYu4ktcvsUmj
         loyS2IKyzcqK/1pne5+uC9TXd6UMQCofKFs5pM/e78FhE0QfDFxfdOOQWfm+AC1wn7S5
         8AQw==
X-Gm-Message-State: APjAAAVzDL5y2I9yVj9Hh7x8ViFdHIStCLmQLdpI6+dYflPta4377Rjf
        Um5KlfNNQmrtSWmI38dGTUDEoW6a
X-Google-Smtp-Source: APXvYqyVls0yMVeDJtp1LpYNp5J4VO57q+bUmtpfKVw/f5WgaqutdH04G28Ui5AEaWZ7YivjID8I5A==
X-Received: by 2002:a1c:40c3:: with SMTP id n186mr2965533wma.3.1552852783551;
        Sun, 17 Mar 2019 12:59:43 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:42 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 04/15] habanalabs: Move device CPU code into common file
Date:   Sun, 17 Mar 2019 21:59:16 +0200
Message-Id: <20190317195927.26238-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

This patch moves the code that is responsible of the communication
vs. the F/W to a dedicated file. This will allow us to share the code
between different ASICs.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/Makefile           |   2 +-
 drivers/misc/habanalabs/firmware_if.c      | 324 +++++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c        | 360 ++++-----------------
 drivers/misc/habanalabs/goya/goyaP.h       |  11 -
 drivers/misc/habanalabs/habanalabs.h       |  17 +
 drivers/misc/habanalabs/include/armcp_if.h |   8 +
 6 files changed, 407 insertions(+), 315 deletions(-)
 create mode 100644 drivers/misc/habanalabs/firmware_if.c

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index c6592db59b25..598740d235f8 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -6,7 +6,7 @@ obj-m	:= habanalabs.o
 
 habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
 		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
-		command_submission.o mmu.o
+		command_submission.o mmu.o firmware_if.o
 
 habanalabs-$(CONFIG_DEBUG_FS) += debugfs.o
 
diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
new file mode 100644
index 000000000000..9bf5203e8922
--- /dev/null
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2019 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+#include <linux/firmware.h>
+#include <linux/genalloc.h>
+
+/**
+ * hl_fw_push_fw_to_device() - Push FW code to device.
+ * @hdev: pointer to hl_device structure.
+ *
+ * Copy fw code from firmware file to device memory.
+ *
+ * Return: 0 on success, non-zero for failure.
+ */
+int hl_fw_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
+				void __iomem *dst)
+{
+	const struct firmware *fw;
+	const u64 *fw_data;
+	size_t fw_size, i;
+	int rc;
+
+	rc = request_firmware(&fw, fw_name, hdev->dev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to request %s\n", fw_name);
+		goto out;
+	}
+
+	fw_size = fw->size;
+	if ((fw_size % 4) != 0) {
+		dev_err(hdev->dev, "illegal %s firmware size %zu\n",
+			fw_name, fw_size);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	dev_dbg(hdev->dev, "%s firmware size == %zu\n", fw_name, fw_size);
+
+	fw_data = (const u64 *) fw->data;
+
+	if ((fw->size % 8) != 0)
+		fw_size -= 8;
+
+	for (i = 0 ; i < fw_size ; i += 8, fw_data++, dst += 8) {
+		if (!(i & (0x80000 - 1))) {
+			dev_dbg(hdev->dev,
+				"copied so far %zu out of %zu for %s firmware",
+				i, fw_size, fw_name);
+			usleep_range(20, 100);
+		}
+
+		writeq(*fw_data, dst);
+	}
+
+	if ((fw->size % 8) != 0)
+		writel(*(const u32 *) fw_data, dst);
+
+out:
+	release_firmware(fw);
+	return rc;
+}
+
+int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
+{
+	struct armcp_packet pkt = {};
+
+	pkt.ctl = cpu_to_le32(opcode << ARMCP_PKT_CTL_OPCODE_SHIFT);
+
+	return hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt,
+				sizeof(pkt), HL_DEVICE_TIMEOUT_USEC, NULL);
+}
+
+int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
+				u16 len, u32 timeout, long *result)
+{
+	struct armcp_packet *pkt;
+	dma_addr_t pkt_dma_addr;
+	u32 tmp;
+	int rc = 0;
+
+	if (len > HL_CPU_CB_SIZE) {
+		dev_err(hdev->dev, "Invalid CPU message size of %d bytes\n",
+			len);
+		return -ENOMEM;
+	}
+
+	pkt = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, len,
+								&pkt_dma_addr);
+	if (!pkt) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for packet to CPU\n");
+		return -ENOMEM;
+	}
+
+	memcpy(pkt, msg, len);
+
+	mutex_lock(&hdev->send_cpu_message_lock);
+
+	if (hdev->disabled)
+		goto out;
+
+	if (hdev->device_cpu_disabled) {
+		rc = -EIO;
+		goto out;
+	}
+
+	rc = hl_hw_queue_send_cb_no_cmpl(hdev, hw_queue_id, len, pkt_dma_addr);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to send CB on CPU PQ (%d)\n", rc);
+		goto out;
+	}
+
+	rc = hl_poll_timeout_memory(hdev, (u64) (uintptr_t) &pkt->fence,
+					timeout, &tmp);
+
+	hl_hw_queue_inc_ci_kernel(hdev, hw_queue_id);
+
+	if (rc == -ETIMEDOUT) {
+		dev_err(hdev->dev, "Timeout while waiting for device CPU\n");
+		hdev->device_cpu_disabled = true;
+		goto out;
+	}
+
+	if (tmp == ARMCP_PACKET_FENCE_VAL) {
+		u32 ctl = le32_to_cpu(pkt->ctl);
+
+		rc = (ctl & ARMCP_PKT_CTL_RC_MASK) >> ARMCP_PKT_CTL_RC_SHIFT;
+		if (rc) {
+			dev_err(hdev->dev,
+				"F/W ERROR %d for CPU packet %d\n",
+				rc, (ctl & ARMCP_PKT_CTL_OPCODE_MASK)
+						>> ARMCP_PKT_CTL_OPCODE_SHIFT);
+			rc = -EINVAL;
+		} else if (result) {
+			*result = (long) le64_to_cpu(pkt->result);
+		}
+	} else {
+		dev_err(hdev->dev, "CPU packet wrong fence value\n");
+		rc = -EINVAL;
+	}
+
+out:
+	mutex_unlock(&hdev->send_cpu_message_lock);
+
+	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, len, pkt);
+
+	return rc;
+}
+
+int hl_fw_test_cpu_queue(struct hl_device *hdev)
+{
+	struct armcp_packet test_pkt = {};
+	long result;
+	int rc;
+
+	test_pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEST <<
+					ARMCP_PKT_CTL_OPCODE_SHIFT);
+	test_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &test_pkt,
+			sizeof(test_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if (!rc) {
+		if (result == ARMCP_PACKET_FENCE_VAL)
+			dev_info(hdev->dev,
+				"queue test on CPU queue succeeded\n");
+		else
+			dev_err(hdev->dev,
+				"CPU queue test failed (0x%08lX)\n", result);
+	} else {
+		dev_err(hdev->dev, "CPU queue test failed, error %d\n", rc);
+	}
+
+	return rc;
+}
+
+void *hl_fw_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
+						dma_addr_t *dma_handle)
+{
+	u64 kernel_addr;
+
+	/* roundup to HL_CPU_PKT_SIZE */
+	size = (size + (HL_CPU_PKT_SIZE - 1)) & HL_CPU_PKT_MASK;
+
+	kernel_addr = gen_pool_alloc(hdev->cpu_accessible_dma_pool, size);
+
+	*dma_handle = hdev->cpu_accessible_dma_address +
+		(kernel_addr - (u64) (uintptr_t) hdev->cpu_accessible_dma_mem);
+
+	return (void *) (uintptr_t) kernel_addr;
+}
+
+void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
+					void *vaddr)
+{
+	/* roundup to HL_CPU_PKT_SIZE */
+	size = (size + (HL_CPU_PKT_SIZE - 1)) & HL_CPU_PKT_MASK;
+
+	gen_pool_free(hdev->cpu_accessible_dma_pool, (u64) (uintptr_t) vaddr,
+			size);
+}
+
+int hl_fw_send_heartbeat(struct hl_device *hdev)
+{
+	struct armcp_packet hb_pkt = {};
+	long result;
+	int rc;
+
+	hb_pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEST <<
+					ARMCP_PKT_CTL_OPCODE_SHIFT);
+	hb_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &hb_pkt,
+			sizeof(hb_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if ((rc) || (result != ARMCP_PACKET_FENCE_VAL))
+		rc = -EIO;
+
+	return rc;
+}
+
+int hl_fw_armcp_info_get(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct armcp_packet pkt = {};
+	void *armcp_info_cpu_addr;
+	dma_addr_t armcp_info_dma_addr;
+	long result;
+	int rc;
+
+	armcp_info_cpu_addr =
+			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
+					sizeof(struct armcp_info),
+					&armcp_info_dma_addr);
+	if (!armcp_info_cpu_addr) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for ArmCP info packet\n");
+		return -ENOMEM;
+	}
+
+	memset(armcp_info_cpu_addr, 0, sizeof(struct armcp_info));
+
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_INFO_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(armcp_info_dma_addr +
+				prop->host_phys_base_address);
+	pkt.data_max_size = cpu_to_le32(sizeof(struct armcp_info));
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to send armcp info pkt, error %d\n", rc);
+		goto out;
+	}
+
+	memcpy(&prop->armcp_info, armcp_info_cpu_addr,
+			sizeof(prop->armcp_info));
+
+	rc = hl_build_hwmon_channel_info(hdev, prop->armcp_info.sensors);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to build hwmon channel info, error %d\n", rc);
+		rc = -EFAULT;
+		goto out;
+	}
+
+out:
+	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
+			sizeof(struct armcp_info), armcp_info_cpu_addr);
+
+	return rc;
+}
+
+int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct armcp_packet pkt = {};
+	void *eeprom_info_cpu_addr;
+	dma_addr_t eeprom_info_dma_addr;
+	long result;
+	int rc;
+
+	eeprom_info_cpu_addr =
+			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
+					max_size, &eeprom_info_dma_addr);
+	if (!eeprom_info_cpu_addr) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for EEPROM info packet\n");
+		return -ENOMEM;
+	}
+
+	memset(eeprom_info_cpu_addr, 0, max_size);
+
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_EEPROM_DATA_GET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(eeprom_info_dma_addr +
+				prop->host_phys_base_address);
+	pkt.data_max_size = cpu_to_le32(max_size);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+			HL_ARMCP_EEPROM_TIMEOUT_USEC, &result);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to send armcp EEPROM pkt, error %d\n", rc);
+		goto out;
+	}
+
+	/* result contains the actual size */
+	memcpy(data, eeprom_info_cpu_addr, min((size_t)result, max_size));
+
+out:
+	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, max_size,
+			eeprom_info_cpu_addr);
+
+	return rc;
+}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3dfac5393269..a578d01a56a6 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -12,7 +12,6 @@
 
 #include <linux/pci.h>
 #include <linux/genalloc.h>
-#include <linux/firmware.h>
 #include <linux/hwmon.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
@@ -373,18 +372,6 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->high_pll = PLL_HIGH_DEFAULT;
 }
 
-int goya_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
-{
-	struct armcp_packet pkt;
-
-	memset(&pkt, 0, sizeof(pkt));
-
-	pkt.ctl = cpu_to_le32(opcode << ARMCP_PKT_CTL_OPCODE_SHIFT);
-
-	return hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt,
-			sizeof(pkt), HL_DEVICE_TIMEOUT_USEC, NULL);
-}
-
 /*
  * goya_pci_bars_map - Map PCI BARS of Goya device
  *
@@ -802,7 +789,7 @@ static int goya_late_init(struct hl_device *hdev)
 	 */
 	WREG32(mmMMU_LOG2_DDR_SIZE, ilog2(prop->dram_size));
 
-	rc = goya_send_pci_access_msg(hdev, ARMCP_PACKET_ENABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_ENABLE_PCI_ACCESS);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
 		return rc;
@@ -828,7 +815,7 @@ static int goya_late_init(struct hl_device *hdev)
 	return 0;
 
 disable_pci_access:
-	goya_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
+	hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
 
 	return rc;
 }
@@ -900,19 +887,16 @@ static int goya_sw_init(struct hl_device *hdev)
 
 	hdev->cpu_accessible_dma_mem =
 			hdev->asic_funcs->dma_alloc_coherent(hdev,
-					CPU_ACCESSIBLE_MEM_SIZE,
+					HL_CPU_ACCESSIBLE_MEM_SIZE,
 					&hdev->cpu_accessible_dma_address,
 					GFP_KERNEL | __GFP_ZERO);
 
 	if (!hdev->cpu_accessible_dma_mem) {
-		dev_err(hdev->dev,
-			"failed to allocate %d of dma memory for CPU accessible memory space\n",
-			CPU_ACCESSIBLE_MEM_SIZE);
 		rc = -ENOMEM;
 		goto free_dma_pool;
 	}
 
-	hdev->cpu_accessible_dma_pool = gen_pool_create(CPU_PKT_SHIFT, -1);
+	hdev->cpu_accessible_dma_pool = gen_pool_create(HL_CPU_PKT_SHIFT, -1);
 	if (!hdev->cpu_accessible_dma_pool) {
 		dev_err(hdev->dev,
 			"Failed to create CPU accessible DMA pool\n");
@@ -922,7 +906,7 @@ static int goya_sw_init(struct hl_device *hdev)
 
 	rc = gen_pool_add(hdev->cpu_accessible_dma_pool,
 				(uintptr_t) hdev->cpu_accessible_dma_mem,
-				CPU_ACCESSIBLE_MEM_SIZE, -1);
+				HL_CPU_ACCESSIBLE_MEM_SIZE, -1);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to add memory to CPU accessible DMA pool\n");
@@ -937,7 +921,7 @@ static int goya_sw_init(struct hl_device *hdev)
 free_cpu_pq_pool:
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 free_cpu_pq_dma_mem:
-	hdev->asic_funcs->dma_free_coherent(hdev, CPU_ACCESSIBLE_MEM_SIZE,
+	hdev->asic_funcs->dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE,
 			hdev->cpu_accessible_dma_mem,
 			hdev->cpu_accessible_dma_address);
 free_dma_pool:
@@ -960,7 +944,7 @@ static int goya_sw_fini(struct hl_device *hdev)
 
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 
-	hdev->asic_funcs->dma_free_coherent(hdev, CPU_ACCESSIBLE_MEM_SIZE,
+	hdev->asic_funcs->dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE,
 			hdev->cpu_accessible_dma_mem,
 			hdev->cpu_accessible_dma_address);
 
@@ -1240,7 +1224,7 @@ static int goya_init_cpu_queues(struct hl_device *hdev)
 
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_5, HL_QUEUE_SIZE_IN_BYTES);
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_4, HL_EQ_SIZE_IN_BYTES);
-	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_10, CPU_ACCESSIBLE_MEM_SIZE);
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_10, HL_CPU_ACCESSIBLE_MEM_SIZE);
 
 	/* Used for EQ CI */
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_6, 0);
@@ -2328,67 +2312,45 @@ static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
 }
 
 /*
- * goya_push_fw_to_device - Push FW code to device
- *
- * @hdev: pointer to hl_device structure
+ * goya_push_uboot_to_device() - Push u-boot FW code to device.
+ * @hdev: Pointer to hl_device structure.
  *
- * Copy fw code from firmware file to device memory.
- * Returns 0 on success
+ * Copy u-boot fw code from firmware file to SRAM BAR.
  *
+ * Return: 0 on success, non-zero for failure.
  */
-static int goya_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
-					void __iomem *dst)
+static int goya_push_uboot_to_device(struct hl_device *hdev)
 {
-	const struct firmware *fw;
-	const u64 *fw_data;
-	size_t fw_size, i;
-	int rc;
-
-	rc = request_firmware(&fw, fw_name, hdev->dev);
-
-	if (rc) {
-		dev_err(hdev->dev, "Failed to request %s\n", fw_name);
-		goto out;
-	}
-
-	fw_size = fw->size;
-	if ((fw_size % 4) != 0) {
-		dev_err(hdev->dev, "illegal %s firmware size %zu\n",
-			fw_name, fw_size);
-		rc = -EINVAL;
-		goto out;
-	}
-
-	dev_dbg(hdev->dev, "%s firmware size == %zu\n", fw_name, fw_size);
-
-	fw_data = (const u64 *) fw->data;
+	char fw_name[200];
+	void __iomem *dst;
 
-	if ((fw->size % 8) != 0)
-		fw_size -= 8;
+	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-u-boot.bin");
+	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + UBOOT_FW_OFFSET;
 
-	for (i = 0 ; i < fw_size ; i += 8, fw_data++, dst += 8) {
-		if (!(i & (0x80000 - 1))) {
-			dev_dbg(hdev->dev,
-				"copied so far %zu out of %zu for %s firmware",
-				i, fw_size, fw_name);
-			usleep_range(20, 100);
-		}
+	return hl_fw_push_fw_to_device(hdev, fw_name, dst);
+}
 
-		writeq(*fw_data, dst);
-	}
+/*
+ * goya_push_linux_to_device() - Push LINUX FW code to device.
+ * @hdev: Pointer to hl_device structure.
+ *
+ * Copy LINUX fw code from firmware file to HBM BAR.
+ *
+ * Return: 0 on success, non-zero for failure.
+ */
+static int goya_push_linux_to_device(struct hl_device *hdev)
+{
+	char fw_name[200];
+	void __iomem *dst;
 
-	if ((fw->size % 8) != 0)
-		writel(*(const u32 *) fw_data, dst);
+	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-fit.itb");
+	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
 
-out:
-	release_firmware(fw);
-	return rc;
+	return hl_fw_push_fw_to_device(hdev, fw_name, dst);
 }
 
 static int goya_pldm_init_cpu(struct hl_device *hdev)
 {
-	char fw_name[200];
-	void __iomem *dst;
 	u32 val, unit_rst_val;
 	int rc;
 
@@ -2406,15 +2368,11 @@ static int goya_pldm_init_cpu(struct hl_device *hdev)
 	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, unit_rst_val);
 	val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
 
-	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-u-boot.bin");
-	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + UBOOT_FW_OFFSET;
-	rc = goya_push_fw_to_device(hdev, fw_name, dst);
+	rc = goya_push_uboot_to_device(hdev);
 	if (rc)
 		return rc;
 
-	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-fit.itb");
-	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
-	rc = goya_push_fw_to_device(hdev, fw_name, dst);
+	rc = goya_push_linux_to_device(hdev);
 	if (rc)
 		return rc;
 
@@ -2476,8 +2434,6 @@ static void goya_read_device_fw_version(struct hl_device *hdev,
 static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 {
 	struct goya_device *goya = hdev->asic_specific;
-	char fw_name[200];
-	void __iomem *dst;
 	u32 status;
 	int rc;
 
@@ -2574,9 +2530,7 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 		goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-fit.itb");
-	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
-	rc = goya_push_fw_to_device(hdev, fw_name, dst);
+	rc = goya_push_linux_to_device(hdev);
 	if (rc)
 		return rc;
 
@@ -2762,7 +2716,7 @@ static int goya_hw_init(struct hl_device *hdev)
 	return 0;
 
 disable_pci_access:
-	goya_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
+	hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
 disable_msix:
 	goya_disable_msix(hdev);
 disable_queues:
@@ -2869,7 +2823,7 @@ int goya_suspend(struct hl_device *hdev)
 {
 	int rc;
 
-	rc = goya_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
 	if (rc)
 		dev_err(hdev->dev, "Failed to disable PCI access from CPU\n");
 
@@ -3150,10 +3104,6 @@ int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 				u32 timeout, long *result)
 {
 	struct goya_device *goya = hdev->asic_specific;
-	struct armcp_packet *pkt;
-	dma_addr_t pkt_dma_addr;
-	u32 tmp;
-	int rc = 0;
 
 	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q)) {
 		if (result)
@@ -3161,74 +3111,8 @@ int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 		return 0;
 	}
 
-	if (len > CPU_CB_SIZE) {
-		dev_err(hdev->dev, "Invalid CPU message size of %d bytes\n",
-			len);
-		return -ENOMEM;
-	}
-
-	pkt = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, len,
-								&pkt_dma_addr);
-	if (!pkt) {
-		dev_err(hdev->dev,
-			"Failed to allocate DMA memory for packet to CPU\n");
-		return -ENOMEM;
-	}
-
-	memcpy(pkt, msg, len);
-
-	mutex_lock(&hdev->send_cpu_message_lock);
-
-	if (hdev->disabled)
-		goto out;
-
-	if (hdev->device_cpu_disabled) {
-		rc = -EIO;
-		goto out;
-	}
-
-	rc = hl_hw_queue_send_cb_no_cmpl(hdev, GOYA_QUEUE_ID_CPU_PQ, len,
-			pkt_dma_addr);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to send CB on CPU PQ (%d)\n", rc);
-		goto out;
-	}
-
-	rc = hl_poll_timeout_memory(hdev, (u64) (uintptr_t) &pkt->fence,
-					timeout, &tmp);
-
-	hl_hw_queue_inc_ci_kernel(hdev, GOYA_QUEUE_ID_CPU_PQ);
-
-	if (rc == -ETIMEDOUT) {
-		dev_err(hdev->dev, "Timeout while waiting for device CPU\n");
-		hdev->device_cpu_disabled = true;
-		goto out;
-	}
-
-	if (tmp == ARMCP_PACKET_FENCE_VAL) {
-		u32 ctl = le32_to_cpu(pkt->ctl);
-
-		rc = (ctl & ARMCP_PKT_CTL_RC_MASK) >> ARMCP_PKT_CTL_RC_SHIFT;
-		if (rc) {
-			dev_err(hdev->dev,
-				"F/W ERROR %d for CPU packet %d\n",
-				rc, (ctl & ARMCP_PKT_CTL_OPCODE_MASK)
-						>> ARMCP_PKT_CTL_OPCODE_SHIFT);
-			rc = -EINVAL;
-		} else if (result) {
-			*result = (long) le64_to_cpu(pkt->result);
-		}
-	} else {
-		dev_err(hdev->dev, "CPU packet wrong fence value\n");
-		rc = -EINVAL;
-	}
-
-out:
-	mutex_unlock(&hdev->send_cpu_message_lock);
-
-	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, len, pkt);
-
-	return rc;
+	return hl_fw_send_cpu_message(hdev, GOYA_QUEUE_ID_CPU_PQ, msg, len,
+					timeout, result);
 }
 
 int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
@@ -3306,33 +3190,16 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 
 int goya_test_cpu_queue(struct hl_device *hdev)
 {
-	struct armcp_packet test_pkt;
-	long result;
-	int rc;
-
-	/* cpu_queues_enable flag is always checked in send cpu message */
-
-	memset(&test_pkt, 0, sizeof(test_pkt));
-
-	test_pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEST <<
-					ARMCP_PKT_CTL_OPCODE_SHIFT);
-	test_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &test_pkt,
-			sizeof(test_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
+	struct goya_device *goya = hdev->asic_specific;
 
-	if (!rc) {
-		if (result == ARMCP_PACKET_FENCE_VAL)
-			dev_info(hdev->dev,
-				"queue test on CPU queue succeeded\n");
-		else
-			dev_err(hdev->dev,
-				"CPU queue test failed (0x%08lX)\n", result);
-	} else {
-		dev_err(hdev->dev, "CPU queue test failed, error %d\n", rc);
-	}
+	/*
+	 * check capability here as send_cpu_message() won't update the result
+	 * value if no capability
+	 */
+	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
 
-	return rc;
+	return hl_fw_test_cpu_queue(hdev);
 }
 
 static int goya_test_queues(struct hl_device *hdev)
@@ -3373,27 +3240,13 @@ static void goya_dma_pool_free(struct hl_device *hdev, void *vaddr,
 static void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev,
 					size_t size, dma_addr_t *dma_handle)
 {
-	u64 kernel_addr;
-
-	/* roundup to CPU_PKT_SIZE */
-	size = (size + (CPU_PKT_SIZE - 1)) & CPU_PKT_MASK;
-
-	kernel_addr = gen_pool_alloc(hdev->cpu_accessible_dma_pool, size);
-
-	*dma_handle = hdev->cpu_accessible_dma_address +
-		(kernel_addr - (u64) (uintptr_t) hdev->cpu_accessible_dma_mem);
-
-	return (void *) (uintptr_t) kernel_addr;
+	return hl_fw_cpu_accessible_dma_pool_alloc(hdev, size, dma_handle);
 }
 
 static void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev,
 						size_t size, void *vaddr)
 {
-	/* roundup to CPU_PKT_SIZE */
-	size = (size + (CPU_PKT_SIZE - 1)) & CPU_PKT_MASK;
-
-	gen_pool_free(hdev->cpu_accessible_dma_pool, (u64) (uintptr_t) vaddr,
-			size);
+	hl_fw_cpu_accessible_dma_pool_free(hdev, size, vaddr);
 }
 
 static int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sg,
@@ -5032,72 +4885,26 @@ static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
 int goya_send_heartbeat(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
-	struct armcp_packet hb_pkt;
-	long result;
-	int rc;
 
 	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	memset(&hb_pkt, 0, sizeof(hb_pkt));
-
-	hb_pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEST <<
-					ARMCP_PKT_CTL_OPCODE_SHIFT);
-	hb_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &hb_pkt,
-			sizeof(hb_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
-
-	if ((rc) || (result != ARMCP_PACKET_FENCE_VAL))
-		rc = -EIO;
-
-	return rc;
+	return hl_fw_send_heartbeat(hdev);
 }
 
 static int goya_armcp_info_get(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct armcp_packet pkt;
-	void *armcp_info_cpu_addr;
-	dma_addr_t armcp_info_dma_addr;
 	u64 dram_size;
-	long result;
 	int rc;
 
 	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	armcp_info_cpu_addr =
-			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
-			sizeof(struct armcp_info), &armcp_info_dma_addr);
-	if (!armcp_info_cpu_addr) {
-		dev_err(hdev->dev,
-			"Failed to allocate DMA memory for ArmCP info packet\n");
-		return -ENOMEM;
-	}
-
-	memset(armcp_info_cpu_addr, 0, sizeof(struct armcp_info));
-
-	memset(&pkt, 0, sizeof(pkt));
-
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_INFO_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.addr = cpu_to_le64(armcp_info_dma_addr +
-				prop->host_phys_base_address);
-	pkt.data_max_size = cpu_to_le32(sizeof(struct armcp_info));
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-			GOYA_ARMCP_INFO_TIMEOUT, &result);
-
-	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to send armcp info pkt, error %d\n", rc);
-		goto out;
-	}
-
-	memcpy(&prop->armcp_info, armcp_info_cpu_addr,
-			sizeof(prop->armcp_info));
+	rc = hl_fw_armcp_info_get(hdev);
+	if (rc)
+		return rc;
 
 	dram_size = le64_to_cpu(prop->armcp_info.dram_size);
 	if (dram_size) {
@@ -5113,19 +4920,7 @@ static int goya_armcp_info_get(struct hl_device *hdev)
 		prop->dram_end_address = prop->dram_base_address + dram_size;
 	}
 
-	rc = hl_build_hwmon_channel_info(hdev, prop->armcp_info.sensors);
-	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to build hwmon channel info, error %d\n", rc);
-		rc = -EFAULT;
-		goto out;
-	}
-
-out:
-	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
-			sizeof(struct armcp_info), armcp_info_cpu_addr);
-
-	return rc;
+	return 0;
 }
 
 static void goya_init_clock_gating(struct hl_device *hdev)
@@ -5214,52 +5009,11 @@ static int goya_get_eeprom_data(struct hl_device *hdev, void *data,
 				size_t max_size)
 {
 	struct goya_device *goya = hdev->asic_specific;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct armcp_packet pkt;
-	void *eeprom_info_cpu_addr;
-	dma_addr_t eeprom_info_dma_addr;
-	long result;
-	int rc;
 
 	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	eeprom_info_cpu_addr =
-			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
-					max_size, &eeprom_info_dma_addr);
-	if (!eeprom_info_cpu_addr) {
-		dev_err(hdev->dev,
-			"Failed to allocate DMA memory for EEPROM info packet\n");
-		return -ENOMEM;
-	}
-
-	memset(eeprom_info_cpu_addr, 0, max_size);
-
-	memset(&pkt, 0, sizeof(pkt));
-
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_EEPROM_DATA_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.addr = cpu_to_le64(eeprom_info_dma_addr +
-				prop->host_phys_base_address);
-	pkt.data_max_size = cpu_to_le32(max_size);
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-			GOYA_ARMCP_EEPROM_TIMEOUT, &result);
-
-	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to send armcp EEPROM pkt, error %d\n", rc);
-		goto out;
-	}
-
-	/* result contains the actual size */
-	memcpy(data, eeprom_info_cpu_addr, min((size_t)result, max_size));
-
-out:
-	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, max_size,
-			eeprom_info_cpu_addr);
-
-	return rc;
+	return hl_fw_get_eeprom_data(hdev, data, max_size);
 }
 
 static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 830551b6b062..6fdc76b5bde0 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -49,9 +49,6 @@
 
 #define MAX_POWER_DEFAULT		200000		/* 200W */
 
-#define GOYA_ARMCP_INFO_TIMEOUT		10000000	/* 10s */
-#define GOYA_ARMCP_EEPROM_TIMEOUT	10000000	/* 10s */
-
 #define DRAM_PHYS_DEFAULT_SIZE		0x100000000ull	/* 4GB */
 
 /* DRAM Memory Map */
@@ -142,13 +139,6 @@
 #define HW_CAP_GOLDEN		0x00000400
 #define HW_CAP_TPC		0x00000800
 
-#define CPU_PKT_SHIFT		5
-#define CPU_PKT_SIZE		(1 << CPU_PKT_SHIFT)
-#define CPU_PKT_MASK		(~((1 << CPU_PKT_SHIFT) - 1))
-#define CPU_MAX_PKTS_IN_CB	32
-#define CPU_CB_SIZE		(CPU_PKT_SIZE * CPU_MAX_PKTS_IN_CB)
-#define CPU_ACCESSIBLE_MEM_SIZE	(HL_QUEUE_LENGTH * CPU_CB_SIZE)
-
 enum goya_fw_component {
 	FW_COMP_UBOOT,
 	FW_COMP_PREBOOT
@@ -192,7 +182,6 @@ void goya_init_security(struct hl_device *hdev);
 u64 goya_get_max_power(struct hl_device *hdev);
 void goya_set_max_power(struct hl_device *hdev, u64 value);
 
-int goya_send_pci_access_msg(struct hl_device *hdev, u32 opcode);
 void goya_late_fini(struct hl_device *hdev);
 int goya_suspend(struct hl_device *hdev);
 int goya_resume(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index a8ee52c880cd..1445ba1cafd4 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -33,6 +33,9 @@
 
 #define HL_PLL_LOW_JOB_FREQ_USEC	5000000 /* 5 s */
 
+#define HL_ARMCP_INFO_TIMEOUT_USEC	10000000 /* 10s */
+#define HL_ARMCP_EEPROM_TIMEOUT_USEC	10000000 /* 10s */
+
 #define HL_MAX_QUEUES			128
 
 #define HL_MAX_JOBS_PER_CS		64
@@ -1351,6 +1354,20 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size);
 void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
 
+int hl_fw_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
+				void __iomem *dst);
+int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode);
+int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
+				u16 len, u32 timeout, long *result);
+int hl_fw_test_cpu_queue(struct hl_device *hdev);
+void *hl_fw_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
+						dma_addr_t *dma_handle);
+void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
+					void *vaddr);
+int hl_fw_send_heartbeat(struct hl_device *hdev);
+int hl_fw_armcp_info_get(struct hl_device *hdev);
+int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
+
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
 long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index 9dddb917e72c..ccb82390241e 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -302,6 +302,14 @@ enum armcp_pwm_attributes {
 	armcp_pwm_enable
 };
 
+#define HL_CPU_PKT_SHIFT		5
+#define HL_CPU_PKT_SIZE			(1 << HL_CPU_PKT_SHIFT)
+#define HL_CPU_PKT_MASK			(~((1 << HL_CPU_PKT_SHIFT) - 1))
+#define HL_CPU_MAX_PKTS_IN_CB		32
+#define HL_CPU_CB_SIZE			(HL_CPU_PKT_SIZE * \
+					 HL_CPU_MAX_PKTS_IN_CB)
+#define HL_CPU_ACCESSIBLE_MEM_SIZE	(HL_QUEUE_LENGTH * HL_CPU_CB_SIZE)
+
 /* Event Queue Packets */
 
 struct eq_generic_event {
-- 
2.17.1

