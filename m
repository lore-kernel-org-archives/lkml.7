Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FEEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768942075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370945;
	bh=uRQM1qfRhkfP2ZO8dRRQBkHRrlYp2Dj7fn3vU/E2ITM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/JQP2yBGW93Zlfp0KFsdgA+UZW+blKPDGGXzbGKWkI9L3NGe8lunx6KzBJ683icu
	 Wayqhjon94fsO3F0LRyAndV8SxQo+tratFBnrRAdiSEbD7QttOBhAn06LJxO9S8a/m
	 psQ4ZeLDnDcIA1KJ939AxSvfXXL2AEs3D9GpsiTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfDDJBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731424AbfDDJB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:01:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8CA21741;
        Thu,  4 Apr 2019 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368485;
        bh=uRQM1qfRhkfP2ZO8dRRQBkHRrlYp2Dj7fn3vU/E2ITM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DslScXed+xQukV9rQVEexBIGc6WcZoEMDMJNs6GZjbbRHh+JrKMogyar7PA5U8Pn+
         KVgVeHGcGRGqEfXhqXF8Rz3yNDlWq7+vfWzt20cvrFHSVGnnHX+/J7kjCeUI4b8T+u
         FaGFBuSOxFihNJh+3l7Uw/jZvNwwGoD7faPH+SJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Slavomir Kaslev <kaslevs@vmware.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 041/187] fs: Make splice() and tee() take into account O_NONBLOCK flag on pipes
Date:   Thu,  4 Apr 2019 10:46:18 +0200
Message-Id: <20190404084605.015765515@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 29e92b506394..7769181aa1a6 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1119,6 +1119,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 		if (ipipe == opipe)
 			return -EINVAL;
 
+		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
 	}
 
@@ -1144,6 +1147,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 		if (unlikely(ret < 0))
 			return ret;
 
+		if (in->f_flags & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		file_start_write(out);
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
@@ -1168,6 +1174,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
 			offset = in->f_pos;
 		}
 
+		if (out->f_flags & O_NONBLOCK)
+			flags |= SPLICE_F_NONBLOCK;
+
 		pipe_lock(opipe);
 		ret = wait_for_space(opipe, flags);
 		if (!ret)
@@ -1717,6 +1726,9 @@ static long do_tee(struct file *in, struct file *out, size_t len,
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



