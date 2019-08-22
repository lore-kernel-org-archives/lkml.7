Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8B2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64DC2341A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkW4PEg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389629AbfHVUAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:00:41 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:51034 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389524AbfHVUAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:00:38 -0400
Received: by mail-qt1-f201.google.com with SMTP id c14so7657262qtn.17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9WhbLtA1PXXZFsn027jIR9WnGYXiAtblVNlzQiAJJRM=;
        b=AkW4PEg8sMv0JywT4cALwVmK7sakobFBNA609slVBXgyG8MnxhqVyi9tIn5nwBPERu
         /Il6KfJlShTL+7xkVedpbOriuKmmSnDwS1QbvswmpaOYKu/P+l5TZqxd0EL+rMJ8hhju
         WqpUyTZultC9mQ7GPF3mRep7adSIG0Uf6FYCfxBmZEDSTzIUDTRKZtVkThozogeLUppD
         L6z5FDhHLpn7fj69PbWz3utrOf2gUa65DXB3Mh2IFjZrxHCpzXKV5jNHXSu4cq1bOpkR
         DpQqIaxhqy6jAAIZG8he16Vj7ll9IQca5qdfTNZrbco8yzKEToRhsYh+e+7mq0N4aNyT
         +e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9WhbLtA1PXXZFsn027jIR9WnGYXiAtblVNlzQiAJJRM=;
        b=qnP4OerMnCZLMl4XjLt34TcQaC/5xaKb4aES4JJqKU6cN6E0ml+/ZoZG0go/x4STW6
         xm04jkLktwcEHmcnEgcNkWYWt0zfAB/WTpcbqOrziGYpPw0Gk3rBueqpfBpLgzRmyh9v
         EwJeDON9kQJl9gIEIFQheoHqE1ArXiqFSWcD6CykOnWb/qyE4Z3M53kPLIcoLq9D+ujQ
         GbJKK7KN62JHu0eBhow1AhX0IjUeJJiV7zNmhb0QWsI3ZVahTUoYR/HCGvYOJgfKD82S
         g7YQvLAy1saq8XvKLjW2HtSNLgwpZqa6Gda7rm9HA96JYdy4eU1sw65K3gKvae7yKAKc
         XeAQ==
X-Gm-Message-State: APjAAAUWycQFj0SBF56jZqFZ3HyMzDkgj1c09+LSAumOkDnxzNrNfAx6
        C1Zy+U+5aeiV6ouR8S5lIKAwaLcBFxw=
X-Google-Smtp-Source: APXvYqxx8BxWXRQ3WUuUqowsTxGrCRGmGyHhwE4M6AywtCiosAGn84MKaz7FSzZ64J6yaYzk/KOj1mNUZ00=
X-Received: by 2002:a0c:f147:: with SMTP id y7mr1083982qvl.244.1566504037397;
 Thu, 22 Aug 2019 13:00:37 -0700 (PDT)
Date:   Thu, 22 Aug 2019 13:00:29 -0700
In-Reply-To: <20190822200030.141272-1-khazhy@google.com>
Message-Id: <20190822200030.141272-2-khazhy@google.com>
Mime-Version: 1.0
References: <20190822200030.141272-1-khazhy@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 2/3] fuse: pass gfp flags to fuse_request_alloc
From:   Khazhismel Kumykov <khazhy@google.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shakeelb@google.com, Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having a helper per flag

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fuse/dev.c    | 16 +++-------------
 fs/fuse/file.c   |  6 +++---
 fs/fuse/fuse_i.h |  4 +---
 fs/fuse/inode.c  |  4 ++--
 4 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ea8237513dfa..c957620ce7ba 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -66,7 +66,7 @@ static struct page **fuse_req_pages_alloc(unsigned int npages, gfp_t flags,
 	return pages;
 }
 
