Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035CDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B290C2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfMouhbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfKZLmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:42:09 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:41016 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKZLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:42:08 -0500
Received: by mail-wm1-f73.google.com with SMTP id g8so1017561wmg.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 03:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UhG4TbrFQmzzMiP4BKNG5iQmKmV3aCdN4xUR1YDfRPM=;
        b=pfMouhbRCLequNThaZW7MP2Z9T7cZW3BKnMwxJsL/Kh33hHKRxn/F78Gm1njQTHRnk
         KPKlJb7aNIHx8AhmDhp3NVvPdJiP8ZSO8GoLlx3QnxmArmuKheHLqVczKsTG99mjwG7z
         wGdYhDx8WsQ18FMNCIMkZTQbDASXzHPVbonyNfjHslt3u6krRS6c/FtTpxOjXIkKsklW
         1Y38eay8DGsyakOW3mVoZTqmV33JJh5oT4UbmyKM4rFkSYwmoc+nKJTSbJb/E1cQC9Bu
         mR4EoFAy/cIWnONn5H3sbaoScdY84CRdDXQsk9kZ4ucdp9R//wc7ti2lGCwtCg0ILoup
         POVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UhG4TbrFQmzzMiP4BKNG5iQmKmV3aCdN4xUR1YDfRPM=;
        b=pJahgkwJZAdH9PD235i4RUoSQbcBHb/pMQe4g/BmhhmfsGOJpxA980TU/V37/lNJrc
         V8myCug+yP4o6LJwrn058xhhkv5FLKODKqR7KC6eK85opUUtR03NBdUmQJU//4u4HGGm
         7LNq7qV9Xllm0F59dcobmyNJN1DpmJ8vgg17kVZ3vVsnM3SXCVYSzORL3m/g8CZ+NzG3
         K0vfgLW4cVcQ8yLyqcni8yNKwVQSg/E8uacy/fvNi7CpqqYvfnpb7kBOCkT5IJEYond5
         T3yAJeAsiXlT1L6Yn5pBVnCxTq5cZJuTU/joF0JkfJKfTULHnXbVV1pClcp6fv0/uvkV
         ePKQ==
X-Gm-Message-State: APjAAAWySMsG/cOIrbyQTsXMWBVsx8HA2yB9Hq7V02o7eueNHh2924SL
        HPTnyGugoBuGwwO87+UaiLy+lF2zNA==
X-Google-Smtp-Source: APXvYqwoGV7i0r1gTEUR1Tl8FkRM0G/pJpFJdLS6qomEgLxb0fRD0Pw9med/N0AXUlQtVoxl6+iFeihPdA==
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr15855542wrs.200.1574768526170;
 Tue, 26 Nov 2019 03:42:06 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:41:21 +0100
In-Reply-To: <20191126114121.85552-1-elver@google.com>
Message-Id: <20191126114121.85552-3-elver@google.com>
Mime-Version: 1.0
References: <20191126114121.85552-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 3/3] kcsan: Prefer __always_inline for fast-path
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, dvyukov@google.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        mark.rutland@arm.com, paulmck@kernel.org,
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
Signed-off-by: Marco Elver <elver@google.com>
---
Rebased on: locking/kcsan branch of tip tree.
---
 kernel/kcsan/atomic.h   |  2 +-
 kernel/kcsan/core.c     | 16 +++++++---------
 kernel/kcsan/encoding.h | 14 +++++++-------
 3 files changed, 15 insertions(+), 17 deletions(-)

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
index 3314fc29e236..c616fec639cd 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -78,10 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
  */
 static DEFINE_PER_CPU(long, kcsan_skip);
 
-static inline atomic_long_t *find_watchpoint(unsigned long addr,
-					     size_t size,
-					     bool expect_write,
-					     long *encoded_watchpoint)
+static __always_inline atomic_long_t *
+find_watchpoint(unsigned long addr, size_t size, bool expect_write, long *encoded_watchpoint)
 {
 	const int slot = watchpoint_slot(addr);
 	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
@@ -146,7 +144,7 @@ insert_watchpoint(unsigned long addr, size_t size, bool is_write)
  *	2. the thread that set up the watchpoint already removed it;
  *	3. the watchpoint was removed and then re-used.
  */
-static inline bool
+static __always_inline bool
 try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
 {
 	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
@@ -160,7 +158,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
 	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
 }
 
-static inline struct kcsan_ctx *get_ctx(void)
+static __always_inline struct kcsan_ctx *get_ctx(void)
 {
 	/*
 	 * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
@@ -169,7 +167,7 @@ static inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
-static inline bool is_atomic(const volatile void *ptr)
+static __always_inline bool is_atomic(const volatile void *ptr)
 {
 	struct kcsan_ctx *ctx = get_ctx();
 
@@ -193,7 +191,7 @@ static inline bool is_atomic(const volatile void *ptr)
 	return kcsan_is_atomic(ptr);
 }
 
-static inline bool should_watch(const volatile void *ptr, int type)
+static __always_inline bool should_watch(const volatile void *ptr, int type)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -226,7 +224,7 @@ static inline void reset_kcsan_skip(void)
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
2.24.0.432.g9d3f5f5b63-goog

