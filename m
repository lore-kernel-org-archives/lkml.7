Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F32EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF09020874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP+eRJvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfDVKJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:09:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41492 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVKJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:09:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so9083184wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JC4hWZcbjeS3SRdxWazevYDpsx2C0ooIBNLLgiI/PSU=;
        b=nP+eRJvfn1LNInhKekVqag01V5EYoKnTzt1bgPNHQ0b9E8DgP0Q1v+KhpWialrz1mY
         +KUnaVkGO96qilWrTwbGX1eYQ/lzyM0bUo2qA2uWjyQ1QsCKiv+UgSAjoSyrw0nbLJHe
         WL9LbuzBkGvffN4a5vsmO+KeH6XKTtTqKvCjR6FDgecvt2ykLgLK7qOHlyOYM4Nt9Uab
         MSBdm0idtv//o9VsuxbXiJ6zNi7JL3fsE89CXwb5zMB8O1sa6PEwJsk6SbBX1/LpRGs4
         6NGxY2FP2r8SvSoAbmQTJoyfctoHi1evgRYanY5SyTOSE6Jv7RwKu/FP9BrY/sqVsV1A
         5MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JC4hWZcbjeS3SRdxWazevYDpsx2C0ooIBNLLgiI/PSU=;
        b=W5faFNkaalPqDgRd2erYnaG58/GCvLwYrBJN9VqPTSVBqur7n472tVP0d+M7OqBP1L
         k4cmJ22jodrz6cL2HovouXeHFGg7OrsayK8Yl2rSjk1t4sq2mLhiEMZxoVQ9v8+4aecW
         h59QiL83kvCGKb8x53D1DwdmMG3uMw6qEq5klyCuv1c/DS7Z1omIUFrC8KlIdoAO9cnN
         8BWXCP2DUAQP16tR3rX/ESRaFKuognLprjoUp6cEnytNZJoCTOG7qAkju5s/UBIeIHv/
         aJPd79HxrLzUcqMT8hTDHriTXVwzs6cVH/k5xtU7DZxuCnB3UaBE9Z//+4RQ/ymhOhzy
         7EJg==
X-Gm-Message-State: APjAAAVsVo7YOc5Hl3Eo29Pr+2gOTgHhh5d/Sy3Vg3oa7k1dRZDUfw1u
        H/6XcvoPE4eyuLxINksHdhGKVVfU
X-Google-Smtp-Source: APXvYqyS3cO+hyrL062naFsQ17YqpKcZYc9RuOBaIx3ixtXYqRe2zW5tQWBI7U8mCr0U4Cld1V7ACg==
X-Received: by 2002:adf:d848:: with SMTP id k8mr13664118wrl.185.1555927752151;
        Mon, 22 Apr 2019 03:09:12 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id g84sm16160559wmf.25.2019.04.22.03.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 03:09:11 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: use ASIC functions interface for rreg/wreg
Date:   Mon, 22 Apr 2019 13:09:09 +0300
Message-Id: <20190422100909.5230-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch slightly changes the macros of RREG32 and WREG32, which are
used when reading or writing from registers.

Instead of directly calling a function in the common code from these
macros, the new code calls a function from the ASIC functions interface.

This change allows us to share much more code between real ASICs and
simulators, which in turn reduces the maintenance burden and
the chances for forgetting to port code between the ASIC files.

The patch also implements the hl_poll_timeout macro, instead of calling
the generic readl_poll_timeout macro. This is required to allow use of
this macro in the simulator files.

As a result from this change, more functions in goya.c are shared with the
simulator and therefore, should not be defined as static.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - Remove static from some functions as goya.c as they are now called
    from the simulator code (which is not upstreamed).
 
 drivers/misc/habanalabs/goya/goya.c  | 32 +++++++++++------------
 drivers/misc/habanalabs/goya/goyaP.h | 38 +++++++++++++++++++---------
 drivers/misc/habanalabs/habanalabs.h | 32 ++++++++++++++++++-----
 3 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3f707e8c408a..984c854d2932 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -297,7 +297,7 @@ static u32 goya_all_events[] = {
 	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4
 };
 
-static void goya_get_fixed_properties(struct hl_device *hdev)
+void goya_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int i;
@@ -648,9 +648,6 @@ static int goya_sw_init(struct hl_device *hdev)
 	goya->tpc_clk = GOYA_PLL_FREQ_LOW;
 	goya->ic_clk = GOYA_PLL_FREQ_LOW;
 
-	goya->mmu_prepare_reg = goya_mmu_prepare_reg;
-	goya->qman0_set_security = goya_qman0_set_security;
-
 	hdev->asic_specific = goya;
 
 	/* Create DMA pool for small allocations */
@@ -815,7 +812,7 @@ static void goya_init_dma_ch(struct hl_device *hdev, int dma_id)
  * Initialize the H/W registers of the QMAN DMA channels
  *
  */
