Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAD3C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BB521721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXOwGXUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403895AbfFKFux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:50:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41035 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390539AbfFKFuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:50:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so11444967wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MyJRGMad7Q+q5bdCcVkcqrpNdIFL1aRgxmT8M36cbcw=;
        b=aXOwGXUFZVG0ymaKqmM/EVuPR9t7ED5qtz4UdL+hsjMWtY6BrkaltdTsQCCwkONGGq
         vhLQaaHDjM5ElITNmGFlqxzRs/0U8VsN772CpSi1DpbrSLc5ISZVEmAiaqsUII1PqXRu
         VHraZG61iRdYVw0jdI0VTtZGj9mMG8/RYCqY56vRh51Yvb2xEk5vRh65uMvsuSukZyAE
         9B3Wyu/LNrqQ5EhjsaEQ6kE5etMGKLL70g1fxMnqYcyNMUGaf8ARARf01V500JJjGPnx
         rNw/VBSAAIwGMcSG/ufHN1T6kPwM5pvoAqHwEN/GcT6FB0UlxnHe3XZJoZeXdgtGXjVe
         aLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MyJRGMad7Q+q5bdCcVkcqrpNdIFL1aRgxmT8M36cbcw=;
        b=B2E3/r8QMCtHbwtpbYNcU3EyregFackdKn68M7kZhe76EYmAvaUTrPosXjBgICdE//
         EOu1sdpETit8/t1mNaK3A0mLmpw9IRNNui8G0A0O7bz98oCMZe8amRR9jadqm6oz8EN8
         fN2Jbu58Q3DnG7n+uZ5JjxeGG20OJhdVmuNrx2ybHaFsIgeiprpXTv4JsegWxZpwalzm
         Zrlv5mCB2wM4la5wH+tsByqh7JdHe893TwT5tGWwgcqJGGTPRbBRuvj9KDPEz0Pz7fb2
         TxDCIawwb8FkNGeEmsYpIG09Tsk+dEBh23YJewWgK3KFUxsDFV7AIpmwMvbD2KfRMNVg
         FwuA==
X-Gm-Message-State: APjAAAWLvZ3s/hc1PDqKyW/Bxhm5Q+gW3P+vXT6neS+6oMMyzfceKPuL
        2A7DGEg1saJpo4houNEq52p7w4hU4MU=
X-Google-Smtp-Source: APXvYqzLL+4PmjjxJp+YbZgBOc9LjZI+BS11rVtWx1GPtnydvvUtoUhwcN2Mi90/BnY7hWe4Kya0CQ==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr1816175wrk.229.1560232249189;
        Mon, 10 Jun 2019 22:50:49 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j8sm11968056wrr.64.2019.06.10.22.50.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 22:50:48 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/8] habanalabs: initialize device CPU queues after MMU init
Date:   Tue, 11 Jun 2019 08:50:38 +0300
Message-Id: <20190611055045.15945-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611055045.15945-1-oded.gabbay@gmail.com>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the order of H/W IP initializations. The MMU needs to
be initialized before the device CPU queues, because the CPU will go
through the ASIC MMU in order to reach the host memory (where the queues
are located).

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/asid.c      |  2 +-
 drivers/misc/habanalabs/device.c    | 22 +++++-----
 drivers/misc/habanalabs/goya/goya.c | 64 +++++++++++++----------------
 3 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/habanalabs/asid.c b/drivers/misc/habanalabs/asid.c
index f54e7971a762..2c01461701a3 100644
--- a/drivers/misc/habanalabs/asid.c
+++ b/drivers/misc/habanalabs/asid.c
@@ -18,7 +18,7 @@ int hl_asid_init(struct hl_device *hdev)
 
 	mutex_init(&hdev->asid_mutex);
 
