Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2E7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E58218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWUthL+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfCPUn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 16:43:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34617 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfCPUnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 16:43:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id k1so12501293wre.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bM3J1aRwQpaVX7yZhoyNmxrEPMCvNp+DZxyeXWWUsd4=;
        b=XWUthL+d+/tlInSG4Xl3G12g56VOWMiPYfCasMQ6lyj6F3ISvIamyUGExmcIc//xQZ
         Om+SBPU3Nyb+rvgVi9XWtdJSgxfe3KXU1NgEJZUd9hES1VaRY+fEWkJSajLhIVBju5sk
         9Nv+KP6YbUny/zhS4PBOMsaqb/UmAxjVn7MPxMOn/d5rkSQKYGmYy4qvVH9etW0BQ4Pi
         7YhMALvmESnHwsKXbGxEodgOyux5W65QNoayG1HGB38radmbYeLxT575y+YmvLXxfQzn
         lzycGKFlhQhBt4ZwCmpKqIuwh1j0oRvnWGgy7KPnQsNl2I2vFlxx6ZizaRPsUx0Vrg1a
         Qbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bM3J1aRwQpaVX7yZhoyNmxrEPMCvNp+DZxyeXWWUsd4=;
        b=UAz/2XfWpJbQtdzArEN40qHBt6dYfHDK2ji233CE18i8Z4wJwZ2G75HafbtmRALHoo
         Vxv6U/XTku2kNdfWuyzNvxjWf7DEIVO0EAeWJjD4pNyWXSODtHf2Vrp++NKWjHr+m2b1
         ooNeTqxPzurk8h/8rb1IP7AVfPADY8G5bJ1ef0gRgYOuzjktN9O+CnnuS+8b0/uUso5o
         jSUkmu8MuuS1mMjvkfPbukh78vSRDKv4vmwkD0Nv31H9S6MGVxgSQhwGge8lzPjm5JNP
         OX4ev3HnVuqkKjgh1Aq/ngtVL0QdUzKSd3m5l0iGmkckNDN67elLpJyRVJnFC7aYXHdo
         VdNg==
X-Gm-Message-State: APjAAAUoqzuSgz3IMmbTZpYWCjFDeKtwOXHJm81fw52aUiw3R7cC+m4T
        b7FkvJSxcI7yN9nI4qGuXEGrKxxV
X-Google-Smtp-Source: APXvYqzNL7VFS6dRksUAglGHc6KIoWNQrkDkSqqheRxwsiMvcOvDkoJuxnwP6EBjJ9cdJE8gzDHQug==
X-Received: by 2002:adf:f543:: with SMTP id j3mr6480344wrp.220.1552769001232;
        Sat, 16 Mar 2019 13:43:21 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id y7sm8684315wmi.34.2019.03.16.13.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 13:43:20 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/3] habanalabs: prevent host crash during suspend/resume
Date:   Sat, 16 Mar 2019 22:43:16 +0200
Message-Id: <20190316204317.28279-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190316204317.28279-1-oded.gabbay@gmail.com>
References: <20190316204317.28279-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the implementation of suspend/resume of the device so that
upon resume of the device, the host won't crash due to PCI completion
timeout.

Upon suspend, the device is being reset due to PERST. Therefore, upon
resume, the driver must initialize the PCI controller as if the driver was
loaded. If the controller is not initialized and the device tries to
access the device through the PCI bars, the host will crash with PCI
completion timeout error.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c    | 46 +++++++++++++++++++--
 drivers/misc/habanalabs/goya/goya.c | 63 +----------------------------
 2 files changed, 43 insertions(+), 66 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 470d8005b50e..77d51be66c7e 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -416,6 +416,27 @@ int hl_device_suspend(struct hl_device *hdev)
 
 	pci_save_state(hdev->pdev);
 
+	/* Block future CS/VM/JOB completion operations */
+	rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+	if (rc) {
+		dev_err(hdev->dev, "Can't suspend while in reset\n");
+		return -EIO;
+	}
+
+	/* This blocks all other stuff that is not blocked by in_reset */
+	hdev->disabled = true;
+
+	/*
+	 * Flush anyone that is inside the critical section of enqueue
+	 * jobs to the H/W
+	 */
+	hdev->asic_funcs->hw_queues_lock(hdev);
+	hdev->asic_funcs->hw_queues_unlock(hdev);
+
+	/* Flush processes that are sending message to CPU */
+	mutex_lock(&hdev->send_cpu_message_lock);
+	mutex_unlock(&hdev->send_cpu_message_lock);
+
 	rc = hdev->asic_funcs->suspend(hdev);
 	if (rc)
 		dev_err(hdev->dev,
@@ -443,21 +464,38 @@ int hl_device_resume(struct hl_device *hdev)
 
 	pci_set_power_state(hdev->pdev, PCI_D0);
 	pci_restore_state(hdev->pdev);
-	rc = pci_enable_device(hdev->pdev);
+	rc = pci_enable_device_mem(hdev->pdev);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to enable PCI device in resume\n");
 		return rc;
 	}
 
