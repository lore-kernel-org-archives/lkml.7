Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0156C208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="KIIxiTpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbfJ1JxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:53:04 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:57530 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728915AbfJ1JxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:53:04 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 67A722E1430;
        Mon, 28 Oct 2019 12:53:00 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 7uyn4H3XtT-r0BGrrK5;
        Mon, 28 Oct 2019 12:53:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572256380; bh=xqm1jSofN29SdWEre48fi8W13SuV+/iA71X565d9MD8=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=KIIxiTpuwCzyjAr46XiPLPDpgf4IO/lzLTUd0XYu2AGAm2Vc7JX8hB6zbITv+4rvD
         CTJNLol+3A+jvYHx4eJN0cA+njdzn0tXhkBJ7if4OsmCrNYq9psmlCg+05VDml+JO/
         6SIL4RfsnA9B9FOgCVSu33EltimrP/FpwHOnGNwk=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by vla1-5826f599457c.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id C5lPuitJie-qxWCl6oM;
        Mon, 28 Oct 2019 12:52:59 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] pipe: add fcntl for changing free space desired for write
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     David Howells <dhowells@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 28 Oct 2019 12:52:59 +0300
Message-ID: <157225637948.2332.2715544570854147191.stgit@buzz>
In-Reply-To: <5b970999-c714-6bfb-0b02-ed206bafced4@yandex-team.ru>
References: <5b970999-c714-6bfb-0b02-ed206bafced4@yandex-team.ru>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writer produces data faster than reader consumes it is would be more
optimal to wake up writer when buffer have enough room for following data.
Right now pipe wakeup writer when there is just one free page.

Unfortunately we cannot change default behavior without risk of breaking
things. This patch makes threshold tunable via fcntl.

fcntl(fd, F_SETPIPE_WRITE_SZ, size);
size = fcntl(fd, F_GETPIPE_WRITE_SZ);

Size is rounded up to page size like F_SETPIPE_SZ. Default is one page.

perf stat bash -c 'seq 50000000 | wc' shows decreasing count of context
switches from 26k to 13k when default is set to half of buffer size.
Execution time stays the same.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/CAHk-=wjoTncMYdQFmY4yspKOUsDSNn1dHp1FWvJ0eRO94ZM3dQ@mail.gmail.com/

---

#define _GNU_SOURCE
#include <unistd.h>
#include <fcntl.h>

#define F_SETPIPE_WRITE_SZ	(1024 + 15)

int main(int argc, char **argv)
{
	int fd[2];

	pipe2(fd, O_CLOEXEC);
	fcntl(fd[0], F_SETPIPE_SZ, 64 << 10);
	fcntl(fd[0], F_SETPIPE_WRITE_SZ, 32 << 10);

	if (!fork()) {
		dup2(fd[1], 1);
		execlp("seq", "seq", "50000000", NULL);
	} else {
		dup2(fd[0], 0);
		execlp("wc", "wc", NULL);
	}
}
---
 fs/fcntl.c                 |    2 ++
 fs/pipe.c                  |   28 +++++++++++++++++++++++++---
 include/linux/pipe_fs_i.h  |    2 ++
 include/uapi/linux/fcntl.h |    6 ++++++
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3d40771e8e7c..6dc6784a718c 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -414,6 +414,8 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_SETPIPE_SZ:
 	case F_GETPIPE_SZ:
+	case F_SETPIPE_WRITE_SZ:
+	case F_GETPIPE_WRITE_SZ:
 		err = pipe_fcntl(filp, cmd, arg);
 		break;
 	case F_ADD_SEALS:
diff --git a/fs/pipe.c b/fs/pipe.c
index 8a2ab2f974bd..17c56ee0b86a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -324,7 +324,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				curbuf = (curbuf + 1) & (pipe->buffers - 1);
 				pipe->curbuf = curbuf;
 				pipe->nrbufs = --bufs;
