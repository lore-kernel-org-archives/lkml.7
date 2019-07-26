Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25728C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD213218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMiv0WrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfGZLSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:18:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40697 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfGZLSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:18:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so36847407lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eMpGSpTyVsL6Rz4OXKaKpRlqsxTmfjaIt+u76FPKxs=;
        b=wMiv0WrDMfyZey+oa3BCO4vZEV5iVDpJ3HSnBDH532w+UrkqHjnECgSXxJZvKFt2WR
         GijF4Y9rs+qXtWmsOPx9uuONshsHlKJwsVyckNZq6MiN+bRv7RIq5CWXsjekPOBYYfC3
         7gkDpEjn0U9oRERcyFRssY9Z4Hmpj2o0l9FaKfqaXzn/Ur5Dme9MGqgeOz53TgUwOhou
         L5aFv9lCsFzoXYHv93Q2C7EHmHD4O0XErxFgGZ86iPYf559/1GwYkxjnmxtfr6tfIlpE
         E8lfRDRUD0nULJph/0C7slnh/vnM0VG/Zte1LOcX6LnhThwTI7heWVxW7SYPf10DLbLe
         i6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eMpGSpTyVsL6Rz4OXKaKpRlqsxTmfjaIt+u76FPKxs=;
        b=IjUi8aFwyUneCARxC5D0AgI9Pqv3mpHcr83+/MIBWfGPCEzzwEzQ1d2nzPNkPWPl9k
         9NZ5C+UnH08MEomqBAHzAY3Jqmi2hP9kf8jK91rF5PRG0WITLX9URJ0BAMGJ1i8MgUAq
         n1MMQ0NZ1SEr9TIs2Fsm0ds5BAkoKN5ICUdrFwbzeiZhAtqAN4x+k6eh/+BQOH07dUTk
         AteplZ1UxzXWiOQNIyE+rt+GaI1DfzmIFLk6O/giRhtWG4IgoeZ6GtS80szQIDfvUusj
         owoRyu9ruQVzwAv41N5fCa6PJMEjklYoQfUcYzeeU0rTj+e1GI/2eYn3PCNyL2ebDNb7
         bRPA==
X-Gm-Message-State: APjAAAVVy/vTEcWwa3FG3ttVbU6kklZZvvIFot4r2o5msYZH6CfRHteg
        hRxfV5x7Ak3hF8EiyORQJ870aw==
X-Google-Smtp-Source: APXvYqybQ8NJUC8Z2zEIWk2sQvm0BLowUtZT94IvnsRhTwC6rbMgx9euIW+Q0Ls1WYWUgMBMFLTS7g==
X-Received: by 2002:ac2:4a6e:: with SMTP id q14mr13120834lfp.154.1564139892685;
        Fri, 26 Jul 2019 04:18:12 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id s19sm9805925lji.38.2019.07.26.04.18.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:18:11 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3] seqlock: mark raw_read_seqcount and read_seqcount_retry as __always_inline
Date:   Fri, 26 Jul 2019 13:18:04 +0200
Message-Id: <20190726111804.18290-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the function graph tracer, each traced function calls sched_clock()
to take a timestamp. As sched_clock() uses
raw_read_seqcount()/read_seqcount_retry(), we must ensure that these
do not in turn trigger the graph tracer.
Both functions is marked as inline. However, if CONFIG_OPTIMIZE_INLINING
is set that may make the two functions tracable which they shouldn't.

Rework so that functions in seqlock.h are marked with __always_inline
since it can happen that other clocks can be utilized by the tracer, so
they will be inlined even if CONFIG_OPTIMIZE_INLINING is turned on.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 include/linux/seqlock.h | 86 +++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index bcf4cf26b8c8..fd202fd3db14 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -52,7 +52,7 @@ typedef struct seqcount {
 #endif
 } seqcount_t;
 
