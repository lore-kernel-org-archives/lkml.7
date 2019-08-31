Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C6EC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 11:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A944022CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 11:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGUFrqGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfHaLz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 07:55:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42714 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfHaLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 07:55:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id 26so3901513pfp.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 04:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jiPI/S1I8ovmltBRaSbmMFouXNTRLulDlE8rPr/ejko=;
        b=GGUFrqGAVjbyF5vKF3QF51JSgXMSZfxc7mdKdQy421z5AVSFolgparAvlh75IjaOO1
         7PcWSJ4fxcA3OHXKMqg7lai8U5bEr60glEVhd8RNRQ0r6k6KZT3kTS0PSddADp+rOdvk
         l1McEl6fVEe+X5umSQIxqN42n8gwqpiEXPR4+bEbz38lyiNoFuR3tZ+cdC88mGUOnjcN
         hqL6YkkjDXobfVk8b1BBUM+yVkcVqbnFmyFOMFGZuAp7qMhAPW2V3V2ZEjWAVI9pdd1m
         XwOgjgDZlBEYt4oGeR2l6JmVDkvqCgOCM3wc9eToZWJCuNkD4ygUDoTpGUMWyS/qK5ZG
         46gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jiPI/S1I8ovmltBRaSbmMFouXNTRLulDlE8rPr/ejko=;
        b=s1Iq8N5B2HTFcTA7Hgjwj/O7PmEWJWrom3VIJrkUd64xNhjP47Ke7IhqN6Xe6mHvIR
         +zhYXRzLu25vpJv4EowJSrpKEZRGEfyyld3FDyAdsQq8vo2CfBX4VF9furs+NvfpeXdy
         9ps/mXyiA4OIJeNN736SLokyj9f7RMckXo86cps27K3nFpdOcF6vmi9SOXWGJf0524C9
         2ppKmwBcMvY4vQU9iSBq8qaEVf8/ISXajn9VR44HPhOFkHO8LRDTCgphq20+2eG4VkkD
         jkjIiT+w0xGgacDFOy2UVyKNaMA6i/W3uVFk8N0dKqwa5gZHbdGlv2LLMKXgCaiLd3B0
         k4Hw==
X-Gm-Message-State: APjAAAXIPnK08rVZduOXcBHtGwt6j/wZvT2Obn7F0CopGfRH1li12P4n
        cvdXqJPG6+/q8pEhzAMPm6+5XjW1Qg8=
X-Google-Smtp-Source: APXvYqz8wPT9Oo/EEVfCWytD2ATICtzrqqQct0x8l87FYI1dLTg9Ot+r67im8hkY0QQzTA+N8NzwKg==
X-Received: by 2002:a17:90a:ad4a:: with SMTP id w10mr3617827pjv.41.1567252554735;
        Sat, 31 Aug 2019 04:55:54 -0700 (PDT)
Received: from localhost.localdomain ([183.83.73.90])
        by smtp.gmail.com with ESMTPSA id t15sm10353411pfc.47.2019.08.31.04.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 04:55:54 -0700 (PDT)
From:   Harsh Jain <harshjain32@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     harshjain32@gmail.com
Subject: [PATCH] staging:kpc2000: Fix long constant sparse warning
Date:   Sat, 31 Aug 2019 17:25:32 +0530
Message-Id: <20190831115532.2398-1-harshjain32@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fixed following warning in kpc2000 driver
"constant XXXX is so big it is unsigned long"

