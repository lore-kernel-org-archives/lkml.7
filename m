Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1C1C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F347B206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfKODUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:20:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbfKODUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:20:41 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2D31FEB4961799FCF945;
        Fri, 15 Nov 2019 11:20:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 11:20:29 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <yukuai3@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
Date:   Fri, 15 Nov 2019 11:27:50 +0800
Message-ID: <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dentry_d_lock_class' can be used for spin_lock_nested in case lockdep
confused about two different dentry take the 'd_lock'.

However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
two dentry are involed. So, and in 'DENTRY_D_LOCK_NESTED_2'

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 include/linux/dcache.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 10090f1..8eb84ef 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -129,7 +129,8 @@ struct dentry {
 enum dentry_d_lock_class
 {
 	DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
-	DENTRY_D_LOCK_NESTED
+	DENTRY_D_LOCK_NESTED,
+	DENTRY_D_LOCK_NESTED_2
 };
 
 struct dentry_operations {
-- 
2.7.4

