Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89118C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEB522CF4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOwCT4Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfIBHud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:50:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51136 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:50:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so1473819wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 00:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rnqm5w5Xk8peKmrwSKmbbCB3qz0ZNIOtMjC2NwLiH5s=;
        b=SOwCT4ZlStfqkLHeTC1Vwb3e5fsGvfx0IYBU7hYypj39YeTi5rwGdKOgasWPakDFkf
         OuEGjVBKSDGOl4eF3NHzu9B6AapvChIxUQIxAG7lNaYILX+5duuIOnTxv6yDcRTJwMsP
         ZjprgWi6ooFg6BhjzByd1pTxt/83yLeOur362h3D5s59rS4+kat2m6BwxiQRe8sKv45g
         dyDVw/Ms3WDc8cWrI8G2/re7yNITAgVZymQL3QkD5te2s3SY8vMu77g57MHErmIL4mw/
         FXc5W3GxNVdyuncpJseBCC58QtMTnU0xBZl9pXOXTLXorCT/PvWZRTypIzK8AQIhGL9W
         VfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rnqm5w5Xk8peKmrwSKmbbCB3qz0ZNIOtMjC2NwLiH5s=;
        b=bDc/dwUTlGc8x5+XcZO8h7XE3zI/9gqiTsntGaFR+AcNzsSIAu5tipt+HXNcbkIU4R
         Lkektf3+W3jSUHY4ovxKOk8WW7fCoWpmsHyQbMuIjhx3cw+OKZSu2zC2TCKOePs/5Mhx
         CKaThgNUGVHytBZuu2fazTnVz4TMiq0/3DzR5pKfqokRM1OFpiRuY8ZU4b++1D4jzBQl
         lQnsaRuDVkqLieqTCsumuQftp8VWWb+fyrqLRfe6NaZ6YfoEZw1zyNGph2yp4MQWj8ZE
         AsdKF4sFLkASIVGcDDS2Hz2v+uCK5rSScKuq4vFi3hXDPVzhoTSN11OtCF2yuQ5AySVM
         /nlA==
X-Gm-Message-State: APjAAAWXxZnZNVzJ9An9jVy+YRdouZw6hYzevc9otxpTCGqeeIN1X25h
        WbTWb7ma8HLwJ6lZDxKtyWh1rDEf
X-Google-Smtp-Source: APXvYqy/A4L+LGEF5j/xpvoXEwN5hH7fLtO72ZJWmB28PyyLXVqw6QqPLyU3bxb5nPcOgUrY7DBWpQ==
X-Received: by 2002:a1c:9641:: with SMTP id y62mr1141705wmd.161.1567410627450;
        Mon, 02 Sep 2019 00:50:27 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id f6sm27460510wrh.30.2019.09.02.00.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 00:50:26 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: stop using the acronym KMD
Date:   Mon,  2 Sep 2019 10:50:23 +0300
Message-Id: <20190902075024.27302-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to stop using the acronym KMD. Therefore, replace all locations
(except for register names we can't modify) where KMD is written to other
terms such as "Linux kernel driver" or "Host kernel driver", etc.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/asid.c               |  2 +-
 drivers/misc/habanalabs/command_buffer.c     |  3 +-
 drivers/misc/habanalabs/command_submission.c |  5 +-
 drivers/misc/habanalabs/context.c            |  2 +-
 drivers/misc/habanalabs/goya/goya.c          | 22 +++---
 drivers/misc/habanalabs/goya/goyaP.h         | 14 ++--
 drivers/misc/habanalabs/habanalabs.h         | 32 ++++-----
 drivers/misc/habanalabs/include/armcp_if.h   | 70 ++++++++++----------
 include/uapi/misc/habanalabs.h               | 22 +++---
 9 files changed, 88 insertions(+), 84 deletions(-)

diff --git a/drivers/misc/habanalabs/asid.c b/drivers/misc/habanalabs/asid.c
index 2c01461701a3..a2fdf31cf27c 100644
--- a/drivers/misc/habanalabs/asid.c
+++ b/drivers/misc/habanalabs/asid.c
@@ -18,7 +18,7 @@ int hl_asid_init(struct hl_device *hdev)
 
 	mutex_init(&hdev->asid_mutex);
 
-	/* ASID 0 is reserved for KMD and device CPU */
+	/* ASID 0 is reserved for the kernel driver and device CPU */
 	set_bit(0, hdev->asid_bitmap);
 
 	return 0;
diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index e495f44064fa..53fddbd8e693 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -397,7 +397,8 @@ struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size)
 	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, cb_size, &cb_handle,
 			HL_KERNEL_ASID_ID);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to allocate CB for KMD %d\n", rc);
