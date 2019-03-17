Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6DDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1269820896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSzlYLmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfCQUAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:00:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35581 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfCQT75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id 81so3361288wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AKxoI6OcL3oxvp+cimCungYTvLi1W9hb2x1T5kIB5ko=;
        b=WSzlYLmSCCKN+T54gR7jiWlchui/I/W5G+kjSkupvaOcBgPU51WXJF+q+7PzS2jPCY
         P/YlmlYMMs3QYzLqXk0gRiopYmsBOzBfkFX/Z5+RjqiRfwK79kRFSG2egKh1dx2DqBvJ
         xfJ1M/lWe6gvNRSHCYHjwNha0BwJNQ3HYJY3MjdyWWttWWr1hFuzj1ooOCBHUv3xA7z3
         NW9s/90vGJx8qKvC0l0Xn6aXe1X9DM2UlzB+WwxAdDLbmclsInT1WRgUfd/vXG1WZCJi
         xlYkvdiCBnAEHlKGiBhLw8hiUZnwXeZnZie83sAV7bPDRMXX02V1neUv4c/yYC3oq6qg
         Xe0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AKxoI6OcL3oxvp+cimCungYTvLi1W9hb2x1T5kIB5ko=;
        b=dF+z6F1s4b8mJWQBKdUXDeRtOrHhmMe+B3sWro/evx+5B/V0r1MsYYMJ2pXErPNcFF
         oYjhHSjiElZEKsoLr4RocLPyI2vpgtN/ugP8WhcTZTyXlDTwrMKaPuDhre/eahwrtuVu
         sz/bYhIVb/g3OoyoWYSpxcDMvIOfFCFTY9AhagEpNOb/ID4vFNJJqqrvxX24tTp6EVKZ
         yLlb4JpeBKJntaQISJL9gvhfPxvuIGgsR3fp0wc4UqAUiMdXD0ljjkCMEotAsdntCqmp
         3uNWQKY7I4uIvU9BQoVAhxh+LZ1yjJRwt1GMPFd3dobHHlPvEfIgPapSIa93OfVfWI5o
         rtYQ==
X-Gm-Message-State: APjAAAVD4QZ4JE4YIVQPj43NAbu4vaWJf86r0RUoyHUq/X/8oP3fPbQe
        fvKU3Pg8eWdSC6PJTePeupkMB3ze
X-Google-Smtp-Source: APXvYqyrypRmblvpzy/TcWLG1UAf9nm2zBmY5PoU7NppD9s+KUHNch1y1ElWsa2RRq7reRDxf+7Ksw==
X-Received: by 2002:a7b:c016:: with SMTP id c22mr8611278wmb.55.1552852794339;
        Sun, 17 Mar 2019 12:59:54 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:53 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 11/15] habanalabs: Add a printout with the name of a busy engine
Date:   Sun, 17 Mar 2019 21:59:23 +0200
Message-Id: <20190317195927.26238-12-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Print the name of a busy engine when checking if a device is idle.
The change is done mainly to help a user to pinpoint problems in his
topology's recipe.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c        | 24 ++++++++++++----------
 drivers/misc/habanalabs/habanalabs.h       |  8 +++++++-
 drivers/misc/habanalabs/habanalabs_ioctl.c |  2 +-
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 466464c026e0..b474651db0e5 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2784,6 +2784,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	dma_addr_t fence_dma_addr;
 	struct hl_cb *cb;
 	u32 tmp, timeout;
+	char buf[16] = {};
 	int rc;
 
 	if (hdev->pldm)
@@ -2791,9 +2792,10 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	else
 		timeout = HL_DEVICE_TIMEOUT_USEC;
 
-	if (!hdev->asic_funcs->is_device_idle(hdev)) {
+	if (!hdev->asic_funcs->is_device_idle(hdev, buf, sizeof(buf))) {
 		dev_err_ratelimited(hdev->dev,
-			"Can't send KMD job on QMAN0 if device is not idle\n");
+			"Can't send KMD job on QMAN0 because %s is busy\n",
+			buf);
 		return -EBUSY;
 	}
 
