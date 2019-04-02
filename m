Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C04C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8D720856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbfDBNnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:43:13 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43660 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731518AbfDBNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:11 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe4-0002oc-7z; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004vW-3r; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.674761641@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 63/99] ext4: force inode writes when nfsd calls
 commit_metadata()
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit fde872682e175743e0c3ef939c89e3c6008a1529 upstream.

Some time back, nfsd switched from calling vfs_fsync() to using a new
commit_metadata() hook in export_operations().  If the file system did
not provide a commit_metadata() hook, it fell back to using
sync_inode_metadata().  Unfortunately doesn't work on all file
systems.  In particular, it doesn't work on ext4 due to how the inode
gets journalled --- the VFS writeback code will not always call
ext4_write_inode().

So we need to provide our own ext4_nfs_commit_metdata() method which
calls ext4_write_inode() directly.

Google-Bug-Id: 121195940
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/super.c             | 11 +++++++++++
 include/trace/events/ext4.h | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1042,6 +1042,16 @@ static struct dentry *ext4_fh_to_parent(
 				    ext4_nfs_get_inode);
 }
 
+static int ext4_nfs_commit_metadata(struct inode *inode)
+{
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL
+	};
+
+	trace_ext4_nfs_commit_metadata(inode);
+	return ext4_write_inode(inode, &wbc);
+}
+
 /*
  * Try to release metadata pages (indirect blocks, directories) which are
  * mapped via the block device.  Since these pages could have journal heads
@@ -1162,6 +1172,7 @@ static const struct export_operations ex
 	.fh_to_dentry = ext4_fh_to_dentry,
 	.fh_to_parent = ext4_fh_to_parent,
 	.get_parent = ext4_get_parent,
+	.commit_metadata = ext4_nfs_commit_metadata,
 };
 
 enum {
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -195,6 +195,26 @@ TRACE_EVENT(ext4_drop_inode,
 		  (unsigned long) __entry->ino, __entry->drop)
 );
 
+TRACE_EVENT(ext4_nfs_commit_metadata,
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	ino_t,	ino			)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+	),
+
+	TP_printk("dev %d,%d ino %lu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino)
+);
+
 TRACE_EVENT(ext4_mark_inode_dirty,
 	TP_PROTO(struct inode *inode, unsigned long IP),
 

