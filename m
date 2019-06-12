Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E5C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9251F20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560333523;
	bh=rd5QVACaIHkIaNCptV/ZkwpcoLClv4T852TI2/wT5Yo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aDqM/Zi7iFLiaDRVYOK/SksHtckHKv8k4R3DLmrshwFmKnGp+hFctr+qmewDN+eY0
	 Zezn/CKk1f22rV7bT9lrI6Dp+bfSirHoWO7syKLghAgWrli6jfOGb6f+P581MMFIz4
	 M6+uamrY+esHMxd8Ng/OSi0eIMhFaO67+G1YEPRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfFLJ6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfFLJ6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:58:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B22208C2;
        Wed, 12 Jun 2019 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560333521;
        bh=rd5QVACaIHkIaNCptV/ZkwpcoLClv4T852TI2/wT5Yo=;
        h=From:To:Cc:Subject:Date:From;
        b=H5XGG3bogdKthXXEi8pCIuAPXjcjVvvVcqNlQxJx/UL+GdX6sgFwP2ZinO3hzwYJ9
         9H7TEoN3rejBBOTu6wFxG+dwwQBDmr2U09r/IGs1BknnOevagSSyz6mLvajNkHGfDx
         uYbUHxgqnS/pVaFj8QThNfcMOAe+rvd3TMNza1gY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     akinobu.mita@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fault-inject: clean up debugfs file creation logic
Date:   Wed, 12 Jun 2019 11:58:28 +0200
Message-Id: <20190612095828.17936-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to check the return value of a debugfs_create_file
call, a caller should never change what they do depending on if debugfs
is working properly or not, so remove the checks, simplifying the logic
in the file a lot.

Also fix up the error check for debugfs_create_dir() which was not
returning NULL for an error, but rather a error pointer.

Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/fault-inject.c | 73 +++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 3cb21b2bf088..8186ca84910b 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -166,10 +166,10 @@ static int debugfs_ul_get(void *data, u64 *val)
 
 DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
 
-static struct dentry *debugfs_create_ul(const char *name, umode_t mode,
-				struct dentry *parent, unsigned long *value)
+static void debugfs_create_ul(const char *name, umode_t mode,
+			      struct dentry *parent, unsigned long *value)
 {
-	return debugfs_create_file(name, mode, parent, value, &fops_ul);
+	debugfs_create_file(name, mode, parent, value, &fops_ul);
 }
 
 #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
@@ -185,12 +185,11 @@ static int debugfs_stacktrace_depth_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
 			debugfs_stacktrace_depth_set, "%llu\n");
 
-static struct dentry *debugfs_create_stacktrace_depth(
-	const char *name, umode_t mode,
-	struct dentry *parent, unsigned long *value)
+static void debugfs_create_stacktrace_depth(const char *name, umode_t mode,
+					    struct dentry *parent,
+					    unsigned long *value)
 {
-	return debugfs_create_file(name, mode, parent, value,
-				   &fops_stacktrace_depth);
+	debugfs_create_file(name, mode, parent, value, &fops_stacktrace_depth);
 }
 
 #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
@@ -202,51 +201,31 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 	struct dentry *dir;
 
 	dir = debugfs_create_dir(name, parent);
-	if (!dir)
-		return ERR_PTR(-ENOMEM);
-
-	if (!debugfs_create_ul("probability", mode, dir, &attr->probability))
-		goto fail;
-	if (!debugfs_create_ul("interval", mode, dir, &attr->interval))
-		goto fail;
-	if (!debugfs_create_atomic_t("times", mode, dir, &attr->times))
-		goto fail;
-	if (!debugfs_create_atomic_t("space", mode, dir, &attr->space))
-		goto fail;
-	if (!debugfs_create_ul("verbose", mode, dir, &attr->verbose))
-		goto fail;
-	if (!debugfs_create_u32("verbose_ratelimit_interval_ms", mode, dir,
-				&attr->ratelimit_state.interval))
-		goto fail;
-	if (!debugfs_create_u32("verbose_ratelimit_burst", mode, dir,
-				&attr->ratelimit_state.burst))
-		goto fail;
-	if (!debugfs_create_bool("task-filter", mode, dir, &attr->task_filter))
-		goto fail;
+	if (IS_ERR(dir))
+		return dir;
+
+	debugfs_create_ul("probability", mode, dir, &attr->probability);
+	debugfs_create_ul("interval", mode, dir, &attr->interval);
+	debugfs_create_atomic_t("times", mode, dir, &attr->times);
+	debugfs_create_atomic_t("space", mode, dir, &attr->space);
+	debugfs_create_ul("verbose", mode, dir, &attr->verbose);
+	debugfs_create_u32("verbose_ratelimit_interval_ms", mode, dir,
+			   &attr->ratelimit_state.interval);
+	debugfs_create_u32("verbose_ratelimit_burst", mode, dir,
+			   &attr->ratelimit_state.burst);
+	debugfs_create_bool("task-filter", mode, dir, &attr->task_filter);
 
 #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
-
-	if (!debugfs_create_stacktrace_depth("stacktrace-depth", mode, dir,
-				&attr->stacktrace_depth))
-		goto fail;
-	if (!debugfs_create_ul("require-start", mode, dir,
-				&attr->require_start))
-		goto fail;
-	if (!debugfs_create_ul("require-end", mode, dir, &attr->require_end))
-		goto fail;
-	if (!debugfs_create_ul("reject-start", mode, dir, &attr->reject_start))
-		goto fail;
-	if (!debugfs_create_ul("reject-end", mode, dir, &attr->reject_end))
-		goto fail;
-
+	debugfs_create_stacktrace_depth("stacktrace-depth", mode, dir,
+					&attr->stacktrace_depth);
+	debugfs_create_ul("require-start", mode, dir, &attr->require_start);
+	debugfs_create_ul("require-end", mode, dir, &attr->require_end);
+	debugfs_create_ul("reject-start", mode, dir, &attr->reject_start);
+	debugfs_create_ul("reject-end", mode, dir, &attr->reject_end);
 #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
 
 	attr->dname = dget(dir);
 	return dir;
-fail:
-	debugfs_remove_recursive(dir);
-
-	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL_GPL(fault_create_debugfs_attr);
 
-- 
2.22.0

