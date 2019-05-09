Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9AFC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A282177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlvCmfko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfEITBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:01:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53224 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbfEITBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:01:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id g26so2647183wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uUWOdEXqtxWsNp1XjgcdfIolg6F8fuU4e1LPqNUI6mM=;
        b=XlvCmfkoWxA/EEk+1X50BwGiEwCjQfgTMRUR7JE4mSCuNSQ1WEaKk8a2qTEbHTeoWN
         3X0HojmPM9Z+UZTfRkKe/8YbEiTCIw6YmNM4mFecB3tlgPmN0TxHTXrdmQ+ncZiymBNV
         bbGA+v1j6Yio2Fk3uQWtmGYvBWnNgEllRtqAk5yIBPK7280XpHlQJdrwy3SwkdKCRgne
         UIXGf1powPeKuZvWs3Rg5HY6vx9+1oIXnzS6bFaCscBewt+StWNMNTixGnyOJ+gAqHRu
         vop0MDovFaqgOo226o8hOJKbbVFsRVF+oS4FF6mw4/5Bqr9TF0l2M+NeTXlmakbKVMre
         ZXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uUWOdEXqtxWsNp1XjgcdfIolg6F8fuU4e1LPqNUI6mM=;
        b=bRiqwDjSjV5cXBUZaC0RD8ev6YcUBoMJ3TuA+lppxWxdkjGaeLkzkl6Ou4/URyoTZj
         C6Zmd+wr9pLe5n9Wbq4FNPewlOE7DJd5kNbGhIEV1eGRpoCN4KpJzUfBoIGWbWXGtSKB
         /DHfjToMP98x9J5pvxpt8dFCLGfOJOxZUepBy4T8wOqL8PSgrRP3m8TI0OoOwxkLupWM
         HuFC1q3cRgF/ec9ahV65A+JYOCj3jU+LczPG78/cG+RWqpjQtCvhpVl8EGO6u+B3m2Zb
         7DHdgP9qis2UEiS2k1/YpuDOP8c64UJ06gUMCyFY4rR5gGfU+d+gxG1IQaAJyDeVZIGg
         5sSg==
X-Gm-Message-State: APjAAAWut+LUPcOsvMITj+426Wi2hzUuCLvfHzxd2bcN48HY7nrdu9Me
        hVlweBOA0jRTLtV+dwzzJLcadXOq
X-Google-Smtp-Source: APXvYqw8zu5zD8EF+VKoA8rph0OhaIgAq4J1wWN3b16GS5ccVARrpbKAhuinmrhMNSXmCNkDujwpFQ==
X-Received: by 2002:a1c:cb48:: with SMTP id b69mr4191958wmg.109.1557428505386;
        Thu, 09 May 2019 12:01:45 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j1sm2833671wrt.52.2019.05.09.12.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 12:01:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/3] habanalabs: change polling functions to macros
Date:   Thu,  9 May 2019 22:01:35 +0300
Message-Id: <20190509190135.5634-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509190135.5634-1-oded.gabbay@gmail.com>
References: <20190509190135.5634-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes two polling functions to macros, in order to make their
API the same as the standard readl_poll_timeout so we would be able to
define the "condition for exit" when calling these macros.

This will simplify the code as it will eliminate the need to check both
for timeout and for the (cond) in the calling function.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 10 +--
 drivers/misc/habanalabs/device.c             | 89 --------------------
 drivers/misc/habanalabs/firmware_if.c        | 29 +++----
 drivers/misc/habanalabs/goya/goya.c          | 25 +++---
 drivers/misc/habanalabs/habanalabs.h         | 57 ++++++++++++-
 5 files changed, 81 insertions(+), 129 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 6fe785e26859..6ad83d5ef4b0 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -682,14 +682,12 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		u32 tmp;
 
 		rc = hl_poll_timeout_memory(hdev,
-			(u64) (uintptr_t) &ctx->thread_ctx_switch_wait_token,
-			jiffies_to_usecs(hdev->timeout_jiffies),
-			&tmp);
+			&ctx->thread_ctx_switch_wait_token, tmp, (tmp == 1),
+			100, jiffies_to_usecs(hdev->timeout_jiffies));
 
-		if (rc || !tmp) {
+		if (rc == -ETIMEDOUT) {
 			dev_err(hdev->dev,
-				"context switch phase didn't finish in time\n");
-			rc = -ETIMEDOUT;
+				"context switch phase timeout (%d)\n", tmp);
 			goto out;
 		}
 	}
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 8289cb7ea759..feedf4810430 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -1171,95 +1171,6 @@ void hl_device_fini(struct hl_device *hdev)
 	pr_info("removed device successfully\n");
 }
 