+		dev_err(hdev->dev,
+			"Failed to allocate CB for the kernel driver %d\n", rc);
 		return NULL;
 	}
 
diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 4777ec4c2b55..a9ac045dcfde 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -409,8 +409,9 @@ static struct hl_cb *validate_queue_index(struct hl_device *hdev,
 		return NULL;
 	}
 
-	if (hw_queue_prop->kmd_only) {
-		dev_err(hdev->dev, "Queue index %d is restricted for KMD\n",
+	if (hw_queue_prop->driver_only) {
+		dev_err(hdev->dev,
+			"Queue index %d is restricted for the kernel driver\n",
 			chunk->queue_index);
 		return NULL;
 	} else if (hw_queue_prop->type == QUEUE_TYPE_INT) {
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index bc0dec57a983..17db7b3dfb4c 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -128,7 +128,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 	ctx->thread_ctx_switch_wait_token = 0;
 
 	if (is_kernel_ctx) {
-		ctx->asid = HL_KERNEL_ASID_ID; /* KMD gets ASID 0 */
+		ctx->asid = HL_KERNEL_ASID_ID; /* Kernel driver gets ASID 0 */
 		rc = hl_mmu_ctx_init(ctx);
 		if (rc) {
 			dev_err(hdev->dev, "Failed to init mmu ctx module\n");
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c88c2fea97b9..6fba14b81f90 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -42,8 +42,8 @@
  * PQ, CQ and CP are not secured.
  * PQ, CB and the data are on the SRAM/DRAM.
  *
- * Since QMAN DMA is secured, KMD is parsing the DMA CB:
- *     - KMD checks DMA pointer
+ * Since QMAN DMA is secured, the driver is parsing the DMA CB:
+ *     - checks DMA pointer
  *     - WREG, MSG_PROT are not allowed.
  *     - MSG_LONG/SHORT are allowed.
  *
@@ -56,15 +56,15 @@
  * QMAN DMA: PQ, CQ and CP are secured.
  * MMU is set to bypass on the Secure props register of the QMAN.
  * The reasons we don't enable MMU for PQ, CQ and CP are:
- *     - PQ entry is in kernel address space and KMD doesn't map it.
+ *     - PQ entry is in kernel address space and the driver doesn't map it.
  *     - CP writes to MSIX register and to kernel address space (completion
  *       queue).
  *
- * DMA is not secured but because CP is secured, KMD still needs to parse the
- * CB, but doesn't need to check the DMA addresses.
+ * DMA is not secured but because CP is secured, the driver still needs to parse
+ * the CB, but doesn't need to check the DMA addresses.
  *
- * For QMAN DMA 0, DMA is also secured because only KMD uses this DMA and KMD
- * doesn't map memory in MMU.
+ * For QMAN DMA 0, DMA is also secured because only the driver uses this DMA and
+ * the driver doesn't map memory in MMU.
  *
  * QMAN TPC/MME: PQ, CQ and CP aren't secured (no change from MMU disabled mode)
  *
@@ -336,18 +336,18 @@ void goya_get_fixed_properties(struct hl_device *hdev)
 
 	for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++) {
 		prop->hw_queues_props[i].type = QUEUE_TYPE_EXT;
-		prop->hw_queues_props[i].kmd_only = 0;
+		prop->hw_queues_props[i].driver_only = 0;
 	}
 
 	for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES ; i++) {
 		prop->hw_queues_props[i].type = QUEUE_TYPE_CPU;
-		prop->hw_queues_props[i].kmd_only = 1;
+		prop->hw_queues_props[i].driver_only = 1;
 	}
 
 	for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES +
 			NUMBER_OF_INT_HW_QUEUES; i++) {
 		prop->hw_queues_props[i].type = QUEUE_TYPE_INT;
-		prop->hw_queues_props[i].kmd_only = 0;
+		prop->hw_queues_props[i].driver_only = 0;
 	}
 
 	for (; i < HL_MAX_QUEUES; i++)
@@ -2853,7 +2853,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 
 	if (!hdev->asic_funcs->is_device_idle(hdev, NULL, NULL)) {
 		dev_err_ratelimited(hdev->dev,
-			"Can't send KMD job on QMAN0 because the device is not idle\n");
+			"Can't send driver job on QMAN0 because the device is not idle\n");
 		return -EBUSY;
 	}
 
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 06da71e8d7ea..89b6574f8e4f 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -70,19 +70,19 @@
 						MMU_PAGE_TABLES_SIZE)
 #define MMU_CACHE_MNG_ADDR		(MMU_DRAM_DEFAULT_PAGE_ADDR + \
 					MMU_DRAM_DEFAULT_PAGE_SIZE)
