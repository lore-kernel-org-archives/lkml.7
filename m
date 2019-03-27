Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1562075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715036;
	bh=ELbBOpgyJxj1MQ/U5w1pooSJN7v97l9mDWii1E/3yPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vooYb+/VcqxblQ3q4VSPSXnR5181ICAb5T5p7Q7VL4tm0aMt0mZ1jtGkv1fcDhZco
	 NMM0aQ41xVxVQg8q+s8+8pV7WhH0ZWQ3A49yhETmskN7/7QJlQluUULi8d5YT8uaQR
	 IJTE7iBF35DuL50qUbg1KETbljV6vXGRdnuKKGBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbfC0Taf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732518AbfC0SDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27ACE2183E;
        Wed, 27 Mar 2019 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709809;
        bh=ELbBOpgyJxj1MQ/U5w1pooSJN7v97l9mDWii1E/3yPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKkNXdSoQrsf5vSz3ZR3zRBGAwE+ENxNb9A5V2HWUc8vJkE5WZO+Md7JEduVEj0Fs
         jWZGiKJCu/X5HmFpJhW71wpfJkcFTG1co+sIr88E1ZQT+4AFGQf0u/h/oapfag49/r
         Z+x/vuprp41/n61BAzVJyjXE7yQdqvkjT7E7M5RE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Slavomir Kaslev <kaslevs@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 051/262] fs: Make splice() and tee() take into account O_NONBLOCK flag on pipes
Date:   Wed, 27 Mar 2019 13:58:26 -0400
Message-Id: <20190327180158.10245-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Slavomir Kaslev <kaslevs@vmware.com>

[ Upstream commit ee5e001196d1345b8fee25925ff5f1d67936081e ]

The current implementation of splice() and tee() ignores O_NONBLOCK set
on pipe file descriptors and checks only the SPLICE_F_NONBLOCK flag for
blocking on pipe arguments.  This is inconsistent since splice()-ing
from/to non-pipe file descriptors does take O_NONBLOCK into
consideration.

Fix this by promoting O_NONBLOCK, when set on a pipe, to
SPLICE_F_NONBLOCK.

Some context for how the current implementation of splice() leads to
inconsistent behavior.  In the ongoing work[1] to add VM tracing
capability to trace-cmd we stream tracing data over named FIFOs or
vsockets from guests back to the host.

When we receive SIGINT from user to stop tracing, we set O_NONBLOCK on
the input file descriptor and set SPLICE_F_NONBLOCK for the next call to
splice().  If splice() was blocked waiting on data from the input FIFO,
after SIGINT splice() restarts with the same arguments (no
SPLICE_F_NONBLOCK) and blocks again instead of returning -EAGAIN when no
data is available.

This differs from the splice() behavior when reading from a vsocket or
when we're doing a traditional read()/write() loop (trace-cmd's
--nosplice argument).

With this patch applied we get the same behavior in all situations after
setting O_NONBLOCK which also matches the behavior of doing a
read()/write() loop instead of splice().

This change does have potential of breaking users who don't expect
EAGAIN from splice() when SPLICE_F_NONBLOCK is not set.  OTOH programs
that set O_NONBLOCK and don't anticipate EAGAIN are arguably buggy[2].

 [1] https://github.com/skaslev/trace-cmd/tree/vsock
 [2] https://github.com/torvalds/linux/blob/d47e3da1759230e394096fd742aad423c291ba48/fs/read_write.c#L1425

Signed-off-by: Slavomir Kaslev <kaslevs@vmware.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 90c29675d573..f568273ac336 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1123,6 +1123,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 		if (ipipe == opipe)
 			return -EINVAL;
 
+		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
 	}
 
@@ -1148,6 +1151,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 		if (unlikely(ret < 0))
 			return ret;
 
+		if (in->f_flags & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		file_start_write(out);
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
@@ -1172,6 +1178,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 			offset = in->f_pos;
 		}
 
+		if (out->f_flags & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		pipe_lock(opipe);
 		ret = wait_for_space(opipe, flags);
 		if (!ret)
@@ -1721,6 +1730,9 @@ static long do_tee(struct file *in, struct file *out, size_t len,
 	 * copying the data.
 	 */
 	if (ipipe && opipe && ipipe != opipe) {
+		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		/*
 		 * Keep going, unless we encounter an error. The ipipe/opipe
 		 * ordering doesn't really matter.
-- 
2.19.1

