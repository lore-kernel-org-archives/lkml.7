Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E4BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C120B20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="qS/ZD4Xm";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="G7lk07J0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDLM5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:57:09 -0400
Received: from mail14.wdc04.mandrillapp.com ([205.201.139.14]:50736 "EHLO
        mail14.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbfDLM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:57:09 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Apr 2019 08:57:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=Qh4PQEYMpRN+GYZWq3heOyIAyLoqMHuiIIQoSMtEvaE=;
 b=qS/ZD4XmPKSedWHGzkw/W+DTEqZHpiotLs39BXtTNnHwSkCuI9JKhDGih4n8UhBUypNR1qIAU74g
   nZS903pfjxG7JqLOqYZe8py84/t2MXvDPFdNnP0KADTKTVHEQBf6wCDMD2AEannxKiaL/6BvLec3
   mX4moNTrQqenmsqS2Js=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail14.wdc04.mandrillapp.com id hm25i81jvmgh for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:42:03 +0000 (envelope-from <bounce-md_31050260.5cb0879b.v1-6e105d2767894291b0d2a53033411f61@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555072923; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=Qh4PQEYMpRN+GYZWq3heOyIAyLoqMHuiIIQoSMtEvaE=; 
 b=G7lk07J0uQi7CjoGYdwdnTQVPT52X2HizuwX7IoU2mtTXOlsBHVznc76qBN8O8HLSnhtRo
 O0Rje6iOwR7UD4SS1lkAOCaxDjTNSbGTpj+XTLM0hza0lmzpcn+zQrESdXCXc4+r1kZe/0Fg
 FzaqhfZpoy7XnplL0W7V/pNzF+r/E=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 1/3] fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
Received: from [87.98.221.171] by mandrillapp.com id 6e105d2767894291b0d2a53033411f61; Fri, 12 Apr 2019 12:42:03 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Message-Id: <20190412124144.GA22786@deco.navytux.spb.ru>
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com> <4c4651e2-167e-bfcc-7b3e-cda118f98a69@rasmusvillemoes.dk> <20190409203807.GA13855@deco.navytux.spb.ru> <d8c23d05-8810-13a2-cc50-7a47ff35e90b@rasmusvillemoes.dk> <20190411123816.GA18309@deco.navytux.spb.ru> <CAHk-=whJtZt52SnhBGrNMnuxFn3GE9X_e02x8BPxtkqrfyZukw@mail.gmail.com>
In-Reply-To: <CAHk-=whJtZt52SnhBGrNMnuxFn3GE9X_e02x8BPxtkqrfyZukw@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.6e105d2767894291b0d2a53033411f61
X-Mandrill-User: md_31050260
Date:   Fri, 12 Apr 2019 12:42:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 09:22:56AM -0700, Linus Torvalds wrote:
> On Thu, Apr 11, 2019 at 5:38 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > However file->f_pos writing is still there and it will bug under race
> > detector, e.g. under KTSAN because read and write can be running
> > simultaneously. Maybe it is not only race bug, but also a bit of
> > slowdown as read and write code paths write to the same memory thus
> > needing inter-cpu synchronization if read and write handlers are on
> > different cpus. However for this I'm not sure.
> 
> I doubt it's noticeable, but it would probably be good to simply not
> do the write for streams.
> 
> That *could* be done somewhat similarly, with just changing th address
> to be updated, or course.
> 
> In fact, we *used* to (long ago) pass in the address of "file->f_pos"
> itself to the low-level read/write routines. We then changed it to do
> that indirection through a local copy of pos (and
> file_pos_read/file_pos_write) because we didn't do the proper locking,
> so different read/write versions could mess with each other (and with
> lseek).
> 
> But one of the things that commit 9c225f2655e36 ("vfs: atomic f_pos
> accesses as per POSIX") did was to add the proper locking at least for
> the cases that we care about deeply, so we *could* say that we have
> three cases:
> 
>  - FMODE_ATOMIC_POS: properly locked,
>  - FMODE_STREAM: no pos at all
>  - otherwise a "mostly don't care - don't mix!"
> 
> and so we could go back to not copying the pos at all, and instead do
> something like
> 
>         loff_t *ppos = f.file->f_mode & FMODE_STREAM ? NULL : &file->f_pos;
>         ret = vfs_write(f.file, buf, count, ppos);
> 
> and perhaps have a long-term plan to try to get rid of the "don't mix"
> case entirely (ie "if you use f_pos, then we'll do the proper
> locking")
> 
> (The above is obviously surrounded by the fdget_pos()/fdput_pos() that
> implements the locking decision).

Ok Linus, thanks for feedback. Please consider applying or queueing the
following patches.

If the patches are ok, the first one is probably better to be applied
now - to catch wrongly converted drivers right from start, while the
second one could be probably better delayed till merge window. However
please do as what you prefer is best.

Kirill

---- 8< ----
From 328d4cc5dbb1d6fdbff1f80f1eed9f04b9a5de1c Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@nexedi.com>
Date: Fri, 12 Apr 2019 12:31:57 +0300
Subject: [PATCH 1/2] vfs: pass ppos=NULL to .read()/.write() of FMODE_STREAM files

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
 fs/open.c       |  5 ++--
 fs/read_write.c | 75 +++++++++++++++++++++++++++++--------------------
 2 files changed, 47 insertions(+), 33 deletions(-)

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
index 61b43ad7608e..d62556be6848 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -371,7 +371,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 	inode = file_inode(file);
 	if (unlikely((ssize_t) count < 0))
 		return retval;
-	pos = *ppos;
+	pos = (ppos ? *ppos : 0);
 	if (unlikely(pos < 0)) {
 		if (!unsigned_offsets(file))
 			return retval;
@@ -400,12 +400,13 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
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
 
@@ -468,12 +469,12 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
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
@@ -558,15 +559,10 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
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
@@ -575,10 +571,14 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
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
@@ -595,10 +595,14 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
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
 
@@ -673,14 +677,15 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
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
 
@@ -1013,10 +1018,14 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
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
 
@@ -1033,10 +1042,14 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
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
2.21.0.593.g511ec345e1


---- 8< ----
From ac88efdcdedb66230fcdf56e3fb244d8f5502b0b Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@nexedi.com>
Date: Fri, 12 Apr 2019 14:53:57 +0300
Subject: [PATCH 2/2] vfs: use &file->f_pos directly on files that have position

Long ago vfs read/write operations were passing ppos=&file->f_pos directly to
.read / .write file_operations methods. That changed in 2004 in 55f09ec0087c
("read/write: pass down a copy of f_pos, not f_pos itself.") which started to
pass ppos=&local_var trying to avoid simultaneous read/write/lseek stepping
onto each other toes and overwriting file->f_pos racily. That measure was not
complete and in 2014 commit 9c225f2655e36 ("vfs: atomic f_pos accesses as per
POSIX") added file->f_pos_lock to completely disable simultaneous
read/write/lseek runs. After f_pos_lock was introduced the reason to avoid
passing ppos=&file->f_pos directly due to concurrency vanished.

Linus explains[1]:

	In fact, we *used* to (long ago) pass in the address of "file->f_pos"
	itself to the low-level read/write routines. We then changed it to do
	that indirection through a local copy of pos (and
	file_pos_read/file_pos_write) because we didn't do the proper locking,
	so different read/write versions could mess with each other (and with
	lseek).

	But one of the things that commit 9c225f2655e36 ("vfs: atomic f_pos
	accesses as per POSIX") did was to add the proper locking at least for
	the cases that we care about deeply, so we *could* say that we have
	three cases:

	 - FMODE_ATOMIC_POS: properly locked,
	 - FMODE_STREAM: no pos at all
	 - otherwise a "mostly don't care - don't mix!"

	and so we could go back to not copying the pos at all, and instead do
	something like

	        loff_t *ppos = f.file->f_mode & FMODE_STREAM ? NULL : &file->f_pos;
	        ret = vfs_write(f.file, buf, count, ppos);

	and perhaps have a long-term plan to try to get rid of the "don't mix"
	case entirely (ie "if you use f_pos, then we'll do the proper
	locking")

	(The above is obviously surrounded by the fdget_pos()/fdput_pos() that
	implements the locking decision).

Currently for regular files we always set FMODE_ATOMIC_POS and change that to
FMODE_STREAM if stream_open is used explicitly on open. That leaves other
files, like e.g. sockets and pipes, for "mostly don't care - don't mix!" case.

Sockets, for example, always check that on read/write the initial pos they
receive is 0 and don't update it. And if it is !0 they return -ESPIPE.
That suggests that we can do the switch into passing &file->f_pos directly now
and incrementally convert to FMODE_STREAM files that were doing the stream-like
checking manually in their low-level .read/.write handlers.

Note: it is theoretically possible that a driver updates *ppos inside
even if read/write returns error. For such cases the conversion will
change IO semantic a bit. The semantic that is changing here was
introduced in 2013 in commit 5faf153ebf61 "don't call file_pos_write()
if vfs_{read,write}{,v}() fails".

[1] https://lore.kernel.org/linux-fsdevel/CAHk-=whJtZt52SnhBGrNMnuxFn3GE9X_e02x8BPxtkqrfyZukw@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 fs/read_write.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index d62556be6848..13550b65cb2c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -571,14 +571,7 @@ ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos, *ppos = file_ppos(f.file);
-		if (ppos) {
-			pos = *ppos;
-			ppos = &pos;
-		}
-		ret = vfs_read(f.file, buf, count, ppos);
-		if (ret >= 0 && ppos)
-			f.file->f_pos = pos;
+		ret = vfs_read(f.file, buf, count, file_ppos(f.file));
 		fdput_pos(f);
 	}
 	return ret;
@@ -595,14 +588,7 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos, *ppos = file_ppos(f.file);
-		if (ppos) {
-			pos = *ppos;
-			ppos = &pos;
-		}
-		ret = vfs_write(f.file, buf, count, ppos);
-		if (ret >= 0 && ppos)
-			f.file->f_pos = pos;
+		ret = vfs_write(f.file, buf, count, file_ppos(f.file));
 		fdput_pos(f);
 	}
 
@@ -1018,14 +1004,7 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos, *ppos = file_ppos(f.file);
-		if (ppos) {
-			pos = *ppos;
-			ppos = &pos;
-		}
-		ret = vfs_readv(f.file, vec, vlen, ppos, flags);
-		if (ret >= 0 && ppos)
-			f.file->f_pos = pos;
+		ret = vfs_readv(f.file, vec, vlen, file_ppos(f.file), flags);
 		fdput_pos(f);
 	}
 
@@ -1042,14 +1021,7 @@ static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 	ssize_t ret = -EBADF;
 
 	if (f.file) {
-		loff_t pos, *ppos = file_ppos(f.file);
-		if (ppos) {
-			pos = *ppos;
-			ppos = &pos;
-		}
-		ret = vfs_writev(f.file, vec, vlen, ppos, flags);
-		if (ret >= 0 && ppos)
-			f.file->f_pos = pos;
+		ret = vfs_writev(f.file, vec, vlen, file_ppos(f.file), flags);
 		fdput_pos(f);
 	}
 
-- 
2.21.0.593.g511ec345e1
