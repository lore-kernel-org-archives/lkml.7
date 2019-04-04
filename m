Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E05DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616F42075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjJAumft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfDDTAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:00:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52209 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfDDTAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:00:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so4257358wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w9qSlfOttP+8Rf/TKo+6QSsCY8pdbQMEOp9+VSTfS7I=;
        b=mjJAumftLYEEgDmm4NxO/nWITLLT87Pjbumz0O/CzD9Luz/6ja88GNYDbiw/5LSZOx
         VXcV+/O3bOGCLigRT3N5cfaQoxWtu8SOJTMxtsIFupcfwADQEkiXfIin2UDm2+9NAcpo
         DePQFK+6DOBErUrw6Zq/sazbDDRJ3T2u+nDuJi+naimOr22ZotiaPu7JGxIdabu2E32J
         EO5vE95tD1SEfOTe10u/FKThmBNt6fiMApim4JmT/2O9bYhCkVSWyk6Ips2ksmAoBeRy
         xfSfK/NtCOZt1IT2A8ugbpRDMojERJtY/bFB09vLN/59mRp7J9dmm1AloZdy6M2ztmZR
         dPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w9qSlfOttP+8Rf/TKo+6QSsCY8pdbQMEOp9+VSTfS7I=;
        b=GWjleL6JyYTxMcbpAc8bn3nrznEjaoJmxoh8HpT1tQHNf++AOcMXLU+1emuf/zNgVt
         9dIf59RF61oXIBdHMighmnNbQYwQ/QACLdCD1xqEkullvf4a9W7VsgiC8pDhpMQXynHN
         pJLrlcu1GhFggRHcZkasUCJx/U54KqWM/LkFrll0dudvEaGgcZpeCuwOzS9F+hQARTTS
         8S38KvZ5VSXsqfxBhMARTqcGrzGP54eDdzbcvbLpo+P7SMBxk4s07pxwjBVNnjylWumT
         G6Ag+t3k8FZtHAlXNrPwbz4TuwKnytMjnlo7ls17Z62pZooNGS3yKfBnBlIAGYqMgcqw
         jcSQ==
X-Gm-Message-State: APjAAAU24RrrGKg4zfyiZCfwNF3YaTtpAcAm8PALhsX5F8AVh3xxhd3x
        othwD+DwaCQ/zxNZtdP0UgetXLhQ
X-Google-Smtp-Source: APXvYqxyElzVHQybImhuLZ8zibsjOWdttvD0aVZT3pu2GV6gJgGXMJkFB8iUot+XHTNwrqzUEUNC0Q==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr5144802wma.38.1554404405352;
        Thu, 04 Apr 2019 12:00:05 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o4sm41137280wmo.20.2019.04.04.12.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 12:00:04 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/3] habanalabs: ASIC_AUTO_DETECT enum value is redundant
Date:   Thu,  4 Apr 2019 22:00:00 +0300
Message-Id: <20190404190001.28337-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404190001.28337-1-oded.gabbay@gmail.com>
References: <20190404190001.28337-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the enum value of ASIC_AUTO_DETECT because we can use
the validity of the pdev variable to know whether we have a real device or
a simulator. For a real device, we detect the asic type from the device ID
while for a simulator, the simulator code calls create_hdev() with the
specified ASIC type.

Set ASIC_INVALID as the first option in the enum to make sure that no
other enum value will receive the value 0 (which indicates a non-existing
entry in the simulator array).

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h     | 8 +++-----
 drivers/misc/habanalabs/habanalabs_drv.c | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 535d4f9531f6..2f02bb55f66a 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -390,14 +390,12 @@ struct hl_eq {
 
 /**
  * enum hl_asic_type - supported ASIC types.
- * @ASIC_AUTO_DETECT: ASIC type will be automatically set.
- * @ASIC_GOYA: Goya device.
  * @ASIC_INVALID: Invalid ASIC type.
+ * @ASIC_GOYA: Goya device.
  */
 enum hl_asic_type {
-	ASIC_AUTO_DETECT,
-	ASIC_GOYA,
-	ASIC_INVALID
+	ASIC_INVALID,
+	ASIC_GOYA
 };
 
 struct hl_cs_parser;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index b697339d3904..1667df7ca64c 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -218,7 +218,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	hdev->disabled = true;
 	hdev->pdev = pdev; /* can be NULL in case of simulator device */
 
-	if (asic_type == ASIC_AUTO_DETECT) {
+	if (pdev) {
 		hdev->asic_type = get_asic_type(pdev->device);
 		if (hdev->asic_type == ASIC_INVALID) {
 			dev_err(&pdev->dev, "Unsupported ASIC\n");
@@ -337,7 +337,7 @@ static int hl_pci_probe(struct pci_dev *pdev,
 		 " device found [%04x:%04x] (rev %x)\n",
 		 (int)pdev->vendor, (int)pdev->device, (int)pdev->revision);
 
-	rc = create_hdev(&hdev, pdev, ASIC_AUTO_DETECT, -1);
+	rc = create_hdev(&hdev, pdev, ASIC_INVALID, -1);
 	if (rc)
 		return rc;
 
-- 
2.17.1

