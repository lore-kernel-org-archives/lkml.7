Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF728C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 06:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF11218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 06:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iuf9G9ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCPGQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 02:16:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34578 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfCPGQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 02:16:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so7929924pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 23:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tBDn8qa7vRCUuocpm81qvskwGplajY6xq7T4mFalhe4=;
        b=Iuf9G9ee6I4iypwaqO+QoBaW20UOCF9eMISUJ3arzrPKTZDR1sUeJveKyz+JuBARJr
         1+0bN8E1TZxlu8W+eTOtH6fpkF2/RJ8lw2k/t3r2L1RdKdXVkcX856D5Sz6B9xYRBrLU
         KkSovconwBHhxkQuPeVqw0ROMccDw7POUA+UZfFpUOJRpOIcH5oeRZ50QbZ8EtkWbzP0
         uMK6Q/zeAttDKljkkyJYh124f5Z5oQqBRoknIgb7CozQkQ1nnVB5/msMYB/K4lfy9d7O
         g7VqmkO7kkGMM3VfKxvTk+vJf+TaZCWLx2VWzXjLRqFbk3xegv8cBu5Da4nj6Fr7gCLR
         Vs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tBDn8qa7vRCUuocpm81qvskwGplajY6xq7T4mFalhe4=;
        b=IYwgIEUPOni6scIvReYRli2EhNswowNXxvfGOeMWwMntH58Oy0bYXeChwXgKVhuOOY
         04oot7sYCvJWABbQI7MzNHZpzdt5V8rHYPe8zbSvSFOWAh4UjjsaT0bYa4+gAo50Kymo
         LCv9RKs+YvMBbNNISiw/6LTJW3mSHUrPlz4MMTUnBHymoDOZi0f8R9mhaB5Yl0Mf3Gfu
         fcBiVBmvq3qJCHKrGLw6nBsFgI7YMzpQKmwonmMp236OFQqosy6yiFHNAUdMFlV4kQFt
         IHjtiWpyf0YZJZVfoU4uz0eXdQK0scrJIlipbs1scS2UdeC7Knt+ps6gL2AGIStTNckV
         KohA==
X-Gm-Message-State: APjAAAVW0KcdWyA77e6JXH4X5h+h4E5uhaj1BwXrV5XwUiGtIEI9lEqx
        TLApa+8FgeO8+agsKhUHsDI=
X-Google-Smtp-Source: APXvYqxnhMSwNR6nlzpo7oDGqepzNg+++NTTPwgt38iYQ5D5TZ33+q0tBcweDf9F1Y8epYrCouqEEQ==
X-Received: by 2002:a65:5cc3:: with SMTP id b3mr493987pgt.82.1552717005792;
        Fri, 15 Mar 2019 23:16:45 -0700 (PDT)
Received: from localhost.localdomain ([122.172.52.69])
        by smtp.googlemail.com with ESMTPSA id x1sm8508241pge.73.2019.03.15.23.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 23:16:45 -0700 (PDT)
From:   Arshad Hussain <arshad.super@gmail.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     gaoxiang25@huawei.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        yuchao0@huawei.com
Subject: [PATCH] staging: erofs: Add function comment for erofs/inode.c
Date:   Sat, 16 Mar 2019 11:46:28 +0530
Message-Id: <20190316061628.1734-1-arshad.super@gmail.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds functions comment for file erofs/inode.c in
sphinx format.

Signed-off-by: Arshad Hussain <arshad.super@gmail.com>
---
 drivers/staging/erofs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 924b8dfc7a8f..c68f280ba849 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -14,7 +14,15 @@
 
 #include <trace/events/erofs.h>
 
-/* no locking */
+/**
+ * read_inode(): Get physical Inode from disk.This is with
+ * 		 No locking.
+ *
+ * @inode: VFS inode structure
+ * @data: Page address where inode will be read
+ *
+ * Return: 0 on Success, Error number on failure
+ */
 static int read_inode(struct inode *inode, void *data)
 {
 	struct erofs_vnode *vi = EROFS_V(inode);
@@ -102,7 +110,13 @@ static int read_inode(struct inode *inode, void *data)
 	return 0;
 }
 
-/*
+/**
+ * fill_inline_data(): Fill last page if inline data is available
+ *
+ * @inode: VFS inode structure
+ * @data: TRUE if directory
+ * @m_pofs: Position to correct inode
+ *
  * try_lock can be required since locking order is:
  *   file data(fs_inode)
  *        meta(bd_inode)
@@ -111,6 +125,8 @@ static int read_inode(struct inode *inode, void *data)
  * no data operations exist. However I tend to
  * try_lock since it takes no much overhead and
  * will success immediately.
+ *
+ * Return: 0 on Success, Error number on failure
  */
 static int fill_inline_data(struct inode *inode, void *data,
 			    unsigned int m_pofs)
@@ -151,6 +167,15 @@ static int fill_inline_data(struct inode *inode, void *data,
 	return -EAGAIN;
 }
 
+/**
+ * fill_inode(): Fill in the inode
+ *
+ * @inode: VFS inode structure
+ * @isdir: TRUE if directory
+ *
+ * return: 0 on success, else error code on error
+ */
+
 static int fill_inode(struct inode *inode, int isdir)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
@@ -224,9 +249,16 @@ static int fill_inode(struct inode *inode, int isdir)
 	return err;
 }
 
-/*
+/**
+ * erofs_ilookup_test_actor(): Obtain inode from mounted FS
+ *
+ * @inode: VFS inode structure
+ * @opaque: Data pointer passed to test/set
+ *
  * erofs nid is 64bits, but i_ino is 'unsigned long', therefore
  * we should do more for 32-bit platform to find the right inode.
+ *
+ * Return: NID on Success
  */
 #if BITS_PER_LONG == 32
 static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
@@ -236,6 +268,14 @@ static int erofs_ilookup_test_actor(struct inode *inode, void *opaque)
 	return EROFS_V(inode)->nid == nid;
 }
 
+/*
+ * erofs_iget_set_actor(): Obtain inode from mounted FS
+ *
+ * @inode: VFS inode structure
+ * @opaque: Data pointer passed to test/set
+ *
+ * Return: 0 on success
+ */
 static int erofs_iget_set_actor(struct inode *inode, void *opaque)
 {
 	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
@@ -245,6 +285,14 @@ static int erofs_iget_set_actor(struct inode *inode, void *opaque)
 }
 #endif
 
+/**
+ * erofs_iget_locked(): Get the VFS inode from mounted FS
+ *
+ * @sb: VFS superblock structure of mounted FS
+ * @nid: Node ID to get
+ *
+ * Return: Pointer to inode
+ */
 static inline struct inode *erofs_iget_locked(struct super_block *sb,
 					      erofs_nid_t nid)
 {
@@ -259,6 +307,19 @@ static inline struct inode *erofs_iget_locked(struct super_block *sb,
 #endif
 }
 
+/**
+ * erofs_iget(): Get the VFS inode from the inode cache.
+ *
+ * @sb: VFS superblock structure
+ * @nid: Node ID
+ * @isdir: TRUE if directory.
+ *
+ * Get inode from inode cache. If not in cache, get it from disk
+ * and fill the cache.
+ *
+ * return: Pointer to the inode on success, else error code on error
+ */
+
 struct inode *erofs_iget(struct super_block *sb,
 	erofs_nid_t nid, bool isdir)
 {
-- 
2.14.5

