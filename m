Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1832C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C586C2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbfC0Xn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:43:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfC0Xnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35ABA308FFB1;
        Wed, 27 Mar 2019 23:43:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3376E22706;
        Wed, 27 Mar 2019 23:43:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 26/68] vfs: Kill sget_userns()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:43:50 +0000
Message-ID: <155373023041.7602.18320457477644098824.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 27 Mar 2019 23:43:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kill sget_userns(), folding it into sget() as that's the only remaining
user.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-fsdevel@vger.kernel.org
---

 fs/super.c         |   61 +++++++++++++++++-----------------------------------
 include/linux/fs.h |    5 ----
 2 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 3b5275298f7c..f27ee08fb26f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -566,24 +566,35 @@ struct super_block *sget_fc(struct fs_context *fc,
 EXPORT_SYMBOL(sget_fc);
 
 /**
- *	sget_userns -	find or create a superblock
- *	@type:	filesystem type superblock should belong to
- *	@test:	comparison callback
- *	@set:	setup callback
- *	@flags:	mount flags
- *	@user_ns: User namespace for the super_block
- *	@data:	argument to each of them
+ *	sget	-	find or create a superblock
+ *	@type:	  filesystem type superblock should belong to
+ *	@test:	  comparison callback
+ *	@set:	  setup callback
+ *	@flags:	  mount flags
+ *	@data:	  argument to each of them
  */
-struct super_block *sget_userns(struct file_system_type *type,
+struct super_block *sget(struct file_system_type *type,
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
-			int flags, struct user_namespace *user_ns,
+			int flags,
 			void *data)
 {
+	struct user_namespace *user_ns = current_user_ns();
 	struct super_block *s = NULL;
 	struct super_block *old;
 	int err;
 
+	/* We don't yet pass the user namespace of the parent
+	 * mount through to here so always use &init_user_ns
+	 * until that changes.
+	 */
+	if (flags & SB_SUBMOUNT)
+		user_ns = &init_user_ns;
+
+	/* Ensure the requestor has permissions over the target filesystem */
+	if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
+		return ERR_PTR(-EPERM);
+
 	if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
 	    !(type->fs_flags & FS_USERNS_MOUNT) &&
 	    !capable(CAP_SYS_ADMIN))
@@ -629,38 +640,6 @@ struct super_block *sget_userns(struct file_system_type *type,
 	return s;
 }
 
-EXPORT_SYMBOL(sget_userns);
-
-/**
- *	sget	-	find or create a superblock
- *	@type:	  filesystem type superblock should belong to
- *	@test:	  comparison callback
- *	@set:	  setup callback
- *	@flags:	  mount flags
- *	@data:	  argument to each of them
- */
-struct super_block *sget(struct file_system_type *type,
-			int (*test)(struct super_block *,void *),
-			int (*set)(struct super_block *,void *),
-			int flags,
-			void *data)
-{
-	struct user_namespace *user_ns = current_user_ns();
-
-	/* We don't yet pass the user namespace of the parent
-	 * mount through to here so always use &init_user_ns
-	 * until that changes.
-	 */
-	if (flags & SB_SUBMOUNT)
-		user_ns = &init_user_ns;
-
-	/* Ensure the requestor has permissions over the target filesystem */
-	if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
-		return ERR_PTR(-EPERM);
-
-	return sget_userns(type, test, set, flags, user_ns, data);
-}
-
 EXPORT_SYMBOL(sget);
 
 void drop_super(struct super_block *sb)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 20c15794c2ac..646f4ccaeee9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2233,11 +2233,6 @@ void free_anon_bdev(dev_t);
 struct super_block *sget_fc(struct fs_context *fc,
 			    int (*test)(struct super_block *, struct fs_context *),
 			    int (*set)(struct super_block *, struct fs_context *));
-struct super_block *sget_userns(struct file_system_type *type,
-			int (*test)(struct super_block *,void *),
-			int (*set)(struct super_block *,void *),
-			int flags, struct user_namespace *user_ns,
-			void *data);
 struct super_block *sget(struct file_system_type *type,
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),

