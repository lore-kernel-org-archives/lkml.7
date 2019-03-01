Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFB9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB3420850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="GNmXw9cJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfCARQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:16:47 -0500
Received: from smtp121.ord1c.emailsrvr.com ([108.166.43.121]:42002 "EHLO
        smtp121.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728347AbfCARQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:16:47 -0500
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Mar 2019 12:16:46 EST
Received: from smtp8.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp8.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id B9D91A012F;
        Fri,  1 Mar 2019 12:08:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1551460135;
        bh=Xu7Uxi0xQRaSsOKwI0OjPi904kiPaYkiHRyP0omueQk=;
        h=From:To:Subject:Date:From;
        b=GNmXw9cJxFHaJZWasReSP4nbJAhxVtYT3sacyyPi1GMwivbL9gjPDTiddXbKIxCnd
         tBxha4mzpaH5cDXd54UpKxa7mUTNbdPPI0KCJh8/GKkGm5ZVEHtVw4GbukXnyk1c29
         X8sRqqSj0mDx9gnzsZSwctOsc1wEZnka6QQHvJ18=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EE22FA02E4;
        Fri,  1 Mar 2019 12:08:54 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 01 Mar 2019 12:08:55 -0500
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH] fuse: Add ioctl flag for compat ioctl with 64-bit time_t
Date:   Fri,  1 Mar 2019 17:08:31 +0000
Message-Id: <20190301170831.23612-1-abbotti@mev.co.uk>
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

