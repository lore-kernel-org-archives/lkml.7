Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58597C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2805820645
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="CKcJvo9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDXOOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:14:24 -0400
Received: from smtp73.ord1d.emailsrvr.com ([184.106.54.73]:41850 "EHLO
        smtp73.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfDXOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:14:24 -0400
Received: from smtp10.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp10.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 89344A01FA;
        Wed, 24 Apr 2019 10:14:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1556115262;
        bh=dEOzUVrDYVD8a9AiBp7EenF4AaDSnNVwKFYaReUz2zA=;
        h=From:To:Subject:Date:From;
        b=CKcJvo9GlqbDlwLiMJkNyv27AgYlrCrCmDvx73ZMg63KjVPNsv4SOq/d5KX0/GnAZ
         bLSjsr0ZywDRbEgd37LjQkcfiaFcWJbRHrIIcJx7Ly2wFVMi7VSa5TwG16GcYaCZRx
         kMtEZA/lhTvRSHL5qJ+xruB5pWFl1V8exSqn2IUI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C97A7A020B;
        Wed, 24 Apr 2019 10:14:21 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 24 Apr 2019 10:14:22 -0400
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH] fuse: Add ioctl flag for x32 compat ioctl
Date:   Wed, 24 Apr 2019 15:14:11 +0100
Message-Id: <20190424141411.24418-1-abbotti@mev.co.uk>
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
ABI.  In particular, the server does not know the size of the client
process's `time_t` type.

For 64-bit kernels, the `FUSE_IOCTL_COMPAT` and `FUSE_IOCTL_32BIT` flags
are currently set in the ioctl input request (`struct fuse_ioctl_in`
member `flags`) for a 32-bit requesting process.  This patch defines a
new flag `FUSE_IOCTL_COMPAT_X32` and sets it if the 32-bit requesting
process is using the x32 ABI.  This allows the server process to
distinguish between requests from requesting client processes using IA32
emulation or the x32 ABI and so infer the size of the client process's
`time_t` type and any other IA32/x32 differences.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>
---
This is based on an earlier patch titled "fuse: Add ioctl flag for
compat ioctl with 64-bit time_t" that focussed specifically on `time_t`
compatibility.  At the insistence of Miklos, I have changed it to focus
on x32 compatibility. -- Ian Abbott
---
 fs/fuse/file.c            | 7 ++++++-
 include/uapi/linux/fuse.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 06096b60f1df..44d52c54dd75 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2576,8 +2576,13 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 #if BITS_PER_LONG == 32
 	inarg.flags |= FUSE_IOCTL_32BIT;
 #else
-	if (flags & FUSE_IOCTL_COMPAT)
+	if (flags & FUSE_IOCTL_COMPAT) {
 		inarg.flags |= FUSE_IOCTL_32BIT;
+#ifdef CONFIG_X86_X32
+		if (in_x32_syscall())
+			inarg.flags |= FUSE_IOCTL_COMPAT_X32;
+#endif
+	}
 #endif
 
 	/* assume all the iovs returned by client always fits in a page */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2ac598614a8f..c8ba8230639e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -335,6 +335,7 @@ struct fuse_file_lock {
  * FUSE_IOCTL_RETRY: retry with new iovecs
  * FUSE_IOCTL_32BIT: 32bit ioctl
  * FUSE_IOCTL_DIR: is a directory
+ * FUSE_IOCTL_COMPAT_X32: x32 compat ioctl on 64bit machine (64bit time_t)
  *
  * FUSE_IOCTL_MAX_IOV: maximum of in_iovecs + out_iovecs
  */
@@ -343,6 +344,7 @@ struct fuse_file_lock {
 #define FUSE_IOCTL_RETRY	(1 << 2)
 #define FUSE_IOCTL_32BIT	(1 << 3)
 #define FUSE_IOCTL_DIR		(1 << 4)
+#define FUSE_IOCTL_COMPAT_X32	(1 << 5)
 
 #define FUSE_IOCTL_MAX_IOV	256
 
-- 
2.20.1

