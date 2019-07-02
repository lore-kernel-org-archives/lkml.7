Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1E0C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5140520659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z37uH13G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGBH6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34990 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfGBH6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so7851377pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gtR3W8cNK4Xe7N97wr9wNOK1b76MJzoKS2zMLIXyrNY=;
        b=Z37uH13GxqsV5ei17LUBkHq/pRF9kUmPZx/zdRoCLubYfcmzKio6dtxou1dkO8cAmz
         wiuqSOipG1hzG2Rn0M66nn7MiTgXl/2GNe9VVT2vsDJ7Nyagw9vsI4ybFTg7sSDckQHk
         J6/eIc46vuwaxGyR891axLuLnVEFYsY++hJEM5w3q/WpF3SzLh7cHwSka4ds95ixcNL1
         NFOynlsSvVXvKK8JCcir4+DSERqHIBdiaYbHlzG1RQezseldRGlqRVmPZj4FT3AMUSyG
         rLsTfum++/7rK35svwkaIApIlikERCG9J8+KHvKb3XGeCx6xcUJm61nbbNl3LX2E8GKp
         xiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gtR3W8cNK4Xe7N97wr9wNOK1b76MJzoKS2zMLIXyrNY=;
        b=iIUQjfNNmJbBPLW7LdNNpHRRYgjrtlUodtl/v43J6aDQT+PXqrfOHOF9tD5srbG6YO
         0lg7qx3kbKE0cakApjTVJoQtTJstut98i+qAvdzfseZJ5PzFAqKoMLXGs6BMBut70c9S
         80/FTtGGyHD8PnuVI2TBz2538tHVMlC5C0BrqpFGTUicHyUtGgz4foEBivG//H6qkWLO
         U82iSsNgAhqMl+il0HSbyi6cLF03w8Q2OtBV6nixQaASs5F7Cg8WuoJ47V8yW7bgp2FX
         p+KRF/MEMH1W4MHet3fKtoUmiSySpShYSSxZhOTr40vZV/wGAZJXrrbVUyBWaXIM6tMC
         ssoA==
X-Gm-Message-State: APjAAAXHaAmIHwtBJD08oifo8xMjybzl9tQb8OdW2iXPUNqC4md+eBv2
        ttMXk9SLGc+ut7Hkpojba5cCot184iY=
X-Google-Smtp-Source: APXvYqzVi+Kl60mGgdJZcVwwnWP59gHB7iT7sKTR6H177UgzGpEMHsnrH6ut2TmD1IHNH4sKMfAtWg==
X-Received: by 2002:a63:f64a:: with SMTP id u10mr29651444pgj.329.1562054303023;
        Tue, 02 Jul 2019 00:58:23 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id s20sm12857514pfe.169.2019.07.02.00.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:58:22 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 12/27] media: use kzalloc instead of kmalloc and memset
Date:   Tue,  2 Jul 2019 15:58:18 +0800
Message-Id: <20190702075818.24066-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc followed by a memset with kzalloc.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Resend

 drivers/media/usb/pvrusb2/pvrusb2-eeprom.c | 3 +--
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-eeprom.c b/drivers/media/usb/pvrusb2/pvrusb2-eeprom.c
index 79f0e0c6df37..fac90af8b537 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-eeprom.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-eeprom.c
@@ -39,7 +39,7 @@ static u8 *pvr2_eeprom_fetch(struct pvr2_hdw *hdw)
 	int ret;
 	int mode16 = 0;
 	unsigned pcnt,tcnt;
-	eeprom = kmalloc(EEPROM_SIZE,GFP_KERNEL);
+	eeprom = kzalloc(EEPROM_SIZE,GFP_KERNEL);
 	if (!eeprom) {
 		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
 			   "Failed to allocate memory required to read eeprom");
@@ -74,7 +74,6 @@ static u8 *pvr2_eeprom_fetch(struct pvr2_hdw *hdw)
 	   (1) we're only fetching part of the eeprom, and (2) if we were
 	   getting the whole thing our I2C driver can't grab it in one
 	   pass - which is what tveeprom is otherwise going to attempt */
-	memset(eeprom,0,EEPROM_SIZE);
 	for (tcnt = 0; tcnt < EEPROM_SIZE; tcnt += pcnt) {
 		pcnt = 16;
 		if (pcnt + tcnt > EEPROM_SIZE) pcnt = EEPROM_SIZE-tcnt;
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 70b5cb08d65b..ff75b4a53dfa 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -3309,7 +3309,7 @@ static u8 *pvr2_full_eeprom_fetch(struct pvr2_hdw *hdw)
 	int ret;
 	int mode16 = 0;
 	unsigned pcnt,tcnt;
-	eeprom = kmalloc(EEPROM_SIZE,GFP_KERNEL);
+	eeprom = kzalloc(EEPROM_SIZE,GFP_KERNEL);
 	if (!eeprom) {
 		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
 			   "Failed to allocate memory required to read eeprom");
@@ -3344,7 +3344,6 @@ static u8 *pvr2_full_eeprom_fetch(struct pvr2_hdw *hdw)
 	   (1) we're only fetching part of the eeprom, and (2) if we were
 	   getting the whole thing our I2C driver can't grab it in one
 	   pass - which is what tveeprom is otherwise going to attempt */
-	memset(eeprom,0,EEPROM_SIZE);
 	for (tcnt = 0; tcnt < EEPROM_SIZE; tcnt += pcnt) {
 		pcnt = 16;
 		if (pcnt + tcnt > EEPROM_SIZE) pcnt = EEPROM_SIZE-tcnt;
-- 
2.11.0

