Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25614C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7762195D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255525;
	bh=x04yC2S3tL6CMTkpcmbqbWA7QxnK8NNDoQ2CwqoQQUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QbwfVyNHQJSdThpHThcfzcVOS1qmit8W+6BWPNbSeG22FYBBWNMV1eiOtW86jTES3
	 MBvinca62oOzgXZh2N+A88ttPVwwDhQxLEqgx/WdYnk1/Qi8+DcajqGJv22blYTtYd
	 mVctnX8TY7nMwB6KntWwOoqXBcj6VWojig7mF4lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfCVLwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732154AbfCVLv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:51:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53412192B;
        Fri, 22 Mar 2019 11:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255518;
        bh=x04yC2S3tL6CMTkpcmbqbWA7QxnK8NNDoQ2CwqoQQUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGs9tyyLaS4r6YPuFTdX035m59fViJYTSslcSF6HQfS4kQ4Opro++o7O49EoxI0yU
         WlnU8l9qBwo6zle355w+/IyIM5JM4T7pgaCaicETE3B6C6LiZ+CpVY3KZmVAZx3pjq
         be7v6xyDE1tj9WfcFw2juyXG8zkzipQh1DDri/o8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 4.14 100/183] splice: dont merge into linked buffers
Date:   Fri, 22 Mar 2019 12:15:28 +0100
Message-Id: <20190322111248.929624659@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit a0ce2f0aa6ad97c3d4927bf2ca54bcebdf062d55 upstream.

Before this patch, it was possible for two pipes to affect each other after
data had been transferred between them with tee():

============
$ cat tee_test.c

int main(void) {
  int pipe_a[2];
  if (pipe(pipe_a)) err(1, "pipe");
  int pipe_b[2];
  if (pipe(pipe_b)) err(1, "pipe");
  if (write(pipe_a[1], "abcd", 4) != 4) err(1, "write");
  if (tee(pipe_a[0], pipe_b[1], 2, 0) != 2) err(1, "tee");
  if (write(pipe_b[1], "xx", 2) != 2) err(1, "write");

  char buf[5];
  if (read(pipe_a[0], buf, 4) != 4) err(1, "read");
  buf[4] = 0;
  printf("got back: '%s'\n", buf);
}
$ gcc -o tee_test tee_test.c
$ ./tee_test
got back: 'abxx'
$
============

As suggested by Al Viro, fix it by creating a separate type for
non-mergeable pipe buffers, then changing the types of buffers in
splice_pipe_to_pipe() and link_pipe().

Cc: <stable@vger.kernel.org>
Fixes: 7c77f0b3f920 ("splice: implement pipe to pipe splicing")
Fixes: 70524490ee2e ("[PATCH] splice: add support for sys_tee()")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pipe.c                 |   14 ++++++++++++++
 fs/splice.c               |    4 ++++
 include/linux/pipe_fs_i.h |    1 +
 3 files changed, 19 insertions(+)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -239,6 +239,14 @@ static const struct pipe_buf_operations
 	.get = generic_pipe_buf_get,
 };
 
+static const struct pipe_buf_operations anon_pipe_buf_nomerge_ops = {
+	.can_merge = 0,
+	.confirm = generic_pipe_buf_confirm,
+	.release = anon_pipe_buf_release,
+	.steal = anon_pipe_buf_steal,
+	.get = generic_pipe_buf_get,
+};
+
 static const struct pipe_buf_operations packet_pipe_buf_ops = {
 	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
@@ -247,6 +255,12 @@ static const struct pipe_buf_operations
 	.get = generic_pipe_buf_get,
 };
 
+void pipe_buf_mark_unmergeable(struct pipe_buffer *buf)
+{
+	if (buf->ops == &anon_pipe_buf_ops)
+		buf->ops = &anon_pipe_buf_nomerge_ops;
+}
+
 static ssize_t
 pipe_read(struct kiocb *iocb, struct iov_iter *to)
 {
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1580,6 +1580,8 @@ retry:
 			 */
 			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 
+			pipe_buf_mark_unmergeable(obuf);
+
 			obuf->len = len;
 			opipe->nrbufs++;
 			ibuf->offset += obuf->len;
@@ -1654,6 +1656,8 @@ static int link_pipe(struct pipe_inode_i
 		 */
 		obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 
+		pipe_buf_mark_unmergeable(obuf);
+
 		if (obuf->len > len)
 			obuf->len = len;
 
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -183,6 +183,7 @@ void generic_pipe_buf_get(struct pipe_in
 int generic_pipe_buf_confirm(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_steal(struct pipe_inode_info *, struct pipe_buffer *);
 void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
+void pipe_buf_mark_unmergeable(struct pipe_buffer *buf);
 
 extern const struct pipe_buf_operations nosteal_pipe_buf_ops;
 