-static inline void __seqcount_init(seqcount_t *s, const char *name,
+static __always_inline void __seqcount_init(seqcount_t *s, const char *name,
 					  struct lock_class_key *key)
 {
 	/*
@@ -72,7 +72,7 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 		__seqcount_init((s), #s, &__key);	\
 	} while (0)
 
-static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
+static __always_inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 {
 	seqcount_t *l = (seqcount_t *)s;
 	unsigned long flags;
@@ -105,7 +105,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
  */
-static inline unsigned __read_seqcount_begin(const seqcount_t *s)
+static __always_inline unsigned __read_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret;
 
@@ -127,7 +127,7 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
  * seqcount without any lockdep checking and without checking or
  * masking the LSB. Calling code is responsible for handling that.
  */
-static inline unsigned raw_read_seqcount(const seqcount_t *s)
+static __always_inline unsigned raw_read_seqcount(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
@@ -143,7 +143,7 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
  * seqcount, but without any lockdep checking. Validity of the critical
  * section is tested by checking read_seqcount_retry function.
  */
-static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
+static __always_inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret = __read_seqcount_begin(s);
 	smp_rmb();
@@ -159,7 +159,7 @@ static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
  * Validity of the critical section is tested by checking read_seqcount_retry
  * function.
  */
-static inline unsigned read_seqcount_begin(const seqcount_t *s)
+static __always_inline unsigned read_seqcount_begin(const seqcount_t *s)
 {
 	seqcount_lockdep_reader_access(s);
 	return raw_read_seqcount_begin(s);
@@ -179,7 +179,7 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
  * read_seqcount_retry() instead of stabilizing at the beginning of the
  * critical section.
  */
-static inline unsigned raw_seqcount_begin(const seqcount_t *s)
+static __always_inline unsigned raw_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
@@ -200,7 +200,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  * Use carefully, only in critical code, and comment how the barrier is
  * provided.
  */
-static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
+static
+__always_inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	return unlikely(s->sequence != start);
 }
@@ -215,7 +216,8 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
  * If the critical section was invalid, it must be ignored (and typically
  * retried).
  */
-static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
+static
+__always_inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
 	return __read_seqcount_retry(s, start);
@@ -223,13 +225,13 @@ static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 
 
 
-static inline void raw_write_seqcount_begin(seqcount_t *s)
+static __always_inline void raw_write_seqcount_begin(seqcount_t *s)
 {
 	s->sequence++;
 	smp_wmb();
 }
 
-static inline void raw_write_seqcount_end(seqcount_t *s)
+static __always_inline void raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
@@ -269,14 +271,14 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *              X = false;
  *      }
  */
-static inline void raw_write_seqcount_barrier(seqcount_t *s)
+static __always_inline void raw_write_seqcount_barrier(seqcount_t *s)
 {
 	s->sequence++;
 	smp_wmb();
 	s->sequence++;
 }
 
-static inline int raw_read_seqcount_latch(seqcount_t *s)
+static __always_inline int raw_read_seqcount_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
 	int seq = READ_ONCE(s->sequence); /* ^^^ */
@@ -360,7 +362,7 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  * NOTE: When data is a dynamic data structure; one should use regular RCU
  *       patterns to manage the lifetimes of the objects within.
  */
-static inline void raw_write_seqcount_latch(seqcount_t *s)
+static __always_inline void raw_write_seqcount_latch(seqcount_t *s)
 {
        smp_wmb();      /* prior stores before incrementing "sequence" */
        s->sequence++;
@@ -371,18 +373,19 @@ static inline void raw_write_seqcount_latch(seqcount_t *s)
  * Sequence counter only version assumes that callers are using their
  * own mutexing.
  */
-static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
+static
+__always_inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
 	raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
-static inline void write_seqcount_begin(seqcount_t *s)
+static __always_inline void write_seqcount_begin(seqcount_t *s)
 {
 	write_seqcount_begin_nested(s, 0);
 }
 
-static inline void write_seqcount_end(seqcount_t *s)
+static __always_inline void write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, 1, _RET_IP_);
 	raw_write_seqcount_end(s);
@@ -395,7 +398,7 @@ static inline void write_seqcount_end(seqcount_t *s)
  * After write_seqcount_invalidate, no read-side seq operations will complete
  * successfully and see data older than this.
  */
-static inline void write_seqcount_invalidate(seqcount_t *s)
+static __always_inline void write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence+=2;
@@ -428,12 +431,13 @@ typedef struct {
 /*
  * Read side functions for starting and finalizing a read side section.
  */
-static inline unsigned read_seqbegin(const seqlock_t *sl)
+static __always_inline unsigned read_seqbegin(const seqlock_t *sl)
 {
 	return read_seqcount_begin(&sl->seqcount);
 }
 
-static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
+static
+__always_inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
 	return read_seqcount_retry(&sl->seqcount, start);
 }
@@ -443,43 +447,43 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
  * Acts like a normal spin_lock/unlock.
  * Don't need preempt_disable() because that is in the spin_lock already.
  */
-static inline void write_seqlock(seqlock_t *sl)
+static __always_inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
 	write_seqcount_begin(&sl->seqcount);
 }
 
-static inline void write_sequnlock(seqlock_t *sl)
+static __always_inline void write_sequnlock(seqlock_t *sl)
 {
 	write_seqcount_end(&sl->seqcount);
 	spin_unlock(&sl->lock);
 }
 
-static inline void write_seqlock_bh(seqlock_t *sl)
+static __always_inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
 	write_seqcount_begin(&sl->seqcount);
 }
 