@@ -4692,7 +4694,7 @@ static void goya_disable_clock_gating(struct hl_device *hdev)
 
 }
 
-static bool goya_is_device_idle(struct hl_device *hdev)
+static bool goya_is_device_idle(struct hl_device *hdev, char *buf, size_t size)
 {
 	u64 offset, dma_qm_reg, tpc_qm_reg, tpc_cmdq_reg, tpc_cfg_reg;
 	int i;
@@ -4704,7 +4706,7 @@ static bool goya_is_device_idle(struct hl_device *hdev)
 
 		if ((RREG32(dma_qm_reg) & DMA_QM_IDLE_MASK) !=
 				DMA_QM_IDLE_MASK)
-			return false;
+			return HL_ENG_BUSY(buf, size, "DMA%d_QM", i);
 	}
 
 	offset = mmTPC1_QM_GLBL_STS0 - mmTPC0_QM_GLBL_STS0;
@@ -4716,31 +4718,31 @@ static bool goya_is_device_idle(struct hl_device *hdev)
 
 		if ((RREG32(tpc_qm_reg) & TPC_QM_IDLE_MASK) !=
 				TPC_QM_IDLE_MASK)
-			return false;
+			return HL_ENG_BUSY(buf, size, "TPC%d_QM", i);
 
 		if ((RREG32(tpc_cmdq_reg) & TPC_CMDQ_IDLE_MASK) !=
 				TPC_CMDQ_IDLE_MASK)
-			return false;
+			return HL_ENG_BUSY(buf, size, "TPC%d_CMDQ", i);
 
 		if ((RREG32(tpc_cfg_reg) & TPC_CFG_IDLE_MASK) !=
 				TPC_CFG_IDLE_MASK)
-			return false;
+			return HL_ENG_BUSY(buf, size, "TPC%d_CFG", i);
 	}
 
 	if ((RREG32(mmMME_QM_GLBL_STS0) & MME_QM_IDLE_MASK) !=
 			MME_QM_IDLE_MASK)
-		return false;
+		return HL_ENG_BUSY(buf, size, "MME_QM");
 
 	if ((RREG32(mmMME_CMDQ_GLBL_STS0) & MME_CMDQ_IDLE_MASK) !=
 			MME_CMDQ_IDLE_MASK)
-		return false;
+		return HL_ENG_BUSY(buf, size, "MME_CMDQ");
 
 	if ((RREG32(mmMME_ARCH_STATUS) & MME_ARCH_IDLE_MASK) !=
 			MME_ARCH_IDLE_MASK)
-		return false;
+		return HL_ENG_BUSY(buf, size, "MME_ARCH");
 
 	if (RREG32(mmMME_SHADOW_0_STATUS) & MME_SHADOW_IDLE_MASK)
-		return false;
+		return HL_ENG_BUSY(buf, size, "MME");
 
 	return true;
 }
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index ed3649d38ff8..9cc841777d81 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -555,7 +555,7 @@ struct hl_asic_funcs {
 	int (*send_heartbeat)(struct hl_device *hdev);
 	void (*enable_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
-	bool (*is_device_idle)(struct hl_device *hdev);
+	bool (*is_device_idle)(struct hl_device *hdev, char *buf, size_t size);
 	int (*soft_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
@@ -1010,6 +1010,12 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	WREG32(mm##reg, (RREG32(mm##reg) & ~REG_FIELD_MASK(reg, field)) | \
 			(val) << REG_FIELD_SHIFT(reg, field))
 
+#define HL_ENG_BUSY(buf, size, fmt, ...) ({ \
+		if (buf) \
+			snprintf(buf, size, fmt, ##__VA_ARGS__); \
+		false; \
+	})
+
 struct hwmon_chip_info;
 
 /**
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 19b96afc0308..37f9de8e7404 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -93,7 +93,7 @@ static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	hw_idle.is_idle = hdev->asic_funcs->is_device_idle(hdev);
+	hw_idle.is_idle = hdev->asic_funcs->is_device_idle(hdev, NULL, 0);
 
 	return copy_to_user(out, &hw_idle,
 		min((size_t) max_size, sizeof(hw_idle))) ? -EFAULT : 0;
-- 
2.17.1