-	/* ASID 0 is reserved for KMD */
+	/* ASID 0 is reserved for KMD and device CPU */
 	set_bit(0, hdev->asid_bitmap);
 
 	return 0;
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index cca4af29daf7..4df8ef88ce2d 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -326,7 +326,15 @@ static int device_late_init(struct hl_device *hdev)
 {
 	int rc;
 
-	INIT_DELAYED_WORK(&hdev->work_freq, set_freq_to_low_job);
+	if (hdev->asic_funcs->late_init) {
+		rc = hdev->asic_funcs->late_init(hdev);
+		if (rc) {
+			dev_err(hdev->dev,
+				"failed late initialization for the H/W\n");
+			return rc;
+		}
+	}
+
 	hdev->high_pll = hdev->asic_prop.high_pll;
 
 	/* force setting to low frequency */
@@ -337,17 +345,9 @@ static int device_late_init(struct hl_device *hdev)
 	else
 		hdev->asic_funcs->set_pll_profile(hdev, PLL_LAST);
 
-	if (hdev->asic_funcs->late_init) {
-		rc = hdev->asic_funcs->late_init(hdev);
-		if (rc) {
-			dev_err(hdev->dev,
-				"failed late initialization for the H/W\n");
-			return rc;
-		}
-	}
-
+	INIT_DELAYED_WORK(&hdev->work_freq, set_freq_to_low_job);
 	schedule_delayed_work(&hdev->work_freq,
-			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
+	usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
 
 	if (hdev->heartbeat) {
 		INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 81c1d576783f..106074466dca 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -539,9 +539,32 @@ int goya_late_init(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int rc;
 
+	goya_fetch_psoc_frequency(hdev);
+
+	rc = goya_mmu_clear_pgt_range(hdev);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to clear MMU page tables range %d\n", rc);
+		return rc;
+	}
+
+	rc = goya_mmu_set_dram_default_page(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to set DRAM default page %d\n", rc);
+		return rc;
+	}
+
+	rc = goya_init_cpu_queues(hdev);
+	if (rc)
+		return rc;
+
+	rc = goya_test_cpu_queue(hdev);
+	if (rc)
+		return rc;
+
 	rc = goya_armcp_info_get(hdev);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to get armcp info\n");
+		dev_err(hdev->dev, "Failed to get armcp info %d\n", rc);
 		return rc;
 	}
 
@@ -553,33 +576,15 @@ int goya_late_init(struct hl_device *hdev)
 
 	rc = hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_ENABLE_PCI_ACCESS);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
+		dev_err(hdev->dev,
+			"Failed to enable PCI access from CPU %d\n", rc);
 		return rc;
 	}
 
 	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
 			GOYA_ASYNC_EVENT_ID_INTS_REGISTER);
 
-	goya_fetch_psoc_frequency(hdev);
-
-	rc = goya_mmu_clear_pgt_range(hdev);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to clear MMU page tables range\n");
-		goto disable_pci_access;
-	}
-
-	rc = goya_mmu_set_dram_default_page(hdev);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to set DRAM default page\n");
-		goto disable_pci_access;
-	}
-
 	return 0;
-
-disable_pci_access:
-	hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
-
-	return rc;
 }
 
 /*
@@ -1000,7 +1005,7 @@ int goya_init_cpu_queues(struct hl_device *hdev)
 
 	if (err) {
 		dev_err(hdev->dev,
-			"Failed to communicate with ARM CPU (ArmCP timeout)\n");
+			"Failed to setup communication with device CPU\n");
 		return -EIO;
 	}
 
@@ -2465,13 +2470,6 @@ static int goya_hw_init(struct hl_device *hdev)
 	if (rc)
 		goto disable_queues;
 
-	rc = goya_init_cpu_queues(hdev);
-	if (rc) {
-		dev_err(hdev->dev, "failed to initialize CPU H/W queues %d\n",
-			rc);
-		goto disable_msix;
-	}
-
 	/*
 	 * Check if we managed to set the DMA mask to more then 32 bits. If so,
 	 * let's try to increase it again because in Goya we set the initial
@@ -2481,7 +2479,7 @@ static int goya_hw_init(struct hl_device *hdev)
 	if (hdev->dma_mask > 32) {
 		rc = hl_pci_set_dma_mask(hdev, 48);
 		if (rc)
-			goto disable_pci_access;
+			goto disable_msix;
 	}
 
 	/* Perform read from the device to flush all MSI-X configuration */
@@ -2489,8 +2487,6 @@ static int goya_hw_init(struct hl_device *hdev)
 
 	return 0;
 
-disable_pci_access:
-	hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
 disable_msix:
 	goya_disable_msix(hdev);
 disable_queues:
@@ -2972,10 +2968,6 @@ int goya_test_queues(struct hl_device *hdev)
 			ret_val = -EINVAL;
 	}
 
-	rc = goya_test_cpu_queue(hdev);
-	if (rc)
-		ret_val = -EINVAL;
-
 	return ret_val;
 }
 
-- 
2.17.1

