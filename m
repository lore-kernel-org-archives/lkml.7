Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81DCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B3E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="bwA+CJs9";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="l2MLy+bJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfC0K3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:29:14 -0400
Received: from mail177-9.suw61.mandrillapp.com ([198.2.177.9]:57723 "EHLO
        mail177-9.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfC0K3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:29:14 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 06:29:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=e8HYmYugXSvAr9S+tFkQEap2XogCxVY+blXQqfdS8eY=;
 b=bwA+CJs9NV86wdMXamuuRoHZA0x4/NXHwK+hn3y8J+AJUphDKVouD1IgZb+5Bgjjz50OvoK9ZlL8
   NrYm1p6f/rB2K39A7NYr4h2nYqLiX9062tpAlaitqMjebW5XSPw+2QIzrO9ezzWpj2x0jTuXZi4v
   nhZTP/v4/sdwrvX4Fv0=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-9.suw61.mandrillapp.com id hjd87i22rtk0 for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:14:12 +0000 (envelope-from <bounce-md_31050260.5c9b4cf3.v1-79ee1a4a408346d9baf236bbd10d9599@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1553681651; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=e8HYmYugXSvAr9S+tFkQEap2XogCxVY+blXQqfdS8eY=; 
 b=l2MLy+bJ5ALyc0/hns9OuvfjcJbyJRwv9MVspXa2bS2fZiKNCn1ykhKVkKxdwJ/5QQ58T2
 g3bbDXqObf1rnLNV9Mj9TmWucAjay/q/be2uyzEnUpBoIfajTYjtFWpMOiV65sBziyoGySvS
 JZqQgi2wdlOLhuZ++rkdPGV911HYI=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [RESEND1, PATCH v2 2/2] fuse: allow filesystems to have precise control over data cache
Received: from [87.98.221.171] by mandrillapp.com id 79ee1a4a408346d9baf236bbd10d9599; Wed, 27 Mar 2019 10:14:11 +0000
X-Mailer: git-send-email 2.21.0.392.gf8f6787159
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Brian Foster <bfoster@redhat.com>,
        Maxim Patlasov <mpatlasov@parallels.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrew Gallagher <andrewjcg@fb.com>,
        "Anand V . Avati" <avati@redhat.com>,
        Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Constantine Shulyupin <const@MakeLinux.com>,
        Chad Austin <chadaustin@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>,
        <linux-fsdevel@vger.kernel.org>,
        <fuse-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <e0b43507976d6ea9010f1bacaef067f18de49f1f.1553677194.git.kirr@nexedi.com>
In-Reply-To: <cover.1553677194.git.kirr@nexedi.com>
References: <cover.1553677194.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.79ee1a4a408346d9baf236bbd10d9599
X-Mandrill-User: md_31050260
Date:   Wed, 27 Mar 2019 10:14:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On networked filesystems file data can be changed externally.
FUSE provides notification messages for filesystem to inform kernel that
metadata or data region of a file needs to be invalidated in local page
cache. That provides the basis for filesystem implementations to
invalidate kernel cache precisely based on observed filesystem-specific
events.

FUSE has also "automatic" invalidation mode(*) when the kernel
automatically invalidates data cache of a file if it sees mtime change.
It also automatically invalidates whole data cache of a file if it sees
file size being changed.

The automatic mode has corresponding capability - FUSE_AUTO_INVAL_DATA.
However, due to probably historical reason, that capability controls
only whether mtime change should be resulting in automatic invalidation
or not. A change in file size always results in invalidating whole data
cache of a file irregardless of whether FUSE_AUTO_INVAL_DATA was
negotiated(+).

The filesystem I write[1] represents data arrays stored in networked
database as local files suitable for mmap. It is read-only filesystem -
changes to data are committed externally via database interfaces and the
filesystem only glues data into contiguous file streams suitable for
mmap and traditional array processing. The files are big - starting from
hundreds gigabytes and more. The files change regularly, and frequently
by data being appended to their end. The size of files thus changes
frequently.

If a file was accessed locally and some part of its data got into page
cache, we want that data to stay cached unless there is memory pressure,
or unless corresponding part of the file was actually changed. However
current FUSE behaviour - when it sees file size change - is to
invalidate the whole file. The data cache of the file is thus completely
lost even on small size change, and despite that the filesystem server is
careful to accurately translate database changes into FUSE invalidation
messages to kernel.

Let's fix it: if a filesystem, through new FUSE_PRECISE_INVAL_DATA
capability, indicates to kernel that it is fully responsible for data
cache invalidation, then the kernel won't invalidate files data cache on
size change and only truncate that cache to new size in case the size
decreased.

(*) see 72d0d248ca "fuse: add FUSE_AUTO_INVAL_DATA init flag",
eed2179efe "fuse: invalidate inode mapping if mtime changes"

(+) in writeback mode the kernel does not invalidate data cache on file
size change, but neither it allows the filesystem to set the size due to
external event (see 8373200b12 "fuse: Trust kernel i_size only")

[1] https://lab.nexedi.com/kirr/wendelin.core/blob/a50f1d9f/wcfs/wcfs.go#L20

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           | 12 ++++++++++--
 include/uapi/linux/fuse.h |  7 ++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e6195bc8f836..154f6cdd94d1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -694,6 +694,9 @@ struct fuse_conn {
 	/** Use enhanced/automatic page cache invalidation. */
 	unsigned auto_inval_data:1;
 
+	/** Filesystem is fully reponsible for page cache invalidation. */
+	unsigned precise_inval_data:1;
+
 	/** Does the filesystem support readdirplus? */
 	unsigned do_readdirplus:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1bca5023bcc5..2be0bca7f76c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -237,7 +237,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 
 		if (oldsize != attr->size) {
 			truncate_pagecache(inode, attr->size);
-			inval = true;
+			if (!fc->precise_inval_data)
+				inval = true;
 		} else if (fc->auto_inval_data) {
 			struct timespec64 new_mtime = {
 				.tv_sec = attr->mtime,
@@ -912,6 +913,13 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 				fc->dont_mask = 1;
 			if (arg->flags & FUSE_AUTO_INVAL_DATA)
 				fc->auto_inval_data = 1;
+			if (arg->flags & FUSE_PRECISE_INVAL_DATA)
+				fc->precise_inval_data = 1;
+			if (fc->auto_inval_data && fc->precise_inval_data) {
+				pr_warn("filesystem requested both auto and "
+					"precise cache control - using auto\n");
+				fc->precise_inval_data = 0;
+			}
 			if (arg->flags & FUSE_DO_READDIRPLUS) {
 				fc->do_readdirplus = 1;
 				if (arg->flags & FUSE_READDIRPLUS_AUTO)
@@ -973,7 +981,7 @@ static void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_PRECISE_INVAL_DATA;
 	req->in.h.opcode = FUSE_INIT;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(*arg);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2ac598614a8f..33de8f6391ec 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -125,6 +125,9 @@
  *
  *  7.29
  *  - add FUSE_NO_OPENDIR_SUPPORT flag
+ *
+ *  7.30
+ *  - add FUSE_PRECISE_INVAL_DATA
  */
 
 #ifndef _LINUX_FUSE_H
@@ -160,7 +163,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 29
+#define FUSE_KERNEL_MINOR_VERSION 30
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -263,6 +266,7 @@ struct fuse_file_lock {
  * FUSE_MAX_PAGES: init_out.max_pages contains the max number of req pages
  * FUSE_CACHE_SYMLINKS: cache READLINK responses
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
+ * FUSE_PRECISE_INVAL_DATA: filesystem is fully responsible for data cache invalidation
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -289,6 +293,7 @@ struct fuse_file_lock {
 #define FUSE_MAX_PAGES		(1 << 22)
 #define FUSE_CACHE_SYMLINKS	(1 << 23)
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
+#define FUSE_PRECISE_INVAL_DATA (1 << 25)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.21.0.392.gf8f6787159
