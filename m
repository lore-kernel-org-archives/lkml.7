Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796F8C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5546F20730
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfKQWSi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 17:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfKQWSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:18:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 894C920730;
        Sun, 17 Nov 2019 22:18:36 +0000 (UTC)
Date:   Sun, 17 Nov 2019 17:18:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH 1/2] ftrace: Add modify_ftrace_direct()
Message-ID: <20191117171835.35af6c0e@gandalf.local.home>
In-Reply-To: <20191115215125.mbqv7taqnx376yed@ast-mbp.dhcp.thefacebook.com>
References: <20191114194636.811109457@goodmis.org>
        <20191114194738.938540273@goodmis.org>
        <20191115215125.mbqv7taqnx376yed@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 13:51:26 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Thanks a lot for implementing it.
> Switching to iterator just to modify the call.. hmm.
> So "call direct_bpf_A" gets replaced to "call ftrace_stub" to do the iterator
> only to patch "call direct_bpf_B" later. I'm struggling to see why do that when
> arch can provide call to call rewrite easily. x86 and others have such ability
> already. I don't understand why you want to sacrifice simplicity here.
> Anyway with all 3 apis (register, modify, unreg) it looks complete.
> I'll start playing with it on Monday.

Now if you take my latest for-next branch, and add the patch below, you
can then implement a ftrace_modify_direct_caller() in x86 (or whatever
architecture you'd like), that does what you want. I encapsulated the
code such that the stub trick is for those that don't implement their
own modification.

-- Steve

From 6220daa748fcf9e7f6a12cad94ea50026571bda1 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Sun, 17 Nov 2019 17:04:15 -0500
Subject: [PATCH] ftrace: Add a helper function to modify_ftrace_direct() to
 allow arch optimization

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
 include/linux/ftrace.h |  18 +++++++
 kernel/trace/ftrace.c  | 120 ++++++++++++++++++++++++++++++-----------
 2 files changed, 106 insertions(+), 32 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 73eb2e93593f..ff89fd07a745 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -246,12 +246,23 @@ static inline void ftrace_free_init_mem(void) { }
 static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
 #endif /* CONFIG_FUNCTION_TRACER */
 
+struct ftrace_func_entry {
+	struct hlist_node hlist;
+	unsigned long ip;
+	unsigned long direct; /* for direct lookup only */
+};
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+struct dyn_ftrace;
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
@@ -271,6 +282,13 @@ static inline struct ftrace_direct_func *ftrace_find_direct_func(unsigned long a
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
2.20.1

