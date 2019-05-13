Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84584C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5676B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIZBhs3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbfEMOrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:47:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54725 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbfEMOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:47:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so8363036wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ALWueNgHHs3ZajRzWLC6W++2c5xP+kZBpwlzia5t3sw=;
        b=DIZBhs3+DdvpI1CqvIXZAGc5lF8SZVfY2jzm63MUvuntyEL4MNiatQ0+aS4d5PhXRR
         VvHaULiYpyHb6UvspJLZHVYGkkr1HVl79wZ6GzQN5cUu2FVhlwhzPiE4BHGQXal7UqTV
         ZDGytr9vh6+u8P/dXDoJTTBCGnm3ykaoUJ0FgmPbflwTdeAK2/00h2o0ogW6CfshZ1dN
         2nB+gMQjEMtamV8JZdshw0Z1HVXQfFIx8lJaFrG21aJmEPzDrk68dnHsoeTVImrELbYk
         fDftO7zSkaqXWS7QTcNi/nt1ecJ5wGSe/0anDHr1AYYJa8FCwVRkoN2I8UXh8B7FOBny
         a/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ALWueNgHHs3ZajRzWLC6W++2c5xP+kZBpwlzia5t3sw=;
        b=D0bIToto9ZEvMvIOkIxItLScT5yws9oJRdeiVRoFAanhVLU6QGlOeAo74D5HadlYxK
         z8uKuhJegwPJWBBpsVJzXjS4obJXQtCIBZq7kT2/zLT1tbV388PYmEn8WZuy3heoQEx1
         V+KpaPtIcBPOH2oBqx/c529U4aqfLnz0iwI4JkTjD026hv97hddEXHjw8PFSRRMiiuoZ
         VxAb9SP4ol/uBPt8NNKbXv6PWJb6zrZ+PmlVL1o9sOmo620EzUcKpp8a1US8rrEXR9Av
         P7UPOQULg1DGbmsVB5yI9iqC5i6iDU+/VHNClwRRShMXuSwJocDyNnN+77L4Ak5/T4Z5
         Hqjg==
X-Gm-Message-State: APjAAAXlSobwfd/5ZErfz3/e9sJrLzo6eTz1iHF1UqSYcxH7vaDu59g9
        WLP8VHwiNlOQI4U4Fd6I3INsX1y2
X-Google-Smtp-Source: APXvYqzZ8fdmmFlLOfOgtMbKEXsTvxvbJSXY/+LygbnGMtNF5KV77IhMKtpiDSpRrKBHGscZJJWBDQ==
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr7207569wmk.22.1557758857815;
        Mon, 13 May 2019 07:47:37 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id f6sm10598235wmh.13.2019.05.13.07.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 07:47:37 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH] habanalabs: increase PCI ELBI timeout for Palladium
Date:   Mon, 13 May 2019 17:47:34 +0300
Message-Id: <20190513144734.23644-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch increases the timeout for PCI ELBI configuration to support low
frequency Palladium images.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h |  2 ++
 drivers/misc/habanalabs/pci.c        | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 2941838c04c1..9b1c03f1ab32 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -34,6 +34,8 @@
 #define HL_ARMCP_INFO_TIMEOUT_USEC	10000000 /* 10s */
 #define HL_ARMCP_EEPROM_TIMEOUT_USEC	10000000 /* 10s */
 
+#define HL_PCI_ELBI_TIMEOUT_MSEC	10 /* 10ms */
+
 #define HL_MAX_QUEUES			128
 
 #define HL_MAX_JOBS_PER_CS		64
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index 0e78a04d63f4..c98d88c7a5c6 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -10,6 +10,8 @@
 
 #include <linux/pci.h>
 
+#define HL_PLDM_PCI_ELBI_TIMEOUT_MSEC	(HL_PCI_ELBI_TIMEOUT_MSEC * 10)
+
 /**
  * hl_pci_bars_map() - Map PCI BARs.
  * @hdev: Pointer to hl_device structure.
@@ -88,8 +90,14 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	ktime_t timeout;
+	u64 msec;
 	u32 val;
 
+	if (hdev->pldm)
+		msec = HL_PLDM_PCI_ELBI_TIMEOUT_MSEC;
+	else
+		msec = HL_PCI_ELBI_TIMEOUT_MSEC;
+
 	/* Clear previous status */
 	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, 0);
 
@@ -98,7 +106,7 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_CTRL,
 				PCI_CONFIG_ELBI_CTRL_WRITE);
 
-	timeout = ktime_add_ms(ktime_get(), 10);
+	timeout = ktime_add_ms(ktime_get(), msec);
 	for (;;) {
 		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, &val);
 		if (val & PCI_CONFIG_ELBI_STS_MASK)
-- 
2.17.1

