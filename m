Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEEFC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF0E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lz74ltzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfIQTgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:36:10 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37901 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfIQTgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:36:10 -0400
Received: by mail-pl1-f202.google.com with SMTP id x5so2732180pln.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2NRtuvKbt7hoCUKdcO2DQz0SKjqBn1iBiRT69g1zRIM=;
        b=lz74ltziFu7N9FdWM2Wk+leFwy2lbrUMLopHSlydWLgsiEG7PXi/086swTVSMcdu5F
         r1nmdQsBiezhx7jBZb+kdnZp8YDjEAGrkuT+/hvcAp4MSxy7SWFBXkGGTQT9O0Ii7+Sc
         4ThlfTDBVQQ0JJvS/kiOG3AJzgeQw78nnQaYieDZ7ReIyQ8+SkCI4VzHcDWJu7jTLK/5
         wkAmi2Qexp0DuMjJROd05a/tqULAtaLuOelQmiYHx/vbYFg6DszOY4lrSNW2G/T3JLri
         Z8izXlv+5yWGFc0/9APv/DPwvXPXZbBv9IczXa6UGUhkApS6XEY+2LrYBPoFyFcexGvJ
         kmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2NRtuvKbt7hoCUKdcO2DQz0SKjqBn1iBiRT69g1zRIM=;
        b=NLdz97uc8ICv2kw6SAD7q09mszJgWNzyaHuyd7rgx0Q2f5RMNRLDcn4BY9dWNSc/Vc
         s3CJ6SKiKkutatiTsOLA8bNDGA4+NXg/T8fZUVzAiRkEyvG5KLopeGn20OxDf1ogdMNX
         5ZpyBT5P3YLjEgLAAQGlHxjkNf5FMzW56uDVWq+tvwCWXG6rWk9WCmYjWv1yagYChLtm
         bQg8HdVgfZfsYKjzbuzu86dQtsDwUwzjcgAhJX+JcJGkgKsJNBvAVG7/LpapbeK0MG0d
         S4NMbQg8h2lmXInOfC+J1Hu0uA2tBpxnhNdnrs+5nB5cN8NyWbH1jhIof80X84dx4Ngm
         DrGw==
X-Gm-Message-State: APjAAAXIFB9oA2JqMQrLCdbSfK4M0dQUfeLoqmZ01B5rtMj9sFmwZ2Gj
        rm1biFoAJvwB92c2Q+owE1SY0z+pEMg=
X-Google-Smtp-Source: APXvYqwiWxhxuJwyT4PvGNQH+mApcPQsn3EAU6pp2NpiIIv9fUdf+EdNR0rdJjGoFbPDAc3b1T/Z8kMSwOk=
X-Received: by 2002:a65:6901:: with SMTP id s1mr472083pgq.338.1568748967798;
 Tue, 17 Sep 2019 12:36:07 -0700 (PDT)
Date:   Tue, 17 Sep 2019 12:35:33 -0700
In-Reply-To: <CACGdZY+iviCmTc1fQriWSBbxhywGiFj1+f6RJ1AXpE6i=O_i-w@mail.gmail.com>
Message-Id: <20190917193533.34984-1-khazhy@google.com>
Mime-Version: 1.0
References: <CACGdZY+iviCmTc1fQriWSBbxhywGiFj1+f6RJ1AXpE6i=O_i-w@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH v4] fuse: kmemcg account fs data
From:   Khazhismel Kumykov <khazhy@google.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shakeelb@google.com, Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

account per-file, dentry, and inode data

blockdev/superblock and temporary per-request data was left alone, as
this usually isn't accounted

Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fuse/dir.c   | 3 ++-
 fs/fuse/file.c  | 5 +++--
 fs/fuse/inode.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 58557d4817e9..d572c900bb0f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -279,7 +279,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 #if BITS_PER_LONG < 64
 static int fuse_dentry_init(struct dentry *dentry)
 {
-	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
+	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
+				   GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 
 	return dentry->d_fsdata ? 0 : -ENOMEM;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8c7578b95d2c..0f0225686aee 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -63,12 +63,13 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
 {
 	struct fuse_file *ff;
 
-	ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL);
+	ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!ff))
 		return NULL;
 
 	ff->fc = fc;
-	ff->release_args = kzalloc(sizeof(*ff->release_args), GFP_KERNEL);
+	ff->release_args = kzalloc(sizeof(*ff->release_args),
+				   GFP_KERNEL_ACCOUNT);
 	if (!ff->release_args) {
 		kfree(ff);
 		return NULL;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3d598a5bb5b5..e040e2a2b621 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -66,7 +66,7 @@ static struct file_system_type fuseblk_fs_type;
 
 struct fuse_forget_link *fuse_alloc_forget(void)
 {
-	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
+	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL_ACCOUNT);
 }
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
-- 
2.23.0.237.gc6a4ce50a0-goog

