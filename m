Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96814C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB9B21852
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="K55eCudJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392409AbfGXUL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:11:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34379 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392080AbfGXT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so15515583pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAymHu4XgH/IMiMyO9fyDAqFZAsMMnHk5zE8/frQ4uo=;
        b=K55eCudJpgMV3HvVPCvXCT2QQujmZe6yvWdEIOSaA0I2vL9iqGt6nBFTUTkThN/L3Y
         n9+KVA6TzNCHLm5ANX22040lNXx+OKQL6AvpwyvTLY1uYTLzM/DI2z3lpd9nXRCR2Yxs
         CU3Y6LipTPu6cFwUO+MdIRQijVtH+vBoWgIFj3kHwh2fwDaK4A5PK3C9KtzOOAcSg3Md
         FhcwWOgFtp73AE0b3/gOoSLuguNHhl0vySF1po5/aPVnkJcNfdKLSHYO05+foShtDPkc
         z9na6AwBNhf0+5erxRNIiZe9R59xYttV5//vtkhLHmQtHqbVwsdtmrqWkinSIoa1VWT9
         Z+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAymHu4XgH/IMiMyO9fyDAqFZAsMMnHk5zE8/frQ4uo=;
        b=KGZrwFxPQxB/1zKY/prNueSqjv/V69f0jPmgkB/XU/EdRy1UFmNVZ+vOds3liE2IFg
         zdEb3Vjm5tD6ytMS69FqwdoITOW2pqS6nTexYC2hKkWjJA3X5LNDBq6HUQnGv8UqkAR5
         2wsTzn+E52FbFXvL54YvW35XmTEazMjLrkWbGUZ/ythKuSfTEJVcmX92MSRBIoBMZFRB
         efQTweAOtX21ez8JSb2mRUDQsgUOhICzatDVjBxvAFKO6gHRAnITIS5CNUac3iyod38N
         7KoQNTd4/Y/XFKwp30gt3jiEhYc4s7r0IYDX/0A6hUM9VAzvmk6cqEStcaz8JqNPWdA6
         FU4w==
X-Gm-Message-State: APjAAAWpnP5BHDSxNogTkzA6pggL2b9HLm8sDqbddzc2QWkCb1GEKYb+
        iV/tSWG0bZYwcbxcbzLgXlUwXirj
X-Google-Smtp-Source: APXvYqyjsUwm6vdk0KrCkHjEKYpzILWh5UmjK0JP1EUkFgI5lw4urYp9jknmdAtlM3ZTKAv0bBhZzg==
X-Received: by 2002:a17:90b:f0f:: with SMTP id br15mr90541875pjb.101.1563998264319;
        Wed, 24 Jul 2019 12:57:44 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f88sm46307394pjg.5.2019.07.24.12.57.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:57:43 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v10 4/5] overlayfs: internal getxattr operations without sepolicy checking
Date:   Wed, 24 Jul 2019 12:57:15 -0700
Message-Id: <20190724195719.218307-5-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190724195719.218307-1-salyzyn@android.com>
References: <20190724195719.218307-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check impure, opaque, origin & meta xattr with no sepolicy audit
(using __vfs_getxattr) since these operations are internal to
overlayfs operations and do not disclose any data.  This became
an issue for credential override off since sys_admin would have
been required by the caller; whereas would have been inherently
present for the creator since it performed the mount.

