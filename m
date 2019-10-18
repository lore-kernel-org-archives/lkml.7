Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65B8CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC9B2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxRofBTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502079AbfJRU4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:56:47 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:47445 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbfJRU4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:56:46 -0400
Received: by mail-ua1-f74.google.com with SMTP id 4so1013011uay.14
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pFSHWfsa4OYLf86WgPeUBVlVGsm2bxueW/eIsJSwKiQ=;
        b=ZxRofBTLLxqPyCT9Ejy040W4kNnnOcsZi+MYGlj8YmtDrP9euwn9536tbUMP5I5E9E
         F0qx7pSkCzwWzszOhh0BzfZEdDFhioSEIQsOAfXYzm67ai6YT5MHVUIh3otszhFmuwXm
         g3AqXIn7dagWoecDRZTNGWVxcocTUDUSU3HbY4V/ColcRzFd3jctb+BIV4Gt/lHRqXVg
         Ru7ba3cotGuss8tpCcF2Gt34tcszr8ssTjjdaM3cj+weEdMzb/JIGkO2ToQDLHGjH4iL
         qE9H6KIJiORtyryH1SHjaK45+zN7i1fJGvekzSHyy3Gdl62cIuKAlqcUdWw0l7TCTYVj
         YKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pFSHWfsa4OYLf86WgPeUBVlVGsm2bxueW/eIsJSwKiQ=;
        b=PPIslm/QGimVHVJT74TOhrW8IdFeIWyKdiQZz45dXzxzyo71e5Yb/zLvpfIOEPQPBG
         ETB4UOnUTPPsfBQ8e0TA2z14KRpLQ+pdMUwtvuHO4SY1fzSDH2glFSJToagNvm0Kft8v
         FyLEXLD4t4L45hnEtFuvIGN5F0ywri2hwSWYwO7BboV8bRuFiwNWrJHdORbj4njnxoo9
         cliEN4y81tAbCK9mJ6PxRyg8qcevxfd9amwEFfVWH3FJ3yXg1jeji024jrx/fP+FmxX+
         nYFSJJL9xnc8SNrWSadhOXVksxINNn1DXK4/sEWsBvZAJdjYV9uVrnUlFPS8rO6qku8I
         ZuWQ==
X-Gm-Message-State: APjAAAXKbqKv+XdSf3PQYubQRZ/05l2BhqSCKvKuPGZo/AbA9qAUqGCH
        nma2rO1wFG/W5ZYNMHJsRRKkbEsMYA==
X-Google-Smtp-Source: APXvYqw3YHqNer9uDRETXpkMeSewm1GG1VHr/SMOl/zfhsvRorqD8QIY7Bi+m+OskYEEZDdwy6ZMEtTZhw==
X-Received: by 2002:ac5:cb62:: with SMTP id l2mr6580899vkn.32.1571432203606;
 Fri, 18 Oct 2019 13:56:43 -0700 (PDT)
Date:   Fri, 18 Oct 2019 22:56:29 +0200
Message-Id: <20191018205631.248274-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 1/3] binder: Fix race between mmap() and binder_alloc_print_pages()
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>, jannh@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binder_alloc_print_pages() iterates over
alloc->pages[0..alloc->buffer_size-1] under alloc->mutex.
binder_alloc_mmap_handler() writes alloc->pages and alloc->buffer_size
without holding that lock, and even writes them before the last bailout
point.

Unfortunately we can't take the alloc->mutex in the ->mmap() handler
because mmap_sem can be taken while alloc->mutex is held.
So instead, we have to locklessly check whether the binder_alloc has been
fully initialized with binder_alloc_get_vma(), like in
binder_alloc_new_buf_locked().

Fixes: 8ef4665aa129 ("android: binder: Add page usage in binder stats")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/android/binder_alloc.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index eb76a823fbb2..21952dfa147d 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -841,14 +841,20 @@ void binder_alloc_print_pages(struct seq_file *m,
 	int free = 0;
 
 	mutex_lock(&alloc->mutex);
-	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-		page = &alloc->pages[i];
-		if (!page->page_ptr)
-			free++;
-		else if (list_empty(&page->lru))
-			active++;
-		else
-			lru++;
+	/*
+	 * Make sure the binder_alloc is fully initialized, otherwise we might
+	 * read inconsistent state.
+	 */
+	if (binder_alloc_get_vma(alloc) != NULL) {
+		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+			page = &alloc->pages[i];
+			if (!page->page_ptr)
+				free++;
+			else if (list_empty(&page->lru))
+				active++;
+			else
+				lru++;
+		}
 	}
 	mutex_unlock(&alloc->mutex);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
-- 
2.23.0.866.gb869b98d4c-goog

