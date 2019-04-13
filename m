Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BFBC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72C2218AF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="TVhCOSRw";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="QlXpwt0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfDMRYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:24:54 -0400
Received: from mail18.wdc04.mandrillapp.com ([205.201.139.18]:4245 "EHLO
        mail18.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727580AbfDMRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:24:47 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Apr 2019 13:24:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=Iy97WLVPISZgdG4TAVxl763cg4XknvpGREfNQtadPV4=;
 b=TVhCOSRwneVimp97Pej9qPoBIQqhptdfm+dTCcV1qLB58BGxJfqHxz81bT5JTonnQxgw6r6a2UiJ
   35tYRfQskYw5V2GACFKpehp0n/OHsWeOVXh1+8/jPct8lzv7pZMxE0kpaQSA48xZt4akGHZAkcRo
   XRFmQfd7OGTSc4+B2hc=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail18.wdc04.mandrillapp.com id hm8dls1jvmg0 for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 16:55:07 +0000 (envelope-from <bounce-md_31050260.5cb2146a.v1-557b8269f7f5460db189b1c1bf4c70c6@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555174507; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=Iy97WLVPISZgdG4TAVxl763cg4XknvpGREfNQtadPV4=; 
 b=QlXpwt0OKYFYCYb739bXZUHZiFe5L1uls0wr57fsnrG2g33YjFG4bEhILw0urBBIU4TdhO
 BkOdBJf8Ajx+HlT9ytqOX0XdgHmJ340YpLTlB/jQzPMy/bm7NdKzYqlJHMh5eQ+SKeb3ZG7E
 ErSFmO9ZOwUeRRrONAnM3E9UD5Ffk=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 2/2] vfs: use &file->f_pos directly on files that have position
Received: from [87.98.221.171] by mandrillapp.com id 557b8269f7f5460db189b1c1bf4c70c6; Sat, 13 Apr 2019 16:55:07 +0000
X-Mailer: git-send-email 2.21.0.593.g511ec345e1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <20190413165449.11168-2-kirr@nexedi.com>
In-Reply-To: <20190413165116.GB10314@deco.navytux.spb.ru>
References: <20190413165449.11168-1-kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.557b8269f7f5460db189b1c1bf4c70c6
X-Mandrill-User: md_31050260
Date:   Sat, 13 Apr 2019 16:55:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