This is a change in operations since we do not check in the new
ovl_vfs_getxattr function if the credential override is off or
not.  Reasoning is that the sepolicy check is unnecessary overhead,
especially since the check can be expensive.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
---
v10 - added to patch series
---
 fs/overlayfs/namei.c     | 12 +++++++-----
 fs/overlayfs/overlayfs.h |  2 ++
 fs/overlayfs/util.c      | 24 +++++++++++++++---------
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 9702f0d5309d..fb6c0cd7b65f 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -106,10 +106,11 @@ int ovl_check_fh_len(struct ovl_fh *fh, int fh_len)
 
 static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
 {
-	int res, err;
+	ssize_t res;
+	int err;
 	struct ovl_fh *fh = NULL;
 
-	res = vfs_getxattr(dentry, name, NULL, 0);
+	res = ovl_vfs_getxattr(dentry, name, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return NULL;
@@ -123,7 +124,7 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
 	if (!fh)
 		return ERR_PTR(-ENOMEM);
 
-	res = vfs_getxattr(dentry, name, fh, res);
+	res = ovl_vfs_getxattr(dentry, name, fh, res);
 	if (res < 0)
 		goto fail;
 
@@ -141,10 +142,11 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
 	return NULL;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to get origin (%i)\n", res);
+	pr_warn_ratelimited("overlayfs: failed to get origin (%zi)\n", res);
 	goto out;
 invalid:
-	pr_warn_ratelimited("overlayfs: invalid origin (%*phN)\n", res, fh);
+	pr_warn_ratelimited("overlayfs: invalid origin (%*phN)\n",
+			    (int)res, fh);
 	goto out;
 }
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 73a02a263fbc..82574684a9b6 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -205,6 +205,8 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+ssize_t ovl_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
+			 size_t size);
 struct super_block *ovl_same_sb(struct super_block *sb);
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f5678a3f8350..672459c3cff7 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -40,6 +40,12 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
+ssize_t ovl_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
+			 size_t size)
+{
+	return __vfs_getxattr(dentry, d_inode(dentry), name, buf, size);
+}
+
 struct super_block *ovl_same_sb(struct super_block *sb)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
@@ -537,9 +543,9 @@ void ovl_copy_up_end(struct dentry *dentry)
 
 bool ovl_check_origin_xattr(struct dentry *dentry)
 {
-	int res;
+	ssize_t res;
 
-	res = vfs_getxattr(dentry, OVL_XATTR_ORIGIN, NULL, 0);
+	res = ovl_vfs_getxattr(dentry, OVL_XATTR_ORIGIN, NULL, 0);
 
 	/* Zero size value means "copied up but origin unknown" */
 	if (res >= 0)
@@ -550,13 +556,13 @@ bool ovl_check_origin_xattr(struct dentry *dentry)
 
 bool ovl_check_dir_xattr(struct dentry *dentry, const char *name)
 {
-	int res;
+	ssize_t res;
 	char val;
 
 	if (!d_is_dir(dentry))
 		return false;
 
-	res = vfs_getxattr(dentry, name, &val, 1);
+	res = ovl_vfs_getxattr(dentry, name, &val, 1);
 	if (res == 1 && val == 'y')
 		return true;
 
@@ -837,13 +843,13 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
 /* err < 0, 0 if no metacopy xattr, 1 if metacopy xattr found */
 int ovl_check_metacopy_xattr(struct dentry *dentry)
 {
-	int res;
+	ssize_t res;
 
 	/* Only regular files can have metacopy xattr */
 	if (!S_ISREG(d_inode(dentry)->i_mode))
 		return 0;
 
-	res = vfs_getxattr(dentry, OVL_XATTR_METACOPY, NULL, 0);
+	res = ovl_vfs_getxattr(dentry, OVL_XATTR_METACOPY, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return 0;
@@ -852,7 +858,7 @@ int ovl_check_metacopy_xattr(struct dentry *dentry)
 
 	return 1;
 out:
-	pr_warn_ratelimited("overlayfs: failed to get metacopy (%i)\n", res);
+	pr_warn_ratelimited("overlayfs: failed to get metacopy (%zi)\n", res);
 	return res;
 }
 
@@ -878,7 +884,7 @@ ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value,
 	ssize_t res;
 	char *buf = NULL;
 
-	res = vfs_getxattr(dentry, name, NULL, 0);
+	res = ovl_vfs_getxattr(dentry, name, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return -ENODATA;
@@ -890,7 +896,7 @@ ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value,
 		if (!buf)
 			return -ENOMEM;
 
-		res = vfs_getxattr(dentry, name, buf, res);
+		res = ovl_vfs_getxattr(dentry, name, buf, res);
 		if (res < 0)
 			goto fail;
 	}
-- 
2.22.0.657.g960e92d24f-goog