-/*
- * hl_poll_timeout_memory - Periodically poll a host memory address
- *                              until it is not zero or a timeout occurs
- * @hdev: pointer to habanalabs device structure
- * @addr: Address to poll
- * @timeout_us: timeout in us
- * @val: Variable to read the value into
- *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @addr is stored in @val. Must not
- * be called from atomic context if sleep_us or timeout_us are used.
- *
- * The function sleeps for 100us with timeout value of
- * timeout_us
- */
-int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr,
-				u32 timeout_us, u32 *val)
-{
-	/*
-	 * address in this function points always to a memory location in the
-	 * host's (server's) memory. That location is updated asynchronously
-	 * either by the direct access of the device or by another core
-	 */
-	u32 *paddr = (u32 *) (uintptr_t) addr;
-	ktime_t timeout;
-
-	/* timeout should be longer when working with simulator */
-	if (!hdev->pdev)
-		timeout_us *= 10;
-
-	timeout = ktime_add_us(ktime_get(), timeout_us);
-
-	might_sleep();
-
-	for (;;) {
-		/*
-		 * Flush CPU read/write buffers to make sure we read updates
-		 * done by other cores or by the device
-		 */
-		mb();
-		*val = *paddr;
-		if (*val)
-			break;
-		if (ktime_compare(ktime_get(), timeout) > 0) {
-			*val = *paddr;
-			break;
-		}
-		usleep_range((100 >> 2) + 1, 100);
-	}
-
-	return *val ? 0 : -ETIMEDOUT;
-}
-
-/*
- * hl_poll_timeout_devicememory - Periodically poll a device memory address
- *                                until it is not zero or a timeout occurs
- * @hdev: pointer to habanalabs device structure
- * @addr: Device address to poll
- * @timeout_us: timeout in us
- * @val: Variable to read the value into
- *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @addr is stored in @val. Must not
- * be called from atomic context if sleep_us or timeout_us are used.
- *
- * The function sleeps for 100us with timeout value of
- * timeout_us
- */
-int hl_poll_timeout_device_memory(struct hl_device *hdev, void __iomem *addr,
-				u32 timeout_us, u32 *val)
-{
-	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
-
-	might_sleep();
-
-	for (;;) {
-		*val = readl(addr);
-		if (*val)
-			break;
-		if (ktime_compare(ktime_get(), timeout) > 0) {
-			*val = readl(addr);
-			break;
-		}
-		usleep_range((100 >> 2) + 1, 100);
-	}
-
-	return *val ? 0 : -ETIMEDOUT;
-}
-
 /*
  * MMIO register access helper functions.
  */
diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index de445a1d9f3d..0cbdfa0d7fba 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -117,33 +117,28 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 		goto out;
 	}
 
-	rc = hl_poll_timeout_memory(hdev, (u64) (uintptr_t) &pkt->fence,
-					timeout, &tmp);
+	rc = hl_poll_timeout_memory(hdev, &pkt->fence, tmp,
+				(tmp == ARMCP_PACKET_FENCE_VAL), 1000, timeout);
 
 	hl_hw_queue_inc_ci_kernel(hdev, hw_queue_id);
 
 	if (rc == -ETIMEDOUT) {
-		dev_err(hdev->dev, "Timeout while waiting for device CPU\n");
+		dev_err(hdev->dev, "Device CPU packet timeout (0x%x)\n", tmp);
 		hdev->device_cpu_disabled = true;
 		goto out;
 	}
 
