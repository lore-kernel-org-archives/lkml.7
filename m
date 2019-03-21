Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC240C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9344218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfCULrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:47:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCULrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:47:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 320CD8123A;
        Thu, 21 Mar 2019 11:47:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 567D860C14;
        Thu, 21 Mar 2019 11:47:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 1/8] vfs: Add a single-or-reconfig keying to
 vfs_get_super()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Thu, 21 Mar 2019 11:47:43 +0000
Message-ID: <155316886354.29437.8797952998692804823.stgit@warthog.procyon.org.uk>
In-Reply-To: <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk>
References: <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 21 Mar 2019 11:47:45 +0000 (UTC)
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

 fs/super.c                 |   18 +++++++++++++-----
 include/linux/fs_context.h |    1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 6d8dbf309241..fa1d697b73bb 100644
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
@@ -1195,18 +1197,24 @@ int vfs_get_super(struct fs_context *fc,
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
+	} else if (keying == vfs_get_single_reconf_super) {
+		err = reconfigure_super(fc);
+		if (err < 0)
+			goto error;
 	}
 
 	BUG_ON(fc->root);
 	fc->root = dget(sb->s_root);
 	return 0;
+
+error:
+	deactivate_locked_super(sb);
+	return err;
 }
 EXPORT_SYMBOL(vfs_get_super);
 
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 8233c873af73..f1ed5ea0a041 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -136,6 +136,7 @@ extern int vfs_init_pseudo_fs_context(struct fs_context *fc,
  */
 enum vfs_get_super_keying {
 	vfs_get_single_super,	/* Only one such superblock may exist */
+	vfs_get_single_reconf_super, /* As above, but reconfigure if it exists */
 	vfs_get_keyed_super,	/* Superblocks with different s_fs_info keys may exist */
 	vfs_get_independent_super, /* Multiple independent superblocks may exist */
 };

