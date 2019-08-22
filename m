Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9688FC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD0C22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXWxYdY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfHVAKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:10:10 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37026 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfHVAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:10:09 -0400
Received: by mail-pl1-f201.google.com with SMTP id v13so2501034plo.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AyQNolgMX833/X5DxQq+yfb1DTSBcK57n5nfh7LiGZY=;
        b=CXWxYdY2fz8qnTLgNoq5USbT2+vkn500HAIsMO5Uh9eHjkfxfI7UrVZZuZ7SmUGZGP
         dB3tTHlmMLHOwKhFqMRSIvMsQpUhf3NzCW00PPLLUVvHn9hCDlRC9YCAu3sMSlglmR0/
         Ho4YKXnexV7YxR3Z7YeEihCwOO/B5jtZK6Mkq+iiU3qi1QMcq9OFYB67Qt48IXPAP6sa
         HQmtwfrhdBCdnt8x9N1z+TK2Xs3SKMcICya5PBq3dtfjcT0u56UK6jGAbZ9HEBIDup2U
         S6yUljm4oQrVtgkp+9Wy3dIycEJmSOLpToqBuQurfL2hkD5Urq403INsyLxlUAnC54FJ
         xvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AyQNolgMX833/X5DxQq+yfb1DTSBcK57n5nfh7LiGZY=;
        b=X3QpNvKKAvzJngo1BPVVg2+OAW7ESMReuOHAiVm9l80uKsrcfwCyMMbuxp1ktyfrhE
         /gzdtGBjcuGrBSxpzkIWQLU6UORwRssPkXA1u0Di7dFeXdAFaBEsRoRcKSba0NSMzMqJ
         QORcgsIp5MQXWtB8TacKNigewS7n7gPfJ7DkRjuR4+/CVgsVSYKUJmUZ/E+kwjia2WZv
         yuVPVQdt8NbeOLUsbCPNFIcKZM1gjEuMhLQkwC75lZpt+OjFtZW4jhWOdmD34x2613Yu
         4P9WfJacqIwGziLQj9vleIYDi6mDcI9N/C2CB23VmsiYIylEBD89cxM6Ne0b4QvHa+VK
         4kUA==
X-Gm-Message-State: APjAAAWSVaoMIak39AtZOQmrpg4MtDw+u+vnSkmQGJmHZBkwRCvY943+
        p7/IgfZJ/o7p1IxsI0v/BIwt/9zEdcc=
X-Google-Smtp-Source: APXvYqwr2mvIzGXC8hI6pNkeL55T9ffQqD9wqaDUaCXOxOADS+4j1W7TF4BrTjUWGizCe7lMBn0Q/Ueakbk=
X-Received: by 2002:a63:704:: with SMTP id 4mr31164087pgh.242.1566432608279;
 Wed, 21 Aug 2019 17:10:08 -0700 (PDT)
Date:   Wed, 21 Aug 2019 17:09:32 -0700
In-Reply-To: <20190822000933.180870-1-khazhy@google.com>
Message-Id: <20190822000933.180870-2-khazhy@google.com>
Mime-Version: 1.0
References: <20190822000933.180870-1-khazhy@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 2/3] fuse: kmemcg account fs data
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

accounts the per-file reserved request, adding new
fuse_request_alloc_account()

blockdev/superblock and temporary per-request data was left alone, as
this usually isn't accounted

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fuse/dev.c    | 6 ++++++
 fs/fuse/dir.c    | 3 ++-
 fs/fuse/file.c   | 4 ++--
 fs/fuse/fuse_i.h | 2 ++
 fs/fuse/inode.c  | 3 ++-
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ea8237513dfa..a0d166a6596f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -97,6 +97,12 @@ struct fuse_req *fuse_request_alloc(unsigned npages)
 }
 EXPORT_SYMBOL_GPL(fuse_request_alloc);
 
+struct fuse_req *fuse_request_alloc_account(unsigned int npages)
+{
+	return __fuse_request_alloc(npages, GFP_KERNEL_ACCOUNT);
+}
+EXPORT_SYMBOL_GPL(fuse_request_alloc_account);
+
 struct fuse_req *fuse_request_alloc_nofs(unsigned npages)
 {
 	return __fuse_request_alloc(npages, GFP_NOFS);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f9c59a296568..2013e1222de7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -258,7 +258,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 #if BITS_PER_LONG < 64
 static int fuse_dentry_init(struct dentry *dentry)
 {
-	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
+	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
+				   GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 
 	return dentry->d_fsdata ? 0 : -ENOMEM;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5ae2828beb00..c584ad7478b3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -45,12 +45,12 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
 {
 	struct fuse_file *ff;
 
-	ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL);
+	ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!ff))
 		return NULL;
 
 	ff->fc = fc;
-	ff->reserved_req = fuse_request_alloc(0);
+	ff->reserved_req = fuse_request_alloc_account(0);
 	if (unlikely(!ff->reserved_req)) {
 		kfree(ff);
 		return NULL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 24dbca777775..08161b2d9b08 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -904,6 +904,8 @@ void __exit fuse_ctl_cleanup(void);
  */
 struct fuse_req *fuse_request_alloc(unsigned npages);
 
+struct fuse_req *fuse_request_alloc_account(unsigned int npages);
+
 struct fuse_req *fuse_request_alloc_nofs(unsigned npages);
 
 bool fuse_req_realloc_pages(struct fuse_conn *fc, struct fuse_req *req,
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4bb885b0f032..eab44ddc68b9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -76,7 +76,8 @@ struct fuse_mount_data {
 
 struct fuse_forget_link *fuse_alloc_forget(void)
 {
-	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
+	return kzalloc(sizeof(struct fuse_forget_link),
+		       GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 }
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
-- 
2.23.0.187.g17f5b7556c-goog

