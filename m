Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8ECC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7853B2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbfC0Xnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:43:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfC0Xnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:43:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38960F74A4;
        Wed, 27 Mar 2019 23:43:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64DEB19C5A;
        Wed, 27 Mar 2019 23:43:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 25/68] vfs: Kill mount_ns()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:43:43 +0000
Message-ID: <155373022365.7602.4831935858502341047.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 27 Mar 2019 23:43:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kill mount_ns() as it has been replaced by vfs_get_super() in the new mount
API.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-fsdevel@vger.kernel.org
---

 fs/super.c         |   44 --------------------------------------------
 include/linux/fs.h |    3 ---
 2 files changed, 47 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 6c3acd633cca..3b5275298f7c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1148,50 +1148,6 @@ void kill_litter_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(kill_litter_super);
 
-static int ns_test_super(struct super_block *sb, void *data)
-{
-	return sb->s_fs_info == data;
-}
-
-static int ns_set_super(struct super_block *sb, void *data)
-{
-	sb->s_fs_info = data;
-	return set_anon_super(sb, NULL);
-}
-
-struct dentry *mount_ns(struct file_system_type *fs_type,
-	int flags, void *data, void *ns, struct user_namespace *user_ns,
-	int (*fill_super)(struct super_block *, void *, int))
-{
-	struct super_block *sb;
-
-	/* Don't allow mounting unless the caller has CAP_SYS_ADMIN
-	 * over the namespace.
-	 */
-	if (!(flags & SB_KERNMOUNT) && !ns_capable(user_ns, CAP_SYS_ADMIN))
-		return ERR_PTR(-EPERM);
-
-	sb = sget_userns(fs_type, ns_test_super, ns_set_super, flags,
-			 user_ns, ns);
-	if (IS_ERR(sb))
-		return ERR_CAST(sb);
-
-	if (!sb->s_root) {
-		int err;
-		err = fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
-		if (err) {
-			deactivate_locked_super(sb);
-			return ERR_PTR(err);
-		}
-
-		sb->s_flags |= SB_ACTIVE;
-	}
-
-	return dget(sb->s_root);
-}
-
-EXPORT_SYMBOL(mount_ns);
-
 int set_anon_super_fc(struct super_block *sb, struct fs_context *fc)
 {
 	return set_anon_super(sb, NULL);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b738e8e5b096..20c15794c2ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2194,9 +2194,6 @@ struct file_system_type {
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
 
-extern struct dentry *mount_ns(struct file_system_type *fs_type,
-	int flags, void *data, void *ns, struct user_namespace *user_ns,
-	int (*fill_super)(struct super_block *, void *, int));
 #ifdef CONFIG_BLOCK
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,