-#define DRAM_KMD_END_ADDR		(MMU_CACHE_MNG_ADDR + \
+#define DRAM_DRIVER_END_ADDR		(MMU_CACHE_MNG_ADDR + \
 						MMU_CACHE_MNG_SIZE)
 
 #define DRAM_BASE_ADDR_USER		0x20000000
 
-#if (DRAM_KMD_END_ADDR > DRAM_BASE_ADDR_USER)
-#error "KMD must reserve no more than 512MB"
+#if (DRAM_DRIVER_END_ADDR > DRAM_BASE_ADDR_USER)
+#error "Driver must reserve no more than 512MB"
 #endif
 
 /*
- * SRAM Memory Map for KMD
+ * SRAM Memory Map for Driver
  *
- * KMD occupies KMD_SRAM_SIZE bytes from the start of SRAM. It is used for
+ * Driver occupies DRIVER_SRAM_SIZE bytes from the start of SRAM. It is used for
  * MME/TPC QMANs
  *
  */
@@ -108,10 +108,10 @@
 #define TPC7_QMAN_BASE_OFFSET	(TPC6_QMAN_BASE_OFFSET + \
 				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
 
-#define SRAM_KMD_RES_OFFSET	(TPC7_QMAN_BASE_OFFSET + \
+#define SRAM_DRIVER_RES_OFFSET	(TPC7_QMAN_BASE_OFFSET + \
 				(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE))
 
