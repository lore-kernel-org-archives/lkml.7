Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57406C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBE920870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="LpJmu5BI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfDAMDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:03:15 -0400
Received: from smtp65.iad3b.emailsrvr.com ([146.20.161.65]:48596 "EHLO
        smtp65.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbfDAMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:03:15 -0400
Received: from smtp1.relay.iad3b.emailsrvr.com (localhost [127.0.0.1])
        by smtp1.relay.iad3b.emailsrvr.com (SMTP Server) with ESMTP id B75AA6025F;
        Mon,  1 Apr 2019 08:03:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1554120193;
        bh=sjkonCUc+s8fYj2pZ5yzpMQO3f3I3UTX6FsK3e2nWeM=;
        h=From:To:Subject:Date:From;
        b=LpJmu5BIVMgYz9r7mwq4Ae1Th3G9M/tmcaxlSwZfhvOpyZvqp6txAJEB2h/zZ8OYO
         bNslhuntXFImwr7LZDtAAnUzSprqsuBtGrYohBne4w9WCqAD/zhLn5iwCsXvk5dOJs
         yejAjk99i1whU6vGg3f/lyhGfpOII3Jo5pRAB4so=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1191160281;
        Mon,  1 Apr 2019 08:03:12 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 01 Apr 2019 08:03:13 -0400
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [RESEND PATCH v1] fuse: Add ioctl flag for compat ioctl with 64-bit time_t
Date:   Mon,  1 Apr 2019 13:03:02 +0100
Message-Id: <20190401120302.18890-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a CUSE server running on a 64-bit kernel can tell when an
ioctl request comes from a process running a 32-bit ABI, but cannot tell
whether the requesting process is using legacy IA32 emulation or x32
ABI, for example.  In particular, the server does not know the size of
the client process's `time_t` type.

For 64-bit kernels, the `FUSE_IOCTL_COMPAT` and `FUSE_IOCTL_32BIT` flags
are currently set in the ioctl input request (`struct fuse_ioctl_in`
member `flags`) for a 32-bit requesting process.  This patch defines a
new flag `FUSE_IOCTL_COMPAT_64TIME` and sets it if the 32-bit requesting
process (running on a 64-bit kernel) uses a 64-bit `time_t` type.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
This is a resend of a patch I sent on March 1.  No changes.
https://www.spinics.net/lists/linux-fsdevel/msg140531.html

 fs/fuse/file.c            | 5 ++++-
 include/uapi/linux/fuse.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 06096b60f1df..9777e7a19889 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2576,8 +2576,11 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 #if BITS_PER_LONG == 32
 	inarg.flags |= FUSE_IOCTL_32BIT;
 #else
-	if (flags & FUSE_IOCTL_COMPAT)
+	if (flags & FUSE_IOCTL_COMPAT) {
 		inarg.flags |= FUSE_IOCTL_32BIT;
+		if (COMPAT_USE_64BIT_TIME)
+			inarg.flags |= FUSE_IOCTL_COMPAT_64TIME;
+	}
 #endif
 
 	/* assume all the iovs returned by client always fits in a page */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2ac598614a8f..1f4a71486601 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -335,6 +335,7 @@ struct fuse_file_lock {
  * FUSE_IOCTL_RETRY: retry with new iovecs
  * FUSE_IOCTL_32BIT: 32bit ioctl
  * FUSE_IOCTL_DIR: is a directory
+ * FUSE_IOCTL_COMPAT_64TIME: 32bit compat ioctl with 64bit time_t
  *
  * FUSE_IOCTL_MAX_IOV: maximum of in_iovecs + out_iovecs
  */
@@ -343,6 +344,7 @@ struct fuse_file_lock {
 #define FUSE_IOCTL_RETRY	(1 << 2)
 #define FUSE_IOCTL_32BIT	(1 << 3)
 #define FUSE_IOCTL_DIR		(1 << 4)
+#define FUSE_IOCTL_COMPAT_64TIME (1 << 5)
 
 #define FUSE_IOCTL_MAX_IOV	256
 
-- 
2.20.1

