Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F10C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B3E2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKiijk8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfGSCHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 22:07:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43199 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfGSCHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:07:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so13715709pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 19:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cn6HpCqocofcTiM1Gleeu1RdMvR6xgTxVinOm89T4fE=;
        b=vKiijk8E2GYJLmXCSqisDXKNeVkOdK0i96hFcY3sJE7srh2/Vj0RX1QkFlZN+RZIRo
         nENub6q4UVws0K+D84WGMBkqQh+V6PbFYUTtthmE+GwfVHqDxpkY8zrofMtEGIdVEyxn
         Zs1bP/PB5idBKt4D8GK/w+Sp1I2o7cT0Ihbb5NNstyj2rv2oNNYeL9AXIRXgpexhWzmF
         HlWQJqLV7H7II0Xt9LoyCqnOz8t4gxQ6OqluB9RNuW4gWwtadxmw4XNGFb23te97BQmc
         ge9o6JKyBrJF+GoUNOch29h5SJKfv9TSwwLAq6C0P9YfbRgGqAGuARQeIAWGDqZETKn6
         sGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cn6HpCqocofcTiM1Gleeu1RdMvR6xgTxVinOm89T4fE=;
        b=Wpqawy6KbyvPTRrJ5WNymPYJFXRau+0GxK3O5GFzpCM2UzUMMNzpQLgLe91aBY5ijS
         ZgsQqtN4ausldIdvJU/EzcbUArIlZzy0hAw2S3KY2lQ1+S7U204jDcRJ7UjLJVaUogBj
         RRavBH6x7Bk3MLrrYQ1lmvLBkLcDJkJraiFmu3FGkCbbj3hQASL11OC/RBfcV7dxBghU
         aOWXtbntRYF1/H8pkgOlsxtWBIrga9QBh7hYC2jlwi4QR0pTgRGhYLlt9IkZ9N+lPel7
         EkhaE41qQ4svrV6GZOqnV8bJwJDHGgkv+5pGIhJEYPGdeGyHaI4iagWgB5ixdtmxyxkx
         9ogw==
X-Gm-Message-State: APjAAAWNUGw1rCvdK4Tx5db1TVkWT51Q+36bETpz0vXiD+xkpwoY52p1
        a5MEiA00gE9Tx/PyLLikKUI=
X-Google-Smtp-Source: APXvYqywOrUiB4kg7/DmwawT/8/A7EhERe2Wb4P1JJ4zXNsXJkbgA6JDlshugGSGnAR+inPbHyVdTA==
X-Received: by 2002:a17:90b:94:: with SMTP id bb20mr55478290pjb.16.1563502067163;
        Thu, 18 Jul 2019 19:07:47 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id d6sm25139253pgf.55.2019.07.18.19.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 19:07:46 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     squashfs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        huyue2@yulong.com
Subject: [PATCH RESEND v2] squashfs: avoid to allocate page actor when to read into the page cache
Date:   Fri, 19 Jul 2019 10:06:53 +0800
Message-Id: <20190719020653.8396-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, we will allocate page actor in squashfs_readpage_block() via
kmalloc() if enable SQUASHFS_FILE_DIRECT option. However, the actor size
is small and it will be freed finally in this function. So, use stack
memory will be better for that case to avoid out of memory.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: fix commit message

 fs/squashfs/file_direct.c | 10 +++-------
 fs/squashfs/page_actor.c  | 10 ++--------
 fs/squashfs/page_actor.h  |  4 ++--
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index a4894cc..98c2dd1 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -35,7 +35,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	int end_index = start_index | mask;
 	int i, n, pages, missing_pages, bytes, res = -ENOMEM;
 	struct page **page;
-	struct squashfs_page_actor *actor;
+	struct squashfs_page_actor actor;
 	void *pageaddr;
 
 	if (end_index > file_end)
@@ -51,9 +51,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	 * Create a "page actor" which will kmap and kunmap the
 	 * page cache pages appropriately within the decompressor
 	 */
-	actor = squashfs_page_actor_init_special(page, pages, 0);
-	if (actor == NULL)
-		goto out;
+	squashfs_page_actor_init_special(&actor, page, pages, 0);
 
 	/* Try to grab all the pages covered by the Squashfs block */
 	for (missing_pages = 0, i = 0, n = start_index; i < pages; i++, n++) {
@@ -90,7 +88,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	}
 
 	/* Decompress directly into the page cache buffers */
-	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
+	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, &actor);
 	if (res < 0)
 		goto mark_errored;
 
@@ -116,7 +114,6 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 			put_page(page[i]);
 	}
 
-	kfree(actor);
 	kfree(page);
 
 	return 0;
@@ -135,7 +132,6 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	}
 
 out:
-	kfree(actor);
 	kfree(page);
 	return res;
 }
diff --git a/fs/squashfs/page_actor.c b/fs/squashfs/page_actor.c
index 520d323..0344806 100644
--- a/fs/squashfs/page_actor.c
+++ b/fs/squashfs/page_actor.c
@@ -78,14 +78,9 @@ static void direct_finish_page(struct squashfs_page_actor *actor)
 		kunmap_atomic(actor->pageaddr);
 }
 
-struct squashfs_page_actor *squashfs_page_actor_init_special(struct page **page,
-	int pages, int length)
+void squashfs_page_actor_init_special(struct squashfs_page_actor *actor,
+	struct page **page, int pages, int length)
 {
-	struct squashfs_page_actor *actor = kmalloc(sizeof(*actor), GFP_KERNEL);
-
-	if (actor == NULL)
-		return NULL;
-
 	actor->length = length ? : pages * PAGE_SIZE;
 	actor->page = page;
 	actor->pages = pages;
@@ -94,5 +89,4 @@ struct squashfs_page_actor *squashfs_page_actor_init_special(struct page **page,
 	actor->squashfs_first_page = direct_first_page;
 	actor->squashfs_next_page = direct_next_page;
 	actor->squashfs_finish_page = direct_finish_page;
-	return actor;
 }
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index 2e3073a..ab9d381 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -61,8 +61,8 @@ struct squashfs_page_actor {
 };
 
 extern struct squashfs_page_actor *squashfs_page_actor_init(void **, int, int);
-extern struct squashfs_page_actor *squashfs_page_actor_init_special(struct page
-							 **, int, int);
+extern void squashfs_page_actor_init_special(struct squashfs_page_actor *actor,
+				struct page **page, int pages, int length);
 static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
 {
 	return actor->squashfs_first_page(actor);
-- 
1.9.1