-static void goya_init_dma_qmans(struct hl_device *hdev)
+void goya_init_dma_qmans(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct hl_hw_queue *q;
@@ -968,7 +965,7 @@ static int goya_stop_external_queues(struct hl_device *hdev)
  * Returns 0 on success
  *
  */
-static int goya_init_cpu_queues(struct hl_device *hdev)
+int goya_init_cpu_queues(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct hl_eq *eq;
@@ -1549,7 +1546,7 @@ static void goya_init_mme_cmdq(struct hl_device *hdev)
 	WREG32(mmMME_CMDQ_GLBL_CFG0, CMDQ_MME_ENABLE);
 }
 
-static void goya_init_mme_qmans(struct hl_device *hdev)
+void goya_init_mme_qmans(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	u32 so_base_lo, so_base_hi;
@@ -1656,7 +1653,7 @@ static void goya_init_tpc_cmdq(struct hl_device *hdev, int tpc_id)
 	WREG32(mmTPC0_CMDQ_GLBL_CFG0 + reg_off, CMDQ_TPC_ENABLE);
 }
 
-static void goya_init_tpc_qmans(struct hl_device *hdev)
+void goya_init_tpc_qmans(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	u32 so_base_lo, so_base_hi;
@@ -2373,7 +2370,7 @@ static int goya_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid,
 	return 0;
 }
 
-static int goya_mmu_init(struct hl_device *hdev)
+int goya_mmu_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct goya_device *goya = hdev->asic_specific;
@@ -2649,7 +2646,7 @@ static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 	return rc;
 }
 
-static void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
+void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 {
 	u32 db_reg_offset, db_value;
 	bool invalid_queue = false;
@@ -2816,7 +2813,6 @@ void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 
 static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 {
-	struct goya_device *goya = hdev->asic_specific;
 	struct packet_msg_prot *fence_pkt;
 	u32 *fence_ptr;
 	dma_addr_t fence_dma_addr;
@@ -2847,7 +2843,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 
 	*fence_ptr = 0;
 
-	goya->qman0_set_security(hdev, true);
+	goya_qman0_set_security(hdev, true);
 
 	/*
 	 * goya cs parser saves space for 2xpacket_msg_prot at end of CB. For
@@ -2889,7 +2885,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	hdev->asic_funcs->dma_pool_free(hdev, (void *) fence_ptr,
 					fence_dma_addr);
 
-	goya->qman0_set_security(hdev, false);
+	goya_qman0_set_security(hdev, false);
 
 	return rc;
 }
@@ -3927,12 +3923,12 @@ void goya_add_end_of_cb_packets(u64 kernel_address, u32 len, u64 cq_addr,
 	cq_pkt->addr = cpu_to_le64(CFG_BASE + mmPCIE_DBI_MSIX_DOORBELL_OFF);
 }
 
-static void goya_update_eq_ci(struct hl_device *hdev, u32 val)
+void goya_update_eq_ci(struct hl_device *hdev, u32 val)
 {
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_6, val);
 }
 
-static void goya_restore_phase_topology(struct hl_device *hdev)
+void goya_restore_phase_topology(struct hl_device *hdev)
 {
 	int i, num_of_sob_in_longs, num_of_mon_in_longs;
 
@@ -4556,7 +4552,7 @@ void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
 
 	/* zero the MMBP and ASID bits and then set the ASID */
 	for (i = 0 ; i < GOYA_MMU_REGS_NUM ; i++)
-		goya->mmu_prepare_reg(hdev, goya_mmu_regs[i], asid);
+		goya_mmu_prepare_reg(hdev, goya_mmu_regs[i], asid);
 }
 
 static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard)
@@ -4829,7 +4825,9 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_hw_state = goya_get_hw_state,
 	.pci_bars_map = goya_pci_bars_map,
 	.set_dram_bar_base = goya_set_ddr_bar_base,
-	.init_iatu = goya_init_iatu
+	.init_iatu = goya_init_iatu,
+	.rreg = hl_rreg,
+	.wreg = hl_wreg
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index b572e0263ac5..d20f84bc1962 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -147,9 +147,6 @@ enum goya_fw_component {
 };
 
 struct goya_device {
-	void (*mmu_prepare_reg)(struct hl_device *hdev, u64 reg, u32 asid);
-	void (*qman0_set_security)(struct hl_device *hdev, bool secure);
-
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t	hw_queues_lock;
 
@@ -162,13 +159,32 @@ struct goya_device {
 	u32		hw_cap_initialized;
 };
 
+void goya_get_fixed_properties(struct hl_device *hdev);
+int goya_mmu_init(struct hl_device *hdev);
+void goya_init_dma_qmans(struct hl_device *hdev);
+void goya_init_mme_qmans(struct hl_device *hdev);
+void goya_init_tpc_qmans(struct hl_device *hdev);
+int goya_init_cpu_queues(struct hl_device *hdev);
+void goya_init_security(struct hl_device *hdev);
+void goya_late_fini(struct hl_device *hdev);
+
+void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
+void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val);
+void goya_update_eq_ci(struct hl_device *hdev, u32 val);
+void goya_restore_phase_topology(struct hl_device *hdev);
+
 int goya_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus,
 			u8 i2c_addr, u8 i2c_reg, u32 *val);
 int goya_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus,
 			u8 i2c_addr, u8 i2c_reg, u32 val);
