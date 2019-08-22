Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B15C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E39F22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6AQoA1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfHVAJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:09:57 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:45008 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHVAJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:09:56 -0400
Received: by mail-vk1-f202.google.com with SMTP id a5so1590082vki.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pv63BqJG13E00+xwd/kF1jAWY+UxyXW33fdXaIG0kq8=;
        b=D6AQoA1ldI7Td2oaG347F6IipHY5tct5IVr+ZroY46wc2oeOBig9h8SX4dVUwbmpkk
         wJ9SvoTKVLRLyS0KQGzGDBHsHrzk7paM9h/bx2REKW+54BkeqdsWziITIIAgHqJqmgeI
         Fttd73tnUVn7lBOt4rStJQHq4ekEuATA+hFFL3ytj+VuWFykDfR4/Uv1hTrOiehHHXFq
         J6NvzzRX9hadxjvziCkeZI5JP4NdeJOigPiTCkAOOX2LJcLP/GWAjDKL+UqcTpy1wFay
         5bOjifnewYNs0sm+ha3kwdNZYvK1/4Ye3s2j1ZCKveddw1LJGk3scOM0xNfySseyHuuN
         Fa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pv63BqJG13E00+xwd/kF1jAWY+UxyXW33fdXaIG0kq8=;
        b=qi72jEzIGmei1uw7otXpxjCmv9d9cAGCZAK1rNY1iZ/DrokBEM1hOANynoePpQgM1K
         JpWi34kT9YEISzpY+tfwSgKvyJ+XCHfIv/4Qsf/bxChui/q86YeHBNCq1+MKDo9UdhRe
         3ZTgS0eo1wq0WkRhpKv367080n7a+QnVz/wpRj2CxpTBo8Net8RNlnhGLGW2tXfVwgzu
         byxzKf61ZmNKzd30Pa2YFRnpyvdNWtdKm0ddT8jcZXCS8FL/EsDJ9iIlbing9QnUtx+Y
         CFuQbByqbs8FwZCRyDBCYzifGq3I43tuSe4IcxrpJKUfBdroD4akkK3ZSn/wkNmc/zR4
         7V7Q==
X-Gm-Message-State: APjAAAWAzJvIRPwbj8EadoZ0JFF/BVKeGQlqbdkp2n5Vgq+Lelrxdz1U
        AAHAnEdO4FpHYd5w0G0ek89Sj4MsAQk=
X-Google-Smtp-Source: APXvYqwm9+jVtbSYDQW7U2by/dHV3bsRwuVzMr7tlKUcqfS6l0SD4nj4sPXvOx6Hn1BrOVmcOdvhza1U1h0=
X-Received: by 2002:a9f:3110:: with SMTP id m16mr4238732uab.10.1566432594812;
 Wed, 21 Aug 2019 17:09:54 -0700 (PDT)
Date:   Wed, 21 Aug 2019 17:09:31 -0700
Message-Id: <20190822000933.180870-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 1/3] fuse: on 64-bit store time in d_fsdata directly
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

