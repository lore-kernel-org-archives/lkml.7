Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA404CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6B020874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfJ3NKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:10:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfJ3NKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:10:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B1DC34B0C0F4A344D568;
        Wed, 30 Oct 2019 21:10:13 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 30 Oct 2019 21:10:07 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akinobu.mita@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <zhongjiang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fault-inject: Use debugfs_create_ulong() instead of debugfs_create_ul()
Date:   Wed, 30 Oct 2019 21:06:16 +0800
Message-ID: <1572440776-50318-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_ulong() has implemented the function of debugfs_create_ul()
in lib/fault-inject.c. hence we can replace it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 lib/fault-inject.c | 43 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 8186ca8..326fc1d 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -151,10 +151,13 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 EXPORT_SYMBOL_GPL(should_fail);
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+#ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
 
-static int debugfs_ul_set(void *data, u64 val)
+static int debugfs_stacktrace_depth_set(void *data, u64 val)
 {
-	*(unsigned long *)data = val;
+	*(unsigned long *)data =
+		min_t(unsigned long, val, MAX_STACK_TRACE_DEPTH);
+
 	return 0;
 }
 
@@ -164,26 +167,8 @@ static int debugfs_ul_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
-
-static void debugfs_create_ul(const char *name, umode_t mode,
-			      struct dentry *parent, unsigned long *value)
-{
-	debugfs_create_file(name, mode, parent, value, &fops_ul);
-}
-
-#ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
-
-static int debugfs_stacktrace_depth_set(void *data, u64 val)
-{
-	*(unsigned long *)data =
-		min_t(unsigned long, val, MAX_STACK_TRACE_DEPTH);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
-			debugfs_stacktrace_depth_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
+			 debugfs_stacktrace_depth_set, "%llu\n");
 
 static void debugfs_create_stacktrace_depth(const char *name, umode_t mode,
 					    struct dentry *parent,
@@ -204,11 +189,11 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 	if (IS_ERR(dir))
 		return dir;
 
-	debugfs_create_ul("probability", mode, dir, &attr->probability);
-	debugfs_create_ul("interval", mode, dir, &attr->interval);
+	debugfs_create_ulong("probability", mode, dir, &attr->probability);
+	debugfs_create_ulong("interval", mode, dir, &attr->interval);
 	debugfs_create_atomic_t("times", mode, dir, &attr->times);
 	debugfs_create_atomic_t("space", mode, dir, &attr->space);
-	debugfs_create_ul("verbose", mode, dir, &attr->verbose);
+	debugfs_create_ulong("verbose", mode, dir, &attr->verbose);
 	debugfs_create_u32("verbose_ratelimit_interval_ms", mode, dir,
 			   &attr->ratelimit_state.interval);
 	debugfs_create_u32("verbose_ratelimit_burst", mode, dir,
@@ -218,10 +203,10 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
 	debugfs_create_stacktrace_depth("stacktrace-depth", mode, dir,
 					&attr->stacktrace_depth);
-	debugfs_create_ul("require-start", mode, dir, &attr->require_start);
-	debugfs_create_ul("require-end", mode, dir, &attr->require_end);
-	debugfs_create_ul("reject-start", mode, dir, &attr->reject_start);
-	debugfs_create_ul("reject-end", mode, dir, &attr->reject_end);
+	debugfs_create_ulong("require-start", mode, dir, &attr->require_start);
+	debugfs_create_ulong("require-end", mode, dir, &attr->require_end);
+	debugfs_create_ulong("reject-start", mode, dir, &attr->reject_start);
+	debugfs_create_ulong("reject-end", mode, dir, &attr->reject_end);
 #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
 
 	attr->dname = dget(dir);
-- 
1.7.12.4

