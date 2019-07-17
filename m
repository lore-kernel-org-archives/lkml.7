Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB24C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657CF217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REOR2/eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfGQLnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:43:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39960 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGQLnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:43:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so11824897pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 04:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bJyjiMSczq8O/fy0DzHpsXHTkh3Pfc7KNhEI3e8/DNc=;
        b=REOR2/eulenSRfo961iSG6Zwh3ujyZv+gSrkmc+Kvm3b7jmuCeJokM9AOCJTgjIR3E
         GhFnwtRm3qAbsb7pmYMEBqHGSoVTNJ2AIiJGIb86WJRnQYRaLKEk4ziC/DKUeMVx4RZm
         zJogkn9oIYwzMx4vOATigvOXDw6BRYxBxnWA1CGc4lO6gnRC1qr/iSwuhn9nURAi8kBD
         S76ZhpTauDp3WTjvucHHX5NmsKKP2WD7jEbE4zdigXpYGIrnPoW6DDW/1FttgTX9oBDQ
         lkazExwHUpDb5Vek3Nurm/v689kUPg25npVX5XsMRiF/DKddlsUQc7KZXOitavzwQdoJ
         F4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bJyjiMSczq8O/fy0DzHpsXHTkh3Pfc7KNhEI3e8/DNc=;
        b=mcqdxVBUn05tnDsfpEMZvGJguKAT0iWHDnRtoeBw+qsgj8NYX0bY3E2ot3Nnqk8FRu
         G8eQxJAYstQHsm4xp5XvOrNxIHmlomtA6unPu+og+qO3V5fGRHrXiB5aPxiXSkcfNRqm
         dhO1/pvugoLGXWjc5+IAORsftcw0/z5VrGLeXevxencAHUP7yHV5Cjpmq/NqXP4YXmWZ
         pKJzpdDpIhw7lEQWtj6+RQuy1yCYEnPeUQm6/0JAZ1g7ZN1h+74m9+xkmDyqKd0j4FFw
         EeBsIVmw+lAWp1hGz467ZlPGnrtS6d86OhgoGexcxmcd6llItf0nGQ0bdooLg+HzQePu
         J1Lw==
X-Gm-Message-State: APjAAAWGq5SCf3IYEHwyblgjGsFhegeBq7OAZ/XXUwgjIngciWOBvZcR
        TcApsZzUlLNbo+6b/+/LKBObATQE
X-Google-Smtp-Source: APXvYqyPVIgIkkAGz0j+I8ADYvdUfugkHiYN8xT/46UN9WPQG0pFVNSDVX2BfiDJiqiN3nKPF8Oaxg==
X-Received: by 2002:a17:902:b68f:: with SMTP id c15mr43033767pls.104.1563363781160;
        Wed, 17 Jul 2019 04:43:01 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id v3sm22465538pfm.188.2019.07.17.04.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 04:43:00 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] squashfs: avoid to allocate page actor when to read into the page cache
Date:   Wed, 17 Jul 2019 19:41:51 +0800
Message-Id: <20190717114151.10508-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, we will allocate page actor in squashfs_readpage_block() via
kmalloc() if enable SQUASHFS_FILE_DIRECT option. However, the actor size
is small and it will be freed finally in this function. So just use stack
memory to avoid out of memory. Also save this space for system use.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
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

