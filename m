Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841A6C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF42216F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921708;
	bh=3rZd8WAF0bdHLPMC9H3Bv1cYv1WRtPTVMC3DphGZp8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k3StQOjm2gXEi0zCOS1u2hc9nygRe3ji4j7T/2CvtxTok8HWw7z9VpAB1JArfVO7n
	 gVRnEDaIhTa9eIDHvRRNwrIBkgKOQkp0q4YCN9xDswQmTd60qha/DRxZLD/uJwUStJ
	 VB4BKbm+tNLp9LvL8UTwUfrz7tNLTJbh+qgPO5yI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfKPQ20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfKPPlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:41:19 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C7372075B;
        Sat, 16 Nov 2019 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918878;
        bh=3rZd8WAF0bdHLPMC9H3Bv1cYv1WRtPTVMC3DphGZp8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZUU022/PcOd2DEu/kYBsk8LMN4SgAhUDqObdwW/eN6jVwn5NM65XLvuh4X96Zpmm
         zCQsRNISC/q+y+VeseoyZCo7sWujcYQX+nYQ8oj45jjDqLy88dui9AfIGVHEhucDw6
         XyDH7sI4WiYtZPofK1SCioOdq2mV5OZOt2R3Szt0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 008/237] pty: fix compat ioctls
Date:   Sat, 16 Nov 2019 10:37:23 -0500
Message-Id: <20191116154113.7417-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 50f45326afab723df529eca54095e2feac24da2d ]

pointer-taking ones need compat_ptr(); int-taking one doesn't.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/pty.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 678406e0948b2..00099a8439d21 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -28,6 +28,7 @@
 #include <linux/mount.h>
 #include <linux/file.h>
 #include <linux/ioctl.h>
+#include <linux/compat.h>
 
 #undef TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
@@ -488,6 +489,7 @@ static int pty_bsd_ioctl(struct tty_struct *tty,
 	return -ENOIOCTLCMD;
 }
 
+#ifdef CONFIG_COMPAT
 static long pty_bsd_compat_ioctl(struct tty_struct *tty,
 				 unsigned int cmd, unsigned long arg)
 {
@@ -495,8 +497,11 @@ static long pty_bsd_compat_ioctl(struct tty_struct *tty,
 	 * PTY ioctls don't require any special translation between 32-bit and
 	 * 64-bit userspace, they are already compatible.
 	 */
-	return pty_bsd_ioctl(tty, cmd, arg);
+	return pty_bsd_ioctl(tty, cmd, (unsigned long)compat_ptr(arg));
 }
+#else
+#define pty_bsd_compat_ioctl NULL
+#endif
 
 static int legacy_count = CONFIG_LEGACY_PTY_COUNT;
 /*
@@ -676,6 +681,7 @@ static int pty_unix98_ioctl(struct tty_struct *tty,
 	return -ENOIOCTLCMD;
 }
 
+#ifdef CONFIG_COMPAT
 static long pty_unix98_compat_ioctl(struct tty_struct *tty,
 				 unsigned int cmd, unsigned long arg)
 {
@@ -683,8 +689,12 @@ static long pty_unix98_compat_ioctl(struct tty_struct *tty,
 	 * PTY ioctls don't require any special translation between 32-bit and
 	 * 64-bit userspace, they are already compatible.
 	 */
-	return pty_unix98_ioctl(tty, cmd, arg);
+	return pty_unix98_ioctl(tty, cmd,
+		cmd == TIOCSIG ? arg : (unsigned long)compat_ptr(arg));
 }
+#else
+#define pty_unix98_compat_ioctl NULL
+#endif
 
 /**
  *	ptm_unix98_lookup	-	find a pty master
-- 
2.20.1

