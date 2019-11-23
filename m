Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A148C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835EF20720
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKWSMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfKWSMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDE4E20719;
        Sat, 23 Nov 2019 18:12:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZtg-000ExL-UM; Sat, 23 Nov 2019 13:12:40 -0500
Message-Id: <20191123181240.819461375@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:11:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [for-next][PATCH 01/10] ftrace: Add a helper function to modify_ftrace_direct() to allow arch
 optimization
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a direct ftrace callback is at a location that does not have any other
ftrace helpers attached to it, it is possible to simply just change the
text to call the new caller (if the architecture supports it). But this
requires special architecture code. Currently, modify_ftrace_direct() uses a
trick to add a stub ftrace callback to the location forcing it to call the
ftrace iterator. Then it can change the direct helper to call the new
function in C, and then remove the stub. Removing the stub will have the
location now call the new location that the direct helper is using.

The new helper function does the registering the stub trick, but is a weak
function, allowing an architecture to override it to do something a bit more
direct.

Link: https://lore.kernel.org/r/20191115215125.mbqv7taqnx376yed@ast-mbp.dhcp.thefacebook.com

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  21 +++++++-
 kernel/trace/ftrace.c  | 120 ++++++++++++++++++++++++++++++-----------
 2 files changed, 107 insertions(+), 34 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 73eb2e93593f..dfaa37e1943d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -246,12 +246,24 @@ static inline void ftrace_free_init_mem(void) { }
 static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
 #endif /* CONFIG_FUNCTION_TRACER */
 
+struct ftrace_func_entry {
+	struct hlist_node hlist;
+	unsigned long ip;
+	unsigned long direct; /* for direct lookup only */
+};
+
+struct dyn_ftrace;
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 extern int ftrace_direct_func_count;
 int register_ftrace_direct(unsigned long ip, unsigned long addr);
 int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
 int modify_ftrace_direct(unsigned long ip, unsigned long old_addr, unsigned long new_addr);
 struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr);
+int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
+				struct dyn_ftrace *rec,
+				unsigned long old_addr,
+				unsigned long new_addr);
 #else
 # define ftrace_direct_func_count 0
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
@@ -271,6 +283,13 @@ static inline struct ftrace_direct_func *ftrace_find_direct_func(unsigned long a
 {
 	return NULL;
 }
+static inline int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
+					      struct dyn_ftrace *rec,
+					      unsigned long old_addr,
+					      unsigned long new_addr)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
@@ -343,8 +362,6 @@ static inline void stack_tracer_enable(void) { }
 int ftrace_arch_code_modify_prepare(void);
 int ftrace_arch_code_modify_post_process(void);
 
