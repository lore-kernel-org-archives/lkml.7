Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D41C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0271218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKGI4wPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfCPUnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 16:43:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34765 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfCPUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 16:43:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so11559825wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=idG1/cY0XLoPpmCgEb5uVgBKDvUOMac2Yl6W5iCiK8M=;
        b=EKGI4wPE1rZNzq6VGYvOIrxVJVpuWC/AYvqb8nk12+w1v4a/LkoNGwSwS8L9/b/jOo
         vdXdOJ7M2Ms/PcM9ybzxsgCJtxJO1wzP+n3EsCgnHjDjdfLQ6+DJZ10bIjTXyHZCHg/0
         lmIHnZ0vapzt5vRGqxAjMUqnqO6tb1Y2cWtp2KYbMjaBuiJtWbxWO45JFHqQBomVYUJW
         WdZZnYpxpcP8YaHkOkx8ADSABOh8EuHrdRmc5mDjCFiGcoE28WFyAl0G58YR5u3SzC3Y
         oUAQbEUVyOy0ODERP0ce/kA1c/xku1/YXb6KGG6qi4VlKZNyU2pW2YuU9TFV5nRVg7A7
         Q0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=idG1/cY0XLoPpmCgEb5uVgBKDvUOMac2Yl6W5iCiK8M=;
        b=bXk6X7IWA5KDaKCO5CINXInva36x7sOErNOCFIYVyPj2Qzr6RXatNT18K0OhYFMGsx
         kKEgjMkezdewiPJLhL87CiwloDWoNlQkcgamHnNriQ4wcZJlQJCaFN0H6ykly2tI5UtV
         oL5ZdHUlCaJ0pE94OCxK6lmaBckJc9cev9QqYKm9SCPcbUirLng2dUrlFLhoGy1HSkYa
         wJ7FyEbcYkGOlDLFlmqYpfEizVybMQrtAT6FR96dAA2eaBRCP31uRHGx1jxdN5x3c/dk
         X1J9wSBNDs6ldwvi2snMG0oTze8y95gUNQfczvqcbs96h0T8voUt3He+FqOakO/JwH1f
         jKqQ==
X-Gm-Message-State: APjAAAUnk99m46o1aVGfsf8lI/MyJV24aM2PZoW+Ig3BOMDuKdCXLuK0
        qEFL9OiXg/MrGSXIyfvUxLVTm3Xo
X-Google-Smtp-Source: APXvYqwLZu0JYuxyaqcOeFw9yn1SsWV5HRwUa4umHdX4r4nOo+V1kYuPqsNz7ysz4bMhs1U8NJUvYA==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr6404291wmi.104.1552769000008;
        Sat, 16 Mar 2019 13:43:20 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id y7sm8684315wmi.34.2019.03.16.13.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 13:43:19 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/3] habanalabs: perform accounting for active CS
Date:   Sat, 16 Mar 2019 22:43:15 +0200
Message-Id: <20190316204317.28279-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds accounting for active CS. Active means that the CS was
submitted to the H/W queues and was not completed yet.

This is necessary to support suspend operation. Because the device will be
reset upon suspend, we can only suspend after all active CS have been
completed. Hence, we need to perform accounting on their number.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c |  6 ++++++
 drivers/misc/habanalabs/device.c             |  1 +
 drivers/misc/habanalabs/habanalabs.h         | 13 ++++++++-----
 drivers/misc/habanalabs/hw_queue.c           |  5 +++--
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 3525236ed8d9..19c84214a7ea 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -179,6 +179,12 @@ static void cs_do_release(struct kref *ref)
 
 	/* We also need to update CI for internal queues */
 	if (cs->submitted) {
+		int cs_cnt = atomic_dec_return(&hdev->cs_active_cnt);
+
+		WARN_ONCE((cs_cnt < 0),
+			"hl%d: error in CS active cnt %d\n",
+			hdev->id, cs_cnt);
+
 		hl_int_hw_queue_update_ci(cs);
 
 		spin_lock(&hdev->hw_queues_mirror_lock);
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 93d67983ddba..470d8005b50e 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -218,6 +218,7 @@ static int device_early_init(struct hl_device *hdev)
 	spin_lock_init(&hdev->hw_queues_mirror_lock);
 	atomic_set(&hdev->in_reset, 0);
 	atomic_set(&hdev->fd_open_cnt, 0);
+	atomic_set(&hdev->cs_active_cnt, 0);
 
 	return 0;
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 806f0a5ee4d8..a8ee52c880cd 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1056,13 +1056,15 @@ struct hl_device_reset_work {
  * @cb_pool_lock: protects the CB pool.
  * @user_ctx: current user context executing.
  * @dram_used_mem: current DRAM memory consumption.
- * @in_reset: is device in reset flow.
- * @curr_pll_profile: current PLL profile.
- * @fd_open_cnt: number of open user processes.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
  *             value is saved so in case of hard-reset, KMD will restore this
  *             value and update the F/W after the re-initialization
+ * @in_reset: is device in reset flow.
+ * @curr_pll_profile: current PLL profile.
+ * @fd_open_cnt: number of open user processes.
+ * @cs_active_cnt: number of active command submissions on this device (active
+ *                 means already in H/W queues)
  * @major: habanalabs KMD major.
  * @high_pll: high PLL profile frequency.
  * @soft_reset_cnt: number of soft reset since KMD loading.
@@ -1128,11 +1130,12 @@ struct hl_device {
 	struct hl_ctx			*user_ctx;
 
 	atomic64_t			dram_used_mem;
+	u64				timeout_jiffies;
+	u64				max_power;
 	atomic_t			in_reset;
 	atomic_t			curr_pll_profile;
 	atomic_t			fd_open_cnt;
-	u64				timeout_jiffies;
-	u64				max_power;
+	atomic_t			cs_active_cnt;
 	u32				major;
 	u32				high_pll;
 	u32				soft_reset_cnt;
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 67bece26417c..ef3bb6951360 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -370,12 +370,13 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 		spin_unlock(&hdev->hw_queues_mirror_lock);
 	}
 
-	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node) {
+	atomic_inc(&hdev->cs_active_cnt);
+
+	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
 		if (job->ext_queue)
 			ext_hw_queue_schedule_job(job);
 		else
 			int_hw_queue_schedule_job(job);
-	}
 
 	cs->submitted = true;
 
-- 
2.17.1

