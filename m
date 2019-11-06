Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDF8C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E521D7F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="k4jGG7GZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfKFCo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 21:44:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37882 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbfKFCo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 21:44:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id z24so11532399pgu.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 18:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSmJ0wuH4ZQI8dxqbp3iw/jPAFBBlQoY1aWhBRKrK+w=;
        b=k4jGG7GZ5IHSgDuA/PQlGInpwmgi466Uv+TZ3/0zGyX2MI2Zn6Bj7YIEFP2RnsHCjK
         Gcmnn19mbFxZLeTKDpGgRGq6oTf0LPMWkbZ8A0jyzsc3Gjh8TkVuPxX+imltJr0PVZvr
         Lxz7h10DhAVSXOkOrBkpLbgpwHK2IZIacN7eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSmJ0wuH4ZQI8dxqbp3iw/jPAFBBlQoY1aWhBRKrK+w=;
        b=LBnOtm/vtLG5iSVi2gonCthBY6RK51IOPf+9VmOREBIDIyY7IYTf99U9HF7AWt+m4a
         Rc9+h6kDPq2novOQEjbrUp+B9eQLHSrNiqT5KYqdGk7csHpXlZHvU0cXeYMXuJJZFtSv
         LCFc+JuBBw7/tQy79lKyJl230EsnXgz8BEfdKAUyqOY9wVpLeHt8N/MhLVncfpgikQcB
         6v/oANU9YkfNnz+7kGNHDH5m5UByvlV7et7xqTLQA5zoTawUsClpMobwTn2ISjGw9PY4
         P0lOIh9ke7gfRPuIsbSNoJEg9XYJA5qr7p1pUwzh2h3cVXIzz7xoxGyYDyLD4FF0D+Il
         eskQ==
X-Gm-Message-State: APjAAAXHASFDP1WpxJUJSsUIGxVtyeFzPAGNxyupnsOiOxu9t9lTcYOw
        Fa8Sb0hs0tOa/3dp/ke7T1neSwhvTsY=
X-Google-Smtp-Source: APXvYqyqLbhWq/w3O9r3GIC+QQQ1jLZp7H8ijRtbW72ZRwS/idm+Jf1u1OObqSoA9u/4e5iSDK1rVA==
X-Received: by 2002:a63:d44a:: with SMTP id i10mr92555pgj.105.1573008296693;
        Tue, 05 Nov 2019 18:44:56 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n62sm836902pjc.6.2019.11.05.18.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 18:44:56 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ioannis Ilkos <ilkos@google.com>, minchan@google.com,
        primiano@google.com, fmayer@google.com, hjd@google.com,
        joaodias@google.com, joelaf@google.com, lalitm@google.com,
        rslawik@google.com, sspatil@google.com, timmurray@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] rss_stat: Add support to detect RSS updates of external mm
Date:   Tue,  5 Nov 2019 21:44:51 -0500
Message-Id: <20191106024452.81923-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a process updates the RSS of a different process, the rss_stat
tracepoint appears in the context of the process doing the update. This
can confuse userspace that the RSS of process doing the update is
updated, while in reality a different process's RSS was updated.

This issue happens in reclaim paths such as with direct reclaim or
background reclaim.

This patch adds more information to the tracepoint about whether the mm
being updated belongs to the current process's context (curr field). We
also include a hash of the mm pointer so that the process who the mm
belongs to can be uniquely identified (mm_id field).

Also vsprintf.c is refactored a bit to allow reuse of hashing code.

Reported-by: Ioannis Ilkos <ilkos@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
Based on top of the commit in linux-next:
8342d836dc7c ("mm: emit tracepoint when RSS changes")

Google Bug: 140711541

Cc: minchan@google.com
Cc: primiano@google.com
Cc: ilkos@google.com
Cc: fmayer@google.com
Cc: hjd@google.com
Cc: joaodias@google.com
Cc: joelaf@google.com
Cc: lalitm@google.com
Cc: rslawik@google.com
Cc: sspatil@google.com
Cc: timmurray@google.com

 include/linux/mm.h          |  8 ++++----
 include/linux/string.h      |  2 ++
 include/trace/events/kmem.h | 32 +++++++++++++++++++++++++++++---
 lib/vsprintf.c              | 36 +++++++++++++++++++++++++-----------
 mm/memory.c                 |  4 ++--
 5 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 31d8cfb3d988..bfbe65ccffa3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1643,27 +1643,27 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 	return (unsigned long)val;
 }
 
-void mm_trace_rss_stat(int member, long count);
+void mm_trace_rss_stat(struct mm_struct *mm, int member, long count);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
 	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
 
