Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A9C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209DB2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329255;
	bh=vBEqo01wcaRuNShuqD75v8O9XcN47tncKxVYJjYrAIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u/XGqZRKVEKSeFt6I8W2uH9rfBsyG6ayNSTnUhRxL6dFVmFGi1KtMf1PkeFbmPQ6S
	 ASpbmjM0TOcH0HF0hE2pgs03q+6I+who4p5twbH5MhvvXT5W4l8dF5qqxYDmXF1tpy
	 vxrAGr2H/9XkxAOnAaFc/j7TVd7EEOQZaAXQqLvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfD0Bkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfD0Bku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FE420873;
        Sat, 27 Apr 2019 01:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329249;
        bh=vBEqo01wcaRuNShuqD75v8O9XcN47tncKxVYJjYrAIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjbu2/YUls/mxx3PyQp5WofNhY8djFpyj5TyNq3/cPnS0s0wFTQ5/l31R9BvdVnwh
         kah7A18wyZHz/b8ifjkIjXvNICsMmJhA9gXuhaWsNslkawMGKnUF8Z4+XLvOY9f2XX
         I3V2qTIP56shWxt9A0zR5SE4BiU0UxsJu4rgXEOA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 79/79] fs: prevent page refcount overflow in pipe_buf_get
Date:   Fri, 26 Apr 2019 21:38:38 -0400
Message-Id: <20190427013838.6596-79-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <willy@infradead.org>

[ Upstream commit 15fab63e1e57be9fdb5eec1bbc5916e9825e9acb ]

Change pipe_buf_get() to return a bool indicating whether it succeeded
in raising the refcount of the page (if the thing in the pipe is a page).
This removes another mechanism for overflowing the page refcount.  All
callers converted to handle a failure.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c             | 12 ++++++------
 fs/pipe.c                 |  4 ++--
 fs/splice.c               | 12 ++++++++++--
 include/linux/pipe_fs_i.h | 10 ++++++----
 kernel/trace/trace.c      |  6 +++++-
 5 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 809c0f2f9942..64f4de983468 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2034,10 +2034,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 		rem += pipe->bufs[(pipe->curbuf + idx) & (pipe->buffers - 1)].len;
 
 	ret = -EINVAL;
-	if (rem < len) {
-		pipe_unlock(pipe);
-		goto out;
-	}
+	if (rem < len)
+		goto out_free;
 
 	rem = len;
 	while (rem) {
@@ -2055,7 +2053,9 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 			pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
 			pipe->nrbufs--;
 		} else {
-			pipe_buf_get(pipe, ibuf);
+			if (!pipe_buf_get(pipe, ibuf))
+				goto out_free;
+
 			*obuf = *ibuf;
 			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 			obuf->len = rem;
@@ -2078,11 +2078,11 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	ret = fuse_dev_do_write(fud, &cs, len);
 
 	pipe_lock(pipe);
+out_free:
 	for (idx = 0; idx < nbuf; idx++)
 		pipe_buf_release(pipe, &bufs[idx]);
 	pipe_unlock(pipe);
 
-out:
 	kvfree(bufs);
 	return ret;
 }
diff --git a/fs/pipe.c b/fs/pipe.c
index c51750ed4011..2a297bce381f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -189,9 +189,9 @@ EXPORT_SYMBOL(generic_pipe_buf_steal);
  *	in the tee() system call, when we duplicate the buffers in one
  *	pipe into another.
  */
-void generic_pipe_buf_get(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
+bool generic_pipe_buf_get(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 {
-	get_page(buf->page);
+	return try_get_page(buf->page);
 }
 EXPORT_SYMBOL(generic_pipe_buf_get);
 
diff --git a/fs/splice.c b/fs/splice.c
index 90c29675d573..386a5cc74f1e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1588,7 +1588,11 @@ retry:
 			 * Get a reference to this pipe buffer,
 			 * so we can copy the contents over.
 			 */
-			pipe_buf_get(ipipe, ibuf);
+			if (!pipe_buf_get(ipipe, ibuf)) {
+				if (ret == 0)
+					ret = -EFAULT;
+				break;
+			}
 			*obuf = *ibuf;
 
 			/*
@@ -1662,7 +1666,11 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 		 * Get a reference to this pipe buffer,
 		 * so we can copy the contents over.
 		 */
-		pipe_buf_get(ipipe, ibuf);
+		if (!pipe_buf_get(ipipe, ibuf)) {
+			if (ret == 0)
+				ret = -EFAULT;
+			break;
+		}
 
 		obuf = opipe->bufs + nbuf;
 		*obuf = *ibuf;
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 3ecd7ea212ae..bbee2caf5837 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -108,18 +108,20 @@ struct pipe_buf_operations {
 	/*
 	 * Get a reference to the pipe buffer.
 	 */
-	void (*get)(struct pipe_inode_info *, struct pipe_buffer *);
+	bool (*get)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
 /**
  * pipe_buf_get - get a reference to a pipe_buffer
  * @pipe:	the pipe that the buffer belongs to
  * @buf:	the buffer to get a reference to
+ *
+ * Return: %true if the reference was successfully obtained.
  */
-static inline void pipe_buf_get(struct pipe_inode_info *pipe,
+static inline __must_check bool pipe_buf_get(struct pipe_inode_info *pipe,
 				struct pipe_buffer *buf)
 {
-	buf->ops->get(pipe, buf);
+	return buf->ops->get(pipe, buf);
 }
 
 /**
@@ -178,7 +180,7 @@ struct pipe_inode_info *alloc_pipe_info(void);
 void free_pipe_info(struct pipe_inode_info *);
 
 /* Generic pipe buffer ops functions */
-void generic_pipe_buf_get(struct pipe_inode_info *, struct pipe_buffer *);
+bool generic_pipe_buf_get(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_confirm(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_steal(struct pipe_inode_info *, struct pipe_buffer *);
 void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 89158aa93fa6..de77420f83f8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6836,12 +6836,16 @@ static void buffer_pipe_buf_release(struct pipe_inode_info *pipe,
 	buf->private = 0;
 }
 
-static void buffer_pipe_buf_get(struct pipe_inode_info *pipe,
+static bool buffer_pipe_buf_get(struct pipe_inode_info *pipe,
 				struct pipe_buffer *buf)
 {
 	struct buffer_ref *ref = (struct buffer_ref *)buf->private;
 
+	if (ref->ref > INT_MAX/2)
+		return false;
+
 	ref->ref++;
+	return true;
 }
 
 /* Pipe buffer operations for a buffer. */
-- 
2.19.1

