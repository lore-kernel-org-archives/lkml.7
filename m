Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C059BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896B021874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8RHgFZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfH3K5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:57:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52696 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfH3K5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:57:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id t17so6832615wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JblrhOP2KckYCrAmRY7w2GmwW0D6OenWkyaD7huSuok=;
        b=B8RHgFZWijZkYcw+wf6Z7W9FDUamkuMz5bYwNL02UchwXLF30Gw1aCTMpTAxqZrd4r
         kw8om/Siqa9HFfjYhvNl2zTRWxyr3fA3qftJcN9dvNUqeHae5cwfVrMS4cCBLvwIBDLt
         vWt3DYm8TFK052VhbwbjjsrGmB/lmDIP3DSC9xt+OXf9JeFJ+2cTXB/Q98bburK7EBnO
         adysIcDxz6vR3r4/DGo9MxmVUZaY50Q7L3OaMJOGx9AGSTV2q5POeWbs2JXoByKnbwq1
         850gpDvVW5EeTOMgL0wN68eb64JAINJG/uhRnM1B2bK09FKdRJpnWw4Zw3EK2y4hwDjF
         2tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JblrhOP2KckYCrAmRY7w2GmwW0D6OenWkyaD7huSuok=;
        b=GGf4Woo4Lx3fSWDRpLlQA3KslPtH2zscART2ZFDi1aVwGJTRkQIIdcMV9iYMXsKV//
         InlytT/VRggwEn0cEvR/8VPrQF/hA+mg5H/7PQ//K+/yqUDVmLBK+hCO7EkAaEAyavsS
         mw93UtjSmPvsM65vI7zx67mr09ftjIjewCDI9dIeMJ3UYOxnzfDuSKaD5pQnMydOVMnJ
         D4GEK/tsUR8JjNzOn1VXChBPc8MoEGvkw/D6isr1pG+3lMUSXUUQLueyFOMaAWf10exS
         37RIIGtEKDbYxI3vv6IdQut7JusEXQjcQKrg0n0gSRLobNY1/J35bdMtUmHM17HwBwpn
         NECw==
X-Gm-Message-State: APjAAAVfweoU/sr0U9DNXbNTbd9jRknRFZHEX66hOTxzglvWXfm9TjEj
        h8UfK8yRbvXDCd2m+oeivOcQxvaI
X-Google-Smtp-Source: APXvYqxyAJqGkXtx1rrm7+tU7ffXsgel5cWrdYIc6pX4fGjdn5NYUu2A2EQ4vzoOFkP7gqKgKIB3IQ==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr17016798wmf.54.1567162623391;
        Fri, 30 Aug 2019 03:57:03 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 74sm7930892wma.15.2019.08.30.03.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 03:57:02 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: add uapi to retrieve device utilization
Date:   Fri, 30 Aug 2019 13:56:59 +0300
Message-Id: <20190830105700.8781-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users and sysadmins usually want to know what is the device utilization as
a level 0 indication if they are efficiently using the device.

Add a new opcode to the INFO IOCTL that will return the device utilization
over the last period of 100-1000ms. The return value is 0-100,
representing as percentage the total utilization rate.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c |  20 +++-
 drivers/misc/habanalabs/device.c             | 114 ++++++++++++++++++-
 drivers/misc/habanalabs/habanalabs.h         |  23 +++-
 drivers/misc/habanalabs/habanalabs_ioctl.c   |  27 +++++
 drivers/misc/habanalabs/hw_queue.c           |   8 +-
 drivers/misc/habanalabs/include/goya/goya.h  |   2 +
 include/uapi/misc/habanalabs.h               |  49 +++++---
 7 files changed, 220 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index e4dd3e83df8b..4777ec4c2b55 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -178,11 +178,23 @@ static void cs_do_release(struct kref *ref)
 
 	/* We also need to update CI for internal queues */
 	if (cs->submitted) {
-		int cs_cnt = atomic_dec_return(&hdev->cs_active_cnt);
+		hdev->asic_funcs->hw_queues_lock(hdev);
 
-		WARN_ONCE((cs_cnt < 0),
-			"hl%d: error in CS active cnt %d\n",
-			hdev->id, cs_cnt);
+		hdev->cs_active_cnt--;
+		if (!hdev->cs_active_cnt) {
+			struct hl_device_idle_busy_ts *ts;
+
+			ts = &hdev->idle_busy_ts_arr[hdev->idle_busy_ts_idx++];
+			ts->busy_to_idle_ts = ktime_get();
+
+			if (hdev->idle_busy_ts_idx == HL_IDLE_BUSY_TS_ARR_SIZE)
+				hdev->idle_busy_ts_idx = 0;
+		} else if (hdev->cs_active_cnt < 0) {
+			dev_crit(hdev->dev, "CS active cnt %d is negative\n",
+				hdev->cs_active_cnt);
+		}
+
+		hdev->asic_funcs->hw_queues_unlock(hdev);
 
 		hl_int_hw_queue_update_ci(cs);
 
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 41c3ddbca351..bc98032cc4ec 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -293,6 +293,14 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_eq_wq;
 	}
 