-static inline void write_sequnlock_bh(seqlock_t *sl)
+static __always_inline void write_sequnlock_bh(seqlock_t *sl)
 {
 	write_seqcount_end(&sl->seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
-static inline void write_seqlock_irq(seqlock_t *sl)
+static __always_inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
 	write_seqcount_begin(&sl->seqcount);
 }
 
-static inline void write_sequnlock_irq(seqlock_t *sl)
+static __always_inline void write_sequnlock_irq(seqlock_t *sl)
 {
 	write_seqcount_end(&sl->seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
-static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
+static __always_inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 {
 	unsigned long flags;
 
@@ -491,7 +495,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 #define write_seqlock_irqsave(lock, flags)				\
 	do { flags = __write_seqlock_irqsave(lock); } while (0)
 
-static inline void
+static __always_inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
 	write_seqcount_end(&sl->seqcount);
@@ -503,12 +507,12 @@ write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
  * but doesn't update the sequence number. Acts like a normal spin_lock/unlock.
  * Don't need preempt_disable() because that is in the spin_lock already.
  */
-static inline void read_seqlock_excl(seqlock_t *sl)
+static __always_inline void read_seqlock_excl(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
 }
 
-static inline void read_sequnlock_excl(seqlock_t *sl)
+static __always_inline void read_sequnlock_excl(seqlock_t *sl)
 {
 	spin_unlock(&sl->lock);
 }
@@ -523,7 +527,7 @@ static inline void read_sequnlock_excl(seqlock_t *sl)
  * whether to be a reader (even) or writer (odd).
  * N.B. seq must be initialized to an even number to begin with.
  */
-static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
+static __always_inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
 {
 	if (!(*seq & 1))	/* Even */
 		*seq = read_seqbegin(lock);
@@ -531,38 +535,38 @@ static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
 		read_seqlock_excl(lock);
 }
 
-static inline int need_seqretry(seqlock_t *lock, int seq)
+static __always_inline int need_seqretry(seqlock_t *lock, int seq)
 {
 	return !(seq & 1) && read_seqretry(lock, seq);
 }
 
-static inline void done_seqretry(seqlock_t *lock, int seq)
+static __always_inline void done_seqretry(seqlock_t *lock, int seq)
 {
 	if (seq & 1)
 		read_sequnlock_excl(lock);
 }
 
-static inline void read_seqlock_excl_bh(seqlock_t *sl)
+static __always_inline void read_seqlock_excl_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
 }
 
-static inline void read_sequnlock_excl_bh(seqlock_t *sl)
+static __always_inline void read_sequnlock_excl_bh(seqlock_t *sl)
 {
 	spin_unlock_bh(&sl->lock);
 }
 
-static inline void read_seqlock_excl_irq(seqlock_t *sl)
+static __always_inline void read_seqlock_excl_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
 }
 
-static inline void read_sequnlock_excl_irq(seqlock_t *sl)
+static __always_inline void read_sequnlock_excl_irq(seqlock_t *sl)
 {
 	spin_unlock_irq(&sl->lock);
 }
 
-static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
+static __always_inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
 {
 	unsigned long flags;
 
@@ -573,13 +577,13 @@ static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
 #define read_seqlock_excl_irqsave(lock, flags)				\
 	do { flags = __read_seqlock_excl_irqsave(lock); } while (0)
 
-static inline void
+static __always_inline void
 read_sequnlock_excl_irqrestore(seqlock_t *sl, unsigned long flags)
 {
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
-static inline unsigned long
+static __always_inline unsigned long
 read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
 {
 	unsigned long flags = 0;
@@ -592,7 +596,7 @@ read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
 	return flags;
 }
 
-static inline void
+static __always_inline void
 done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 {
 	if (seq & 1)
-- 
2.20.1

