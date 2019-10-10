Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A920C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148D12067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="XJ9AzqJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbfJJNlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:41:21 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:51172 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfJJNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:41:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A5BEB3F32B;
        Thu, 10 Oct 2019 15:41:18 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=XJ9AzqJr;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PvCIW3Nwcj92; Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9D2A63F260;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 658F43610CE;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570714877; bh=I43d2BTecvoJPXAN1AxjOTn1uEK1Ks5L6V9rF+kVywU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJ9AzqJrkAVMR4RNVKFniF4BTgPqdLa+jiit+c4NumrcPH91KNui0QgSnvzaT0h1b
         Enxl+sJfziYIHP/L28Sv0vj8uxgmRM2AahsWxj9JoVctrzhjNVkJE+FO9HLi2E7dhY
         lXbUSY8Vh8b7YI3Shl123a996WCXuLCV5pRMl4V0=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name
Cc:     Thomas Hellstrom <thellstrom@vmware.com>
Subject: [RFC PATCH 3/4] mm: pagewalk: Disallow user positive callback return values and use them for walk control
Date:   Thu, 10 Oct 2019 15:40:57 +0200
Message-Id: <20191010134058.11949-4-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010134058.11949-1-thomas_os@shipmail.org>
References: <20191010134058.11949-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

When we have both a pmd_entry() and a pte_entry() callback, in some
siutaions it is desirable not to traverse the pte level.
Reserve positive callback return values for walk control and define a
return value PAGE_WALK_CONTINUE that means skip lower level traversal
and continue the walk.

Co-developed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 include/linux/pagewalk.h | 6 ++++++
 mm/pagewalk.c            | 9 ++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 6ec82e92c87f..d9e5d1927315 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -4,6 +4,12 @@
 
 #include <linux/mm.h>
 
+/*
+ * pmd_entry() Return code meaning skip to next entry.
+ * Don't look for lower levels
+ */
+#define PAGE_WALK_CONTINUE 1
+
 struct mm_walk;
 
 /**
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index ea0b9e606ad1..d2483d432fda 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -52,8 +52,12 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		 */
 		if (ops->pmd_entry)
 			err = ops->pmd_entry(pmd, addr, next, walk);
-		if (err)
+		if (err < 0)
 			break;
+		if (err == PAGE_WALK_CONTINUE) {
+			err = 0;
+			continue;
+		}
 
 		/*
 		 * Check this here so we only break down trans_huge
@@ -291,8 +295,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
  *
  *  - 0  : succeeded to handle the current entry, and if you don't reach the
  *         end address yet, continue to walk.
- *  - >0 : succeeded to handle the current entry, and return to the caller
- *         with caller specific value.
+ *  - >0 : Reserved for walk control. Use only PAGE_WALK_XX values.
  *  - <0 : failed to handle the current entry, and return to the caller
  *         with error code.
  *
-- 
2.21.0