-#if (SRAM_KMD_RES_OFFSET >= GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START)
+#if (SRAM_DRIVER_RES_OFFSET >= GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START)
 #error "MME/TPC QMANs SRAM space exceeds limit"
 #endif
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index aa7aaa710f12..c39e07d665c4 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -96,12 +96,12 @@ enum hl_queue_type {
 /**
  * struct hw_queue_properties - queue information.
  * @type: queue type.
- * @kmd_only: true if only KMD is allowed to send a job to this queue, false
- *            otherwise.
+ * @driver_only: true if only the driver is allowed to send a job to this queue,
+ *               false otherwise.
  */
 struct hw_queue_properties {
 	enum hl_queue_type	type;
-	u8			kmd_only;
+	u8			driver_only;
 };
 
 /**
@@ -324,7 +324,7 @@ struct hl_cs_job;
 #define HL_EQ_LENGTH			64
 #define HL_EQ_SIZE_IN_BYTES		(HL_EQ_LENGTH * HL_EQ_ENTRY_SIZE)
 
-/* KMD <-> ArmCP shared memory size */
+/* Host <-> ArmCP shared memory size */
 #define HL_CPU_ACCESSIBLE_MEM_SIZE	SZ_2M
 
 /**
@@ -405,7 +405,7 @@ struct hl_cs_parser;
 
 /**
  * enum hl_pm_mng_profile - power management profile.
- * @PM_AUTO: internal clock is set by KMD.
+ * @PM_AUTO: internal clock is set by the Linux driver.
  * @PM_MANUAL: internal clock is set by the user.
  * @PM_LAST: last power management type.
  */
@@ -613,7 +613,7 @@ struct hl_va_range {
  *		descriptor (hl_vm_phys_pg_list or hl_userptr).
  * @mmu_phys_hash: holds a mapping from physical address to pgt_info structure.
  * @mmu_shadow_hash: holds a mapping from shadow address to pgt_info structure.
- * @hpriv: pointer to the private (KMD) data of the process (fd).
+ * @hpriv: pointer to the private (Kernel Driver) data of the process (fd).
  * @hdev: pointer to the device structure.
  * @refcount: reference counter for the context. Context is released only when
  *		this hits 0l. It is incremented on CS and CS_WAIT.
@@ -1185,19 +1185,19 @@ struct hl_device_idle_busy_ts {
  * @completion_queue: array of hl_cq.
  * @cq_wq: work queue of completion queues for executing work in process context
  * @eq_wq: work queue of event queue for executing work in process context.
- * @kernel_ctx: KMD context structure.
+ * @kernel_ctx: Kernel driver context structure.
  * @kernel_queues: array of hl_hw_queue.
  * @hw_queues_mirror_list: CS mirror list for TDR.
  * @hw_queues_mirror_lock: protects hw_queues_mirror_list.
  * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CGs.
  * @event_queue: event queue for IRQ from ArmCP.
  * @dma_pool: DMA pool for small allocations.
- * @cpu_accessible_dma_mem: KMD <-> ArmCP shared memory CPU address.
- * @cpu_accessible_dma_address: KMD <-> ArmCP shared memory DMA address.
- * @cpu_accessible_dma_pool: KMD <-> ArmCP shared memory pool.
+ * @cpu_accessible_dma_mem: Host <-> ArmCP shared memory CPU address.
+ * @cpu_accessible_dma_address: Host <-> ArmCP shared memory DMA address.
+ * @cpu_accessible_dma_pool: Host <-> ArmCP shared memory pool.
  * @asid_bitmap: holds used/available ASIDs.
  * @asid_mutex: protects asid_bitmap.
- * @send_cpu_message_lock: enforces only one message in KMD <-> ArmCP queue.
+ * @send_cpu_message_lock: enforces only one message in Host <-> ArmCP queue.
  * @debug_lock: protects critical section of setting debug mode for device
  * @asic_prop: ASIC specific immutable properties.
  * @asic_funcs: ASIC specific functions.
@@ -1221,16 +1221,16 @@ struct hl_device_idle_busy_ts {
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
- *             value is saved so in case of hard-reset, KMD will restore this
- *             value and update the F/W after the re-initialization
+ *             value is saved so in case of hard-reset, the driver will restore
+ *             this value and update the F/W after the re-initialization
  * @in_reset: is device in reset flow.
  * @curr_pll_profile: current PLL profile.
  * @cs_active_cnt: number of active command submissions on this device (active
  *                 means already in H/W queues)
- * @major: habanalabs KMD major.
+ * @major: habanalabs kernel driver major.
  * @high_pll: high PLL profile frequency.
- * @soft_reset_cnt: number of soft reset since KMD loading.
- * @hard_reset_cnt: number of hard reset since KMD loading.
+ * @soft_reset_cnt: number of soft reset since the driver was loaded.
+ * @hard_reset_cnt: number of hard reset since the driver was loaded.
  * @idle_busy_ts_idx: index of current entry in idle_busy_ts_arr
  * @id: device minor.
  * @id_control: minor of the control device
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index 5565bce60bc9..e4c6699a1868 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -41,33 +41,34 @@ enum pq_init_status {
 /*
  * ArmCP Primary Queue Packets
  *
- * During normal operation, KMD needs to send various messages to ArmCP,
- * usually either to SET some value into a H/W periphery or to GET the current
- * value of some H/W periphery. For example, SET the frequency of MME/TPC and
- * GET the value of the thermal sensor.
- *
- * These messages can be initiated either by the User application or by KMD
- * itself, e.g. power management code. In either case, the communication from
- * KMD to ArmCP will *always* be in synchronous mode, meaning that KMD will
- * send a single message and poll until the message was acknowledged and the
- * results are ready (if results are needed).
- *
- * This means that only a single message can be sent at a time and KMD must
- * wait for its result before sending the next message. Having said that,
- * because these are control messages which are sent in a relatively low
+ * During normal operation, the host's kernel driver needs to send various
+ * messages to ArmCP, usually either to SET some value into a H/W periphery or
+ * to GET the current value of some H/W periphery. For example, SET the
+ * frequency of MME/TPC and GET the value of the thermal sensor.
+ *
+ * These messages can be initiated either by the User application or by the
+ * host's driver itself, e.g. power management code. In either case, the
+ * communication from the host's driver to ArmCP will *always* be in
+ * synchronous mode, meaning that the host will send a single message and poll
+ * until the message was acknowledged and the results are ready (if results are
+ * needed).
+ *
+ * This means that only a single message can be sent at a time and the host's
+ * driver must wait for its result before sending the next message. Having said
+ * that, because these are control messages which are sent in a relatively low
  * frequency, this limitation seems acceptable. It's important to note that
  * in case of multiple devices, messages to different devices *can* be sent
  * at the same time.
  *
  * The message, inputs/outputs (if relevant) and fence object will be located
- * on the device DDR at an address that will be determined by KMD. During
- * device initialization phase, KMD will pass to ArmCP that address.  Most of
- * the message types will contain inputs/outputs inside the message itself.
- * The common part of each message will contain the opcode of the message (its
- * type) and a field representing a fence object.
- *
- * When KMD wishes to send a message to ArmCP, it will write the message
- * contents to the device DDR, clear the fence object and then write the
+ * on the device DDR at an address that will be determined by the host's driver.
+ * During device initialization phase, the host will pass to ArmCP that address.
+ * Most of the message types will contain inputs/outputs inside the message
+ * itself. The common part of each message will contain the opcode of the
+ * message (its type) and a field representing a fence object.
+ *
+ * When the host's driver wishes to send a message to ArmCP, it will write the
+ * message contents to the device DDR, clear the fence object and then write the
  * value 484 to the mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR register to issue
  * the 484 interrupt-id to the ARM core.
  *
@@ -78,12 +79,13 @@ enum pq_init_status {
  * device DDR and then write to the fence object. If an error occurred, ArmCP
  * will fill the rc field with the right error code.
  *
- * In the meantime, KMD will poll on the fence object. Once KMD sees that the
- * fence object is signaled, it will read the results from the device DDR
- * (if relevant) and resume the code execution in KMD.
+ * In the meantime, the host's driver will poll on the fence object. Once the
+ * host sees that the fence object is signaled, it will read the results from
+ * the device DDR (if relevant) and resume the code execution in the host's
+ * driver.
  *
  * To use QMAN packets, the opcode must be the QMAN opcode, shifted by 8
- * so the value being put by the KMD matches the value read by ArmCP
+ * so the value being put by the host's driver matches the value read by ArmCP
  *
  * Non-QMAN packets should be limited to values 1 through (2^8 - 1)
  *
@@ -148,9 +150,9 @@ enum pq_init_status {
  *
  * ARMCP_PACKET_INFO_GET -
  *       Fetch information from the device as specified in the packet's
- *       structure. KMD passes the max size it allows the ArmCP to write to
- *       the structure, to prevent data corruption in case of mismatched
- *       KMD/FW versions.
+ *       structure. The host's driver passes the max size it allows the ArmCP to
+ *       write to the structure, to prevent data corruption in case of
+ *       mismatched driver/FW versions.
  *
  * ARMCP_PACKET_FLASH_PROGRAM_REMOVED - this packet was removed
  *
@@ -183,9 +185,9 @@ enum pq_init_status {
  * ARMCP_PACKET_EEPROM_DATA_GET -
  *       Get EEPROM data from the ArmCP kernel. The buffer is specified in the
  *       addr field. The CPU will put the returned data size in the result
- *       field. In addition, KMD passes the max size it allows the ArmCP to
- *       write to the structure, to prevent data corruption in case of
- *       mismatched KMD/FW versions.
+ *       field. In addition, the host's driver passes the max size it allows the
+ *       ArmCP to write to the structure, to prevent data corruption in case of
+ *       mismatched driver/FW versions.
  *
  */
 
@@ -231,7 +233,7 @@ struct armcp_packet {
 
 	__le32 ctl;
 
-	__le32 fence;		/* Signal to KMD that message is completed */
+	__le32 fence;		/* Signal to host that message is completed */
 
 	union {
 		struct {/* For temperature/current/voltage/fan/pwm get/set */
@@ -320,7 +322,7 @@ struct armcp_sensor {
 };
 
 /**
- * struct armcp_info - host driver's necessary info from ArmCP.
+ * struct armcp_info - Info from ArmCP that is necessary to the host's driver
  * @sensors: available sensors description.
  * @kernel_version: ArmCP linux kernel version.
  * @reserved: reserved field.
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 19f8039db2ea..39c4ea51a719 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  *
- * Copyright 2016-2018 HabanaLabs, Ltd.
+ * Copyright 2016-2019 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -329,12 +329,12 @@ struct hl_mem_in {
 		struct {
 			/*
 			 * Requested virtual address of mapped memory.
-			 * KMD will try to map the requested region to this
-			 * hint address, as long as the address is valid and
-			 * not already mapped. The user should check the
+			 * The driver will try to map the requested region to
+			 * this hint address, as long as the address is valid
+			 * and not already mapped. The user should check the
 			 * returned address of the IOCTL to make sure he got
-			 * the hint address. Passing 0 here means that KMD
-			 * will choose the address itself.
+			 * the hint address. Passing 0 here means that the
+			 * driver will choose the address itself.
 			 */
 			__u64 hint_addr;
 			/* Handle returned from HL_MEM_OP_ALLOC */
@@ -347,12 +347,12 @@ struct hl_mem_in {
 			__u64 host_virt_addr;
 			/*
 			 * Requested virtual address of mapped memory.
-			 * KMD will try to map the requested region to this
-			 * hint address, as long as the address is valid and
-			 * not already mapped. The user should check the
+			 * The driver will try to map the requested region to
+			 * this hint address, as long as the address is valid
+			 * and not already mapped. The user should check the
 			 * returned address of the IOCTL to make sure he got
-			 * the hint address. Passing 0 here means that KMD
-			 * will choose the address itself.
+			 * the hint address. Passing 0 here means that the
+			 * driver will choose the address itself.
 			 */
 			__u64 hint_addr;
 			/* Size of allocated host memory */
-- 
2.17.1