-struct dyn_ftrace;
-
 enum ftrace_bug_type {
 	FTRACE_BUG_UNKNOWN,
 	FTRACE_BUG_INIT,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ef79c8393f53..caae523f4ef3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1020,12 +1020,6 @@ static bool update_all_ops;
 # error Dynamic ftrace depends on MCOUNT_RECORD
 #endif
 
-struct ftrace_func_entry {
-	struct hlist_node hlist;
-	unsigned long ip;
-	unsigned long direct; /* for direct lookup only */
-};
-
 struct ftrace_func_probe {
 	struct ftrace_probe_ops	*probe_ops;
 	struct ftrace_ops	ops;
@@ -5112,7 +5106,8 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
 
-static struct ftrace_func_entry *find_direct_entry(unsigned long *ip)
+static struct ftrace_func_entry *find_direct_entry(unsigned long *ip,
+						   struct dyn_ftrace **recp)
 {
 	struct ftrace_func_entry *entry;
 	struct dyn_ftrace *rec;
@@ -5132,6 +5127,9 @@ static struct ftrace_func_entry *find_direct_entry(unsigned long *ip)
 	/* Passed in ip just needs to be on the call site */
 	*ip = rec->ip;
 
+	if (recp)
+		*recp = rec;
+
 	return entry;
 }
 
@@ -5143,7 +5141,7 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 
 	mutex_lock(&direct_mutex);
 
-	entry = find_direct_entry(&ip);
+	entry = find_direct_entry(&ip, NULL);
 	if (!entry)
 		goto out_unlock;
 
@@ -5179,6 +5177,75 @@ static struct ftrace_ops stub_ops = {
 	.func		= ftrace_stub,
 };
 
+/**
+ * ftrace_modify_direct_caller - modify ftrace nop directly
+ * @entry: The ftrace hash entry of the direct helper for @rec
+ * @rec: The record representing the function site to patch
+ * @old_addr: The location that the site at @rec->ip currently calls
+ * @new_addr: The location that the site at @rec->ip should call
+ *
+ * An architecture may overwrite this function to optimize the
+ * changing of the direct callback on an ftrace nop location.
+ * This is called with the ftrace_lock mutex held, and no other
+ * ftrace callbacks are on the associated record (@rec). Thus,
+ * it is safe to modify the ftrace record, where it should be
+ * currently calling @old_addr directly, to call @new_addr.
+ *
+ * Safety checks should be made to make sure that the code at
+ * @rec->ip is currently calling @old_addr. And this must
+ * also update entry->direct to @new_addr.
+ */
+int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
+				       struct dyn_ftrace *rec,
+				       unsigned long old_addr,
+				       unsigned long new_addr)
+{
+	unsigned long ip = rec->ip;
+	int ret;
+
+	/*
+	 * The ftrace_lock was used to determine if the record
+	 * had more than one registered user to it. If it did,
+	 * we needed to prevent that from changing to do the quick
+	 * switch. But if it did not (only a direct caller was attached)
+	 * then this function is called. But this function can deal
+	 * with attached callers to the rec that we care about, and
+	 * since this function uses standard ftrace calls that take
+	 * the ftrace_lock mutex, we need to release it.
+	 */
+	mutex_unlock(&ftrace_lock);
+
+	/*
+	 * By setting a stub function at the same address, we force
+	 * the code to call the iterator and the direct_ops helper.
+	 * This means that @ip does not call the direct call, and
+	 * we can simply modify it.
+	 */
+	ret = ftrace_set_filter_ip(&stub_ops, ip, 0, 0);
+	if (ret)
+		goto out_lock;
+
+	ret = register_ftrace_function(&stub_ops);
+	if (ret) {
+		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
+		goto out_lock;
+	}
+
+	entry->direct = new_addr;
+
+	/*
+	 * By removing the stub, we put back the direct call, calling
+	 * the @new_addr.
+	 */
+	unregister_ftrace_function(&stub_ops);
+	ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
+
+ out_lock:
+	mutex_lock(&ftrace_lock);
+
+	return ret;
+}
+
 /**
  * modify_ftrace_direct - Modify an existing direct call to call something else
  * @ip: The instruction pointer to modify
@@ -5197,11 +5264,13 @@ int modify_ftrace_direct(unsigned long ip,
 			 unsigned long old_addr, unsigned long new_addr)
 {
 	struct ftrace_func_entry *entry;
+	struct dyn_ftrace *rec;
 	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
 
-	entry = find_direct_entry(&ip);
+	mutex_lock(&ftrace_lock);
+	entry = find_direct_entry(&ip, &rec);
 	if (!entry)
 		goto out_unlock;
 
@@ -5210,33 +5279,20 @@ int modify_ftrace_direct(unsigned long ip,
 		goto out_unlock;
 
 	/*
-	 * By setting a stub function at the same address, we force
-	 * the code to call the iterator and the direct_ops helper.
-	 * This means that @ip does not call the direct call, and
-	 * we can simply modify it.
+	 * If there's no other ftrace callback on the rec->ip location,
+	 * then it can be changed directly by the architecture.
+	 * If there is another caller, then we just need to change the
+	 * direct caller helper to point to @new_addr.
 	 */
-	ret = ftrace_set_filter_ip(&stub_ops, ip, 0, 0);
-	if (ret)
-		goto out_unlock;
-
-	ret = register_ftrace_function(&stub_ops);
-	if (ret) {
-		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
-		goto out_unlock;
+	if (ftrace_rec_count(rec) == 1) {
+		ret = ftrace_modify_direct_caller(entry, rec, old_addr, new_addr);
+	} else {
+		entry->direct = new_addr;
+		ret = 0;
 	}
 
-	entry->direct = new_addr;
-
-	/*
-	 * By removing the stub, we put back the direct call, calling
-	 * the @new_addr.
-	 */
-	unregister_ftrace_function(&stub_ops);
-	ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
-
-	ret = 0;
-
  out_unlock:
+	mutex_unlock(&ftrace_lock);
 	mutex_unlock(&direct_mutex);
 	return ret;
 }
-- 
2.24.0


