Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAF8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B7B2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfEOU7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbfEOU7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:59:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5181D307CB5E;
        Wed, 15 May 2019 20:59:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF056A23C;
        Wed, 15 May 2019 20:59:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/12] afs: Split afs_validate() so first part can be used
 under LOOKUP_RCU
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:59:11 +0100
Message-ID: <155795395185.28355.325602097001672205.stgit@warthog.procyon.org.uk>
In-Reply-To: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
References: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 15 May 2019 20:59:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split afs_validate() so that the part that decides if the vnode is still
valid can be used under LOOKUP_RCU conditions from afs_d_revalidate().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c    |   37 ++++++++++++++++++++++++-------------
 fs/afs/internal.h |    1 +
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index b644f3d5e4e9..a89948a9dd0d 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -560,23 +560,12 @@ void afs_zap_data(struct afs_vnode *vnode)
 }
 
 /*
- * validate a vnode/inode
- * - there are several things we need to check
- *   - parent dir data changes (rm, rmdir, rename, mkdir, create, link,
- *     symlink)
- *   - parent dir metadata changed (security changes)
- *   - dentry data changed (write, truncate)
- *   - dentry metadata changed (security changes)
+ * Check the validity of a vnode/inode.
  */
-int afs_validate(struct afs_vnode *vnode, struct key *key)
+bool afs_check_validity(struct afs_vnode *vnode)
 {
 	time64_t now = ktime_get_real_seconds();
 	bool valid;
-	int ret;
-
-	_enter("{v={%llx:%llu} fl=%lx},%x",
-	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
-	       key_serial(key));
 
 	/* Quickly check the callback state.  Ideally, we'd use read_seqbegin
 	 * here, but we have no way to pass the net namespace to the RCU
@@ -605,6 +594,28 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	}
 
 	read_sequnlock_excl(&vnode->cb_lock);
+	return valid;
+}
+
+/*
+ * validate a vnode/inode
+ * - there are several things we need to check
+ *   - parent dir data changes (rm, rmdir, rename, mkdir, create, link,
+ *     symlink)
+ *   - parent dir metadata changed (security changes)
+ *   - dentry data changed (write, truncate)
+ *   - dentry metadata changed (security changes)
+ */
+int afs_validate(struct afs_vnode *vnode, struct key *key)
+{
+	bool valid;
+	int ret;
+
+	_enter("{v={%llx:%llu} fl=%lx},%x",
+	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
+	       key_serial(key));
+
+	valid = afs_check_validity(vnode);
 
 	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
 		clear_nlink(&vnode->vfs_inode);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 175501a7cf8b..d19182e9c15c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1021,6 +1021,7 @@ extern struct inode *afs_iget(struct super_block *, struct key *,
 			      struct afs_cb_interest *,
 			      struct afs_vnode *);
 extern void afs_zap_data(struct afs_vnode *);
+extern bool afs_check_validity(struct afs_vnode *);
 extern int afs_validate(struct afs_vnode *, struct key *);
 extern int afs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 extern int afs_setattr(struct dentry *, struct iattr *);