+void goya_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state);
+
+int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id);
+int goya_test_queues(struct hl_device *hdev);
 int goya_test_cpu_queue(struct hl_device *hdev);
 int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 				u32 timeout, long *result);
+
 long goya_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
 long goya_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr);
 long goya_get_current(struct hl_device *hdev, int sensor_index, u32 attr);
@@ -176,33 +192,31 @@ long goya_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr);
 long goya_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr);
 void goya_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 			long value);
-void goya_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state);
+u64 goya_get_max_power(struct hl_device *hdev);
+void goya_set_max_power(struct hl_device *hdev, u64 value);
+
 void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 void goya_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
 int goya_armcp_info_get(struct hl_device *hdev);
-void goya_init_security(struct hl_device *hdev);
 int goya_debug_coresight(struct hl_device *hdev, void *data);
-u64 goya_get_max_power(struct hl_device *hdev);
-void goya_set_max_power(struct hl_device *hdev, u64 value);
-int goya_test_queues(struct hl_device *hdev);
+
 void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
 int goya_mmu_clear_pgt_range(struct hl_device *hdev);
 int goya_mmu_set_dram_default_page(struct hl_device *hdev);
 
-void goya_late_fini(struct hl_device *hdev);
 int goya_suspend(struct hl_device *hdev);
 int goya_resume(struct hl_device *hdev);
-void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val);
+
 void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry);
 void *goya_get_events_stat(struct hl_device *hdev, u32 *size);
+
 void goya_add_end_of_cb_packets(u64 kernel_address, u32 len, u64 cq_addr,
 				u32 cq_val, u32 msix_vec);
 int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser);
 void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
-		dma_addr_t *dma_handle,	u16 *queue_len);
+				dma_addr_t *dma_handle,	u16 *queue_len);
 u32 goya_get_dma_desc_list_size(struct hl_device *hdev, struct sg_table *sgt);
-int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id);
 int goya_send_heartbeat(struct hl_device *hdev);
 void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 86bd5298efd6..e8bbaf0f26c1 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -489,6 +489,8 @@ enum hl_pll_frequency {
  * @pci_bars_map: Map PCI BARs.
  * @set_dram_bar_base: Set DRAM BAR to map specific device address.
  * @init_iatu: Initialize the iATU unit inside the PCI controller.
+ * @rreg: Read a register. Needed for simulator support.
+ * @wreg: Write a register. Needed for simulator support.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -564,6 +566,8 @@ struct hl_asic_funcs {
 	int (*pci_bars_map)(struct hl_device *hdev);
 	int (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
 	int (*init_iatu)(struct hl_device *hdev);
+	u32 (*rreg)(struct hl_device *hdev, u32 reg);
+	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
 };
 
 
@@ -1007,13 +1011,10 @@ struct hl_dbg_device_entry {
 u32 hl_rreg(struct hl_device *hdev, u32 reg);
 void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 
-#define hl_poll_timeout(hdev, addr, val, cond, sleep_us, timeout_us) \
-	readl_poll_timeout(hdev->rmmio + addr, val, cond, sleep_us, timeout_us)
-
-#define RREG32(reg) hl_rreg(hdev, (reg))
-#define WREG32(reg, v) hl_wreg(hdev, (reg), (v))
+#define RREG32(reg) hdev->asic_funcs->rreg(hdev, (reg))
+#define WREG32(reg, v) hdev->asic_funcs->wreg(hdev, (reg), (v))
 #define DREG32(reg) pr_info("REGISTER: " #reg " : 0x%08X\n",	\
-				hl_rreg(hdev, (reg)))
+			hdev->asic_funcs->rreg(hdev, (reg)))
 
 #define WREG32_P(reg, val, mask)				\
 	do {							\
@@ -1031,6 +1032,25 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	WREG32(mm##reg, (RREG32(mm##reg) & ~REG_FIELD_MASK(reg, field)) | \
 			(val) << REG_FIELD_SHIFT(reg, field))
 
+#define hl_poll_timeout(hdev, addr, val, cond, sleep_us, timeout_us) \
+({ \
+	ktime_t __timeout = ktime_add_us(ktime_get(), timeout_us); \
+	might_sleep_if(sleep_us); \
+	for (;;) { \
+		(val) = RREG32(addr); \
+		if (cond) \
+			break; \
+		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) { \
+			(val) = RREG32(addr); \
+			break; \
+		} \
+		if (sleep_us) \
+			usleep_range((sleep_us >> 2) + 1, sleep_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+
+
 #define HL_ENG_BUSY(buf, size, fmt, ...) ({ \
 		if (buf) \
 			snprintf(buf, size, fmt, ##__VA_ARGS__); \
-- 
2.17.1

