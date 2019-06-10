Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D2CC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497D9206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXH131DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbfFJTPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:15:31 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52379 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389199AbfFJTOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:35 -0400
Received: by mail-vs1-f74.google.com with SMTP id b70so3384112vsd.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=boLZuSG3N/M8DQ81P181ktkcspG8tZVzYoDDzeN32S8=;
        b=iXH131DKGX2UMUlAAUKxHnoRXNmqPh28xSMaCgEFeFtAR80G8MAMxI1PfRZ9B3r18n
         d5ZJzNkdUIyvrBOK46suRLEJAlaPOGJYwj7mBlrPRxYk9Ly10frk6YvNWTTHM5vbRdXg
         xmKYG28r+BUQxAMGQ3HArjyLuPNPNZg7poHBscgfk2LQUP++hrYIh18TuzPcopo22Jfc
         kXFjPJzHP+EqnT2xTwPBDyBodzDROX+K8E3zAm7sRmpexjjorM87Ht52fvqkt/Y5zD3L
         mUeNtWZuP2pDXDm2P43dls7kFaI2e9/90OO9GuwDK/jkUGTTIbPpHL9tXhPqxKwjvDV8
         EqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=boLZuSG3N/M8DQ81P181ktkcspG8tZVzYoDDzeN32S8=;
        b=oKE447TiHumPvye03FyZec5crWjhlC5UnAUXcZX/MqGTdKFffWp53l83cUEHWKCSML
         jbBLdGTXiHf8uh3rsY0/5uPVkMuTPmQitryBnPGRJC762jX6rFuSdAw+bt3sU7iit45G
         4k++7J8FgPO3vl8ZOOl5oc1PTOMQ8TxAmBfe5dSBv1zFLPOmij1SSQaJlSK38DR76ERa
         Q0UPl2IGjjmR1WmUI80HPjCKKhMG0+DpnGWfc4Ab4anjPhosC/FdUczCq+vep/iKAiRt
         IOdFbOZjB/qBfzdNIXbVL8yHtQFR6cxMeySPDouY3SpNmUmpZ4ApaT0v0ukkD5u9Hvol
         /5cQ==
X-Gm-Message-State: APjAAAW7WR+ohPb+kYdZBTKag3oA3ImK3AsT13pe09m1FyZ2OvRcO0CE
        5mKO56e3wgDq0K3QcQ29W6OWdzZU0g==
X-Google-Smtp-Source: APXvYqzdoEf4jWI24NW1XHaaDjxDWgWHFwRIZbIFV5V22iA8DuN3pc9LCBZTnlLaSiIhw1BJJ3513F06NQ==
X-Received: by 2002:a67:2781:: with SMTP id n123mr37283823vsn.141.1560194074287;
 Mon, 10 Jun 2019 12:14:34 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:14:21 +0200
Message-Id: <20190610191422.177931-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 1/2] EDAC, ie31200: Add Intel Coffee Lake CPU support
From:   Marco Elver <elver@google.com>
To:     bp@alien8.de, tony.luck@intel.com, jbaron@akamai.com
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coffee Lake seems to work like Skylake and Kaby Lake. This patch adds all
device IDs for Coffee Lake-S CPUs according to datasheet.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---

v2:
- Reverted formatting existing pci_tbl entries.

Tested with a Xeon E-2124G.
---
 drivers/edac/ie31200_edac.c | 58 +++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index adf60eb45bd4..cdb26014d929 100644
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
 
@@ -569,6 +591,36 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{
 		PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_4), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_5), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_6), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_7), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
+	{
+		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, IE31200},
 	{
 		0,
 	}            /* 0 terminated list. */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

