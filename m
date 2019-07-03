Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261DFC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5E8218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIZ+QjmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfGCQaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:30:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34668 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfGCQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:30:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so1533480plt.1;
        Wed, 03 Jul 2019 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sWA+8J2rSgIapxEvPrdhvzsbd/hl1uuQJT8SGPnww+g=;
        b=FIZ+QjmOinajLJg2asmfCN0UL5nbWAIVO3EZ3yUaJUBmqqc9WUWCY/6EWbCnzxXGMe
         LwA/1ZpnjqlYHyeggJ3Re9eD+AeoCWKcVk2a+LmOHmf6jhqgIDNailwMLDJDR8OJJaZ4
         +4fKc/H01jPaCXf9gy8Sifze4cCTi17+49znbXfqXKPGXcUh7uRT/DzRwrj3YPWeWdMg
         V2ya/cCRrCjxxuFRrQ6r1bD/MimWhE8kk5dwymljYoMPV+ia+5gc2uBHF4gHQbwuBX0A
         WoYLz2QPapqy/YMwqW3+7sxsykF3BzXughF4YqwNHCehTk+etRfgNdVgs5luI2cnZEhy
         DlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sWA+8J2rSgIapxEvPrdhvzsbd/hl1uuQJT8SGPnww+g=;
        b=NX/w5WDfyyA53gkBlaYx84uw/hWnphJu8yeJ3cxnVBC9PepXmaZq2btQUKgaaitcv1
         Am4hMRRsccqK08duN0LXNzOS0DZRXlJabgfFUIPvDhDLMhqx/oxI8d13B8GvxGcncosn
         r1VuapZXNtMNf0OXRZNMVTSsjsfvtAWXpTHE8HmNk8H7mskMd2C9c1e/yF9hbKSeYMeM
         OwlmQT1EMY3VfMghApmjP84MctVUpDijsTbG+6ApOS/ZbUrNVREJxMg/GqSwcPs7IH0d
         e2lfJJWg2of/ONBQ1w/8s/Zd7DZ1hTpwi/mnJbktz7XA/59/yUqmEns+UoIp6ttQOC7L
         nZug==
X-Gm-Message-State: APjAAAVtI6zD/Yo9nPmran7v/FEuvEm0SvvuLJlY1obIqeErJvcWurHO
        6iXQ09AIb60EcxFmF8xNO6I=
X-Google-Smtp-Source: APXvYqwsafC/F/Y/6lwyuRes8D5JprdTxE1+fbLr1GrD1jiTOJCYdz+TVvfT9i4buk5iyZ7Ey2Qy7Q==
X-Received: by 2002:a17:902:7248:: with SMTP id c8mr6203101pll.162.1562171399475;
        Wed, 03 Jul 2019 09:29:59 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id p13sm8179907pjb.30.2019.07.03.09.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:29:59 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 20/35] platform/x86/asus: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:29:51 +0800
Message-Id: <20190703162951.32737-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)
  - Split into two patches.

 drivers/platform/x86/asus-wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9b18a184e0aa..472b317ad814 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -260,12 +260,11 @@ static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
 	 * Copy to dma capable address otherwise memory corruption occurs as
 	 * bios has to be able to access it.
 	 */
-	input.pointer = kzalloc(args.length, GFP_DMA | GFP_KERNEL);
+	input.pointer = kmemdup(args.pointer, args.length, GFP_DMA | GFP_KERNEL);
 	input.length = args.length;
 	if (!input.pointer)
 		return -ENOMEM;
 	phys_addr = virt_to_phys(input.pointer);
-	memcpy(input.pointer, args.pointer, args.length);
 
 	status = asus_wmi_evaluate_method(ASUS_WMI_METHODID_AGFN,
 					phys_addr, 0, &retval);
-- 
2.11.0

