Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040D5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BEC22ADF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="GJbaZyZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392068AbfGXT5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:57:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36924 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390673AbfGXT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so21462601pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1oMJfrLOhz58HDhVH6CDl46g8rPXC84FR3jYEnwlGc=;
        b=GJbaZyZrN284EZaMgoaqSAtkOaiXvAl2Jzk1NdlCcJt1i+MCIStLfk4VLsZ2eWeOwL
         aSM/E1tfLEiFAK3NdeyIcFcVvjWjGQQ+uWIHDhmkk8M/SBs1ETRAFe+LkroYUjhXTbx0
         SkMLhttcCwzaCdxowZTuk5Ud6qZm6p8qg32R93rtYmLzltdBctyeCSeLDBsi9u5+AWER
         AV37Ol3qJnqTXl7pm5LrCVzP3JTx6e+lFViT2UYI+qcEHJtGCnuRImT8Uk41RoR0AH0M
         s96Qe7uf+LFZFOV7uPbHX2OtrfWq4tbzx0fZ8BaY8r6/+WWWq9K6m7m/ZjrazNSZSFZT
         6e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1oMJfrLOhz58HDhVH6CDl46g8rPXC84FR3jYEnwlGc=;
        b=SngP38YhGH9zZ6yty1E0fPPm4O6A1W4EwPIQ0ssgrZs45xtttZ5duDM3P1pJZUfX1K
         0ughe9WA14RT2ixdZ+EV+wABf/3gPo24CF67HBrMKVgvTwaqUlWiPu3mIpfgNrvlACxy
         r50AfYfWxv+5GQVf1waWfdGRkx2arbYsX6X7KRybk9rwYwBPW+lQUuC6rwI7ybT6xhDq
         gm5a35jQhsxFPNIOfyOLHaCygibimq9x5qUFHCuL92PIbyAnbaGFeJ4Gd2ZtnqIo2GF1
         PjFDJ3aa90xXxfD8GolZKUaigwqJQ2KkbieQnLarbf/+q+f93pHAZvFT27ey3LCQIGET
         P1bw==
X-Gm-Message-State: APjAAAUsq5oXqF/PeDecylJubLgQGQclYuwYdjJaC1i1Ba1MZ5K7kkAb
        0cJGDP8S8tOAktC3Z9E9X8SxelnZ
X-Google-Smtp-Source: APXvYqy7X7TyygDWC4aF4AtmXyrL0XzYUXo6uIcdD2u7K60Xp3HzR54ZYiPqDmuME7OVT8NPmFC2Nw==
X-Received: by 2002:a63:3147:: with SMTP id x68mr19151426pgx.212.1563998258943;
        Wed, 24 Jul 2019 12:57:38 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f88sm46307394pjg.5.2019.07.24.12.57.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:57:38 -0700 (PDT)
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
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mark Salyzyn <salyzyn@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v10 2/5] Add optional __get xattr method paired to __vfs_getxattr
Date:   Wed, 24 Jul 2019 12:57:13 -0700
Message-Id: <20190724195719.218307-3-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190724195719.218307-1-salyzyn@android.com>
References: <20190724195719.218307-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional __get xattr method that would be called, if set, only
in __vfs_getxattr instead of the regular get xattr method.

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
 fs/xattr.c            | 11 ++++++++++-
 include/linux/xattr.h |  7 +++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..b8f4734e222f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -306,6 +306,9 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
+	if (unlikely(handler->__get))
+		return handler->__get(handler, dentry, inode, name, value,
+				      size);
 	if (!handler->get)
 		return -EOPNOTSUPP;
 	return handler->get(handler, dentry, inode, name, value, size);
@@ -317,6 +320,7 @@ vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
+	const struct xattr_handler *handler;
 
 	error = xattr_permission(inode, name, MAY_READ);
 	if (error)
@@ -339,7 +343,12 @@ vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
 		return ret;
 	}
 nolsm:
-	return __vfs_getxattr(dentry, inode, name, value, size);
+	handler = xattr_resolve_name(inode, &name);
+	if (IS_ERR(handler))
+		return PTR_ERR(handler);
+	if (!handler->get)
+		return -EOPNOTSUPP;
+	return handler->get(handler, dentry, inode, name, value, size);
 }
 EXPORT_SYMBOL_GPL(vfs_getxattr);
 
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 6dad031be3c2..30f25e1ac571 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -30,10 +30,13 @@ struct xattr_handler {
 	const char *prefix;
 	int flags;      /* fs private flags */
 	bool (*list)(struct dentry *dentry);
-	int (*get)(const struct xattr_handler *, struct dentry *dentry,
+	int (*get)(const struct xattr_handler *handler, struct dentry *dentry,
 		   struct inode *inode, const char *name, void *buffer,
 		   size_t size);
-	int (*set)(const struct xattr_handler *, struct dentry *dentry,
+	int (*__get)(const struct xattr_handler *handler, struct dentry *dentry,
+		     struct inode *inode, const char *name, void *buffer,
+		     size_t size);
+	int (*set)(const struct xattr_handler *handler, struct dentry *dentry,
 		   struct inode *inode, const char *name, const void *buffer,
 		   size_t size, int flags);
 };
-- 
2.22.0.657.g960e92d24f-goog

