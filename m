Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8770AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C07C20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="oPD6V7mS";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="qVPcNvqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEFRuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:50:40 -0400
Received: from mail133-31.atl131.mandrillapp.com ([198.2.133.31]:9935 "EHLO
        mail133-31.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbfEFRuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:50:37 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 13:50:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=/hQmroba0dU65ofpriWdOomY8Gf3MCvdyaVKjqbmg6E=;
 b=oPD6V7mS4MbnHKjHkK7be7CJhbuTr23hcNgqEhiZVjecNtfctDrgmaa0RVlBabYplMEqXZZADiIc
   kDzaRP2t1bQPL8WZ6X4QvNPAoEWK4mIQ1FopHRjriBiybMO8vG0hQt4b7UG4jH2ZY8LwFe/zkMRm
   eGRzdyOLEb92GzDOc9k=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-31.atl131.mandrillapp.com id hq1puq1sar8j for <linux-kernel@vger.kernel.org>; Mon, 6 May 2019 17:34:14 +0000 (envelope-from <bounce-md_31050260.5cd07016.v1-185e68dc7b554458a7256644e91bc41d@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1557164054; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=/hQmroba0dU65ofpriWdOomY8Gf3MCvdyaVKjqbmg6E=; 
 b=qVPcNvqg08wPA6FMIdjCA+tSzZzNm9TI5bVoQEAabETbf69s0Eeug/NTWFcErZYTX1x8Fj
 R1oF1zaY4yMDD09nWZ2H4opPS1hZ4M8PNWwNDbLSx6qCU8EhC5PhDBXIxtLa5PIaVBzIzUYr
 sQQaZKm+oH7ojU36MW49o8m641RHE=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 3/3] vfs: pass ppos=NULL to .read()/.write() of FMODE_STREAM files
Received: from [87.98.221.171] by mandrillapp.com id 185e68dc7b554458a7256644e91bc41d; Mon, 06 May 2019 17:34:14 +0000
X-Mailer: git-send-email 2.20.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <438ab720c675a16d53bb18f76a94d25bbe420c45.1557162679.git.kirr@nexedi.com>
In-Reply-To: <cover.1557162679.git.kirr@nexedi.com>
References: <cover.1557162679.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.185e68dc7b554458a7256644e91bc41d
X-Mandrill-User: md_31050260
Date:   Mon, 06 May 2019 17:34:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This amends commit 10dce8af3422 ("fs: stream_open - opener for
stream-like files so that read and write can run simultaneously without
deadlock") in how position is passed into .read()/.write() handler for
stream-like files:

Rasmus noticed that we currently pass 0 as position and ignore any position
change if that is done by a file implementation. This papers over bugs if ppos
is used in files that declare themselves as being stream-like as such bugs will
go unnoticed. Even if a file implementation is correctly converted into using
stream_open, its read/write later could be changed to use ppos and even though
that won't be working correctly, that bug might go unnoticed without someone
doing wrong behaviour analysis. It is thus better to pass ppos=NULL into
read/write for stream-like files as that don't give any chance for ppos usage
bugs because it will oops if ppos is ever used inside .read() or .write().

Note 1: rw_verify_area, new_sync_{read,write} needs to be updated
because they are called by vfs_read/vfs_write & friends before
file_operations .read/.write .

Note 2: if file backend uses new-style .read_iter/.write_iter, position
is still passed into there as non-pointer kiocb.ki_pos . Currently
stream_open.cocci (semantic patch added by 10dce8af3422) ignores files
whose file_operations has *_iter methods.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 fs/open.c       |   5 ++-
 fs/read_write.c | 113 ++++++++++++++++++++++++++++--------------------
 2 files changed, 70 insertions(+), 48 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index a00350018a47..9c7d724a6f67 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1219,8 +1219,9 @@ EXPORT_SYMBOL(nonseekable_open);
 /*
  * stream_open is used by subsystems that want stream-like file descriptors.
  * Such file descriptors are not seekable and don't have notion of position
- * (file.f_pos is always 0). Contrary to file descriptors of other regular
- * files, .read() and .write() can run simultaneously.
+ * (file.f_pos is always 0 and ppos passed to .read()/.write() is always NULL).
+ * Contrary to file descriptors of other regular files, .read() and .write()
+ * can run simultaneously.
  *
  * stream_open never fails and is marked to return int so that it could be
  * directly used as file_operations.open .
diff --git a/fs/read_write.c b/fs/read_write.c
index 61b43ad7608e..c543d965e288 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -365,29 +365,37 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t count)
 {
 	struct inode *inode;
-	loff_t pos;
 	int retval = -EINVAL;
 
 	inode = file_inode(file);
 	if (unlikely((ssize_t) count < 0))
 		return retval;
-	pos = *ppos;
-	if (unlikely(pos < 0)) {
-		if (!unsigned_offsets(file))
-			return retval;
-		if (count >= -pos) /* both values are in 0..LLONG_MAX */
-			return -EOVERFLOW;
-	} else if (unlikely((loff_t) (pos + count) < 0)) {
-		if (!unsigned_offsets(file))
-			return retval;
-	}
 
-	if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
-		retval = locks_mandatory_area(inode, file, pos, pos + count - 1,
-				read_write == READ ? F_RDLCK : F_WRLCK);
-		if (retval < 0)
-			return retval;
+	/*
+	 * ranged mandatory locking does not apply to streams - it makes sense
+	 * only for files where position has a meaning.
+	 */
+	if (ppos) {
+		loff_t pos = *ppos;
+
+		if (unlikely(pos < 0)) {
+			if (!unsigned_offsets(file))
+				return retval;
+			if (count >= -pos) /* both values are in 0..LLONG_MAX */
+				return -EOVERFLOW;
+		} else if (unlikely((loff_t) (pos + count) < 0)) {
+			if (!unsigned_offsets(file))
+				return retval;
+		}
+
+		if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
+			retval = locks_mandatory_area(inode, file, pos, pos + count - 1,
+					read_write == READ ? F_RDLCK : F_WRLCK);
+			if (retval < 0)
+				return retval;
+		}
 	}
