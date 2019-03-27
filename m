Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A79C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E7420651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfC0Xpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:45:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfC0Xpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:45:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6992AD7921;
        Wed, 27 Mar 2019 23:45:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7434019C5A;
        Wed, 27 Mar 2019 23:45:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 40/68] vfs: Convert smackfs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:45:34 +0000
Message-ID: <155373033460.7602.12727592550663113967.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 27 Mar 2019 23:45:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the smackfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-security-module@vger.kernel.org
---

 security/smack/smackfs.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index faf2ea3968b3..7e3a81d05136 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -27,6 +27,7 @@
 #include <linux/ctype.h>
 #include <linux/audit.h>
 #include <linux/magic.h>
+#include <linux/fs_context.h>
 #include "smack.h"
 
 #define BEBITS	(sizeof(__be32) * 8)
@@ -2843,14 +2844,13 @@ static const struct file_operations smk_ptrace_ops = {
 /**
  * smk_fill_super - fill the smackfs superblock
  * @sb: the empty superblock
- * @data: unused
- * @silent: unused
+ * @fc: unused
  *
  * Fill in the well known entries for the smack filesystem
  *
  * Returns 0 on success, an error code on failure
  */
-static int smk_fill_super(struct super_block *sb, void *data, int silent)
+static int smk_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int rc;
 
@@ -2920,25 +2920,35 @@ static int smk_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 /**
- * smk_mount - get the smackfs superblock
- * @fs_type: passed along without comment
- * @flags: passed along without comment
- * @dev_name: passed along without comment
- * @data: passed along without comment
+ * smk_get_tree - get the smackfs superblock
+ * @fc: The mount context, including any options
  *
  * Just passes everything along.
  *
  * Returns what the lower level code does.
  */
-static struct dentry *smk_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data)
+static int smk_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, smk_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, smk_fill_super);
+}
+
+static const struct fs_context_operations smk_context_ops = {
+	.get_tree	= smk_get_tree,
+};
+
+/**
+ * smk_init_fs_context - Initialise a filesystem context for smackfs
+ * @fc: The blank mount context
+ */
+static int smk_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &smk_context_ops;
+	return 0;
 }
 
 static struct file_system_type smk_fs_type = {
 	.name		= "smackfs",
-	.mount		= smk_mount,
+	.init_fs_context = smk_init_fs_context,
 	.kill_sb	= kill_litter_super,
 };
 

