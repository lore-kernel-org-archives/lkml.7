Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD880C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E3220880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiNkdc6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfGQMHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:07:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43701 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfGQMHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:07:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so4909968pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cn6HpCqocofcTiM1Gleeu1RdMvR6xgTxVinOm89T4fE=;
        b=jiNkdc6Pvs170rrUtkWtlaTxWV73JNo1Y5gHIs2Q1SBLZmGe1f4Nv5wGBfvNmYU35g
         lAF8iJ95IEJ0FuRt6gI+2EKjM4vnOBdtST1FLhRHcpKNeGb51YEt+Lcp7EtKgCSsmUS/
         WIV/TxAWugaVruBWkYd5jBII9gj7Mh4mhh9BEzpkka/ArFVVie2DxiOUN+RfMXD6O9KM
         eyXzILWp56Qzs/FJUOPBA7wGKVTVxoVKswr0DqmWpztQRA/dWM56M8wIA8kzSDe6Bgqs
         0enGszW5f11ZfBjIa3blazy+iMz/56xUvi22N+/lAws33J5kdJYzRb9A/QmSMy9bwIw4
         x1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cn6HpCqocofcTiM1Gleeu1RdMvR6xgTxVinOm89T4fE=;
        b=kyAm3xZTjs94Slkr/c0rzX5LDM4+5WauAWpFIBE/hpcBA2RtXfIYP20eFc6msVxL9v
         ceTVV4BTRW1jVaSPrS2dyqH6LYZf8TGcKzmCSjrCBgP19u0p3UWU6JtlaFrAIXfCC32F
         1xTI0p+t8rHdhXl5MzIdcc1w6cs//ykI501EeFI5gadglt6WpHj7Km10FKwr8W852PWG
         F2yQFjnGRN5qbCRl7A1DTYSBRTzKp3Z4NGY6IEdclcGr3IO3MQeE134bsvMyI2EooTAF
         qKkAnKFQ799R3XWN2df8nFNkLoQ7/RvYdB/uPgsX73PUXc0qVApROkdHJaGoPToDBKM6
         ZtWw==
X-Gm-Message-State: APjAAAW9vUL8DLk704WmBfo4gtCMb/eiSTYmsx1Hkel4w7GhHG9Ar9LC
        zVQInHpXCiEa+Wo/XLm5qgw=
X-Google-Smtp-Source: APXvYqyNDu+Lq8AIgQX4Ia8yWbjI5gKFKac0U6zIBF/A847zdMS6ApiJGarQH0TBkIQ/ZYbX6cUo5Q==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr43035891pln.304.1563365223769;
        Wed, 17 Jul 2019 05:07:03 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id v13sm29154897pfn.109.2019.07.17.05.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 05:07:02 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com
Subject: [PATCH v2] squashfs: avoid to allocate page actor when to read into the page cache
Date:   Wed, 17 Jul 2019 20:06:44 +0800
Message-Id: <20190717120644.11128-1-zbestahu@gmail.com>
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