-				do_wakeup = 1;
+				do_wakeup = pipe->buffers-bufs >= pipe->wrbufs;
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -555,7 +555,8 @@ pipe_poll(struct file *filp, poll_table *wait)
 	}
 
 	if (filp->f_mode & FMODE_WRITE) {
-		mask |= (nrbufs < pipe->buffers) ? EPOLLOUT | EPOLLWRNORM : 0;
+		if (pipe->buffers - nrbufs >= pipe->wrbufs)
+			mask |= EPOLLOUT | EPOLLWRNORM;
 		/*
 		 * Most Unices do not set EPOLLERR for FIFOs but on Linux they
 		 * behave exactly like pipes for poll().
@@ -680,6 +681,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 		init_waitqueue_head(&pipe->wait);
 		pipe->r_counter = pipe->w_counter = 1;
 		pipe->buffers = pipe_bufs;
+		pipe->wrbufs = 1;
 		pipe->user = user;
 		mutex_init(&pipe->mutex);
 		return pipe;
@@ -1090,8 +1092,10 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	 * expect a lot of shrink+grow operations, just free and allocate
 	 * again like we would do for growing. If the pipe currently
 	 * contains more buffers than arg, then return busy.
+	 *
+	 * Do not let shrink pipe buffer lower than write size.
 	 */
-	if (nr_pages < pipe->nrbufs) {
+	if (nr_pages < pipe->nrbufs || nr_pages < pipe->wrbufs) {
 		ret = -EBUSY;
 		goto out_revert_acct;
 	}
@@ -1135,6 +1139,18 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	return ret;
 }
 
+static long pipe_set_write_size(struct pipe_inode_info *pipe, unsigned long arg)
+{
+	unsigned int nr_pages;
+
+	nr_pages = (arg + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (!nr_pages || nr_pages > pipe->buffers)
+		return -EINVAL;
+
+	pipe->wrbufs = nr_pages;
+	return nr_pages * PAGE_SIZE;
+}
+
 /*
  * After the inode slimming patch, i_pipe/i_bdev/i_cdev share the same
  * location, so checking ->i_pipe is not enough to verify that this is a
@@ -1163,6 +1179,12 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F_GETPIPE_SZ:
 		ret = pipe->buffers * PAGE_SIZE;
 		break;
+	case F_SETPIPE_WRITE_SZ:
+		ret = pipe_set_write_size(pipe, arg);
+		break;
+	case F_GETPIPE_WRITE_SZ:
+		ret = pipe->wrbufs * PAGE_SIZE;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 5c626fdc10db..b4236805d167 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -33,6 +33,7 @@ struct pipe_buffer {
  *	@nrbufs: the number of non-empty pipe buffers in this pipe
  *	@buffers: total number of buffers (should be a power of 2)
  *	@curbuf: the current pipe buffer entry
+ *	@wrbufs: count of buffers desired for write
  *	@tmp_page: cached released page
  *	@readers: number of current readers of this pipe
  *	@writers: number of current writers of this pipe
@@ -49,6 +50,7 @@ struct pipe_inode_info {
 	struct mutex mutex;
 	wait_queue_head_t wait;
 	unsigned int nrbufs, curbuf, buffers;
+	unsigned int wrbufs;
 	unsigned int readers;
 	unsigned int writers;
 	unsigned int files;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1d338357df8a..3fb043079d4a 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -28,6 +28,12 @@
 #define F_SETPIPE_SZ	(F_LINUX_SPECIFIC_BASE + 7)
 #define F_GETPIPE_SZ	(F_LINUX_SPECIFIC_BASE + 8)
 
+/*
+ * Set and get of pipe space desired for each write
+ */
+#define F_SETPIPE_WRITE_SZ	(F_LINUX_SPECIFIC_BASE + 15)
+#define F_GETPIPE_WRITE_SZ	(F_LINUX_SPECIFIC_BASE + 16)
+
 /*
  * Set/Get seals
  */

