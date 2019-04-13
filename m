Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF37C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 18:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FB921721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 18:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="IrC6pqeg";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="MtYn6MW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfDMS7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 14:59:12 -0400
Received: from mail18.wdc04.mandrillapp.com ([205.201.139.18]:33426 "EHLO
        mail18.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbfDMS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 14:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=1p6hKVya4YXSRknFY1W1+4p10L8vUuogM1OMZJRdf0s=;
 b=IrC6pqeg4pC+G4ho/iOjl7ArcpOy3bsYSoTnzeODwOfAs2LY1/sw1FKoLMmhpbZNJrVFqhL+bWjF
   pRbZey1LdihSHQjrWu1IfFykp7Brqnr7mavxZ+XWqxnlFEIx2YfHqE9jQekYyxM3nKuNmpUb4XLY
   AFDLK6tZpqUYy1OZxO4=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail18.wdc04.mandrillapp.com id hm8onq1jvmgh for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 18:44:07 +0000 (envelope-from <bounce-md_31050260.5cb22df7.v1-d4db30cad2c3441f9662de6bae318ded@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555181047; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=1p6hKVya4YXSRknFY1W1+4p10L8vUuogM1OMZJRdf0s=; 
 b=MtYn6MW9fIqnG9+dEIUITKvaDA8ksx6fhkwOkOlpBt2l3JBzoaS27IGqRUV2xbHzc/Jk5V
 QFMvPUp2POd4S0MHdPInlj/W4hCiPh6Bx5V2Zy0+TVf2+sJElrefMvQgpIRHr9gIi5qX9+lo
 yEk875mnp35j+L3H17pLvrqZOJzic=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 1/2] vfs: pass ppos=NULL to .read()/.write() of FMODE_STREAM files
Received: from [87.98.221.171] by mandrillapp.com id d4db30cad2c3441f9662de6bae318ded; Sat, 13 Apr 2019 18:44:07 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-Id: <20190413184404.GA13490@deco.navytux.spb.ru>
References: <20190413165116.GB10314@deco.navytux.spb.ru> <20190413165449.11168-1-kirr@nexedi.com> <CAHk-=wg6Pn4M+7awA5WrHv2vVc5iLRL29ueG-NSwOCAyVT-OYQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg6Pn4M+7awA5WrHv2vVc5iLRL29ueG-NSwOCAyVT-OYQ@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.d4db30cad2c3441f9662de6bae318ded
X-Mandrill-User: md_31050260
Date:   Sat, 13 Apr 2019 18:44:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 10:27:00AM -0700, Linus Torvalds wrote:
> On Sat, Apr 13, 2019 at 9:55 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -371,7 +371,7 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
> >         inode = file_inode(file);
> >         if (unlikely((ssize_t) count < 0))
> >                 return retval;
> > -       pos = *ppos;
> > +       pos = (ppos ? *ppos : 0);
> >         if (unlikely(pos < 0)) {
> >                 if (!unsigned_offsets(file))
> >                         return retval;
> 
> This part looks silly. We should just avoid all the position overflow
> games when we don't have a position at all (ie streaming). You can't
> overflow what you don't use.
> 
> Similarly, you can't use ranged mandatory locking on a stream, so the
> mandatory locking thing seems dependent on pos too.
> 
> So I think that with a NULL ppos being possible, we should just change
> the code to just do all of that conditionally on having a position,
> rather than saying that the position of a stream is always 0.

Linus, thanks for feedback. After checking a bit of history of
rw_verify_area and seeing what it does I agree with you. I was initially
confused because rw_verify_area calls security_file_permission() at its
tail and so I thought we cannot skip rw_verify_area for !ppos case.
After studying a bit I see now that there are several things going on
and indeed moving ranged locks checking into under `if ppos!=NULL` makes
sense. This code is new to me; apologize for not getting it right
initially.

> That said, this whole "let's make it possible to not have a position
> at all" is a big change, and there's no way I'll apply these before
> the 5.2 merge window.

Ok.

> And I'd really like to have people (Al?) look at this and go "yeah,
> makes sense". I do think that moving to a model where we wither have a
> (properly locked) file position or no pos pointer at all is the right
> model (ie I'd really like to get rid of the mixed case), but there
> might be some practical problem that makes it impractical.
> 
> Because the *real* problem with the mixed case is not "insane people
> who do bad things might get odd results". No, the real problem with
> the mixed case is that it could be a security issue (ie: one process
> intentionally changes the file position just as another process is
> going a 'read' and then avoids some limit test because the limit test
> was done using the old 'pos' value but the actual IO was done using
> the new one).
> 
> So I suspect that we will have to either
> 
>  - get rid of the mixed case entirely (and do only properly locked
> f_pos accesses or pass is a NULL f_pos)
> 
>  - continue to support the mixed case, but also continue to support
> the nasty temporary 'pos' value with that file_pos_{read,write}()
> thing.
> 
> IOW, I would not be ok with passing in a shared - and unlocked -
> &file->f_pos value to random drivers that *might* do odd things when a
> race happens.

I see. That's why I splitted the whole change into 2: the first patch
only adds ppos=NULL semantic for FMODE_STREAM and does not change to
passing &file->f_pos directly. There are signs that people can be
starting to use stream_open even now - before we do mass conversion.
That's why it is better to fix ppos semantic for stream case early.
You said it won't happen before next merge window - ok, but ppos=NULL
change is separate and does not depend on passing &file->f_pos directly.
So let's please apply ppos=NULL patch early when merge window begins and
independently of what happens with whether we'll switch to direct usage
of &file->f_pos.

Looking forward to get review from others too.

And I appreciate if people could help at least somehow with "getting rid
of mixed case entirely" (i.e. always lock f_pos_lock on !FMODE_STREAM),
because this transition starts to diverge from my particular use-case
too far. To me it makes sense to do that transition as follows:

- convert nonseekable_open -> stream_open via stream_open.cocci;
- audit other nonseekable_open calls and convert left users that truly
  don't depend on position to stream_open;
- extend stream_open.cocci to analyze alloc_file_pseudo as well (this
  will cover pipes and sockets), or maybe convert pipes and sockets to
  FMODE_STREAM manually;
- extend stream_open.cocci to analyze file_operations that use no_llseek
  or noop_llseek, but do not use nonseekable_open or alloc_file_pseudo.
  This might find files that have stream semantic but are opened
  differently;
- extend stream_open.cocci to analyze file_operations whose .read/.write
  do not use ppos at all (independently of how file was opened);
- ...
- after that remove FMODE_ATOMIC_POS and always take f_pos_lock if
  !FMODE_STREAM;
- gather bug reports for deadlocked read/write and convert missed cases
  to FMODE_STREAM, probably extending stream_open.cocci along the road
  to catch similar cases.

i.e. always take f_pos_lock unless a file is explicitly marked as being
stream, and try to find and cover all files that are streams.

Updated patch for ppos=NULL for stream case with rw_verify_area change
fixed is below.

Kirill

---- 8<----
From 3df9bc6c8ec58baec37bf413e2c0cef07308988f Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@nexedi.com>
Date: Fri, 12 Apr 2019 12:31:57 +0300
Subject: [PATCH v2 1/2] vfs: pass ppos=NULL to .read()/.write() of FMODE_STREAM files

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

v2: fixed ppos handling in rw_verify_area per Linus comment.

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
2.21.0.593.g511ec345e1
