Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C904DC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9714C20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWqRYwOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfCDREv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:04:51 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42816 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:04:50 -0500
Received: by mail-qk1-f202.google.com with SMTP id 207so4888397qkf.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=y9YtX+guuq4jzTb5p6KJENEt5MDOMi6rFV456jle65Q=;
        b=CWqRYwOgcRdTy/1Zuf8A3CD/jL6JjEg15KYHyTccY8wV9VTBQZFKPDp7YcXEOJ24fR
         MSdmCSL73tkBebZK9OULfdflqqbl8LZsrwI17gQTN8ko6agIOf/R4gBl/HiR07eTdbER
         BaKm8iyStIOkCK7UjmOug4DEMbA+SZXW64b0UHxsMx7QR7LuZx6DYzI9kA52c99QZkuj
         +fdLeqGmGuzjo/8YIKNUuAqkd28EmzlINQz118sDfQJsa7kNKx5FPov5yz1VsMLkpI7Z
         Vx0NFv+uUFcHtx4VehXMJz8fL9q/Fq/o4b2kTqjb+cVZWg1o5vBMXZzzr3wZ8Fk+hgCY
         Ri7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=y9YtX+guuq4jzTb5p6KJENEt5MDOMi6rFV456jle65Q=;
        b=q9EFBTRij4v77Q6LLAWP8mctS7mAwa7TXbzYrf052o8inHWTqfkmQl+n5fW0M1F0V0
         PbOFB+B7Y9+aHtQE/LxYGOlSKboZAp2ScYs4PUh4UyDJfb/kde/pIZiGSF8rx8yxxYmc
         lYxHJd5StHbK8kagh1TdiHC4tRW4oqMe6W+HJmPnya3ehFpnhhYMM6puodtuBP+DEyvh
         sxTLYJzwDBMrupmLWUWT7vnEWWSfC1fH+XlmlqmF6dq9xi+WToyp3HJJU50nIi/hlfUq
         U3HtcTQTJ1/uXaLBMvLPg7oAswj21AfMlOqHHRZRdzyv8vs7JQ7HSoLzFXIvWlYUe9B+
         VGAg==
X-Gm-Message-State: APjAAAV5z/Ruj8+sDd4LidzQiAcP3yzBkZsmTZdouKzQp10oE+Y6ta0j
        tQb0g6mEL6OON23H5Za9H3vVYEltskpsiwSs
X-Google-Smtp-Source: APXvYqxtwN3Nu40niShYMTIoBxqcCBnOl1jnM4/HsXPlf1g0bpaPMXqeZBH1+ePQ3SuwTRGJ7sGylO2mohh48XlI
X-Received: by 2002:ac8:2539:: with SMTP id 54mr11239168qtm.45.1551719089934;
 Mon, 04 Mar 2019 09:04:49 -0800 (PST)
Date:   Mon,  4 Mar 2019 18:04:45 +0100
Message-Id: <1fa6fadf644859e8a6a8ecce258444b49be8c7ee.1551716733.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH] kasan: fix coccinelle warnings in kasan_p*_table
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_p4d_table, kasan_pmd_table and kasan_pud_table are declared as
returning bool, but return 0 instead of false, which produces a coccinelle
warning. Fix it.

Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 45a1b5e38e1e..fcaa1ca03175 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -42,7 +42,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
 #else
 static inline bool kasan_p4d_table(pgd_t pgd)
 {
-	return 0;
+	return false;
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
@@ -54,7 +54,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
 #else
 static inline bool kasan_pud_table(p4d_t p4d)
 {
-	return 0;
+	return false;
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -66,7 +66,7 @@ static inline bool kasan_pmd_table(pud_t pud)
 #else
 static inline bool kasan_pmd_table(pud_t pud)
 {
-	return 0;
+	return false;
 }
 #endif
 pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
-- 
2.21.0.352.gf09ad66450-goog

