Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C78C341AD
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688802468B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3yH+STX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfLMUus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:50:48 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:42732 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:50:48 -0500
Received: by mail-wr1-f73.google.com with SMTP id k18so55612wrw.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 12:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a1jdZmOtDq0rK4AdE9X1BQB4Chvj4FuBPej3mFQLPjk=;
        b=N3yH+STXKEmVZwOd8g92yfolGIDrXCUyvbYfRMPZAV0cqzMv3RzlbLUjECmezVwRE1
         TD+cFnEv+q8T/zR17M5igH56fL8AqDcsV28wwcIxsRznFEFT01x+ZcHiDFQQ0zjk5Kcx
         ao0cRmV1K0FDKyhEFCyHHOMpRHDb4DunZ07J8LbfW2977dqimTRh9W7ODoEqHrBINtXA
         gvkh7ehEfkOWdr21Fich8iBDtuuJbUsPdlEXLMNVQmIYqVZQWZw9u8u3S51mNFy2xjgy
         dawByM65FGUp4mSHxHXgXS8YKaD+1UCjeBryVaBRLckUwjSalnXNce9aVaDdwjS89CTs
         s7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a1jdZmOtDq0rK4AdE9X1BQB4Chvj4FuBPej3mFQLPjk=;
        b=Wy/yZFODmX0GRUR5hFATtWYhTm/yACY39/UTjo38e5QH2noRc84819pvjkhp2erQPe
         4dYqywnG+InK+MwVTEpd6SvlWRqDwCeGSnBkdydukXOFVZhc2g6fNVxXOJw2WRJ8TjPB
         BUrIuxgczyRtSp/jmK3zAzfFnH/0NxWnrs8pIqsgrIqFSKRqfVbHqO9tcIL8VhUud6Su
         bobgfwG012OnS0YrDs8F9310OrGyqqwK2OuKsQDPwRN2wY70rRN8WZ6YtXzYrFPdlBRu
         svUkmw1/BwNwAjDxhmd4E1ktEHyWaZfvSspw+pxu/K9mclFm5w03j7CKPX3IOeQlDh8M
         bOvw==
X-Gm-Message-State: APjAAAVXLyGvIaPBvcjAuloou1WfJ5qd0UyvEqGRJKyK7NuL13znWIQH
        skJuONcoe1ECbqsgKsuBuni6xu8d6Q==
X-Google-Smtp-Source: APXvYqx27WCKFTuvpfsjZF17stOqrA2yK5nhL5kWsOcoNR7csS9CTHDYdUWqRHLRphrvfYDI7THqdFSD/w==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr15819986wrj.68.1576270243820;
 Fri, 13 Dec 2019 12:50:43 -0800 (PST)
Date:   Fri, 13 Dec 2019 21:49:46 +0100
Message-Id: <20191213204946.251125-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH RESEND -rcu/kcsan] kcsan: Prefer __always_inline for fast-path
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer __always_inline for fast-path functions that are called outside
of user_access_save, to avoid generating UACCESS warnings when
optimizing for size (CC_OPTIMIZE_FOR_SIZE). It will also avoid future
surprises with compiler versions that change the inlining heuristic even
when optimizing for performance.

Report: http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Marco Elver <elver@google.com>
---
Version rebased on -rcu/kcsan.

There are 3 locations that would conflict with the style cleanup in
-tip/locking/kcsan:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/kcsan&id=5cbaefe9743bf14c9d3106db0cc19f8cb0a3ca22

For the conflicting locations the better style is carried over, so that
upon eventual merge the resolution should be trivial.
---
 kernel/kcsan/atomic.h   |  2 +-
 kernel/kcsan/core.c     | 17 ++++++++---------
 kernel/kcsan/encoding.h | 11 +++++------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index c9c3fe628011..466e6777533e 100644
--- a/kernel/kcsan/atomic.h
+++ b/kernel/kcsan/atomic.h
@@ -18,7 +18,7 @@
  * than cast to volatile. Eventually, we hope to be able to remove this
  * function.
  */
-static inline bool kcsan_is_atomic(const volatile void *ptr)
+static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
 {
 	/* only jiffies for now */
 	return ptr == &jiffies;
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index d9410d58c93e..69870645b631 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -78,9 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS - 1];
  */
 static DEFINE_PER_CPU(long, kcsan_skip);
 
-static inline atomic_long_t *find_watchpoint(unsigned long addr, size_t size,
-					     bool expect_write,
-					     long *encoded_watchpoint)
+static __always_inline atomic_long_t *
+find_watchpoint(unsigned long addr, size_t size, bool expect_write, long *encoded_watchpoint)
 {
 	const int slot = watchpoint_slot(addr);
 	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
@@ -150,8 +149,8 @@ static inline atomic_long_t *insert_watchpoint(unsigned long addr, size_t size,
  *	2. the thread that set up the watchpoint already removed it;
  *	3. the watchpoint was removed and then re-used.
  */
-static inline bool try_consume_watchpoint(atomic_long_t *watchpoint,
-					  long encoded_watchpoint)
+static __always_inline bool
+try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
 {
 	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint,
 					       CONSUMED_WATCHPOINT);
@@ -166,7 +165,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
 	       CONSUMED_WATCHPOINT;
 }
 
-static inline struct kcsan_ctx *get_ctx(void)
+static __always_inline struct kcsan_ctx *get_ctx(void)
 {
 	/*
 	 * In interrupt, use raw_cpu_ptr to avoid unnecessary checks, that would
@@ -175,7 +174,7 @@ static inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
-static inline bool is_atomic(const volatile void *ptr)
+static __always_inline bool is_atomic(const volatile void *ptr)
 {
 	struct kcsan_ctx *ctx = get_ctx();
 
@@ -199,7 +198,7 @@ static inline bool is_atomic(const volatile void *ptr)
 	return kcsan_is_atomic(ptr);
 }
 
-static inline bool should_watch(const volatile void *ptr, int type)
+static __always_inline bool should_watch(const volatile void *ptr, int type)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -232,7 +231,7 @@ static inline void reset_kcsan_skip(void)
 	this_cpu_write(kcsan_skip, skip_count);
 }
 
-static inline bool kcsan_is_enabled(void)
+static __always_inline bool kcsan_is_enabled(void)
 {
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
 }
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index e17bdac0e54b..e527e83ce825 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -58,9 +58,8 @@ static inline long encode_watchpoint(unsigned long addr, size_t size,
 		      (addr & WATCHPOINT_ADDR_MASK));
 }
 
-static inline bool decode_watchpoint(long watchpoint,
-				     unsigned long *addr_masked, size_t *size,
-				     bool *is_write)
+static __always_inline bool
+decode_watchpoint(long watchpoint, unsigned long *addr_masked, size_t *size, bool *is_write)
 {
 	if (watchpoint == INVALID_WATCHPOINT ||
 	    watchpoint == CONSUMED_WATCHPOINT)
@@ -77,13 +76,13 @@ static inline bool decode_watchpoint(long watchpoint,
 /*
  * Return watchpoint slot for an address.
  */
-static inline int watchpoint_slot(unsigned long addr)
+static __always_inline int watchpoint_slot(unsigned long addr)
 {
 	return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
 }
 
-static inline bool matching_access(unsigned long addr1, size_t size1,
-				   unsigned long addr2, size_t size2)
+static __always_inline bool matching_access(unsigned long addr1, size_t size1,
+					    unsigned long addr2, size_t size2)
 {
 	unsigned long end_range1 = addr1 + size1 - 1;
 	unsigned long end_range2 = addr2 + size2 - 1;
-- 
2.24.1.735.g03f4e72817-goog