-	if (tmp == ARMCP_PACKET_FENCE_VAL) {
-		u32 ctl = le32_to_cpu(pkt->ctl);
+	tmp = le32_to_cpu(pkt->ctl);
 
-		rc = (ctl & ARMCP_PKT_CTL_RC_MASK) >> ARMCP_PKT_CTL_RC_SHIFT;
-		if (rc) {
-			dev_err(hdev->dev,
-				"F/W ERROR %d for CPU packet %d\n",
-				rc, (ctl & ARMCP_PKT_CTL_OPCODE_MASK)
+	rc = (tmp & ARMCP_PKT_CTL_RC_MASK) >> ARMCP_PKT_CTL_RC_SHIFT;
+	if (rc) {
+		dev_err(hdev->dev, "F/W ERROR %d for CPU packet %d\n",
+			rc,
+			(tmp & ARMCP_PKT_CTL_OPCODE_MASK)
 						>> ARMCP_PKT_CTL_OPCODE_SHIFT);
-			rc = -EINVAL;
-		} else if (result) {
-			*result = (long) le64_to_cpu(pkt->result);
-		}
-	} else {
-		dev_err(hdev->dev, "CPU packet wrong fence value\n");
-		rc = -EINVAL;
+		rc = -EIO;
+	} else if (result) {
+		*result = (long) le64_to_cpu(pkt->result);
 	}
 
 out:
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a2459cb106dd..ffc7997d4898 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2844,14 +2844,14 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 		goto free_fence_ptr;
 	}
 
-	rc = hl_poll_timeout_memory(hdev, (u64) (uintptr_t) fence_ptr, timeout,
-					&tmp);
+	rc = hl_poll_timeout_memory(hdev, fence_ptr, tmp,
+				(tmp == GOYA_QMAN0_FENCE_VAL), 1000, timeout);
 
 	hl_hw_queue_inc_ci_kernel(hdev, GOYA_QUEUE_ID_DMA_0);
 
-	if ((rc) || (tmp != GOYA_QMAN0_FENCE_VAL)) {
-		dev_err(hdev->dev, "QMAN0 Job hasn't finished in time\n");
-		rc = -ETIMEDOUT;
+	if (rc == -ETIMEDOUT) {
+		dev_err(hdev->dev, "QMAN0 Job timeout (0x%x)\n", tmp);
+		goto free_fence_ptr;
 	}
 
 free_fence_ptr:
@@ -2925,20 +2925,19 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 		goto free_pkt;
 	}
 
-	rc = hl_poll_timeout_memory(hdev, (u64) (uintptr_t) fence_ptr,
-					GOYA_TEST_QUEUE_WAIT_USEC, &tmp);
+	rc = hl_poll_timeout_memory(hdev, fence_ptr, tmp, (tmp == fence_val),
+					1000, GOYA_TEST_QUEUE_WAIT_USEC);
 
 	hl_hw_queue_inc_ci_kernel(hdev, hw_queue_id);
 
-	if ((!rc) && (tmp == fence_val)) {
-		dev_info(hdev->dev,
-			"queue test on H/W queue %d succeeded\n",
-			hw_queue_id);
-	} else {
+	if (rc == -ETIMEDOUT) {
 		dev_err(hdev->dev,
 			"H/W queue %d test failed (scratch(0x%08llX) == 0x%08X)\n",
 			hw_queue_id, (unsigned long long) fence_dma_addr, tmp);
-		rc = -EINVAL;
+		rc = -EIO;
+	} else {
+		dev_info(hdev->dev, "queue test on H/W queue %d succeeded\n",
+			hw_queue_id);
 	}
 
 free_pkt:
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index f09029339d5e..00b3339f4828 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1065,6 +1065,59 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	(cond) ? 0 : -ETIMEDOUT; \
 })
 
+/*
+ * address in this macro points always to a memory location in the
+ * host's (server's) memory. That location is updated asynchronously
+ * either by the direct access of the device or by another core
+ */
+#define hl_poll_timeout_memory(hdev, addr, val, cond, sleep_us, timeout_us) \
+({ \
+	ktime_t __timeout; \
+	/* timeout should be longer when working with simulator */ \
+	if (hdev->pdev) \
+		__timeout = ktime_add_us(ktime_get(), timeout_us); \
+	else \
+		__timeout = ktime_add_us(ktime_get(), (timeout_us * 10)); \
+	might_sleep_if(sleep_us); \
+	for (;;) { \
+		/* Verify we read updates done by other cores or by device */ \
+		mb(); \
+		(val) = *((u32 *) (uintptr_t) (addr)); \
+		if (cond) \
+			break; \
+		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) { \
+			(val) = *((u32 *) (uintptr_t) (addr)); \
+			break; \
+		} \
+		if (sleep_us) \
+			usleep_range((sleep_us >> 2) + 1, sleep_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+
+#define hl_poll_timeout_device_memory(hdev, addr, val, cond, sleep_us, \
+					timeout_us) \
+({ \
+	ktime_t __timeout; \
+	/* timeout should be longer when working with simulator */ \
+	if (hdev->pdev) \
+		__timeout = ktime_add_us(ktime_get(), timeout_us); \
+	else \
+		__timeout = ktime_add_us(ktime_get(), (timeout_us * 10)); \
+	might_sleep_if(sleep_us); \
+	for (;;) { \
+		(val) = readl(addr); \
+		if (cond) \
+			break; \
+		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) { \
+			(val) = readl(addr); \
+			break; \
+		} \
+		if (sleep_us) \
+			usleep_range((sleep_us >> 2) + 1, sleep_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
 
 #define HL_ENG_BUSY(buf, size, fmt, ...) ({ \
 		if (buf) \
@@ -1334,10 +1387,6 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable);
 int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		enum hl_asic_type asic_type, int minor);
 void destroy_hdev(struct hl_device *hdev);
-int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr, u32 timeout_us,
-				u32 *val);
-int hl_poll_timeout_device_memory(struct hl_device *hdev, void __iomem *addr,
-				u32 timeout_us, u32 *val);
 int hl_hw_queues_create(struct hl_device *hdev);
 void hl_hw_queues_destroy(struct hl_device *hdev);
 int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
-- 
2.17.1