-	mm_trace_rss_stat(member, count);
+	mm_trace_rss_stat(mm, member, count);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
 	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
 
-	mm_trace_rss_stat(member, count);
+	mm_trace_rss_stat(mm, member, count);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
 	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
 
-	mm_trace_rss_stat(member, count);
+	mm_trace_rss_stat(mm, member, count);
 }
 
 /* Optimized variant when page is already known not to be PageAnon */
diff --git a/include/linux/string.h b/include/linux/string.h
index f516cec5277c..6b0e950701d0 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -261,6 +261,8 @@ int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...) __printf(3, 4);
 extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
 				       const void *from, size_t available);
 
+int ptr_to_hashval(const void *ptr, unsigned long *hashval_out);
+
 /**
  * strstarts - does @str start with @prefix?
  * @str: string to examine
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 5a0666bfcf85..ad7e642bd497 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -316,24 +316,50 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+/*
+ * Required for uniquely and securely identifying mm in rss_stat tracepoint.
+ */
+#ifndef __PTR_TO_HASHVAL
+static unsigned int __maybe_unused mm_ptr_to_hash(const void *ptr)
+{
+	int ret;
+	unsigned long hashval;
+
+	ret = ptr_to_hashval(ptr, &hashval);
+	if (ret)
+		return 0;
+
+	/* The hashed value is only 32-bit */
+	return (unsigned int)hashval;
+}
+#define __PTR_TO_HASHVAL
+#endif
+
 TRACE_EVENT(rss_stat,
 
-	TP_PROTO(int member,
+	TP_PROTO(struct mm_struct *mm,
+		int member,
 		long count),
 
-	TP_ARGS(member, count),
+	TP_ARGS(mm, member, count),
 
 	TP_STRUCT__entry(
+		__field(unsigned int, mm_id)
+		__field(unsigned int, curr)
 		__field(int, member)
 		__field(long, size)
 	),
 
 	TP_fast_assign(
+		__entry->mm_id = mm_ptr_to_hash(mm);
+		__entry->curr = !!(current->mm == mm);
 		__entry->member = member;
 		__entry->size = (count << PAGE_SHIFT);
 	),
 
-	TP_printk("member=%d size=%ldB",
+	TP_printk("mm_id=%u curr=%d member=%d size=%ldB",
+		__entry->mm_id,
+		__entry->curr,
 		__entry->member,
 		__entry->size)
 	);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index dee8fc467fcf..401baaac1813 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -761,11 +761,34 @@ static int __init initialize_ptr_random(void)
 early_initcall(initialize_ptr_random);
 
 /* Maps a pointer to a 32 bit unique identifier. */
+int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
+{
+	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
+	unsigned long hashval;
+
+	if (static_branch_unlikely(&not_filled_random_ptr_key))
+		return -EAGAIN;
+
+#ifdef CONFIG_64BIT
+	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
+	/*
+	 * Mask off the first 32 bits, this makes explicit that we have
+	 * modified the address (and 32 bits is plenty for a unique ID).
+	 */
+	hashval = hashval & 0xffffffff;
+#else
+	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
+#endif
+	*hashval_out = hashval;
+	return 0;
+}
+
 static char *ptr_to_id(char *buf, char *end, const void *ptr,
 		       struct printf_spec spec)
 {
 	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
 	unsigned long hashval;
+	int ret;
 
 	/* When debugging early boot use non-cryptographically secure hash. */
 	if (unlikely(debug_boot_weak_hash)) {
@@ -773,22 +796,13 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 		return pointer_string(buf, end, (const void *)hashval, spec);
 	}
 
-	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
+	ret = ptr_to_hashval(ptr, &hashval);
+	if (ret) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
 		return error_string(buf, end, str, spec);
 	}
 
-#ifdef CONFIG_64BIT
-	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
-	/*
-	 * Mask off the first 32 bits, this makes explicit that we have
-	 * modified the address (and 32 bits is plenty for a unique ID).
-	 */
-	hashval = hashval & 0xffffffff;
-#else
-	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
-#endif
 	return pointer_string(buf, end, (const void *)hashval, spec);
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 7596d625ebd1..d3c9784e6dc1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -154,9 +154,9 @@ static int __init init_zero_pfn(void)
 }
 core_initcall(init_zero_pfn);
 
-void mm_trace_rss_stat(int member, long count)
+void mm_trace_rss_stat(struct mm_struct *mm, int member, long count)
 {
-	trace_rss_stat(member, count);
+	trace_rss_stat(mm, member, count);
 }
 
 #if defined(SPLIT_RSS_COUNTING)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