-static struct fuse_req *__fuse_request_alloc(unsigned npages, gfp_t flags)
+struct fuse_req *fuse_request_alloc(unsigned int npages, gfp_t flags)
 {
 	struct fuse_req *req = kmem_cache_zalloc(fuse_req_cachep, flags);
 	if (req) {
@@ -90,18 +90,8 @@ static struct fuse_req *__fuse_request_alloc(unsigned npages, gfp_t flags)
 	}
 	return req;
 }
-
-struct fuse_req *fuse_request_alloc(unsigned npages)
-{
-	return __fuse_request_alloc(npages, GFP_KERNEL);
-}
 EXPORT_SYMBOL_GPL(fuse_request_alloc);
 
-struct fuse_req *fuse_request_alloc_nofs(unsigned npages)
-{
-	return __fuse_request_alloc(npages, GFP_NOFS);
-}
-
 static void fuse_req_pages_free(struct fuse_req *req)
 {
 	if (req->pages != req->inline_pages)
@@ -201,7 +191,7 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
 	if (fc->conn_error)
 		goto out;
 
-	req = fuse_request_alloc(npages);
+	req = fuse_request_alloc(npages, GFP_KERNEL);
 	err = -ENOMEM;
 	if (!req) {
 		if (for_background)
@@ -310,7 +300,7 @@ struct fuse_req *fuse_get_req_nofail_nopages(struct fuse_conn *fc,
 	wait_event(fc->blocked_waitq, fc->initialized);
 	/* Matches smp_wmb() in fuse_set_initialized() */
 	smp_rmb();
-	req = fuse_request_alloc(0);
+	req = fuse_request_alloc(0, GFP_KERNEL);
 	if (!req)
 		req = get_reserved_req(fc, file);
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5ae2828beb00..572d8347ebcb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -50,7 +50,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
 		return NULL;
 
 	ff->fc = fc;
-	ff->reserved_req = fuse_request_alloc(0);
+	ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL);
 	if (unlikely(!ff->reserved_req)) {
 		kfree(ff);
 		return NULL;
@@ -1703,7 +1703,7 @@ static int fuse_writepage_locked(struct page *page)
 
 	set_page_writeback(page);
 
-	req = fuse_request_alloc_nofs(1);
+	req = fuse_request_alloc(1, GFP_NOFS);
 	if (!req)
 		goto err;
 
@@ -1923,7 +1923,7 @@ static int fuse_writepages_fill(struct page *page,
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
 		err = -ENOMEM;
-		req = fuse_request_alloc_nofs(FUSE_REQ_INLINE_PAGES);
+		req = fuse_request_alloc(FUSE_REQ_INLINE_PAGES, GFP_NOFS);
 		if (!req) {
 			__free_page(tmp_page);
 			goto out_unlock;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 24dbca777775..8080a51096e9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -902,9 +902,7 @@ void __exit fuse_ctl_cleanup(void);
 /**
  * Allocate a request
  */
-struct fuse_req *fuse_request_alloc(unsigned npages);
-
-struct fuse_req *fuse_request_alloc_nofs(unsigned npages);
+struct fuse_req *fuse_request_alloc(unsigned int npages, gfp_t flags);
 
 bool fuse_req_realloc_pages(struct fuse_conn *fc, struct fuse_req *req,
 			    gfp_t flags);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4bb885b0f032..5afd1872b8b1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1177,13 +1177,13 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	/* Root dentry doesn't have .d_revalidate */
 	sb->s_d_op = &fuse_dentry_operations;
 
-	init_req = fuse_request_alloc(0);
+	init_req = fuse_request_alloc(0, GFP_KERNEL);
 	if (!init_req)
 		goto err_put_root;
 	__set_bit(FR_BACKGROUND, &init_req->flags);
 
 	if (is_bdev) {
-		fc->destroy_req = fuse_request_alloc(0);
+		fc->destroy_req = fuse_request_alloc(0, GFP_KERNEL);
 		if (!fc->destroy_req)
 			goto err_free_init_req;
 	}
-- 
2.23.0.187.g17f5b7556c-goog

