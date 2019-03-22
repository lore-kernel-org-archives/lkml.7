Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636582082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256367;
	bh=VTGPesFaZHidDFef929D6uK5oAkJTNgnMIYJq53n4yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mcxwkvjUWQGcUJ9QBc469ezz8JY11uBy8RdSL6qT9T9M2/8dgCXnyvyaoVg3ZpG2S
	 bhumDE4et2O68WG3zGQ1+c5AKRvrk0K0POxUNxl4UYniF6QNNQJigPyEu9shfL3b3G
	 Q5aPXnyX3LseLqgOnEUfI57AkqRx9YwhunSQolaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbfCVMGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388372AbfCVMGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:06:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6904206C0;
        Fri, 22 Mar 2019 12:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256362;
        bh=VTGPesFaZHidDFef929D6uK5oAkJTNgnMIYJq53n4yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4AOTCmvvycygQSQK4srY4Vrm0Vi3oL7oa/Z54P6EwcCQyAiein08yAnMT6aJxRbc
         l/9pKgFWjzvMp+5524D/GwnVfmbZchvnEhkTPkGpKdYpflLU6TfQozIlQv6INjWtC2
         pej/fXax5t/8XLP2ok2HKQWpIUdfiNhPXxt38a+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 166/280] ovl: Do not lose security.capability xattr over metadata file copy-up
Date:   Fri, 22 Mar 2019 12:15:19 +0100
Message-Id: <20190322111323.544712639@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: Vivek Goyal <vgoyal@redhat.com>

commit 993a0b2aec52754f0897b1dab4c453be8217cae5 upstream.

If a file has been copied up metadata only, and later data is copied up,
upper loses any security.capability xattr it has (underlying filesystem
clears it as upon file write).

>From a user's point of view, this is just a file copy-up and that should
not result in losing security.capability xattr.  Hence, before data copy
up, save security.capability xattr (if any) and restore it on upper after
data copy up is complete.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Fixes: 0c2888749363 ("ovl: A new xattr OVL_XATTR_METACOPY for file on upper")
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/copy_up.c   |   28 ++++++++++++++++++++++-
 fs/overlayfs/overlayfs.h |    2 +
 fs/overlayfs/util.c      |   55 +++++++++++++++++++++++++++++------------------
 3 files changed, 63 insertions(+), 22 deletions(-)

--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -711,6 +711,8 @@ static int ovl_copy_up_meta_inode_data(s
 {
 	struct path upperpath, datapath;
 	int err;
+	char *capability = NULL;
+	ssize_t uninitialized_var(cap_size);
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
@@ -720,15 +722,37 @@ static int ovl_copy_up_meta_inode_data(s
 	if (WARN_ON(datapath.dentry == NULL))
 		return -EIO;
 
+	if (c->stat.size) {
+		err = cap_size = ovl_getxattr(upperpath.dentry, XATTR_NAME_CAPS,
+					      &capability, 0);
+		if (err < 0 && err != -ENODATA)
+			goto out;
+	}
+
 	err = ovl_copy_up_data(&datapath, &upperpath, c->stat.size);
 	if (err)
-		return err;
+		goto out_free;
+
+	/*
+	 * Writing to upper file will clear security.capability xattr. We
+	 * don't want that to happen for normal copy-up operation.
+	 */
+	if (capability) {
+		err = ovl_do_setxattr(upperpath.dentry, XATTR_NAME_CAPS,
+				      capability, cap_size, 0);
+		if (err)
+			goto out_free;
+	}
+
 
 	err = vfs_removexattr(upperpath.dentry, OVL_XATTR_METACOPY);
 	if (err)
-		return err;
+		goto out_free;
 
 	ovl_set_upperdata(d_inode(c->dentry));
+out_free:
+	kfree(capability);
+out:
 	return err;
 }
 
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -277,6 +277,8 @@ int ovl_lock_rename_workdir(struct dentr
 int ovl_check_metacopy_xattr(struct dentry *dentry);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
 char *ovl_get_redirect_xattr(struct dentry *dentry, int padding);
+ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value,
+		     size_t padding);
 
 static inline bool ovl_is_impuredir(struct dentry *dentry)
 {
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -867,28 +867,49 @@ bool ovl_is_metacopy_dentry(struct dentr
 	return (oe->numlower > 1);
 }
 
-char *ovl_get_redirect_xattr(struct dentry *dentry, int padding)
+ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value,
+		     size_t padding)
 {
-	int res;
-	char *s, *next, *buf = NULL;
+	ssize_t res;
+	char *buf = NULL;
 
-	res = vfs_getxattr(dentry, OVL_XATTR_REDIRECT, NULL, 0);
+	res = vfs_getxattr(dentry, name, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
-			return NULL;
+			return -ENODATA;
 		goto fail;
 	}
 
-	buf = kzalloc(res + padding + 1, GFP_KERNEL);
-	if (!buf)
-		return ERR_PTR(-ENOMEM);
+	if (res != 0) {
+		buf = kzalloc(res + padding, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		res = vfs_getxattr(dentry, name, buf, res);
+		if (res < 0)
+			goto fail;
+	}
+	*value = buf;
 
-	if (res == 0)
-		goto invalid;
+	return res;
+
+fail:
+	pr_warn_ratelimited("overlayfs: failed to get xattr %s: err=%zi)\n",
+			    name, res);
+	kfree(buf);
+	return res;
+}
+
+char *ovl_get_redirect_xattr(struct dentry *dentry, int padding)
+{
+	int res;
+	char *s, *next, *buf = NULL;
 
-	res = vfs_getxattr(dentry, OVL_XATTR_REDIRECT, buf, res);
+	res = ovl_getxattr(dentry, OVL_XATTR_REDIRECT, &buf, padding + 1);
+	if (res == -ENODATA)
+		return NULL;
 	if (res < 0)
-		goto fail;
+		return ERR_PTR(res);
 	if (res == 0)
 		goto invalid;
 
@@ -904,15 +925,9 @@ char *ovl_get_redirect_xattr(struct dent
 	}
 
 	return buf;
-
-err_free:
-	kfree(buf);
-	return ERR_PTR(res);
-fail:
-	pr_warn_ratelimited("overlayfs: failed to get redirect (%i)\n", res);
-	goto err_free;
 invalid:
 	pr_warn_ratelimited("overlayfs: invalid redirect (%s)\n", buf);
 	res = -EINVAL;
-	goto err_free;
+	kfree(buf);
+	return ERR_PTR(res);
 }


