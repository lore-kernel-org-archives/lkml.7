Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34D8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E81220818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfEOQZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:25:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfEOQZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:25:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A974F81F12;
        Wed, 15 May 2019 16:25:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A9D3608A6;
        Wed, 15 May 2019 16:25:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/15] afs: Fix key leak in afs_release() and
 afs_evict_inode()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:25:45 +0100
Message-ID: <155793754533.31671.10385071394174622444.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 15 May 2019 16:25:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix afs_release() to go through the cleanup part of the function if
FMODE_WRITE is set rather than exiting through vfs_fsync() (which skips the
cleanup).  The cleanup involves discarding the refs on the key used for
file ops and the writeback key record.

Also fix afs_evict_inode() to clean up any left over wb keys attached to
the inode/vnode when it is removed.

Fixes: 5a8132761609 ("afs: Do better accretion of small writes on newly created content")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c  |    7 ++++---
 fs/afs/inode.c |    1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index e8d6619890a9..eee2b5663b92 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -170,11 +170,12 @@ int afs_release(struct inode *inode, struct file *file)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_file *af = file->private_data;
+	int ret;
 
 	_enter("{%llx:%llu},", vnode->fid.vid, vnode->fid.vnode);
 
 	if ((file->f_mode & FMODE_WRITE))
-		return vfs_fsync(file, 0);
+		ret = vfs_fsync(file, 0);
 
 	file->private_data = NULL;
 	if (af->wb)
@@ -182,8 +183,8 @@ int afs_release(struct inode *inode, struct file *file)
 	key_put(af->key);
 	kfree(af);
 	afs_prune_wb_keys(vnode);
-	_leave(" = 0");
-	return 0;
+	_leave(" = %d", ret);
+	return ret;
 }
 
 /*
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index c4652b42d545..f30aa5eacd39 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -573,6 +573,7 @@ void afs_evict_inode(struct inode *inode)
 	}
 #endif
 
+	afs_prune_wb_keys(vnode);
 	afs_put_permits(rcu_access_pointer(vnode->permit_cache));
 	key_put(vnode->silly_key);
 	vnode->silly_key = NULL;

