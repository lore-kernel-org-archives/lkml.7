Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52795C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E9F20656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="nJk9j71n";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="d6D9J/0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfDXH3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:29:00 -0400
Received: from mail133-30.atl131.mandrillapp.com ([198.2.133.30]:44014 "EHLO
        mail133-30.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729878AbfDXH27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:28:59 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 03:28:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=YL+9ln5GM65PPIzn4ZyySD2afM+zNx1hrOcUkSaP398=;
 b=nJk9j71n8//VDFEPfr25x6mDb3fy2DcWWNytla1DgQIECYTbJ0fsXN00tfzQdaDybV+O2iL72Ocq
   BnQhkF/zXPYGl85AgM2PnDiBKPIxG68lKgP1YvTrzWzzzJfBVWBFo9RiZNydQNxkspbV6JdrxYHW
   2fcSNrFVmtBl+5pfxNk=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-30.atl131.mandrillapp.com id ho083k1sar8i for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:13:57 +0000 (envelope-from <bounce-md_31050260.5cc00cb5.v1-2c918c4f095043b19309b118e3a68b24@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556090037; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=YL+9ln5GM65PPIzn4ZyySD2afM+zNx1hrOcUkSaP398=; 
 b=d6D9J/0h5nGCWIg1Tk8YM/gieRo4H2GwED3p1sOytzg1rIGaS3/z8i23iUyIl1EUv2Pnxp
 R50dUTZl7h4L+CQteNIuE5TrVkQhg1rrH0XKIQY2oHAfn+DFQvMyiye9j6wSnyWG5EPOTk/d
 uHHGEVnIxNSocgkb5uiM1rA/KUFnY=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [RESEND, PATCH 3/3] fuse: Add FOPEN_STREAM and use stream_open() if filesystem returned that from open handler
Received: from [87.98.221.171] by mandrillapp.com id 2c918c4f095043b19309b118e3a68b24; Wed, 24 Apr 2019 07:13:57 +0000
X-Mailer: git-send-email 2.21.0.765.geec228f530
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>
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
        Han-Wen Nienhuys <hanwen@google.com>, <stable@vger.kernel.org>
Message-Id: <20190424071316.11967-1-kirr@nexedi.com>
In-Reply-To: <dc47c061f20c464ccf46b43822b062dca6486e90.1553637462.git.kirr@nexedi.com>
References: 
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.2c918c4f095043b19309b118e3a68b24
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 07:13:57 +0000
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
filesystem client. See 10dce8af3422 ("fs: stream_open - opener for
stream-like files so that read and write can run simultaneously without
deadlock") for details and e.g. 581d21a2d0 (xenbus: fix deadlock on
writes to /proc/xen/xenbus) for a similar deadlock example on /proc/xen/xenbus.

To avoid such deadlock it was tempting to adjust fuse_finish_open to use
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

This patch together with stream_open (10dce8af3422) should be added to
stable kernels starting from v3.14+ (the kernel where 9c225f2655 first
appeared). This will allow to patch OSSPD and other FUSE filesystems that
provide stream-like files to return FOPEN_STREAM | FOPEN_NONSEEKABLE in
open handler and this way avoid the deadlock on all kernel versions. This
should work because fuse_finish_open ignores unknown open flags returned
from a filesystem and so passing FOPEN_STREAM to a kernel that is not
aware of this flag cannot hurt. In turn the kernel that is not aware of
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
Cc: stable@vger.kernel.org # v3.14+
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---

( resending the same patch with updated description to reference stream_open
  that was landed to master as 10dce8af3422; also added cc stable )

 fs/fuse/file.c            | 4 +++-
 include/uapi/linux/fuse.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 06096b60f1df..44de96cb7871 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -178,7 +178,9 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 
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
index 2ac598614a8f..26abf0a571c7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -229,11 +229,13 @@ struct fuse_file_lock {
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
2.21.0.765.geec228f530
