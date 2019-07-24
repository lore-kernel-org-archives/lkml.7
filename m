Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF734C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B5820665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="VwJUVids"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392794AbfGXULn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:11:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33975 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392064AbfGXT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so21466693pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJ++CCbXQ8fJBmjGMLB43efSHihd3T4m82L9ke05cVI=;
        b=VwJUVids9rL4Oiqm1mwPJJGzIvtW8+Awz6PB9TQJgkGZRH+CrQ/aWA7uCxDwJs6opz
         oAu81qN1qiIzypIqXvoabr31Z20NhjnikNl8qVIXQ60E/jyDUx0EzTZ91cMQqU7dISKg
         aFxI+DAY0bY4rtLAbpzqwOOgOhW+y/q+o9Hf8mkoCwGp6npnWr2L7QkkSwUAzzJ9JNvN
         X/oMxe0mkgiaYiyZNMEswmRf49z3a4rNxzuD8QnHPnqgva8stSmd92EhPYyBAzX/IrMg
         t9V23RYUFdqslF/UksMVdOjcJ2thbRBbXMupMkt3RF1pl7XGzCxCzAc8ChoCEhqPpIyT
         +nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJ++CCbXQ8fJBmjGMLB43efSHihd3T4m82L9ke05cVI=;
        b=DGtIBjFeia5jGfJ3Ip/OPGmBIIp5QZhpAIWduottzx2HCxjGNpbrLvo5MuIC4n82A2
         icEqb3Sv2+A2jddGjoSRs9NgBErreCmtRp5lChsibu1MM2xcnbAZvYP7/rYBAPuhSQ/a
         mydH2pcJ679Jf6RcDlWN1ct4CD57d2iJ4uUjojzYQBylwfYrDVQiF6kWfsbh391uvUTJ
         KkrdwHtOJjPv2aIxPKc0Ks+qi3szebrgq2/BQG6aarZY91ZEXpqIgbwK/AzuvpHhZOGv
         XnqqXQahZhxYZJEiyY3e0ay1Mi1kMafPnX+Ye2h8RMPSmrQf28l/Q05WmMUH0w3FdZgo
         /uGQ==
X-Gm-Message-State: APjAAAVDHC2VvNbuaSS0mRAmOuETb8TZkGMwGSJ2DfQrPdhMpW5g/yjU
        +iOH3W7AGPqEHPxX3VijX2ONF7ST
X-Google-Smtp-Source: APXvYqz//3PrI++REi8kI7k4gAYV0L8OM9T1BzWmO8jrCVX4qZcfCKHU/2YIZ0XZWwOYq7gNEEvXIQ==
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr86694599pjo.111.1563998261788;
        Wed, 24 Jul 2019 12:57:41 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f88sm46307394pjg.5.2019.07.24.12.57.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:57:41 -0700 (PDT)
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
Subject: [PATCH v10 3/5] overlayfs: add __get xattr method
Date:   Wed, 24 Jul 2019 12:57:14 -0700
Message-Id: <20190724195719.218307-4-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190724195719.218307-1-salyzyn@android.com>
References: <20190724195719.218307-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the overlayfs getxattr recursion, the incoming inode fails
to update the selinux sid resulting in avc denials being reported
against a target context of u:object_r:unlabeled:s0.

Solution is to add a _get xattr method that calls the __vfs_getxattr
handler so that the context can be read in, rather than being denied
with an -EACCES when vfs_getxattr handler is called.

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
 fs/overlayfs/inode.c     | 15 +++++++++++++++
 fs/overlayfs/overlayfs.h |  2 ++
 fs/overlayfs/super.c     | 18 ++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 7663aeb85fa3..d3b53849615c 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -362,6 +362,21 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 	return err;
 }
 
+int __ovl_xattr_get(struct dentry *dentry, struct inode *inode,
+		    const char *name, void *value, size_t size)
+{
+	ssize_t res;
+	const struct cred *old_cred;
+	struct dentry *realdentry =
+		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+	res = __vfs_getxattr(realdentry, d_inode(realdentry), name, value,
+			     size);
+	ovl_revert_creds(old_cred);
+	return res;
+}
+
 int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 		  void *value, size_t size)
 {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6934bcf030f0..73a02a263fbc 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -357,6 +357,8 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		  const void *value, size_t size, int flags);
 int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 		  void *value, size_t size);
+int __ovl_xattr_get(struct dentry *dentry, struct inode *inode,
+		    const char *name, void *value, size_t size);
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 struct posix_acl *ovl_get_acl(struct inode *inode, int type);
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b368e2e102fa..82e1130de206 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -859,6 +859,14 @@ ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
 	return ovl_xattr_get(dentry, inode, handler->name, buffer, size);
 }
 
+static int __maybe_unused
+__ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
+			  struct dentry *dentry, struct inode *inode,
+			  const char *name, void *buffer, size_t size)
+{
+	return __ovl_xattr_get(dentry, inode, handler->name, buffer, size);
+}
+
 static int __maybe_unused
 ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 			struct dentry *dentry, struct inode *inode,
@@ -939,6 +947,13 @@ static int ovl_other_xattr_get(const struct xattr_handler *handler,
 	return ovl_xattr_get(dentry, inode, name, buffer, size);
 }
 
+static int __ovl_other_xattr_get(const struct xattr_handler *handler,
+				 struct dentry *dentry, struct inode *inode,
+				 const char *name, void *buffer, size_t size)
+{
+	return __ovl_xattr_get(dentry, inode, name, buffer, size);
+}
+
 static int ovl_other_xattr_set(const struct xattr_handler *handler,
 			       struct dentry *dentry, struct inode *inode,
 			       const char *name, const void *value,
@@ -952,6 +967,7 @@ ovl_posix_acl_access_xattr_handler = {
 	.name = XATTR_NAME_POSIX_ACL_ACCESS,
 	.flags = ACL_TYPE_ACCESS,
 	.get = ovl_posix_acl_xattr_get,
+	.__get = __ovl_posix_acl_xattr_get,
 	.set = ovl_posix_acl_xattr_set,
 };
 
@@ -960,6 +976,7 @@ ovl_posix_acl_default_xattr_handler = {
 	.name = XATTR_NAME_POSIX_ACL_DEFAULT,
 	.flags = ACL_TYPE_DEFAULT,
 	.get = ovl_posix_acl_xattr_get,
+	.__get = __ovl_posix_acl_xattr_get,
 	.set = ovl_posix_acl_xattr_set,
 };
 
@@ -972,6 +989,7 @@ static const struct xattr_handler ovl_own_xattr_handler = {
 static const struct xattr_handler ovl_other_xattr_handler = {
 	.prefix	= "", /* catch all */
 	.get = ovl_other_xattr_get,
+	.__get = __ovl_other_xattr_get,
 	.set = ovl_other_xattr_set,
 };
 
-- 
2.22.0.657.g960e92d24f-goog

