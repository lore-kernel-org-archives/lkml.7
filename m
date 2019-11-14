Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18FCC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C846720727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfKNSUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbfKNSS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B34520842;
        Thu, 14 Nov 2019 18:18:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhJ-00014B-DA; Thu, 14 Nov 2019 13:18:25 -0500
Message-Id: <20191114181825.285418286@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 13/33] ftrace/x86: Add a counter to test function_graph with direct
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As testing for direct calls from the function graph tracer adds a little
overhead (which is a lot when tracing every function), add a counter that
can be used to test if function_graph tracer needs to test for a direct
caller or not.

It would have been nicer if we could use a static branch, but the static
branch logic fails when used within the function graph tracer trampoline.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 8 +++++---
 include/linux/ftrace.h   | 2 ++
 kernel/trace/ftrace.c    | 4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index fef283f6341d..060a361d9d11 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -1049,9 +1049,11 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 	 * return address is actually off by one word, and we
 	 * need to adjust for that.
 	 */
-	if (ftrace_find_direct_func(self_addr + MCOUNT_INSN_SIZE)) {
-		self_addr = *parent;
-		parent++;
+	if (ftrace_direct_func_count) {
+		if (ftrace_find_direct_func(self_addr + MCOUNT_INSN_SIZE)) {
+			self_addr = *parent;
+			parent++;
+		}
 	}
 
 	/*
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 2bc7bd6b8387..55647e185141 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -247,10 +247,12 @@ static inline void ftrace_free_mem(struct module *mod, void *start, void *end) {
 #endif /* CONFIG_FUNCTION_TRACER */
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+extern int ftrace_direct_func_count;
 int register_ftrace_direct(unsigned long ip, unsigned long addr);
 int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
 struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr);
 #else
+# define ftrace_direct_func_count 0
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
 {
 	return -ENODEV;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c4446eabacbe..f9456346ec66 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2364,6 +2364,7 @@ ftrace_find_tramp_ops_new(struct dyn_ftrace *rec)
 /* Protected by rcu_tasks for reading, and direct_mutex for writing */
 static struct ftrace_hash *direct_functions = EMPTY_HASH;
 static DEFINE_MUTEX(direct_mutex);
+int ftrace_direct_func_count;
 
 /*
  * Search the direct_functions hash to see if the given instruction pointer
@@ -5056,6 +5057,7 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 		direct->addr = addr;
 		direct->count = 0;
 		list_add_rcu(&direct->next, &ftrace_direct_funcs);
+		ftrace_direct_func_count++;
 	}
 
 	entry->ip = ip;
@@ -5081,6 +5083,7 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 			if (free_hash)
 				free_ftrace_hash(free_hash);
 			free_hash = NULL;
+			ftrace_direct_func_count--;
 		}
 	} else {
 		if (!direct->count)
@@ -5141,6 +5144,7 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 			list_del_rcu(&direct->next);
 			synchronize_rcu_tasks();
 			kfree(direct);
+			ftrace_direct_func_count--;
 		}
 	}
  out_unlock:
-- 
2.23.0