+	pci_set_master(hdev->pdev);
+
 	rc = hdev->asic_funcs->resume(hdev);
 	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to enable PCI access from device CPU\n");
-		return rc;
+		dev_err(hdev->dev, "Failed to resume device after suspend\n");
+		goto disable_device;
+	}
+
+
+	hdev->disabled = false;
+	atomic_set(&hdev->in_reset, 0);
+
+	rc = hl_device_reset(hdev, true, false);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to reset device during resume\n");
+		goto disable_device;
 	}
 
 	return 0;
+
+disable_device:
+	pci_clear_master(hdev->pdev);
+	pci_disable_device(hdev->pdev);
+
+	return rc;
 }
 
 static void hl_device_hard_reset_pending(struct work_struct *work)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 238dd57c541b..538d8d59d9dc 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1201,15 +1201,6 @@ static int goya_stop_external_queues(struct hl_device *hdev)
 	return retval;
 }
 
-static void goya_resume_external_queues(struct hl_device *hdev)
-{
-	WREG32(mmDMA_QM_0_GLBL_CFG1, 0);
-	WREG32(mmDMA_QM_1_GLBL_CFG1, 0);
-	WREG32(mmDMA_QM_2_GLBL_CFG1, 0);
-	WREG32(mmDMA_QM_3_GLBL_CFG1, 0);
-	WREG32(mmDMA_QM_4_GLBL_CFG1, 0);
-}
-
 /*
  * goya_init_cpu_queues - Initialize PQ/CQ/EQ of CPU
  *
@@ -2178,36 +2169,6 @@ static int goya_stop_internal_queues(struct hl_device *hdev)
 	return retval;
 }
 
-static void goya_resume_internal_queues(struct hl_device *hdev)
-{
-	WREG32(mmMME_QM_GLBL_CFG1, 0);
-	WREG32(mmMME_CMDQ_GLBL_CFG1, 0);
-
-	WREG32(mmTPC0_QM_GLBL_CFG1, 0);
-	WREG32(mmTPC0_CMDQ_GLBL_CFG1, 0);
-
-	WREG32(mmTPC1_QM_GLBL_CFG1, 0);
-	WREG32(mmTPC1_CMDQ_GLBL_CFG1, 0);
-
-	WREG32(mmTPC2_QM_GLBL_CFG1, 0);
-	WREG32(mmTPC2_CMDQ_GLBL_CFG1, 0);
-
-	WREG32(mmTPC3_QM_GLBL_CFG1, 0);
-	WREG32(mmTPC3_CMDQ_GLBL_CFG1, 0);
-
-	WREG32(mmTPC4_QM_GLBL_CFG1, 0);
-	WREG32(mmTPC4_CMDQ_GLBL_CFG1, 0);
-
-	WREG32(mmTPC5_QM_GLBL_CFG1, 0);
-	WREG32(mmTPC5_CMDQ_GLBL_CFG1, 0);
-
-	WREG32(mmTPC6_QM_GLBL_CFG1, 0);
-	WREG32(mmTPC6_CMDQ_GLBL_CFG1, 0);
-
-	WREG32(mmTPC7_QM_GLBL_CFG1, 0);
-	WREG32(mmTPC7_CMDQ_GLBL_CFG1, 0);
-}
-
 static void goya_dma_stall(struct hl_device *hdev)
 {
 	WREG32(mmDMA_QM_0_GLBL_CFG1, 1 << DMA_QM_0_GLBL_CFG1_DMA_STOP_SHIFT);
@@ -2905,20 +2866,6 @@ int goya_suspend(struct hl_device *hdev)
 {
 	int rc;
 
-	rc = goya_stop_internal_queues(hdev);
-
-	if (rc) {
-		dev_err(hdev->dev, "failed to stop internal queues\n");
-		return rc;
-	}
-
-	rc = goya_stop_external_queues(hdev);
-
-	if (rc) {
-		dev_err(hdev->dev, "failed to stop external queues\n");
-		return rc;
-	}
-
 	rc = goya_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
 	if (rc)
 		dev_err(hdev->dev, "Failed to disable PCI access from CPU\n");
@@ -2928,15 +2875,7 @@ int goya_suspend(struct hl_device *hdev)
 
 int goya_resume(struct hl_device *hdev)
 {
-	int rc;
-
-	goya_resume_external_queues(hdev);
-	goya_resume_internal_queues(hdev);
-
-	rc = goya_send_pci_access_msg(hdev, ARMCP_PACKET_ENABLE_PCI_ACCESS);
-	if (rc)
-		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
-	return rc;
+	return goya_init_iatu(hdev);
 }
 
 static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
-- 
2.17.1

