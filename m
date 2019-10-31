Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B31CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CE420873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfJaCA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 22:00:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbfJaCA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 22:00:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63BEA1B45A453CE0045B;
        Thu, 31 Oct 2019 10:00:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 10:00:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akinobu.mita@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <zhongjiang@huawei.com>
Subject: [PATCH v3 2/2] fault-inject: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs fops
Date:   Thu, 31 Oct 2019 09:56:17 +0800
Message-ID: <1572486977-14195-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1572486977-14195-1-git-send-email-zhongjiang@huawei.com>
References: <1572486977-14195-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more clearly to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
operation rather than DEFINE_SIMPLE_ATTRIBUTE.

Meanwhile, debugfs_create_file() in debugfs_create_stacktrace_depth() can
be replaced by debugfs_create_file_unsafe().

Suggested-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 lib/fault-inject.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 430b3ac..2655bfd 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -167,14 +167,14 @@ static int debugfs_ul_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
-			debugfs_stacktrace_depth_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
+			 debugfs_stacktrace_depth_set, "%llu\n");
 
 static void debugfs_create_stacktrace_depth(const char *name, umode_t mode,
 					    struct dentry *parent,
 					    unsigned long *value)
 {
-	debugfs_create_file(name, mode, parent, value, &fops_stacktrace_depth);
+	debugfs_create_file_unsafe(name, mode, parent, value, &fops_stacktrace_depth);
 }
 
 #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
-- 
1.7.12.4

