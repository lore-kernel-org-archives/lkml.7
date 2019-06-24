Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8754FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611ED2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370562;
	bh=/KiQPSqgnA+uU5cBwuXizkixVy1P5Z7IFHizo0NUjmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H2A1JySGPEohjJJCpGiAM+0avgejzuHLe2t6SnB51moVjEdYUGcgn8SCHKCQysASx
	 acB1pIC3p4Te8KyzIwSQmhZDs/wSlBfQTNjOm7QwtONgeAcFFPJo4lOFnCTnfaVSEd
	 xfLQq9JEB8aa+wYfAtqewdBQewL9Jm9fNpKNvHjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfFXKC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbfFXKCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:02:23 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA8AF2146E;
        Mon, 24 Jun 2019 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370542;
        bh=/KiQPSqgnA+uU5cBwuXizkixVy1P5Z7IFHizo0NUjmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M97Xk7o1dUK8Fw8RnOSX7bauF+iKZ1toEpi17Ug0bTOJNz0hhtpxeHzkxM+JL9p3X
         5STHBUKaqC65BuA8vYpq1Bead9sWggCKFLNKzkZqR9zo9b7HRqJNSyEm+h6dLrY/Sv
         T7a8wxFVTKoDyWoMeupo/8k26z57ynqXLP16emzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/90] ovl: fix wrong flags check in FS_IOC_FS[SG]ETXATTR ioctls
Date:   Mon, 24 Jun 2019 17:55:55 +0800
Message-Id: <20190624092314.323719589@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 941d935ac7636911a3fd8fa80e758e52b0b11e20 ]

The ioctl argument was parsed as the wrong type.

Fixes: b21d9c435f93 ("ovl: support the FS_IOC_FS[SG]ETXATTR ioctls")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/file.c | 91 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 749532fd51d7..0bd276e4ccbe 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -409,37 +409,16 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
-static unsigned int ovl_get_inode_flags(struct inode *inode)
-{
-	unsigned int flags = READ_ONCE(inode->i_flags);
-	unsigned int ovl_iflags = 0;
-
-	if (flags & S_SYNC)
-		ovl_iflags |= FS_SYNC_FL;
-	if (flags & S_APPEND)
-		ovl_iflags |= FS_APPEND_FL;
-	if (flags & S_IMMUTABLE)
-		ovl_iflags |= FS_IMMUTABLE_FL;
-	if (flags & S_NOATIME)
-		ovl_iflags |= FS_NOATIME_FL;
-
-	return ovl_iflags;
-}
-
 static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
-				unsigned long arg)
+				unsigned long arg, unsigned int iflags)
 {
 	long ret;
 	struct inode *inode = file_inode(file);
-	unsigned int flags;
-	unsigned int old_flags;
+	unsigned int old_iflags;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
-	if (get_user(flags, (int __user *) arg))
-		return -EFAULT;
-
 	ret = mnt_want_write_file(file);
 	if (ret)
 		return ret;
@@ -448,8 +427,8 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 
 	/* Check the capability before cred override */
 	ret = -EPERM;
-	old_flags = ovl_get_inode_flags(inode);
-	if (((flags ^ old_flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) &&
+	old_iflags = READ_ONCE(inode->i_flags);
+	if (((iflags ^ old_iflags) & (S_APPEND | S_IMMUTABLE)) &&
 	    !capable(CAP_LINUX_IMMUTABLE))
 		goto unlock;
 
@@ -469,6 +448,63 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 
 }
 
+static unsigned int ovl_fsflags_to_iflags(unsigned int flags)
+{
+	unsigned int iflags = 0;
+
+	if (flags & FS_SYNC_FL)
+		iflags |= S_SYNC;
+	if (flags & FS_APPEND_FL)
+		iflags |= S_APPEND;
+	if (flags & FS_IMMUTABLE_FL)
+		iflags |= S_IMMUTABLE;
+	if (flags & FS_NOATIME_FL)
+		iflags |= S_NOATIME;
+
+	return iflags;
+}
+
+static long ovl_ioctl_set_fsflags(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	unsigned int flags;
+
+	if (get_user(flags, (int __user *) arg))
+		return -EFAULT;
+
+	return ovl_ioctl_set_flags(file, cmd, arg,
+				   ovl_fsflags_to_iflags(flags));
+}
+
+static unsigned int ovl_fsxflags_to_iflags(unsigned int xflags)
+{
+	unsigned int iflags = 0;
+
+	if (xflags & FS_XFLAG_SYNC)
+		iflags |= S_SYNC;
+	if (xflags & FS_XFLAG_APPEND)
+		iflags |= S_APPEND;
+	if (xflags & FS_XFLAG_IMMUTABLE)
+		iflags |= S_IMMUTABLE;
+	if (xflags & FS_XFLAG_NOATIME)
+		iflags |= S_NOATIME;
+
+	return iflags;
+}
+
+static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	struct fsxattr fa;
+
+	memset(&fa, 0, sizeof(fa));
+	if (copy_from_user(&fa, (void __user *) arg, sizeof(fa)))
+		return -EFAULT;
+
+	return ovl_ioctl_set_flags(file, cmd, arg,
+				   ovl_fsxflags_to_iflags(fa.fsx_xflags));
+}
+
 static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	long ret;
@@ -480,8 +516,11 @@ static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 
 	case FS_IOC_SETFLAGS:
+		ret = ovl_ioctl_set_fsflags(file, cmd, arg);
+		break;
+
 	case FS_IOC_FSSETXATTR:
-		ret = ovl_ioctl_set_flags(file, cmd, arg);
+		ret = ovl_ioctl_set_fsxflags(file, cmd, arg);
 		break;
 
 	default:
-- 
2.20.1



