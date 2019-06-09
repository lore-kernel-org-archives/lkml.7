Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C94C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B072070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 15:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwPnhSFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfFIPRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 11:17:07 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:33898 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbfFIPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 11:17:06 -0400
Received: by mail-yw1-f74.google.com with SMTP id q8so7275288ywc.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qKJDlF41n2EgvfZqLQFoJ0x9Menf4fYRMFv6XR4X2Ss=;
        b=nwPnhSFyKJ/Gsm2uw7Y+IY923p8lZHU4t6P6tnxAjxi+fElFp0M0kaSSi+1y7Dz/c/
         kN+5JPoAtBEI095SMNkqBK81sozEopfkiCAL8WIAuxYaYwoDGou6jJhs+VXU+LF1Wg3g
         Vl0eP+lyoBFWm00Zp5AHkd7rbGUurFsq7R2fb1CBE7Pk0GP9s9SIqIu8oA02hG5fRLQ5
         uCzIC7jNqukI4RolIP8p/6WVvdrRQJBOhZX0UtAxhuvCnJsZXXZi8VDrcUXGrW/VpRTN
         WZ5AcQgaGZkw7UQVIdOAoIhqsSJSs4x+kScKCtCwWsvBkZeab8FW6i/YkB8x8eCFP06u
         2NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qKJDlF41n2EgvfZqLQFoJ0x9Menf4fYRMFv6XR4X2Ss=;
        b=nuCoUIZUVkG9+4glj3kEabNC7Ho6gEa9q8EINC+2wTMoZDu5oioUGt68fPKHU11Gc2
         0Wal0yk2hLpnTFSYNh/FiyVN+hBjNHVNd4x9yGXZ+Va1ine6u7XVrbUfijLgNoThTD2L
         ZAb+f3WjP0YGHrHw9VpD+Xm62QHUyYtyJPucxVI/3pYJ6ogayr4zhljGogNOxoGXOcaN
         eToSkBfsaiUbCgkHDcX1D17/ljE8ETUUwu2yvVRzsU5JteL5ldHIw03v7zDDoBzoZVFG
         /49sHKFEWynu3gxmY6U4ybKwP0jvBSaorZ/BRysWqsSIsWstizgnO3VUW+WgR7HwbSLU
         Jy3w==
X-Gm-Message-State: APjAAAVZRsuaoesHaAvUJH0n7SNp8Fkk07pLF/rCHjJ0n/QLYuTk8nDR
        khHcEDou5lweaNkrCHfMnvd6CRqq8Q==
X-Google-Smtp-Source: APXvYqw8iLrFEXhDaPCaURMJq2YfIiUlPeYbVxohMdJ7eZEqsVgH8JFE0J7HpHFKr1AMV7dWbyEtglRStQ==
X-Received: by 2002:a25:4742:: with SMTP id u63mr19267473yba.164.1560093425410;
 Sun, 09 Jun 2019 08:17:05 -0700 (PDT)
Date:   Sun,  9 Jun 2019 17:16:13 +0200
Message-Id: <20190609151613.195164-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] EDAC, ie31200: Add Intel Coffee Lake CPU support
From:   Marco Elver <elver@google.com>
To:     jbaron@akamai.com
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coffee Lake seems to work like Skylake and Kaby Lake. This patch adds all
device IDs for Coffee Lake-S CPUs according to datasheet.

Cc: Jason Baron <jbaron@akamai.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---

Tested with a Xeon E-2124G.
---
 drivers/edac/ie31200_edac.c | 95 +++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 31 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index adf60eb45bd4..e9ee3ff608b2 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -20,11 +20,13 @@
  * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
  * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
  * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
+ * 3e..: 8th/9th Gen Core Processor Host Bridge/DRAM Registers
  *
  * Based on Intel specification:
  * http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf
  * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200-family-vol-2-datasheet.html
  * http://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html
+ * https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-family-datasheet-vol-2.html
  *
  * According to the above datasheet (p.16):
  * "
@@ -61,6 +63,26 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
 
+/* Coffee Lake-S */
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK 0x3e00
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_1    0x3e0f
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_2    0x3e18
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_3    0x3e1f
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_4    0x3e30
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_5    0x3e31
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_6    0x3e32
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_7    0x3e33
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_8    0x3ec2
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9    0x3ec6
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10   0x3eca
+
+/* Helper macro to test if HB is for Skylake or later. */
+#define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
+	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
+	 (((did)&PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                   \
+	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
+
 #define IE31200_DIMMS			4
 #define IE31200_RANKS			8
 #define IE31200_RANKS_PER_CHANNEL	4
@@ -381,10 +403,10 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 	u32 addr_decode, mad_offset;
 
 	/*
-	 * Kaby Lake seems to work like Skylake. Please re-visit this logic
-	 * when adding new CPU support.
+	 * Kaby Lake, Coffee Lake seem to work like Skylake. Please re-visit
+	 * this logic when adding new CPU support.
 	 */
-	bool skl = (pdev->device >= PCI_DEVICE_ID_INTEL_IE31200_HB_8);
+	bool skl = DEVICE_ID_SKYLAKE_OR_LATER(pdev->device);
 
 	edac_dbg(0, "MC:\n");
 
@@ -542,36 +564,47 @@ static void ie31200_remove_one(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id ie31200_pci_tbl[] = {
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_5), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_6), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_7), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_8), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_5), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_6), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_7), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_8), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_5), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_6), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_7), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  IE31200 },
 	{
 		0,
-	}            /* 0 terminated list. */
+	} /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

