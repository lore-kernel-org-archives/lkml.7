Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F75C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EFE2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sr9LjJuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbfHVUAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:00:38 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:49091 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733297AbfHVUAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:00:36 -0400
Received: by mail-vk1-f201.google.com with SMTP id l3so2754565vkb.15
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q2xEM4ZZIH60IhHUp/Tsrc3BwYRYS3HENwO9UK8ZY8A=;
        b=sr9LjJuS+htHRlolM9YkWocHcNmySO3oWOJUlCW5vIRDBoMd6wQCLTBGuwEuqsC2Ur
         Wma8aSSiAtzW0x3pzUQrZAkO2xN5hc6iK2purEAarL8Pn57u85rUGnZ4Z5Kb5c6wmko8
         osjWvJYlNjDc82qCar5zR3/Yiffmj2juupyRjK82d70b2Vtm5UKfkHcqRuxyUwoL08nl
         yMNbpjqkol5SNc04oi+ZOGu7nXeE9PZd/JN5LU+cmK/4JYzpGnfGv8H3JvOEfXDlFveS
         l96DKLspK6+yW+KbyQCD+rP6J3xGnoD3UDJzgmrdUG2SbU8ICA3jNFDo6aBuqAtGrAVo
         OBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q2xEM4ZZIH60IhHUp/Tsrc3BwYRYS3HENwO9UK8ZY8A=;
        b=L+F+dKgdyr1Bho6VAXTjaZ66XeuXdKFpHSo2GMapAK/yH07FEWVc7qnf2UsrJvSRCt
         O8Um5udK44NOvpoOc3wQmQv5TG3jWKcQDBu32EN9Q3/gZ0DMAj4K6m0kk2FQX3iFw+kI
         fCC2a/Xx6aI7EM2y4xx1MmB3IjdwcmQqRl7Uw3ZDyTDvkMEhWKA2SO8uXt1pjEAcFKeO
         53LUER5+jLFTEhWaEdOAghP5zUF1+GOYtjLcFyxEFwthQzJa9ySqKhsnNOVSa2kQwiLk
         GZVgzqzoiDMHOWFzlHOBR3eE8/eYr4lRqZ/IOtWj8kUymCTMcu7Y+ORq2Qn5F+3KCvZh
         E8Ug==
X-Gm-Message-State: APjAAAUn3s6w72IXeupd0cp5WS6B7K+UPav0RGtVGl0c1XMi0uY4PtvC
        MNlClGl/TKoVaWx/C2IwZlGQfE5UCd0=
X-Google-Smtp-Source: APXvYqwgnS+IPiPPbFOL3AM9ADOjTTbzmen8VHt2C1prErTvsrLAN7pIppKf4R1EZoMqfkOXMdHZEamKoYo=
X-Received: by 2002:a67:fb90:: with SMTP id n16mr560113vsr.7.1566504034917;
 Thu, 22 Aug 2019 13:00:34 -0700 (PDT)
Date:   Thu, 22 Aug 2019 13:00:28 -0700
Message-Id: <20190822200030.141272-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 1/3] fuse: on 64-bit store time in d_fsdata directly
From:   Khazhismel Kumykov <khazhy@google.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shakeelb@google.com, Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements the optimization noted in f75fdf22b0a8 ("fuse: don't use
->d_time"), as the additional memory can be significant. (In particular,
on SLAB configurations this 8-byte alloc becomes 32 bytes). Per-dentry,
this can consume significant memory.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fuse/dir.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index dd0f64f7bc06..f9c59a296568 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -24,6 +24,18 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
 	set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
 }
 
+#if BITS_PER_LONG >= 64
+static inline void fuse_dentry_settime(struct dentry *entry, u64 time)
+{
+	entry->d_fsdata = (void *) time;
+}
+
+static inline u64 fuse_dentry_time(struct dentry *entry)
+{
+	return (u64)entry->d_fsdata;
+}
+
+#else
 union fuse_dentry {
 	u64 time;
 	struct rcu_head rcu;
@@ -38,6 +50,7 @@ static inline u64 fuse_dentry_time(struct dentry *entry)
 {
 	return ((union fuse_dentry *) entry->d_fsdata)->time;
 }
+#endif
 
 /*
  * FUSE caches dentries and attributes with separate timeout.  The
@@ -242,6 +255,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	goto out;
 }
 
+#if BITS_PER_LONG < 64
 static int fuse_dentry_init(struct dentry *dentry)
 {
 	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
@@ -254,16 +268,21 @@ static void fuse_dentry_release(struct dentry *dentry)
 
 	kfree_rcu(fd, rcu);
 }
+#endif
 
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
+#if BITS_PER_LONG < 64
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
+#endif
 };
 
 const struct dentry_operations fuse_root_dentry_operations = {
+#if BITS_PER_LONG < 64
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
+#endif
 };
 
 int fuse_valid_type(int m)
-- 
2.23.0.187.g17f5b7556c-goog