+
 	return security_file_permission(file,
 				read_write == READ ? MAY_READ : MAY_WRITE);
 }
@@ -400,12 +408,13 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
-	kiocb.ki_pos = *ppos;
+	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_init(&iter, READ, &iov, 1, len);
 
 	ret = call_read_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
-	*ppos = kiocb.ki_pos;
+	if (ppos)
+		*ppos = kiocb.ki_pos;
 	return ret;
 }
 
@@ -468,12 +477,12 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
-	kiocb.ki_pos = *ppos;
+	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_init(&iter, WRITE, &iov, 1, len);
 
 	ret = call_write_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
-	if (ret > 0)
+	if (ret > 0 && ppos)
 		*ppos = kiocb.ki_pos;
 	return ret;
 }
@@ -558,15 +567,10 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 	return ret;
 }
 
-static inline loff_t file_pos_read(struct file *file)
-{
-	return file->f_mode & FMODE_STREAM ? 0 : file->f_pos;
-}
-
-static inline void file_pos_write(struct file *file, loff_t pos)
+/* file_ppos returns &file->f_pos or NULL if file is stream */
+static inline loff_t *file_ppos(struct file *file)
 {
-	if ((file->f_mode & FMODE_STREAM) == 0)
-		file->f_pos = pos;
+	return file->f_mode & FMODE_STREAM ? NULL : &file->f_pos;
 }
 
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
@@ -575,10 +579,14 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos = file_pos_read(f.file);
-		ret = vfs_read(f.file, buf, count, &pos);
-		if (ret >= 0)
-			file_pos_write(f.file, pos);
+		loff_t pos, *ppos = file_ppos(f.file);
+		if (ppos) {
+			pos = *ppos;
+			ppos = &pos;
+		}
+		ret = vfs_read(f.file, buf, count, ppos);
+		if (ret >= 0 && ppos)
+			f.file->f_pos = pos;
 		fdput_pos(f);
 	}
 	return ret;
@@ -595,10 +603,14 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos = file_pos_read(f.file);
-		ret = vfs_write(f.file, buf, count, &pos);
-		if (ret >= 0)
-			file_pos_write(f.file, pos);
+		loff_t pos, *ppos = file_ppos(f.file);
+		if (ppos) {
+			pos = *ppos;
+			ppos = &pos;
+		}
+		ret = vfs_write(f.file, buf, count, ppos);
+		if (ret >= 0 && ppos)
+			f.file->f_pos = pos;
 		fdput_pos(f);
 	}
 
@@ -673,14 +685,15 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	ret = kiocb_set_rw_flags(&kiocb, flags);
 	if (ret)
 		return ret;
-	kiocb.ki_pos = *ppos;
+	kiocb.ki_pos = (ppos ? *ppos : 0);
 
 	if (type == READ)
 		ret = call_read_iter(filp, &kiocb, iter);
 	else
 		ret = call_write_iter(filp, &kiocb, iter);
 	BUG_ON(ret == -EIOCBQUEUED);
-	*ppos = kiocb.ki_pos;
+	if (ppos)
+		*ppos = kiocb.ki_pos;
 	return ret;
 }
 
@@ -1013,10 +1026,14 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos = file_pos_read(f.file);
-		ret = vfs_readv(f.file, vec, vlen, &pos, flags);
-		if (ret >= 0)
-			file_pos_write(f.file, pos);
+		loff_t pos, *ppos = file_ppos(f.file);
+		if (ppos) {
+			pos = *ppos;
+			ppos = &pos;
+		}
+		ret = vfs_readv(f.file, vec, vlen, ppos, flags);
+		if (ret >= 0 && ppos)
+			f.file->f_pos = pos;
 		fdput_pos(f);
 	}
 
@@ -1033,10 +1050,14 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos = file_pos_read(f.file);
-		ret = vfs_writev(f.file, vec, vlen, &pos, flags);
-		if (ret >= 0)
-			file_pos_write(f.file, pos);
+		loff_t pos, *ppos = file_ppos(f.file);
+		if (ppos) {
+			pos = *ppos;
+			ppos = &pos;
+		}
+		ret = vfs_writev(f.file, vec, vlen, ppos, flags);
+		if (ret >= 0 && ppos)
+			f.file->f_pos = pos;
 		fdput_pos(f);
 	}
 
-- 
2.20.1