+	hdev->idle_busy_ts_arr = kmalloc_array(HL_IDLE_BUSY_TS_ARR_SIZE,
+					sizeof(struct hl_device_idle_busy_ts),
+					(GFP_KERNEL | __GFP_ZERO));
+	if (!hdev->idle_busy_ts_arr) {
+		rc = -ENOMEM;
+		goto free_chip_info;
+	}
+
 	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
 
 	mutex_init(&hdev->send_cpu_message_lock);
@@ -303,10 +311,11 @@ static int device_early_init(struct hl_device *hdev)
 	INIT_LIST_HEAD(&hdev->fpriv_list);
 	mutex_init(&hdev->fpriv_list_lock);
 	atomic_set(&hdev->in_reset, 0);
-	atomic_set(&hdev->cs_active_cnt, 0);
 
 	return 0;
 
+free_chip_info:
+	kfree(hdev->hl_chip_info);
 free_eq_wq:
 	destroy_workqueue(hdev->eq_wq);
 free_cq_wq:
@@ -336,6 +345,7 @@ static void device_early_fini(struct hl_device *hdev)
 
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
 
+	kfree(hdev->idle_busy_ts_arr);
 	kfree(hdev->hl_chip_info);
 
 	destroy_workqueue(hdev->eq_wq);
@@ -451,6 +461,100 @@ static void device_late_fini(struct hl_device *hdev)
 	hdev->late_init_done = false;
 }
 
+uint32_t hl_device_utilization(struct hl_device *hdev, uint32_t period_ms)
+{
+	struct hl_device_idle_busy_ts *ts;
+	ktime_t zero_ktime, curr = ktime_get();
+	u32 overlap_cnt = 0, last_index = hdev->idle_busy_ts_idx;
+	s64 period_us, last_start_us, last_end_us, last_busy_time_us,
+		total_busy_time_us = 0;
+
+	zero_ktime = ktime_set(0, 0);
+	period_us = period_ms * USEC_PER_MSEC;
+	ts = &hdev->idle_busy_ts_arr[last_index];
+
+	/* check case that device is currently in idle */
+	if (!ktime_compare(ts->busy_to_idle_ts, zero_ktime) &&
+			!ktime_compare(ts->idle_to_busy_ts, zero_ktime)) {
+
+		last_index--;
+		/* Handle case idle_busy_ts_idx was 0 */
+		if (last_index > HL_IDLE_BUSY_TS_ARR_SIZE)
+			last_index = HL_IDLE_BUSY_TS_ARR_SIZE - 1;
+
+		ts = &hdev->idle_busy_ts_arr[last_index];
+	}
+
+	while (overlap_cnt < HL_IDLE_BUSY_TS_ARR_SIZE) {
+		/* Check if we are in last sample case. i.e. if the sample
+		 * begun before the sampling period. This could be a real
+		 * sample or 0 so need to handle both cases
+		 */
+		last_start_us = ktime_to_us(
+				ktime_sub(curr, ts->idle_to_busy_ts));
+
+		if (last_start_us > period_us) {
+
+			/* First check two cases:
+			 * 1. If the device is currently busy
+			 * 2. If the device was idle during the whole sampling
+			 *    period
+			 */
+
+			if (!ktime_compare(ts->busy_to_idle_ts, zero_ktime)) {
+				/* Check if the device is currently busy */
+				if (ktime_compare(ts->idle_to_busy_ts,
+						zero_ktime))
+					return 100;
+
+				/* We either didn't have any activity or we
+				 * reached an entry which is 0. Either way,
+				 * exit and return what was accumulated so far
+				 */
+				break;
+			}
+
+			/* If sample has finished, check it is relevant */
+			last_end_us = ktime_to_us(
+					ktime_sub(curr, ts->busy_to_idle_ts));
+
+			if (last_end_us > period_us)
+				break;
+
+			/* It is relevant so add it but with adjustment */
+			last_busy_time_us = ktime_to_us(
+						ktime_sub(ts->busy_to_idle_ts,
+						ts->idle_to_busy_ts));
+			total_busy_time_us += last_busy_time_us -
+					(last_start_us - period_us);
+			break;
+		}
+
+		/* Check if the sample is finished or still open */
+		if (ktime_compare(ts->busy_to_idle_ts, zero_ktime))
+			last_busy_time_us = ktime_to_us(
+						ktime_sub(ts->busy_to_idle_ts,
+						ts->idle_to_busy_ts));
+		else
+			last_busy_time_us = ktime_to_us(
+					ktime_sub(curr, ts->idle_to_busy_ts));
+
+		total_busy_time_us += last_busy_time_us;
+
+		last_index--;
+		/* Handle case idle_busy_ts_idx was 0 */
+		if (last_index > HL_IDLE_BUSY_TS_ARR_SIZE)
+			last_index = HL_IDLE_BUSY_TS_ARR_SIZE - 1;
+
+		ts = &hdev->idle_busy_ts_arr[last_index];
+
+		overlap_cnt++;
+	};
+
+	return DIV_ROUND_UP(((total_busy_time_us / USEC_PER_MSEC) * 100),
+				period_ms);
+}
+
 /*
  * hl_device_set_frequency - set the frequency of the device
  *
@@ -808,6 +912,14 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_reset(hdev, &hdev->completion_queue[i]);
 
+	hdev->idle_busy_ts_idx = 0;
+	hdev->idle_busy_ts_arr[0].busy_to_idle_ts = ktime_set(0, 0);
+	hdev->idle_busy_ts_arr[0].idle_to_busy_ts = ktime_set(0, 0);
+
+	if (hdev->cs_active_cnt)
+		dev_crit(hdev->dev, "CS active cnt %d is not 0 during reset\n",
+			hdev->cs_active_cnt);
+
 	mutex_lock(&hdev->fpriv_list_lock);
 
 	/* Make sure the context switch phase will run again */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index a4d929f5bad8..23b86b7f9732 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -45,6 +45,8 @@
 /* MUST BE POWER OF 2 and larger than 1 */
 #define HL_MAX_PENDING_CS		64
 
