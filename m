Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE3BC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2431F2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkbMLZEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgAGQcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:32:41 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:39237 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgAGQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:32:40 -0500
Received: by mail-wm1-f73.google.com with SMTP id t16so54596wmt.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fb41PwBszVzphy7ivShzNkn2ANS2zPkBPktoauw+T4w=;
        b=hkbMLZEK/bDJXE9PJ8Iq19V0o7Jco3Q7mgOf8eP4soGV5xlPCb7SoKvyOaq1hDxagl
         OTk7/5AJU4xP91TBuEcIX0OanED1fDopYrkgyJTUulUBiJffBB2Y319qFEJkTdR+9EmB
         3zSMSbFYkrmCtyayMC8GUT7iVqjSCU0E3YsduDT6gflN2lexsr8xgqE9deatlm/maC1M
         g5RLA9Wq6R+dWmwQpIl3DBDL1ssqeQLvpc3zPtkV5ffbhRXKvU8p/P+SXzDWRVW1h7/f
         UfPa/6l9/XvUpf4IiPt4Sf0jhhjsR2SGrgzQylddIOFvfExZSzlpfrMZDCQIb7ertKDV
         ccsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fb41PwBszVzphy7ivShzNkn2ANS2zPkBPktoauw+T4w=;
        b=eaeNonDQkcvIROYiGbqO8YluazdthCRA9/lqWAycdfL7QF85JiA4yh6X31UdCC8+sZ
         ec08Tz2ekqbUOH31l4YbZj73+HfDNkP8XN56kbI5nWBTwnwxQvLwUmMSEVU4lwTmTWts
         7z1iBEicwhIfDqzMIO+KylSDdnPZKcN2cFv8yHUj3VlLt/VQ8vT9LO9RKf/rUYykBlWd
         lqsBsalk25YsUEAxqhZ+JM1r3SdIUqOmV7l2ayr7NatL3nSjHHbEK6eqZo4eC78eZVPU
         FPLjojkNjliQ3Cw1MBxaWw+z2wn4Dpv0RkDwY9LG/g98lKlSQknbrf3Zwo4cPEV9o8hg
         W36Q==
X-Gm-Message-State: APjAAAWoRdY4+fcR23KLfC9MZqrMFiEaHJSqO7Nz8ToWKGQLu+BmU5Gw
        vVrGG/jcv/YHdwMHyooUlDstdBj9TA==
X-Google-Smtp-Source: APXvYqxPz/5ZS1murJZOXAcpH2HkfRGetrAeAXMwKRp8uMBMvQAgdI8hwnJboW6pdOGVYRBhg9FfCPOCrQ==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr109864131wrx.66.1578414757306;
 Tue, 07 Jan 2020 08:32:37 -0800 (PST)
Date:   Tue,  7 Jan 2020 17:31:04 +0100
Message-Id: <20200107163104.143542-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH RESEND -rcu] kcsan: Prefer __always_inline for fast-path
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
Rebased against -rcu/dev branch.

---
 kernel/kcsan/atomic.h   |  2 +-
 kernel/kcsan/core.c     | 18 +++++++++---------
 kernel/kcsan/encoding.h | 14 +++++++-------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index 576e03ddd6a3..a9c193053491 100644
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
index 3314fc29e236..4d4ab5c5dc53 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -78,10 +78,10 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
  */
 static DEFINE_PER_CPU(long, kcsan_skip);
 
-static inline atomic_long_t *find_watchpoint(unsigned long addr,
-					     size_t size,
-					     bool expect_write,
-					     long *encoded_watchpoint)
+static __always_inline atomic_long_t *find_watchpoint(unsigned long addr,
+						      size_t size,
+						      bool expect_write,
+						      long *encoded_watchpoint)
 {
 	const int slot = watchpoint_slot(addr);
 	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
@@ -146,7 +146,7 @@ insert_watchpoint(unsigned long addr, size_t size, bool is_write)
  *	2. the thread that set up the watchpoint already removed it;
  *	3. the watchpoint was removed and then re-used.
  */
-static inline bool
+static __always_inline bool
 try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
 {
 	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
@@ -160,7 +160,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
 	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
 }
 
-static inline struct kcsan_ctx *get_ctx(void)
+static __always_inline struct kcsan_ctx *get_ctx(void)
 {
 	/*
 	 * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
@@ -169,7 +169,7 @@ static inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
-static inline bool is_atomic(const volatile void *ptr)
+static __always_inline bool is_atomic(const volatile void *ptr)
 {
 	struct kcsan_ctx *ctx = get_ctx();
 
@@ -193,7 +193,7 @@ static inline bool is_atomic(const volatile void *ptr)
 	return kcsan_is_atomic(ptr);
 }
 
-static inline bool should_watch(const volatile void *ptr, int type)
+static __always_inline bool should_watch(const volatile void *ptr, int type)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -226,7 +226,7 @@ static inline void reset_kcsan_skip(void)
 	this_cpu_write(kcsan_skip, skip_count);
 }
 
-static inline bool kcsan_is_enabled(void)
+static __always_inline bool kcsan_is_enabled(void)
 {
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
 }
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index b63890e86449..f03562aaf2eb 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -59,10 +59,10 @@ encode_watchpoint(unsigned long addr, size_t size, bool is_write)
 		      (addr & WATCHPOINT_ADDR_MASK));
 }
 
-static inline bool decode_watchpoint(long watchpoint,
-				     unsigned long *addr_masked,
-				     size_t *size,
-				     bool *is_write)
+static __always_inline bool decode_watchpoint(long watchpoint,
+					      unsigned long *addr_masked,
+					      size_t *size,
+					      bool *is_write)
 {
 	if (watchpoint == INVALID_WATCHPOINT ||
 	    watchpoint == CONSUMED_WATCHPOINT)
@@ -78,13 +78,13 @@ static inline bool decode_watchpoint(long watchpoint,
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

