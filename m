Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C771620811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="INtlbxYo";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="YcMOIyRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbfCZXhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:37:16 -0400
Received: from mail128-16.atl41.mandrillapp.com ([198.2.128.16]:59615 "EHLO
        mail128-16.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730333AbfCZXhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:37:15 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 19:37:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=QL99GUss+MVS3eCKqjgk6p3ckRJUrMSLnzdhSyvE7f4=;
 b=INtlbxYoTwP35GWsscKvgX4FH6Cb3L3AoMLHtr3N1aTybhsxhn5iMZwe9wASJUai4TaH2BWq7atu
   kK5yoSv/8i710YL1GVQ9yFD5IbT5NxCpf002ipZSOHeVdHsxBZUzw6lFzEblQpLRMvr5ScPByZSx
   44C1x/1yZMBn/9klzLI=
Received: from pmta01.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail128-16.atl41.mandrillapp.com id hjarqk1mqukq for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 23:22:12 +0000 (envelope-from <bounce-md_31050260.5c9ab424.v1-cfa380936c2c47eaacb995baa539f9ea@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1553642532; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=QL99GUss+MVS3eCKqjgk6p3ckRJUrMSLnzdhSyvE7f4=; 
 b=YcMOIyRoxP9g3Du+zMIOVDEKM1xToHFT0aYnfq96H4nKyWlArB2FXjoAgweDdsUGafloSv
 dWWDax5fTG7G8sI8hZRn24RsbVSK63whXeSJmguoiE5qj9q3taIFsCUjEBHuRjLjkod3qQJ6
 U/aqnELpzFeyE7a0BCsOIekubXMW8=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 3/3] fuse: Add FOPEN_STREAM and use stream_open() if filesystem returned that from open handler
Received: from [87.98.221.171] by mandrillapp.com id cfa380936c2c47eaacb995baa539f9ea; Tue, 26 Mar 2019 23:22:12 +0000
X-Mailer: git-send-email 2.21.0.392.gf8f6787159
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Message-Id: <dc47c061f20c464ccf46b43822b062dca6486e90.1553637462.git.kirr@nexedi.com>
In-Reply-To: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com>
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.cfa380936c2c47eaacb995baa539f9ea
X-Mandrill-User: md_31050260
Date:   Tue, 26 Mar 2019 23:22:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from 9c225f2655 (vfs: atomic f_pos accesses as per POSIX) files
opened even via nonseekable_open gate read and write via lock and do not
allow them to be run simultaneously. This can create read vs write
deadlock if a filesystem is trying to implement a socket-like file which
is intended to be simultaneously used for both read and write from
filesystem client. See previous patch "fs: stream_open - opener for
stream-like files so that read and write can run simultaneously without
deadlock" for details and e.g. 581d21a2d0 (xenbus: fix deadlock on
writes to /proc/xen/xenbus) for a similar deadlock example on /proc/xen/xenbus.

To avoid such deadlock it was tempting fuse_finish_open to use
stream_open instead of nonseekable_open on just FOPEN_NONSEEKABLE flags,
but grepping through Debian codesearch shows users of FOPEN_NONSEEKABLE,
and in particular GVFS which actually uses offset in its read and write
handlers

	https://codesearch.debian.net/search?q=-%3Enonseekable+%3D
	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1080
	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1247-1346
	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1399-1481

so if we would do such a change it will break a real user.

-> Add another flag (FOPEN_STREAM) for filesystem servers to indicate
that the opened handler is having stream-like semantics; does not use
file position and thus the kernel is free to issue simultaneous read and
write request on opened file handle.

This patch together with stream_open should be added to stable kernels starting from
v3.14+ (the kernel where 9c225f2655 first appeared). This will allow to patch
OSSPD and other FUSE filesystems that provide stream-like files to return
FOPEN_STREAM | FOPEN_NONSEEKABLE in open handler and this way avoid the deadlock on
all kernel versions. This should work because fuse_finish_open ignores unknown open
flags returned from a filesystem and so passing FOPEN_STREAM to a kernel that
is not aware of this flag cannot hurt. In turn the kernel that is not aware of
FOPEN_STREAM will be < v3.14 where just FOPEN_NONSEEKABLE is sufficient to
implement streams without read vs write deadlock.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Yongzhi Pan <panyongzhi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Nikolaus Rath <Nikolaus@rath.org>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 fs/fuse/file.c            | 4 +++-
 include/uapi/linux/fuse.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ffaffe18352a..7ea4099cde16 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -181,7 +181,9 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 		file->f_op = &fuse_direct_io_file_operations;
 	if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 		invalidate_inode_pages2(inode->i_mapping);
-	if (ff->open_flags & FOPEN_NONSEEKABLE)
+	if (ff->open_flags & FOPEN_STREAM)
+		stream_open(inode, file);
+	else if (ff->open_flags & FOPEN_NONSEEKABLE)
 		nonseekable_open(inode, file);
 	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
 		struct fuse_inode *fi = get_fuse_inode(inode);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b4967d48bfda..93ac72a1e4ff 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -226,11 +226,13 @@ struct fuse_file_lock {
  * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
  * FOPEN_NONSEEKABLE: the file is not seekable
  * FOPEN_CACHE_DIR: allow caching this directory
+ * FOPEN_STREAM: the file is stream-like
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
 #define FOPEN_NONSEEKABLE	(1 << 2)
 #define FOPEN_CACHE_DIR		(1 << 3)
+#define FOPEN_STREAM		(1 << 4)
 
 /**
  * INIT request/reply flags
-- 
2.21.0.392.gf8f6787159
