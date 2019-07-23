Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB294C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53D221E70
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W83COtgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391830AbfGWUlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:41:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39321 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfGWUla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:41:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so29266509wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7lzTpmIYbqBhipv/FWm4cBZW4HQ0lc7Za5knns3FYic=;
        b=W83COtgTpC5jBPF8lQAHBaSUO0FMdXLS4emt7ViJiJETCSMbttluV0n94DMkcwDzn6
         hb8xgbzcD+D0gegNH90ZLM1TDRAWPVbgF+agWSvzJiQ+c8GN/aWUmmlJ9Jir5JGn9IvU
         we9n0ybz2zu80leTUl9ljafqvOPjEqeL6h73w7tmTC6eKVj+r7Z5g+MXSrPr7QlBWQ3W
         KC6b3FAqYvBFygEDFYnsKQh5bkwY5k4JYNjstD+gulFe7QAckHLZRT57D3J7iUn/7dJy
         7Uin/hVOgVYfwLl1Gu45dGp81M0bcZ4M0AQJhjwkyQ6xXaQt7vz7Azbs/TnE4AS4CqIt
         mH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7lzTpmIYbqBhipv/FWm4cBZW4HQ0lc7Za5knns3FYic=;
        b=MRAFnG5/lUz4VXmX7KwgrI65JuMY3YFN4fQG+OH0BNsa4epTeBrkUa0hOBoJxyehSr
         LDmxXO4l+3lmJLz6qaQksp5HegsndALNvWrjM3VlAIgkSkzjEHQlzkSNTPbIUjLheNQR
         zaJCMAMfZczEsCQlqCMwTcV4thqLoVJoDyj+7SFK0UwaRbMz3Nr2t6Cd0z+PETYodiCo
         ouqSL0RcVxLrgQfJ0Eq0MOod30YpYRnqw6xtSefGEW7SW8xfKF9w+Vv8ytq/ADle9k2o
         JCCpwqQ3onPo4617h872/5ZrJ5Yrkay1bKZ7Vuup2NzhOUXY/CNE2SumS1fV8dT9I6de
         zbAQ==
X-Gm-Message-State: APjAAAVi03wiVWxotFjMBl3kLUWMiFgKIAWkO0QOW5WlCver1KWY90Nl
        NUYYpVnYa3QYqg9H+Pv4EWByD7XdLjs=
X-Google-Smtp-Source: APXvYqzni1dyVGN08fIIesriJGVlu6ETxsY08W5hNWZfM9dS9R5AsGmm4lwY45TzW0dqrmVeSwYNsQ==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr68442746wmj.94.1563914487064;
        Tue, 23 Jul 2019 13:41:27 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h16sm43934487wrv.88.2019.07.23.13.41.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 13:41:26 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Ben Segal <bpsegal20@gmail.com>
Subject: [PATCH 2/2] habanalabs: fix host memory polling in BE architecture
Date:   Tue, 23 Jul 2019 23:41:20 +0300
Message-Id: <20190723204120.26578-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723204120.26578-1-oded.gabbay@gmail.com>
References: <20190723204120.26578-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Segal <bpsegal20@gmail.com>

This patch fix a bug in the host memory polling macro. The bug is that the
memory being polled can be written by the device, which always writes it
in LE. However, if the host is running Linux in BE mode, we need to
convert the value that was written by the device before matching it to the
required value that the caller has given to the macro.

Signed-off-by: Ben Segal <bpsegal20@gmail.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c |  2 +-
 drivers/misc/habanalabs/firmware_if.c        |  3 ++-
 drivers/misc/habanalabs/goya/goya.c          |  5 +++--
 drivers/misc/habanalabs/habanalabs.h         | 16 ++++++++++++++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 6ad83d5ef4b0..f00d1c32f6d6 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -683,7 +683,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 
 		rc = hl_poll_timeout_memory(hdev,
 			&ctx->thread_ctx_switch_wait_token, tmp, (tmp == 1),
-			100, jiffies_to_usecs(hdev->timeout_jiffies));
+			100, jiffies_to_usecs(hdev->timeout_jiffies), false);
 
 		if (rc == -ETIMEDOUT) {
 			dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index 61112eda4dd2..ea2ca67fbfbf 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -97,7 +97,8 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	}
 
 	rc = hl_poll_timeout_memory(hdev, &pkt->fence, tmp,
-				(tmp == ARMCP_PACKET_FENCE_VAL), 1000, timeout);
+				(tmp == ARMCP_PACKET_FENCE_VAL), 1000,
+				timeout, true);
 
 	hl_hw_queue_inc_ci_kernel(hdev, hw_queue_id);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 1a2c062a57d4..a0e181714891 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2864,7 +2864,8 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	}
 
 	rc = hl_poll_timeout_memory(hdev, fence_ptr, tmp,
-				(tmp == GOYA_QMAN0_FENCE_VAL), 1000, timeout);
+				(tmp == GOYA_QMAN0_FENCE_VAL), 1000,
+				timeout, true);
 
 	hl_hw_queue_inc_ci_kernel(hdev, GOYA_QUEUE_ID_DMA_0);
 
@@ -2945,7 +2946,7 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 	}
 
 	rc = hl_poll_timeout_memory(hdev, fence_ptr, tmp, (tmp == fence_val),
-					1000, GOYA_TEST_QUEUE_WAIT_USEC);
+					1000, GOYA_TEST_QUEUE_WAIT_USEC, true);
 
 	hl_hw_queue_inc_ci_kernel(hdev, hw_queue_id);
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 10da9940ee0d..6a4c64b97f38 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1062,9 +1062,17 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 /*
  * address in this macro points always to a memory location in the
  * host's (server's) memory. That location is updated asynchronously
- * either by the direct access of the device or by another core
+ * either by the direct access of the device or by another core.
+ *
+ * To work both in LE and BE architectures, we need to distinguish between the
+ * two states (device or another core updates the memory location). Therefore,
+ * if mem_written_by_device is true, the host memory being polled will be
+ * updated directly by the device. If false, the host memory being polled will
+ * be updated by host CPU. Required so host knows whether or not the memory
+ * might need to be byte-swapped before returning value to caller.
  */
-#define hl_poll_timeout_memory(hdev, addr, val, cond, sleep_us, timeout_us) \
+#define hl_poll_timeout_memory(hdev, addr, val, cond, sleep_us, timeout_us, \
+				mem_written_by_device) \
 ({ \
 	ktime_t __timeout; \
 	/* timeout should be longer when working with simulator */ \
@@ -1077,10 +1085,14 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 		/* Verify we read updates done by other cores or by device */ \
 		mb(); \
 		(val) = *((u32 *) (uintptr_t) (addr)); \
+		if (mem_written_by_device) \
+			(val) = le32_to_cpu(val); \
 		if (cond) \
 			break; \
 		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) { \
 			(val) = *((u32 *) (uintptr_t) (addr)); \
+			if (mem_written_by_device) \
+				(val) = le32_to_cpu(val); \
 			break; \
 		} \
 		if (sleep_us) \
-- 
2.17.1

