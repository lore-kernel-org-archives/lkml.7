Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C84AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DE520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139646;
	bh=TRmJQ4/w52evmZ4RYA3Er14h2KNlNphZEgWVKF5qhVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CANevS0FYkBAqGnHbj3YDl5r8pb1TkE0311DDTObwHwsMGNEQikJcDMb+vhibwJQw
	 F7R+E+bsi8utGY9McqFXkQ4FET+QQAhORDD8RGVZc8Q//ROLgotn5K6F5MPHLKtYVn
	 OBVGGaiI6J0th6KFuL065zuRrZjCqgG6SlnXqIQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbfDAR1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732648AbfDAR1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:27:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D052063F;
        Mon,  1 Apr 2019 17:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139640;
        bh=TRmJQ4/w52evmZ4RYA3Er14h2KNlNphZEgWVKF5qhVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gc+G+KH0/jPrRusw6YYzT7pDzyIMqash4W+kMvBh7NBoXXXYRJX+ACsNbiHmEdU4M
         9qOfKZmSNqgOnQdm3Zs0PUxFuVNChxSENSRdrpcmzRkku5sYG84zeWy9cfwah+GAvz
         G08q4eLDrLuq+eC2qCZgGdGaKQXxgluHX9+kNL7M=
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
Subject: [PATCH 4.9 27/56] fs/open.c: allow opening only regular files during execve()
Date:   Mon,  1 Apr 2019 19:02:43 +0200
Message-Id: <20190401170105.431671897@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -717,6 +717,12 @@ static int do_dentry_open(struct file *f
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


