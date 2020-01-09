Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980A5C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625B82072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFVOVJQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgAIPXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:23:40 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:36922 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbgAIPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:23:40 -0500
Received: by mail-wr1-f73.google.com with SMTP id z14so3030565wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jq0KfymqHCwAzpI6yM9iLGY3LYJxpSimWAtJZq35DB8=;
        b=YFVOVJQJP7CmAnMj0nn4DvcX4+cZslPAELQzpObx7LA5SBjxFDEKYoXdEzpMGIkss+
         T6xL7TtuA1AlQukiKQH5UiuvhCDfhIFTWyMa2Jkxtu/mhl+Ig7aoKxIAeIO3MT2Omy1s
         sXRCYvQzlg6HFsrBBmYlgRrGCFiBfwsTls0Qosuc9O1gtG8/5RMSIoEyZ7tknwFbbvSP
         6WUJQHizLoh9/Vxg0hBtVru27cw0VWwycDDqDtPQjQkzMl2KC9HXyQHCRr7uYDKlB9wU
         fN52/INesG6BHD8S0070AWfZbMQfE43M8i9K5my8R00v0rR2V0zzfoWt7z7GcLyFWGDd
         Q/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jq0KfymqHCwAzpI6yM9iLGY3LYJxpSimWAtJZq35DB8=;
        b=QiXC4GxL7oNJCxJoB/jFwWO85ACmqMTP7slywzzMVB1eBfMvcciFSMqXdDv+hR1IcZ
         X7rpWIS0ufcj1vxiqQvBkrhHlxU31I+mACJxXRUNZu0oRIEfVHYPaBcMYVKAg2MVtIgy
         8FlfVVIqH6Y1kM9oDpf37v5yw6IOKXYuGhkiibo6NL18XWw7a82smoHn6xTB9JiAEq8m
         U+aepAuh99LUYIZXgAVquGTfd8AsjY/6O8RVKGxh1ywapQizXNRz5BFXSmoWL9WKXiRt
         Zi5AYM40NFTTipcBBUimdzVgFyyyZC2CcYpmGBqPhwpsBMeYYXTwDtXlLm9WH8ZvZbQH
         orsQ==
X-Gm-Message-State: APjAAAUKWNBAyOsGf0vImsoqhOrIPKcl4V/AXsqx/Hhbu4M1JWv5vCMk
        H7FV06pnOlK9V91x0dJcAe1tcStkhA==
X-Google-Smtp-Source: APXvYqzys0Aq7J3rw9uFa1ErL9c2LDkFrZ1G7Kx81b9kMrSo8jzx1hxanXicDl8+oux5z0SaF0dr0afkMw==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr11552160wrv.198.1578583417361;
 Thu, 09 Jan 2020 07:23:37 -0800 (PST)
Date:   Thu,  9 Jan 2020 16:23:21 +0100
In-Reply-To: <20200109152322.104466-1-elver@google.com>
Message-Id: <20200109152322.104466-2-elver@google.com>
Mime-Version: 1.0
References: <20200109152322.104466-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH -rcu 1/2] kcsan: Show full access type in report
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support for showing the complete access type in the
report. Currently the following access types can be shown:
  "read", "read (marked)", "write", "write (marked)".

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c   | 15 ++++++++-------
 kernel/kcsan/kcsan.h  |  2 +-
 kernel/kcsan/report.c | 43 ++++++++++++++++++++++++++++---------------
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 4d4ab5c5dc53..87bf857c8893 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -255,7 +255,7 @@ static inline unsigned int get_delay(void)
 
 static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 					    size_t size,
