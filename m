Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A535C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B531206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUGJYOj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfIPX47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:56:59 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:47860 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbfIPX46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:56:58 -0400
Received: by mail-qt1-f202.google.com with SMTP id p56so2257985qtj.14
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bJmZANwzCFV2Iqz4LhMyBOSdTmADhZHqEPwCse8wah0=;
        b=sUGJYOj1o9xCwXnv4wc+rHf8HlX3D1AlYIvZvyfihO9GHGvXi79ynXEVh/2RhqczAz
         W+684pXzoiyFxTsRk9OmIKGhzVP04cxmhPod4hK6vh/4Y6ekcZzsm0U+/20KsWPN+XE7
         /fXzxWAz8FiAfivCllUrUfspG4b1EtSjjNZ+pYwcsJLvU4Vip/1+kehaDdo13Zyjiqut
         aaK9e8E8fR3smRXhz9TtmNYk9W9VrGnNqpOjZPlcM2GH1ylMQYyzoxrB0lGaWQ8fwGSu
         UiEMQZh272qaXObuaGLMxfyS3y1staHLcfHBXQYkTatdxKpnVEdSJijAeHe8G9DZw6bN
         JK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bJmZANwzCFV2Iqz4LhMyBOSdTmADhZHqEPwCse8wah0=;
        b=deUx/pFwJiaIrs2ADbL/+iK86txt0wDj/l/fN70IxibQuAefs/lV6i3wD/Ete1DY5i
         KITbrR3Y7YMAyNNZTQxrTYJ0+Z82F3AsdHiawJ06vjRVXaFX3hFDOGNbuxktckwAgYeK
         he1irRi+C1upAVFqsqgbWkfrRhTP0HhiC5i89dOoEEr+laKJ4jUBHHIe+3XO6nBEPHxN
         MMb39mCYlUrkSUvmWoYLg5aEiO2IgfeS3kszOoHuqCa5K4PMl2l15CBCIGG8dM1OffMr
         lKQqOQ46rH6v/82zxOViDD50RTcRlokf1fmtFAkcfkfiBCpg2UISQb9dnfmzGXcL0dlI
         2ZLg==
X-Gm-Message-State: APjAAAW6xk8mg3UqzqwyhArs+wX22UvcYZfnHeGdzUgZ2Z+3gfJqPFDM
        jRH5sRzPelTVoF0J80XvLarPy3VBIBI=
X-Google-Smtp-Source: APXvYqwcRpAFsOLDZFs5gKrwwLxNf7Ug2TgXqFTU+omF07IxxIzz4SMFzPqGErLVhC+LGxmgdbZpsHquImU=
X-Received: by 2002:aed:3c52:: with SMTP id u18mr1080316qte.194.1568678215490;
 Mon, 16 Sep 2019 16:56:55 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:56:42 -0700
In-Reply-To: <20190916235642.167583-1-khazhy@google.com>
Message-Id: <20190916235642.167583-2-khazhy@google.com>
Mime-Version: 1.0
References: <20190916235642.167583-1-khazhy@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH v3 2/2] fuse: kmemcg account fs data
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

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 fs/fuse/dir.c   | 3 ++-
 fs/fuse/file.c  | 5 +++--
 fs/fuse/inode.c | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

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
index a2ea347c4d2c..862aff3665b5 100644
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
index 3d598a5bb5b5..6cb445bed89d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -66,7 +66,8 @@ static struct file_system_type fuseblk_fs_type;
 
 struct fuse_forget_link *fuse_alloc_forget(void)
 {
-	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
+	return kzalloc(sizeof(struct fuse_forget_link),
+		       GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 }
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
-- 
2.23.0.237.gc6a4ce50a0-goog

