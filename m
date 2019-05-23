Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269E6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC20420863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5oj3c9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfEWNcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:32:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34614 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWNcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:32:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so4434376lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=1lShfxTWAZnn0xxmbff/egndjUhtx1mRABTy7i2apwY=;
        b=u5oj3c9EuRX/8mgsmB8f+22uOI2oYi8x5Itm62R6HZSQJv9DkeAbU44hmF/Vb6mGjK
         lnQGSVS5KcsYWTCRZapXhr3w7jx+6WoiQY3ww1nPedgx/AinwoobS42RShaxf2KwxcxO
         kbP8cF4yNnZLVcSz3JfVIEOLPuo5TvBihQtgzoKFcgRLnU7ckJw7Ar8mdA1zwFmh72fW
         ybwyAYGd6YDlw18clEXK/nTGKTmxOasfvqxNvrBsFkWJH5+VuzFRgrHeY847VcBtudlh
         ys5c3UNOA6hGYvGNIfyQE8xTkFG+ccmp6eI51gF8GgowatIsnOQP25NJNYZpODu7ikqr
         LO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=1lShfxTWAZnn0xxmbff/egndjUhtx1mRABTy7i2apwY=;
        b=CE1LfsjEOhKMMC2Ixh0vmDuqUZuV1/ctgOPNqWqsnHYvJb4RmVKhYNVv7TNc5vIPoV
         xPAfAZ0a6Lxx57uN2SfwnxPr23bwQZwFmFTv75jgvaQ/OVWdBt4E5Q1/sbFsyRrSMYE1
         z9SseeJEfjOhH+amq2DY8HrI6HqzwHA3XhgDn9UDHMZgfIVnBFQP5QdRY7nO06S5TaSX
         krs8wzVU95AcjniPzNwqXk98cbqXUNvZhPVVlIJcfAn7dh1FE8D45ytoJ0UKfOB1i/Va
         S+uo09D3f9JtsMbqh6AmUTHghqZmjfbeP44mBRVYbUK1phIrr/uqMyfl6N/2xSmVAx0Z
         WzhA==
X-Gm-Message-State: APjAAAWs75jjV28ER91JWxOdTFKiAfxraUVrWANsGf2vQrfD95HKs1yY
        RAP/OOBSb/f2Q94skpmSYUA=
X-Google-Smtp-Source: APXvYqw1rWwaalNTduK2+/sn9gsSAiOSi7BxDpd/1Ex1JIe/qGpx2Ax85hDl0z0zYMwZQTzjtBKQDA==
X-Received: by 2002:ac2:54af:: with SMTP id w15mr3011164lfk.8.1558618368247;
        Thu, 23 May 2019 06:32:48 -0700 (PDT)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id q28sm1035667lfp.3.2019.05.23.06.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 06:32:47 -0700 (PDT)
Date:   Thu, 23 May 2019 15:32:45 +0200
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksiy.Avramchenko@sony.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] z3fold: fix sheduling while atomic
Message-Id: <20190523153245.119dfeed55927e8755250ddd@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_alloc() may be called from z3fold_alloc() in atomic
context, so we need to pass correct gfp flags to avoid "scheduling
while atomic" bug.

Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
---
 mm/z3fold.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 99be52c5ca45..985732c8b025 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -190,10 +190,11 @@ static int size_to_chunks(size_t size)
 
 static void compact_page_work(struct work_struct *w);
 
-static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool)
+static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
+							gfp_t gfp)
 {
 	struct z3fold_buddy_slots *slots = kmem_cache_alloc(pool->c_handle,
-							GFP_KERNEL);
+							    gfp);
 
 	if (slots) {
 		memset(slots->slot, 0, sizeof(slots->slot));
@@ -295,10 +296,10 @@ static void z3fold_unregister_migration(struct z3fold_pool *pool)
 
 /* Initializes the z3fold header of a newly allocated z3fold page */
 static struct z3fold_header *init_z3fold_page(struct page *page,
-					struct z3fold_pool *pool)
+					struct z3fold_pool *pool, gfp_t gfp)
 {
 	struct z3fold_header *zhdr = page_address(page);
-	struct z3fold_buddy_slots *slots = alloc_slots(pool);
+	struct z3fold_buddy_slots *slots = alloc_slots(pool, gfp);
 
 	if (!slots)
 		return NULL;
@@ -912,7 +913,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 	if (!page)
 		return -ENOMEM;
 
-	zhdr = init_z3fold_page(page, pool);
+	zhdr = init_z3fold_page(page, pool, gfp);
 	if (!zhdr) {
 		__free_page(page);
 		return -ENOMEM;
-- 
2.17.1
