Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD9DC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D51D2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0ovaDdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbfGRIsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:48:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36590 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:48:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so27778416wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SuXqyPAcJbV/ZT1YP0LMBniVGMFj3t4c1tGQ9Lrmu74=;
        b=o0ovaDdoMLzcTFBPoX+4wzYH2fkIPrs06qPfxO1GtR+XypODgS8FRLw0QubfjsX5DU
         9lJALk4N6kdYSmyY5ncK2rGEjV6geOxKjDmkWfHem/pnJWbVbrnYcgmVcFdyRJbBUcpc
         +oXbM+yaJLF20zkSFV8G1Rba/bC5ClQstg7nXHNhl7x+M2rO96tzgVc/cNRFMypI4V58
         SzupPQPbzHfZgY+gdyPNnEXD6QzdawHoe1HZqOtFRI3uQaV8CkN8PQCiJ0oE49+n7Mgw
         V0sntcIxc3Qg+ru1qyuiamGmdeOw8yAR+ILuZeaRREgzJxPwnybxS7P7yEVp09rt7hWI
         lTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SuXqyPAcJbV/ZT1YP0LMBniVGMFj3t4c1tGQ9Lrmu74=;
        b=kevwKU9JQA32ZpywfXBOFmKZEw4udbYNbR+mIGN8wj9ZAnzkNpHc2IPyVcs2pnq2Nr
         0pm623TgekGrkZThcaz0yV7uV/QIeSOq4cqTs3A+a8jgWt0ud0bzPt6f/h4CuElCG9lK
         PirLifu+XQAD/It6OohW8AubjyQkWh1Is63pe8u8N1uTKtY7OmQo6mbYuHFBb5VrYINP
         7EDtFVnar0Wz2WOSViNp8YIdAb0EZ5v9bSZM1WWcu5mnVZ2Z2kdChV3Zerr+j9FBI9fv
         Ie+MQhsxdyu2z+uYlQqBDoGrlEeeLRBBLwWL0Elh2BMm4LdMfkziay1qvxDKiti7LO8v
         iP/A==
X-Gm-Message-State: APjAAAXq2LxXR9CR4WwNWzXlaKmawiO2OHstGmx2III1EjX3GhZo0XWu
        OcrR5FZku5kU8/At0SQ13CoGSqcj
X-Google-Smtp-Source: APXvYqzx7lbEaU52L59iidNIwtoSfLRnaUNgxbzMfqehqyCPlB4xLQofeuzwc+38F208rNsUNjcufQ==
X-Received: by 2002:adf:ca0f:: with SMTP id o15mr48446748wrh.135.1563439710707;
        Thu, 18 Jul 2019 01:48:30 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u2sm24855896wmc.3.2019.07.18.01.48.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 01:48:30 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: cap simulator timeout
Date:   Thu, 18 Jul 2019 11:48:28 +0300
Message-Id: <20190718084828.8581-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the driver timeout functions, we give the simulator a factor of 10
in the timeout. This was necessary when the requested timeout is small
but if it was a few seconds, this can result in a very large timeout which
is unnecessary.

This patch caps the maximum timeout of the simulator to 10 seconds, which
is our largest timeout in the code. That is more then enough for anything
the simulator is doing.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 10da9940ee0d..57183ae9b95d 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -36,6 +36,8 @@
 
 #define HL_PCI_ELBI_TIMEOUT_MSEC	10 /* 10ms */
 
+#define HL_SIM_MAX_TIMEOUT_US		10000000 /* 10s */
+
 #define HL_MAX_QUEUES			128
 
 #define HL_MAX_JOBS_PER_CS		64
@@ -1036,14 +1038,18 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	WREG32(mm##reg, (RREG32(mm##reg) & ~REG_FIELD_MASK(reg, field)) | \
 			(val) << REG_FIELD_SHIFT(reg, field))
 
+/* Timeout should be longer when working with simulator but cap the
+ * increased timeout to some maximum
+ */
 #define hl_poll_timeout(hdev, addr, val, cond, sleep_us, timeout_us) \
 ({ \
 	ktime_t __timeout; \
-	/* timeout should be longer when working with simulator */ \
 	if (hdev->pdev) \
 		__timeout = ktime_add_us(ktime_get(), timeout_us); \
 	else \
-		__timeout = ktime_add_us(ktime_get(), (timeout_us * 10)); \
+		__timeout = ktime_add_us(ktime_get(),\
+				min((u64)(timeout_us * 10), \
+					(u64) HL_SIM_MAX_TIMEOUT_US)); \
 	might_sleep_if(sleep_us); \
 	for (;;) { \
 		(val) = RREG32(addr); \
@@ -1067,11 +1073,12 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 #define hl_poll_timeout_memory(hdev, addr, val, cond, sleep_us, timeout_us) \
 ({ \
 	ktime_t __timeout; \
-	/* timeout should be longer when working with simulator */ \
 	if (hdev->pdev) \
 		__timeout = ktime_add_us(ktime_get(), timeout_us); \
 	else \
-		__timeout = ktime_add_us(ktime_get(), (timeout_us * 10)); \
+		__timeout = ktime_add_us(ktime_get(),\
+				min((u64)(timeout_us * 10), \
+					(u64) HL_SIM_MAX_TIMEOUT_US)); \
 	might_sleep_if(sleep_us); \
 	for (;;) { \
 		/* Verify we read updates done by other cores or by device */ \
@@ -1093,11 +1100,12 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 					timeout_us) \
 ({ \
 	ktime_t __timeout; \
-	/* timeout should be longer when working with simulator */ \
 	if (hdev->pdev) \
 		__timeout = ktime_add_us(ktime_get(), timeout_us); \
 	else \
-		__timeout = ktime_add_us(ktime_get(), (timeout_us * 10)); \
+		__timeout = ktime_add_us(ktime_get(),\
+				min((u64)(timeout_us * 10), \
+					(u64) HL_SIM_MAX_TIMEOUT_US)); \
 	might_sleep_if(sleep_us); \
 	for (;;) { \
 		(val) = readl(addr); \
-- 
2.17.1

