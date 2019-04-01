Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE17221939
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138457;
	bh=YeGH6/ggDBZTZdcOgrOWKQD2/Qn4BlJzITvEis6V3qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ETD3+CPg4s4Z2cX0wuIJwTusMvBsWzBN2VL0UC7zLkmAe7s7mpDUsUVIadUi2WYPR
	 /UeehN0m5RCd6mIzMRcvoyuZ+/NPmWAVdQSgp11V7YPYqV86OLQnUi9pw8JPm2REXN
	 Wr8aFvG1S1mTxN1yNZV4F8ElPUMDs2NYseF3x9R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfDARHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbfDARHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:07:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EFCD21925;
        Mon,  1 Apr 2019 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138452;
        bh=YeGH6/ggDBZTZdcOgrOWKQD2/Qn4BlJzITvEis6V3qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFNNblbyS1dTM/reg8i+3OoyL5E5z3RukQgVNTXBiLNcCVQ8TO2wkdVFxsHHLLH4L
         TMjY2uUBRVRTRv6rRaxkts8A9FYA4I9FJ+luA8yjHmd07XUwMKq8jatfdvLjP/GHKJ
         AEjHDSjAdwavgOTsTlZx05OMVtje3YLgcyDPum1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot 
        <syzbot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 070/146] fs/open.c: allow opening only regular files during execve()
Date:   Mon,  1 Apr 2019 19:01:22 +0200
Message-Id: <20190401170054.616261081@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 73601ea5b7b18eb234219ae2adf77530f389da79 upstream.

syzbot is hitting lockdep warning [1] due to trying to open a fifo
during an execve() operation.  But we don't need to open non regular
files during an execve() operation, for all files which we will need are
the executable file itself and the interpreter programs like /bin/sh and
ld-linux.so.2 .

Since the manpage for execve(2) says that execve() returns EACCES when
the file or a script interpreter is not a regular file, and the manpage
for uselib(2) says that uselib() can return EACCES, and we use
FMODE_EXEC when opening for execve()/uselib(), we can bail out if a non
regular file is requested with FMODE_EXEC set.

Since this deadlock followed by khungtaskd warnings is trivially
reproducible by a local unprivileged user, and syzbot's frequent crash
due to this deadlock defers finding other bugs, let's workaround this
deadlock until we get a chance to find a better solution.

[1] https://syzkaller.appspot.com/bug?id=b5095bfec44ec84213bac54742a82483aad578ce

Link: http://lkml.kernel.org/r/1552044017-7890-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Reported-by: syzbot <syzbot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>
Fixes: 8924feff66f35fe2 ("splice: lift pipe_lock out of splice_to_pipe()")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Biggers <ebiggers3@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>	[4.9+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/open.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/open.c
+++ b/fs/open.c
@@ -733,6 +733,12 @@ static int do_dentry_open(struct file *f
 		return 0;
 	}
 
+	/* Any file opened for execve()/uselib() has to be a regular file. */
+	if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) {
+		error = -EACCES;
+		goto cleanup_file;
+	}
+
 	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))


