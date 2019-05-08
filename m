Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BDCC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B1D20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF1LM/Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEHIpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:45:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34188 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEHIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:45:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so15740849wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8J5bICABPTbsXmWljoJLSoNhK+HR7wlCA7LrU5o+qh4=;
        b=eF1LM/TzoWgZLrTYcVpz/qL880npv8Bcp6BZpYW5++ITZw8QPVhIXUN2o0HvQNskoH
         QtED3cWRXQirPX9JUM2/+G5VjT21tqHnunTl1L5J/fWUUgHCy1M+XtX+KGpJlKVwCh82
         b64Z9x9rwgthGefh3Ak63JQ1/gMyexypEZpXjO4W8eTiSxnKuKwyXRgmPdcOvFyqyDrm
         CikwFA4MIuIte8ZVsgxSiybGOlI34WeNK7hzkgw4v3HhC2lSyIPOw6IPEqTcXxsE0WVp
         C10nsFkL1NMGbbyLiewLElxoP4vZWnr1M8kvrirepzdsUnXKidb5rQNWVBTL75Ws7aBD
         EFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8J5bICABPTbsXmWljoJLSoNhK+HR7wlCA7LrU5o+qh4=;
        b=EMw3WXexVWdCEkM0HLc5gfyk61yhl2CFUgNzTIHtiiebs0FK362P1mthMFSl333hwe
         omY0LtHJGW9P+/KsuofJMkO5omGdrM8lxAXmWXIp3QPzrYgXA6r47MPwEdPv+UqBp/DJ
         NCngrAa2iZ8HNTFN3CKHGBzU2egZTCDEDU+J4gKTi7ETfqJ/iri5dwIjRSbh3DpXygmH
         5LbqIHn3YPNU+UR4oTmRk94cLUL2pNbxP10QP752xtB5FX4dy/u4BU+IrpPCUc8ftOS1
         x92Mbblbk+NgyYDv3YuslVZAGat1fTyjmC6UlJRK+DzHNWzNmFfJe9QSI3CMvXjRad95
         fXrA==
X-Gm-Message-State: APjAAAXAb/pfqovxj3uHm+s6psXcjIrF6xE7d2m5fUDzAYA1vaObGGFA
        5I5i5sgKIgmY9YQBejYyJkcSiS9B
X-Google-Smtp-Source: APXvYqxy5KU8btQxhZyHMyTAqFVvwUCpfVEhUyITWI0evVEc4FOSBnMbVmI51170igiyz2b2ZVRCLQ==
X-Received: by 2002:a5d:6642:: with SMTP id f2mr16305430wrw.75.1557305131382;
        Wed, 08 May 2019 01:45:31 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j46sm4467531wre.54.2019.05.08.01.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 01:45:30 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: remove dead code in habanalabs_drv.c
Date:   Wed,  8 May 2019 11:45:29 +0300
Message-Id: <20190508084529.22819-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some dead code that performs checks about variables
with hard-coded values.

The patch also moves the initialization of those variables to a separate
function, that will possibly have different values per ASIC.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs_drv.c | 56 +++++++++++-------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 42a8c0b7279a..6f6dbe93f1df 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -172,6 +172,17 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	return rc;
 }
 
+static void set_driver_behavior_per_device(struct hl_device *hdev)
+{
+	hdev->mmu_enable = 1;
+	hdev->cpu_enable = 1;
+	hdev->fw_loading = 1;
+	hdev->cpu_queues_enable = 1;
+	hdev->heartbeat = 1;
+
+	hdev->reset_pcilink = 0;
+}
+
 /*
  * create_hdev - create habanalabs device instance
  *
@@ -196,29 +207,25 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	if (!hdev)
 		return -ENOMEM;
 
+	/* First, we must find out which ASIC are we handling. This is needed
+	 * to configure the behavior of the driver (kernel parameters)
+	 */
+	if (pdev) {
+		hdev->asic_type = get_asic_type(pdev->device);
+		if (hdev->asic_type == ASIC_INVALID) {
+			dev_err(&pdev->dev, "Unsupported ASIC\n");
+			rc = -ENODEV;
+			goto free_hdev;
+		}
+	} else {
+		hdev->asic_type = asic_type;
+	}
+
 	hdev->major = hl_major;
 	hdev->reset_on_lockup = reset_on_lockup;
-
-	/* Parameters for bring-up - set them to defaults */
-	hdev->mmu_enable = 1;
-	hdev->cpu_enable = 1;
-	hdev->reset_pcilink = 0;
-	hdev->cpu_queues_enable = 1;
-	hdev->fw_loading = 1;
 	hdev->pldm = 0;
-	hdev->heartbeat = 1;
-
-	/* If CPU is disabled, no point in loading FW */
-	if (!hdev->cpu_enable)
-		hdev->fw_loading = 0;
 
-	/* If we don't load FW, no need to initialize CPU queues */
-	if (!hdev->fw_loading)
-		hdev->cpu_queues_enable = 0;
-
-	/* If CPU queues not enabled, no way to do heartbeat */
-	if (!hdev->cpu_queues_enable)
-		hdev->heartbeat = 0;
+	set_driver_behavior_per_device(hdev);
 
 	if (timeout_locked)
 		hdev->timeout_jiffies = msecs_to_jiffies(timeout_locked * 1000);
@@ -228,17 +235,6 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	hdev->disabled = true;
 	hdev->pdev = pdev; /* can be NULL in case of simulator device */
 
-	if (pdev) {
-		hdev->asic_type = get_asic_type(pdev->device);
-		if (hdev->asic_type == ASIC_INVALID) {
-			dev_err(&pdev->dev, "Unsupported ASIC\n");
-			rc = -ENODEV;
-			goto free_hdev;
-		}
-	} else {
-		hdev->asic_type = asic_type;
-	}
-
 	/* Set default DMA mask to 32 bits */
 	hdev->dma_mask = 32;
 
-- 
2.17.1

