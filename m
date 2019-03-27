Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48271C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184C720651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbfC0Xrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731579AbfC0Xr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E55A5307D98E;
        Wed, 27 Mar 2019 23:47:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14C695C28D;
        Wed, 27 Mar 2019 23:47:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 54/68] vfs: Add a single-or-reconfig keying to
 vfs_get_super()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:47:26 +0000
Message-ID: <155373044628.7602.5582738555964851633.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 27 Mar 2019 23:47:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional keying mode to vfs_get_super() to indicate that only a
single superblock should exist in the system, and that, if it does, further
mounts should invoke reconfiguration upon it.

This allows mount_single() to be replaced.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/super.c                 |   24 +++++++++++++++++-------
 include/linux/fs_context.h |    1 +
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 6cb57ad31e6f..60c9caeae3c7 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1175,9 +1175,11 @@ int vfs_get_super(struct fs_context *fc,
 {
 	int (*test)(struct super_block *, struct fs_context *);
 	struct super_block *sb;
+	int err;
 
 	switch (keying) {
 	case vfs_get_single_super:
+	case vfs_get_single_reconf_super:
 		test = test_single_super;
 		break;
 	case vfs_get_keyed_super:
@@ -1195,18 +1197,26 @@ int vfs_get_super(struct fs_context *fc,
 		return PTR_ERR(sb);
 
 	if (!sb->s_root) {
-		int err = fill_super(sb, fc);
-		if (err) {
-			deactivate_locked_super(sb);
-			return err;
-		}
+		err = fill_super(sb, fc);
+		if (err)
+			goto error;
 
 		sb->s_flags |= SB_ACTIVE;
+		fc->root = dget(sb->s_root);
+	} else {
+		fc->root = dget(sb->s_root);
+		if (keying == vfs_get_single_reconf_super) {
+			err = reconfigure_super(fc);
+			if (err < 0)
+				goto error;
+		}
 	}
 
-	BUG_ON(fc->root);
-	fc->root = dget(sb->s_root);
 	return 0;
+
+error:
+	deactivate_locked_super(sb);
+	return err;
 }
 EXPORT_SYMBOL(vfs_get_super);
 
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 7c7eefb35cc3..3b1da9b2db91 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -138,6 +138,7 @@ extern int vfs_init_pseudo_fs_context(struct fs_context *fc,
  */
 enum vfs_get_super_keying {
 	vfs_get_single_super,	/* Only one such superblock may exist */
+	vfs_get_single_reconf_super, /* As above, but reconfigure if it exists */
 	vfs_get_keyed_super,	/* Superblocks with different s_fs_info keys may exist */
 	vfs_get_independent_super, /* Multiple independent superblocks may exist */
 };

