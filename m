Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB472C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D952175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfCTN7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:59:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727645AbfCTN7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:59:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3EEC7121D602DE199B03;
        Wed, 20 Mar 2019 21:59:33 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 21:59:27 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-audit@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] audit: Make audit_log_cap and audit_copy_inode static
Date:   Wed, 20 Mar 2019 21:59:22 +0800
Message-ID: <20190320135922.8772-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

kernel/auditsc.c:1150:6: warning: symbol 'audit_log_cap' was not declared. Should it be static?
kernel/auditsc.c:1908:6: warning: symbol 'audit_copy_inode' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/auditsc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index fa7b804..17b0007 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1147,7 +1147,8 @@ static void audit_log_execve_info(struct audit_context *context,
 	kfree(buf_head);
 }
 
-void audit_log_cap(struct audit_buffer *ab, char *prefix, kernel_cap_t *cap)
+static void audit_log_cap(struct audit_buffer *ab, char *prefix,
+			  kernel_cap_t *cap)
 {
 	int i;
 
@@ -1905,8 +1906,9 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 }
 
 /* Copy inode data into an audit_names. */
-void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
-		      struct inode *inode, unsigned int flags)
+static void audit_copy_inode(struct audit_names *name,
+			     const struct dentry *dentry,
+			     struct inode *inode, unsigned int flags)
 {
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
-- 
2.7.0


