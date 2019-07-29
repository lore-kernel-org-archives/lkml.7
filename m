Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B9EC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D639C20644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfG2Gxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:53:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfG2Gw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1D0D0268880CFE8A0129;
        Mon, 29 Jul 2019 14:52:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:16 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>, Yue Hu <zbestahu@gmail.com>
Subject: [PATCH 03/22] staging: erofs: fix dummy functions erofs_{get,list}xattr
Date:   Mon, 29 Jul 2019 14:51:40 +0800
Message-ID: <20190729065159.62378-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dummy functions erofs_{get,list}xattr should be inlined
without xattr enabled.

Signed-off-by: Yue Hu <zbestahu@gmail.com>
[ Gao Xiang : this patch was "staging: erofs: remove needless
              dummy functions of erofs_{get,list}xattr. "]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/xattr.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index fbcd57bdf886..63cc87e3d3f4 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -39,6 +39,7 @@ static inline unsigned int xattrblock_offset(struct erofs_sb_info *sbi,
 	return (xattr_id * sizeof(__u32)) % EROFS_BLKSIZ;
 }
 
+#ifdef CONFIG_EROFS_FS_XATTR
 extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
 #ifdef CONFIG_EROFS_FS_SECURITY
@@ -64,25 +65,24 @@ static const struct xattr_handler *xattr_handler_map[] = {
 		xattr_handler_map[idx] : NULL;
 }
 
-#ifdef CONFIG_EROFS_FS_XATTR
 extern const struct xattr_handler *erofs_xattr_handlers[];
 
 int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
 #else
-static int __maybe_unused erofs_getxattr(struct inode *inode, int index,
-	const char *name,
-	void *buffer, size_t buffer_size)
+static inline int erofs_getxattr(struct inode *inode, int index,
+				 const char *name, void *buffer,
+				 size_t buffer_size)
 {
 	return -ENOTSUPP;
 }
 
-static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
-	char *buffer, size_t buffer_size)
+static inline ssize_t erofs_listxattr(struct dentry *dentry,
+				      char *buffer, size_t buffer_size)
 {
 	return -ENOTSUPP;
 }
-#endif
+#endif	/* !CONFIG_EROFS_FS_XATTR */
 
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 struct posix_acl *erofs_get_acl(struct inode *inode, int type);
-- 
2.17.1