Signed-off-by: Harsh Jain <harshjain32@gmail.com>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 18 +++++++++---------
 drivers/staging/kpc2000/kpc2000/core.c       | 18 +++++++++---------
 drivers/staging/kpc2000/kpc_dma/fileops.c    |  8 ++++----
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index c124a836db27..738122afc2ae 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -53,15 +53,15 @@ struct core_table_entry {
 static
 void  parse_core_table_entry_v0(struct core_table_entry *cte, const u64 read_val)
 {
-	cte->type                = ((read_val & 0xFFF0000000000000) >> 52);
-	cte->offset              = ((read_val & 0x00000000FFFF0000) >> 16) * 4096;
-	cte->length              = ((read_val & 0x0000FFFF00000000) >> 32) * 8;
-	cte->s2c_dma_present     = ((read_val & 0x0008000000000000) >> 51);
-	cte->s2c_dma_channel_num = ((read_val & 0x0007000000000000) >> 48);
-	cte->c2s_dma_present     = ((read_val & 0x0000000000008000) >> 15);
-	cte->c2s_dma_channel_num = ((read_val & 0x0000000000007000) >> 12);
-	cte->irq_count           = ((read_val & 0x0000000000000C00) >> 10);
-	cte->irq_base_num        = ((read_val & 0x00000000000003F8) >>  3);
+	cte->type                = ((read_val & 0xFFF0000000000000UL) >> 52);
+	cte->offset              = ((read_val & 0x00000000FFFF0000UL) >> 16) * 4096;
+	cte->length              = ((read_val & 0x0000FFFF00000000UL) >> 32) * 8;
+	cte->s2c_dma_present     = ((read_val & 0x0008000000000000UL) >> 51);
+	cte->s2c_dma_channel_num = ((read_val & 0x0007000000000000UL) >> 48);
+	cte->c2s_dma_present     = ((read_val & 0x0000000000008000UL) >> 15);
+	cte->c2s_dma_channel_num = ((read_val & 0x0000000000007000UL) >> 12);
+	cte->irq_count           = ((read_val & 0x0000000000000C00UL) >> 10);
+	cte->irq_base_num        = ((read_val & 0x00000000000003F8UL) >>  3);
 }
 
 static
diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index cb05cca687e1..0a23727d0dc3 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -205,7 +205,7 @@ static void wait_and_read_ssid(struct kp2000_device *pcard)
 	u64 read_val = readq(pcard->sysinfo_regs_base + REG_FPGA_SSID);
 	unsigned long timeout;
 
-	if (read_val & 0x8000000000000000) {
+	if (read_val & 0x8000000000000000UL) {
 		pcard->ssid = read_val;
 		return;
 	}
@@ -213,7 +213,7 @@ static void wait_and_read_ssid(struct kp2000_device *pcard)
 	timeout = jiffies + (HZ * 2);
 	do {
 		read_val = readq(pcard->sysinfo_regs_base + REG_FPGA_SSID);
-		if (read_val & 0x8000000000000000) {
+		if (read_val & 0x8000000000000000UL) {
 			pcard->ssid = read_val;
 			return;
 		}
@@ -241,16 +241,16 @@ static int  read_system_regs(struct kp2000_device *pcard)
 	}
 
 	read_val = readq(pcard->sysinfo_regs_base + REG_CARD_ID_AND_BUILD);
-	pcard->card_id = (read_val & 0xFFFFFFFF00000000) >> 32;
-	pcard->build_version = (read_val & 0x00000000FFFFFFFF) >> 0;
+	pcard->card_id = (read_val & 0xFFFFFFFF00000000UL) >> 32;
+	pcard->build_version = (read_val & 0x00000000FFFFFFFFUL) >> 0;
 
 	read_val = readq(pcard->sysinfo_regs_base + REG_DATE_AND_TIME_STAMPS);
-	pcard->build_datestamp = (read_val & 0xFFFFFFFF00000000) >> 32;
-	pcard->build_timestamp = (read_val & 0x00000000FFFFFFFF) >> 0;
+	pcard->build_datestamp = (read_val & 0xFFFFFFFF00000000UL) >> 32;
+	pcard->build_timestamp = (read_val & 0x00000000FFFFFFFFUL) >> 0;
 
 	read_val = readq(pcard->sysinfo_regs_base + REG_CORE_TABLE_OFFSET);
-	pcard->core_table_length = (read_val & 0xFFFFFFFF00000000) >> 32;
-	pcard->core_table_offset = (read_val & 0x00000000FFFFFFFF) >> 0;
+	pcard->core_table_length = (read_val & 0xFFFFFFFF00000000UL) >> 32;
+	pcard->core_table_offset = (read_val & 0x00000000FFFFFFFFUL) >> 0;
 
 	wait_and_read_ssid(pcard);
 
@@ -401,7 +401,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 		goto err_release_dma;
 
 	// Disable all "user" interrupts because they're not used yet.
-	writeq(0xFFFFFFFFFFFFFFFF,
+	writeq(0xFFFFFFFFFFFFFFFFUL,
 	       pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
 
 	// let the card master PCIe
diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 48ca88bc6b0b..cb52bd9a6d2f 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -146,15 +146,15 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 			card_addr += desc->DescByteCount;
 
 			dma_addr  = sg_dma_address(sg) + (p * 0x80000);
-			desc->DescSystemAddrLS = (dma_addr & 0x00000000FFFFFFFF) >>  0;
-			desc->DescSystemAddrMS = (dma_addr & 0xFFFFFFFF00000000) >> 32;
+			desc->DescSystemAddrLS = (dma_addr & 0x00000000FFFFFFFFUL) >>  0;
+			desc->DescSystemAddrMS = (dma_addr & 0xFFFFFFFF00000000UL) >> 32;
 
 			user_ctl = acd->priv->user_ctl;
 			if (i == acd->mapped_entry_count-1 && p == pcnt-1) {
 				user_ctl = acd->priv->user_ctl_last;
 			}
-			desc->DescUserControlLS = (user_ctl & 0x00000000FFFFFFFF) >>  0;
-			desc->DescUserControlMS = (user_ctl & 0xFFFFFFFF00000000) >> 32;
+			desc->DescUserControlLS = (user_ctl & 0x00000000FFFFFFFFUL) >>  0;
+			desc->DescUserControlMS = (user_ctl & 0xFFFFFFFF00000000UL) >> 32;
 
 			if (i == acd->mapped_entry_count-1 && p == pcnt-1)
 				desc->acd = acd;
-- 
2.17.1

