Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23962C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAD021850
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639048;
	bh=VhYHj1JGEzybdzdBDT8KkRqbELCLV3SpqUsmXijz9OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qrnXbTlAIN8CGiduBBtzPMI2r4vFGuv0/XgaqyFuZVqSHdGZJwXJJ1pQMtQjvNmDp
	 DcQ3oYT2nIJN3UkGY0eNnGNkZlLaiT1+CK7OFsDc4Tqmt6A0lgbbOCDxoa5asKdwPM
	 RfVJ3FvTz3wKRQKZfFYjuO47AB39rlRj5YgoEXG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389409AbfEWTR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388952AbfEWTRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:17:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4FD0205ED;
        Thu, 23 May 2019 19:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639043;
        bh=VhYHj1JGEzybdzdBDT8KkRqbELCLV3SpqUsmXijz9OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+tWFU0+wTsW0grRAy5E27PPzjJih+07O8+Fhp1FwGP8b2+S9f4JwQ2IrWpHNVf1k
         Barxcz31PwIaGjco5saPdH5pVt+hrm/5VDQ36WLewwtpDffuSQUJIcOYDm3Jw6DHmQ
         Du7RWoWu0OWAh7OLfBIZWo1vzyFhAHxYFBgePCjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 048/114] ovl: fix missing upper fs freeze protection on copy up for ioctl
Date:   Thu, 23 May 2019 21:05:47 +0200
Message-Id: <20190523181736.073093579@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

commit 3428030da004a1128cbdcf93dc03e16f184d845b upstream.

Generalize the helper ovl_open_maybe_copy_up() and use it to copy up file
with data before FS_IOC_SETFLAGS ioctl.

The FS_IOC_SETFLAGS ioctl is a bit of an odd ball in vfs, which probably
caused the confusion.  File may be open O_RDONLY, but ioctl modifies the
file.  VFS does not call mnt_want_write_file() nor lock inode mutex, but
fs-specific code for FS_IOC_SETFLAGS does.  So ovl_ioctl() calls
mnt_want_write_file() for the overlay file, and fs-specific code calls
mnt_want_write_file() for upper fs file, but there was no call for
ovl_want_write() for copy up duration which prevents overlayfs from copying
up on a frozen upper fs.

Fixes: dab5ca8fd9dd ("ovl: add lsattr/chattr support")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/copy_up.c   |    6 +++---
 fs/overlayfs/file.c      |    5 ++---
 fs/overlayfs/overlayfs.h |    2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -878,14 +878,14 @@ static bool ovl_open_need_copy_up(struct
 	return true;
 }
 
-int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags)
+int ovl_maybe_copy_up(struct dentry *dentry, int flags)
 {
 	int err = 0;
 
-	if (ovl_open_need_copy_up(dentry, file_flags)) {
+	if (ovl_open_need_copy_up(dentry, flags)) {
 		err = ovl_want_write(dentry);
 		if (!err) {
-			err = ovl_copy_up_flags(dentry, file_flags);
+			err = ovl_copy_up_flags(dentry, flags);
 			ovl_drop_write(dentry);
 		}
 	}
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -116,11 +116,10 @@ static int ovl_real_fdget(const struct f
 
 static int ovl_open(struct inode *inode, struct file *file)
 {
-	struct dentry *dentry = file_dentry(file);
 	struct file *realfile;
 	int err;
 
-	err = ovl_open_maybe_copy_up(dentry, file->f_flags);
+	err = ovl_maybe_copy_up(file_dentry(file), file->f_flags);
 	if (err)
 		return err;
 
@@ -390,7 +389,7 @@ static long ovl_ioctl(struct file *file,
 		if (ret)
 			return ret;
 
-		ret = ovl_copy_up_with_data(file_dentry(file));
+		ret = ovl_maybe_copy_up(file_dentry(file), O_WRONLY);
 		if (!ret) {
 			ret = ovl_real_ioctl(file, cmd, arg);
 
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -411,7 +411,7 @@ extern const struct file_operations ovl_
 int ovl_copy_up(struct dentry *dentry);
 int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_copy_up_flags(struct dentry *dentry, int flags);
-int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags);
+int ovl_maybe_copy_up(struct dentry *dentry, int flags);
 int ovl_copy_xattr(struct dentry *old, struct dentry *new);
 int ovl_set_attr(struct dentry *upper, struct kstat *stat);
 struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper);


