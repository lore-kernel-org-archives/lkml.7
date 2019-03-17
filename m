Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA43FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8400F21738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR03qKmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfCQT74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:59:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37730 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfCQT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15so14762589wro.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bL1WBDufUkqlFndI9jD2XiaNl+Wgz4BgYs3l/gkjWjk=;
        b=SR03qKmMilWjk/plqua5+PwaAZxS0D9dw9UE+erJOFW+6cKyMFgSYYu0ZOzv/Vegki
         RGcfloY/5IEn0FpVaxm1a+mWryjQ0lDJ+o0FewtresHdLDLwuH8guHeW8kjFxq20nTy4
         fhAAlmbGdgnsJL59e63XYrmqKITSjbGO67znCIKPALBdDjsM/8idjUEUHnPuCAQY1LTm
         hA3HMmDB9Tmn0mROUGhCdsB6eWkKT2d0meIxE3mH2tQuSPTitqvtOoC/9MOVv17zpO03
         Z3wP3qaqPM5/VCUgcdjAb3zkSn2H17U7bEMhYk3rUPZFjwNDmLngBMiqFa8zrQ/oJlCr
         asrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bL1WBDufUkqlFndI9jD2XiaNl+Wgz4BgYs3l/gkjWjk=;
        b=iYuR4r2+qrEejytUXwi2rsGRPb2vNBlFovEJq2hMG/ucJsRTNML/2brA+Oyzu7ukSk
         9MrdbxtcTuHw14ZUy+shyqs2ErYAneq0xsOetQztq4TzRfzWMjtaZQdVERPuJIUOgq4S
         FXhCggxBBUYWPflVHM6bEjQEIixYD5Jz5Z/N3lboqlMwerWKn2iyiT+DLF27VpFI/E+z
         pvWFt3Mb/O1f1koLrrVUAVwOeeBpFdGDKiqLutPqy0hfhCSHs30pvVXXJ2x+YNY14P+m
         cqjnPVCNErp6Es6I3EZur2w161JAGhf4SxWWk9OM+MnKXoL6u5MNxYJeEH1rl3RHqr6f
         fAww==
X-Gm-Message-State: APjAAAUyocrgH/DHZ2YHBJGTEGX2iWvmWiDsGjObdHsMedBXY8u+BYSC
        WX1Qi5yGx/zxs14KxMoGDqu8QT9b
X-Google-Smtp-Source: APXvYqzshc2Q6tDmEfCeXhFfcMhGuEVa3mmUL6PB8+62P2hABPhc7lolLdOyygMUTwGwSsGRcbx94w==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr9183818wrq.174.1552852784622;
        Sun, 17 Mar 2019 12:59:44 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 05/15] habanalabs: use EQ MSI/X ID per chip
Date:   Sun, 17 Mar 2019 21:59:17 +0200
Message-Id: <20190317195927.26238-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Event Queue MSI/X ID is different per ASIC. This patch renames the
current define to have the GOYA_ prefix to mark it only for Goya. It also
moves it from the common armcp_if.h file to the ASIC specific goya_fw_if.h
file.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c               | 8 ++++----
 drivers/misc/habanalabs/include/armcp_if.h        | 2 --
 drivers/misc/habanalabs/include/goya/goya_fw_if.h | 2 ++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a578d01a56a6..6ba0faa979bd 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2205,10 +2205,10 @@ static int goya_enable_msix(struct hl_device *hdev)
 		}
 	}
 
-	irq = pci_irq_vector(hdev->pdev, EVENT_QUEUE_MSIX_IDX);
+	irq = pci_irq_vector(hdev->pdev, GOYA_EVENT_QUEUE_MSIX_IDX);
 
 	rc = request_irq(irq, hl_irq_handler_eq, 0,
-			goya_irq_name[EVENT_QUEUE_MSIX_IDX],
+			goya_irq_name[GOYA_EVENT_QUEUE_MSIX_IDX],
 			&hdev->event_queue);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to request IRQ %d", irq);
@@ -2239,7 +2239,7 @@ static void goya_sync_irqs(struct hl_device *hdev)
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		synchronize_irq(pci_irq_vector(hdev->pdev, i));
 
-	synchronize_irq(pci_irq_vector(hdev->pdev, EVENT_QUEUE_MSIX_IDX));
+	synchronize_irq(pci_irq_vector(hdev->pdev, GOYA_EVENT_QUEUE_MSIX_IDX));
 }
 
 static void goya_disable_msix(struct hl_device *hdev)
@@ -2252,7 +2252,7 @@ static void goya_disable_msix(struct hl_device *hdev)
 
 	goya_sync_irqs(hdev);
 
-	irq = pci_irq_vector(hdev->pdev, EVENT_QUEUE_MSIX_IDX);
+	irq = pci_irq_vector(hdev->pdev, GOYA_EVENT_QUEUE_MSIX_IDX);
 	free_irq(irq, &hdev->event_queue);
 
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index ccb82390241e..c8f28cadc335 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -32,8 +32,6 @@ struct hl_eq_entry {
 #define EQ_CTL_EVENT_TYPE_SHIFT		16
 #define EQ_CTL_EVENT_TYPE_MASK		0x03FF0000
 
-#define EVENT_QUEUE_MSIX_IDX		5
-
 enum pq_init_status {
 	PQ_INIT_STATUS_NA = 0,
 	PQ_INIT_STATUS_READY_FOR_CP,
diff --git a/drivers/misc/habanalabs/include/goya/goya_fw_if.h b/drivers/misc/habanalabs/include/goya/goya_fw_if.h
index a9920cb4a07b..0fa80fe9f6cc 100644
--- a/drivers/misc/habanalabs/include/goya/goya_fw_if.h
+++ b/drivers/misc/habanalabs/include/goya/goya_fw_if.h
@@ -8,6 +8,8 @@
 #ifndef GOYA_FW_IF_H
 #define GOYA_FW_IF_H
 
+#define GOYA_EVENT_QUEUE_MSIX_IDX	5
+
 #define CPU_BOOT_ADDR		0x7FF8040000ull
 
 #define UBOOT_FW_OFFSET		0x100000		/* 1MB in SRAM */
-- 
2.17.1

