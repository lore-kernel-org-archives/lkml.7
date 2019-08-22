Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD3DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8D92339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYYseZMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391053AbfHVUAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:00:42 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53932 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389549AbfHVUAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:00:41 -0400
Received: by mail-pl1-f201.google.com with SMTP id y22so4243277plr.20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVGwk6YhjI455Ut1v3y6cxlNJxNjb6ZkPTuggdcePUs=;
        b=JYYseZMPlM5r1PVnnewPA9qXVNjOEjiBT5JavOaz5iOKpvPti+BzosvwyA1hobwO/O
         w9LDFjs+b4zvgKL4URYTM7g3/yJqpdb75LKM1xpEfXjoY1Xg8Rbv0yP8clb5B5Lf0drd
         Q7xnT5p4+v2P3wBOVqhkeWqS3qbhRCPQUEbXfqrIhwIm83mlGIiC1AyHxS8145DgeGuZ
         ppn9gM21p4S2MX0ZE8ifWvgbLsB6JmPrpr3WYQeX4MZA1zvfw0Jvpmrmz2BDxRqUfyYb
         vY0RPenIjucOwQJMh8uqYtuSGszsLyBFcBMtTvlJRK82LomjEjV+0bJV7pg0YfSbyKIC
         Yaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVGwk6YhjI455Ut1v3y6cxlNJxNjb6ZkPTuggdcePUs=;
        b=MH7c3c4qnFxn0eurCaCAbhULdd75YH1D3a/K39+98Sxm2zZOyqMk3LxE6B4TczmxYg
         f3sFVJpVPcUsdis/O6r75R5A+quEd442VynpViQ7Hb+MKDrgjeOxLY+uSZ3WsQMaUnZa
         yKLb0zlJZpWOnyMaVr/FftWuezxzA3KS6hNt8/GFPN5AtitmqSFRlzw68QAp1KnIDxst
         7ZKCxsrL++KMzizLmPEUXA2iXWtrj2xbj6bI2pKFjO1wt1zIHEuQsYywtlszlr8p+jql
         dKsMZcjYeRomaFrKF02SPkK2Z9q4minFIhXwicL/OhzbyfjmBcZnxHsi56B5HH57WJt6
         9ANA==
X-Gm-Message-State: APjAAAVHuHf3kUH4KBVzZwZyS+nluc0zhD0Oslp29epePlRf8dcuCpgF
        n+vAxYXj61edln52rkGT9yM4cXs8Gv0=
X-Google-Smtp-Source: APXvYqyt7na1QkfBgKdb+30wpsC1mwNBkmXqnLJjgl7dGFiw5WlLWG1hwqPw3fp+52MZwqCdr5Tf1gUluwY=
X-Received: by 2002:a63:f13:: with SMTP id e19mr837076pgl.132.1566504039792;
 Thu, 22 Aug 2019 13:00:39 -0700 (PDT)
Date:   Thu, 22 Aug 2019 13:00:30 -0700
In-Reply-To: <20190822200030.141272-1-khazhy@google.com>
Message-Id: <20190822200030.141272-3-khazhy@google.com>
Mime-Version: 1.0
References: <20190822200030.141272-1-khazhy@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 3/3] fuse: kmemcg account fs data
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
 fs/fuse/dir.c   | 3 ++-
 fs/fuse/file.c  | 4 ++--
 fs/fuse/inode.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

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
index 572d8347ebcb..ae8c8016bb8e 100644
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
-	ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL);
+	ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!ff->reserved_req)) {
 		kfree(ff);
 		return NULL;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5afd1872b8b1..ad92e93eaddd 100644
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