-					    bool is_write,
+					    int type,
 					    atomic_long_t *watchpoint,
 					    long encoded_watchpoint)
 {
@@ -276,7 +276,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	flags = user_access_save();
 
 	if (consumed) {
-		kcsan_report(ptr, size, is_write, true, raw_smp_processor_id(),
+		kcsan_report(ptr, size, type, true, raw_smp_processor_id(),
 			     KCSAN_REPORT_CONSUMED_WATCHPOINT);
 	} else {
 		/*
@@ -292,8 +292,9 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 }
 
 static noinline void
-kcsan_setup_watchpoint(const volatile void *ptr, size_t size, bool is_write)
+kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 {
+	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
 	atomic_long_t *watchpoint;
 	union {
 		u8 _1;
@@ -415,13 +416,13 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, bool is_write)
 		 * No need to increment 'data_races' counter, as the racing
 		 * thread already did.
 		 */
-		kcsan_report(ptr, size, is_write, size > 8 || value_change,
+		kcsan_report(ptr, size, type, size > 8 || value_change,
 			     smp_processor_id(), KCSAN_REPORT_RACE_SIGNAL);
 	} else if (value_change) {
 		/* Inferring a race, since the value should not have changed. */
 		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN))
-			kcsan_report(ptr, size, is_write, true,
+			kcsan_report(ptr, size, type, true,
 				     smp_processor_id(),
 				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
 	}
@@ -455,10 +456,10 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 	 */
 
 	if (unlikely(watchpoint != NULL))
-		kcsan_found_watchpoint(ptr, size, is_write, watchpoint,
+		kcsan_found_watchpoint(ptr, size, type, watchpoint,
 				       encoded_watchpoint);
 	else if (unlikely(should_watch(ptr, type)))
-		kcsan_setup_watchpoint(ptr, size, is_write);
+		kcsan_setup_watchpoint(ptr, size, type);
 }
 
 /* === Public interface ===================================================== */
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index d3b9a96ac8a4..8492da45494b 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -103,7 +103,7 @@ enum kcsan_report_type {
 /*
  * Print a race report from thread that encountered the race.
  */
-extern void kcsan_report(const volatile void *ptr, size_t size, bool is_write,
+extern void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 			 bool value_change, int cpu_id, enum kcsan_report_type type);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 0eea05a3135b..9f503ca2ff7a 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -24,7 +24,7 @@
 static struct {
 	const volatile void	*ptr;
 	size_t			size;
-	bool			is_write;
+	int			access_type;
 	int			task_pid;
 	int			cpu_id;
 	unsigned long		stack_entries[NUM_STACK_ENTRIES];
@@ -41,8 +41,10 @@ static DEFINE_SPINLOCK(report_lock);
  * Special rules to skip reporting.
  */
 static bool
-skip_report(bool is_write, bool value_change, unsigned long top_frame)
+skip_report(int access_type, bool value_change, unsigned long top_frame)
 {
+	const bool is_write = (access_type & KCSAN_ACCESS_WRITE) != 0;
+
 	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) && is_write &&
 	    !value_change) {
 		/*
@@ -63,9 +65,20 @@ skip_report(bool is_write, bool value_change, unsigned long top_frame)
 	return kcsan_skip_report_debugfs(top_frame);
 }
 
-static inline const char *get_access_type(bool is_write)
+static const char *get_access_type(int type)
 {
-	return is_write ? "write" : "read";
+	switch (type) {
+	case 0:
+		return "read";
+	case KCSAN_ACCESS_ATOMIC:
+		return "read (marked)";
+	case KCSAN_ACCESS_WRITE:
+		return "write";
+	case KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "write (marked)";
+	default:
+		BUG();
+	}
 }
 
 /* Return thread description: in task or interrupt. */
@@ -112,7 +125,7 @@ static int sym_strcmp(void *addr1, void *addr2)
 /*
  * Returns true if a report was generated, false otherwise.
  */
-static bool print_report(const volatile void *ptr, size_t size, bool is_write,
+static bool print_report(const volatile void *ptr, size_t size, int access_type,
 			 bool value_change, int cpu_id,
 			 enum kcsan_report_type type)
 {
@@ -124,7 +137,7 @@ static bool print_report(const volatile void *ptr, size_t size, bool is_write,
 	/*
 	 * Must check report filter rules before starting to print.
 	 */
-	if (skip_report(is_write, true, stack_entries[skipnr]))
+	if (skip_report(access_type, true, stack_entries[skipnr]))
 		return false;
 
 	if (type == KCSAN_REPORT_RACE_SIGNAL) {
@@ -132,7 +145,7 @@ static bool print_report(const volatile void *ptr, size_t size, bool is_write,
 						other_info.num_stack_entries);
 
 		/* @value_change is only known for the other thread */
-		if (skip_report(other_info.is_write, value_change,
+		if (skip_report(other_info.access_type, value_change,
 				other_info.stack_entries[other_skipnr]))
 			return false;
 	}
@@ -170,7 +183,7 @@ static bool print_report(const volatile void *ptr, size_t size, bool is_write,
 	switch (type) {
 	case KCSAN_REPORT_RACE_SIGNAL:
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
-		       get_access_type(other_info.is_write), other_info.ptr,
+		       get_access_type(other_info.access_type), other_info.ptr,
 		       other_info.size, get_thread_desc(other_info.task_pid),
 		       other_info.cpu_id);
 
@@ -181,14 +194,14 @@ static bool print_report(const volatile void *ptr, size_t size, bool is_write,
 
 		pr_err("\n");
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
-		       get_access_type(is_write), ptr, size,
+		       get_access_type(access_type), ptr, size,
 		       get_thread_desc(in_task() ? task_pid_nr(current) : -1),
 		       cpu_id);
 		break;
 
 	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
 		pr_err("race at unknown origin, with %s to 0x%px of %zu bytes by %s on cpu %i:\n",
-		       get_access_type(is_write), ptr, size,
+		       get_access_type(access_type), ptr, size,
 		       get_thread_desc(in_task() ? task_pid_nr(current) : -1),
 		       cpu_id);
 		break;
@@ -223,7 +236,7 @@ static void release_report(unsigned long *flags, enum kcsan_report_type type)
  * required for the report type, simply acquires report_lock and returns true.
  */
 static bool prepare_report(unsigned long *flags, const volatile void *ptr,
-			   size_t size, bool is_write, int cpu_id,
+			   size_t size, int access_type, int cpu_id,
 			   enum kcsan_report_type type)
 {
 	if (type != KCSAN_REPORT_CONSUMED_WATCHPOINT &&
@@ -243,7 +256,7 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
 
 		other_info.ptr			= ptr;
 		other_info.size			= size;
-		other_info.is_write		= is_write;
+		other_info.access_type		= access_type;
 		other_info.task_pid		= in_task() ? task_pid_nr(current) : -1;
 		other_info.cpu_id		= cpu_id;
 		other_info.num_stack_entries	= stack_trace_save(other_info.stack_entries, NUM_STACK_ENTRIES, 1);
@@ -302,14 +315,14 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
 	goto retry;
 }
 
-void kcsan_report(const volatile void *ptr, size_t size, bool is_write,
+void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		  bool value_change, int cpu_id, enum kcsan_report_type type)
 {
 	unsigned long flags = 0;
 
 	kcsan_disable_current();
-	if (prepare_report(&flags, ptr, size, is_write, cpu_id, type)) {
-		if (print_report(ptr, size, is_write, value_change, cpu_id, type) && panic_on_warn)
+	if (prepare_report(&flags, ptr, size, access_type, cpu_id, type)) {
+		if (print_report(ptr, size, access_type, value_change, cpu_id, type) && panic_on_warn)
 			panic("panic_on_warn set ...\n");
 
 		release_report(&flags, type);
-- 
2.25.0.rc1.283.g88dfdc4193-goog