+#define HL_IDLE_BUSY_TS_ARR_SIZE	4096
+
 /* Memory */
 #define MEM_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
 
@@ -1156,6 +1158,16 @@ struct hl_device_reset_work {
 	struct hl_device		*hdev;
 };
 
+/**
+ * struct hl_device_idle_busy_ts - used for calculating device utilization rate.
+ * @idle_to_busy_ts: timestamp where device changed from idle to busy.
+ * @busy_to_idle_ts: timestamp where device changed from busy to idle.
+ */
+struct hl_device_idle_busy_ts {
+	ktime_t				idle_to_busy_ts;
+	ktime_t				busy_to_idle_ts;
+};
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
@@ -1203,19 +1215,22 @@ struct hl_device_reset_work {
  *              when a user opens the device
  * @fpriv_list_lock: protects the fpriv_list
  * @compute_ctx: current compute context executing.
+ * @idle_busy_ts_arr: array to hold time stamps of transitions from idle to busy
+ *                    and vice-versa
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
  *             value is saved so in case of hard-reset, KMD will restore this
  *             value and update the F/W after the re-initialization
  * @in_reset: is device in reset flow.
+ * @curr_pll_profile: current PLL profile.
  * @cs_active_cnt: number of active command submissions on this device (active
  *                 means already in H/W queues)
- * @curr_pll_profile: current PLL profile.
  * @major: habanalabs KMD major.
  * @high_pll: high PLL profile frequency.
  * @soft_reset_cnt: number of soft reset since KMD loading.
  * @hard_reset_cnt: number of hard reset since KMD loading.
+ * @idle_busy_ts_idx: index of current entry in idle_busy_ts_arr
  * @id: device minor.
  * @id_control: minor of the control device
  * @disabled: is device disabled.
@@ -1285,16 +1300,19 @@ struct hl_device {
 
 	struct hl_ctx			*compute_ctx;
 
+	struct hl_device_idle_busy_ts	*idle_busy_ts_arr;
+
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
 	atomic_t			in_reset;
-	atomic_t			cs_active_cnt;
 	enum hl_pll_frequency		curr_pll_profile;
+	int				cs_active_cnt;
 	u32				major;
 	u32				high_pll;
 	u32				soft_reset_cnt;
 	u32				hard_reset_cnt;
+	u32				idle_busy_ts_idx;
 	u16				id;
 	u16				id_control;
 	u8				disabled;
@@ -1457,6 +1475,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 void hl_hpriv_get(struct hl_fpriv *hpriv);
 void hl_hpriv_put(struct hl_fpriv *hpriv);
 int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
+uint32_t hl_device_utilization(struct hl_device *hdev, uint32_t period_ms);
 
 int hl_build_hwmon_channel_info(struct hl_device *hdev,
 		struct armcp_sensor *sensors_arr);
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index d894873ca2d1..6325e98a5ae9 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -197,6 +197,29 @@ static int debug_coresight(struct hl_device *hdev, struct hl_debug_args *args)
 	return rc;
 }
 
+static int device_utilization(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_device_utilization device_util = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	if ((args->period_ms < 100) || (args->period_ms > 1000) ||
+		(args->period_ms % 100)) {
+		dev_err(hdev->dev,
+			"period %u must be between 100 - 1000 and must be divisible by 100\n",
+			args->period_ms);
+		return -EINVAL;
+	}
+
+	device_util.utilization = hl_device_utilization(hdev, args->period_ms);
+
+	return copy_to_user(out, &device_util,
+		min((size_t) max_size, sizeof(device_util))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -239,6 +262,10 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 		rc = hw_idle(hdev, args);
 		break;
 
+	case HL_INFO_DEVICE_UTILIZATION:
+		rc = device_utilization(hdev, args);
+		break;
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 696cf7d206c6..55b383b2a116 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -364,7 +364,13 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 		spin_unlock(&hdev->hw_queues_mirror_lock);
 	}
 
-	atomic_inc(&hdev->cs_active_cnt);
+	if (!hdev->cs_active_cnt++) {
+		struct hl_device_idle_busy_ts *ts;
+
+		ts = &hdev->idle_busy_ts_arr[hdev->idle_busy_ts_idx];
+		ts->busy_to_idle_ts = ktime_set(0, 0);
+		ts->idle_to_busy_ts = ktime_get();
+	}
 
 	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
 		if (job->ext_queue)
diff --git a/drivers/misc/habanalabs/include/goya/goya.h b/drivers/misc/habanalabs/include/goya/goya.h
index 3f02a52ba4ce..43d241891e45 100644
--- a/drivers/misc/habanalabs/include/goya/goya.h
+++ b/drivers/misc/habanalabs/include/goya/goya.h
@@ -38,4 +38,6 @@
 
 #define TPC_MAX_NUM		8
 
+#define MME_MAX_NUM		1
+
 #endif /* GOYA_H */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 266bf85056d4..73ee212d7fa6 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -77,22 +77,29 @@ enum hl_device_status {
 
 /* Opcode for management ioctl
  *
- * HW_IP_INFO         - Receive information about different IP blocks in the
- *                      device.
- * HL_INFO_HW_EVENTS  - Receive an array describing how many times each event
- *                      occurred since the last hard reset.
- * HL_INFO_DRAM_USAGE - Retrieve the dram usage inside the device and of the
- *                      specific context. This is relevant only for GOYA device.
- * HL_INFO_HW_IDLE    - Retrieve information about the idle status of each
- *                      internal engine.
+ * HW_IP_INFO            - Receive information about different IP blocks in the
+ *                         device.
+ * HL_INFO_HW_EVENTS     - Receive an array describing how many times each event
+ *                         occurred since the last hard reset.
+ * HL_INFO_DRAM_USAGE    - Retrieve the dram usage inside the device and of the
+ *                         specific context. This is relevant only for devices
+ *                         where the dram is managed by the kernel driver
+ * HL_INFO_HW_IDLE       - Retrieve information about the idle status of each
+ *                         internal engine.
  * HL_INFO_DEVICE_STATUS - Retrieve the device's status. This opcode doesn't
  *                         require an open context.
+ * HL_INFO_DEVICE_UTILIZATION - Retrieve the total utilization of the device
+ *                              over the last period specified by the user.
+ *                              The period can be between 100ms to 1s, in
+ *                              resolution of 100ms. The return value is a
+ *                              percentage of the utilization rate.
  */
-#define HL_INFO_HW_IP_INFO	0
-#define HL_INFO_HW_EVENTS	1
-#define HL_INFO_DRAM_USAGE	2
-#define HL_INFO_HW_IDLE		3
-#define HL_INFO_DEVICE_STATUS	4
+#define HL_INFO_HW_IP_INFO		0
+#define HL_INFO_HW_EVENTS		1
+#define HL_INFO_DRAM_USAGE		2
+#define HL_INFO_HW_IDLE			3
+#define HL_INFO_DEVICE_STATUS		4
+#define HL_INFO_DEVICE_UTILIZATION	6
 
 #define HL_INFO_VERSION_MAX_LEN	128
 
@@ -134,6 +141,11 @@ struct hl_info_device_status {
 	__u32 pad;
 };
 
+struct hl_info_device_utilization {
+	__u32 utilization;
+	__u32 pad;
+};
+
 struct hl_info_args {
 	/* Location of relevant struct in userspace */
 	__u64 return_pointer;
@@ -149,8 +161,15 @@ struct hl_info_args {
 	/* HL_INFO_* */
 	__u32 op;
 
-	/* Context ID - Currently not in use */
-	__u32 ctx_id;
+	union {
+		/* Context ID - Currently not in use */
+		__u32 ctx_id;
+		/* Period value for utilization rate (100ms - 1000ms, in 100ms
+		 * resolution.
+		 */
+		__u32 period_ms;
+	};
+
 	__u32 pad;
 };
 
-- 
2.17.1

