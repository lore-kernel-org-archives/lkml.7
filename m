Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69260C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DB720708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfKVLS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:18:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34681 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbfKVKsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iY6Tv-00034B-0r; Fri, 22 Nov 2019 11:48:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B3FBF1C1A6B;
        Fri, 22 Nov 2019 11:48:06 +0100 (CET)
Date:   Fri, 22 Nov 2019 10:48:06 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] seqlock, kcsan: Add annotations for KCSAN
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157441968666.21853.9839482924858141298.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     88ecd153be9519f259b87a9f6f4c8383a8b3bbf1
Gitweb:        https://git.kernel.org/tip/88ecd153be9519f259b87a9f6f4c8383a8b3bbf1
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 14 Nov 2019 19:02:59 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 16 Nov 2019 07:23:15 -08:00

seqlock, kcsan: Add annotations for KCSAN

Since seqlocks in the Linux kernel do not require the use of marked
atomic accesses in critical sections, we teach KCSAN to assume such
accesses are atomic. KCSAN currently also pretends that writes to
`sequence` are atomic, although currently plain writes are used (their
corresponding reads are READ_ONCE).

Further, to avoid false positives in the absence of clear ending of a
seqlock reader critical section (only when using the raw interface),
KCSAN assumes a fixed number of accesses after start of a seqlock
critical section are atomic.

=== Commentary on design around absence of clear begin/end markings ===
Seqlock usage via seqlock_t follows a predictable usage pattern, where
clear critical section begin/end is enforced. With subtle special cases
for readers needing to be flat atomic regions, e.g. because usage such
as in:
  - fs/namespace.c:__legitimize_mnt - unbalanced read_seqretry
  - fs/dcache.c:d_walk - unbalanced need_seqretry

But, anything directly accessing seqcount_t seems to be unpredictable.
Filtering for usage of read_seqcount_retry not following 'do { .. }
while (read_seqcount_retry(..));':

  $ git grep 'read_seqcount_retry' | grep -Ev 'while \(|seqlock.h|Doc|\* '
  => about 1/3 of the total read_seqcount_retry usage.

Just looking at fs/namei.c, we conclude that it is non-trivial to
prescribe and migrate to an interface that would force clear begin/end
seqlock markings for critical sections.

As such, we concluded that the best design currently, is to simply
ensure that KCSAN works well with the existing code.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/seqlock.h | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index bcf4cf2..61232bc 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -37,9 +37,25 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
+#include <linux/kcsan.h>
 #include <asm/processor.h>
 
 /*
+ * The seqlock interface does not prescribe a precise sequence of read
+ * begin/retry/end. For readers, typically there is a call to
+ * read_seqcount_begin() and read_seqcount_retry(), however, there are more
+ * esoteric cases which do not follow this pattern.
+ *
+ * As a consequence, we take the following best-effort approach for raw usage
+ * via seqcount_t under KCSAN: upon beginning a seq-reader critical section,
+ * pessimistically mark then next KCSAN_SEQLOCK_REGION_MAX memory accesses as
+ * atomics; if there is a matching read_seqcount_retry() call, no following
+ * memory operations are considered atomic. Usage of seqlocks via seqlock_t
+ * interface is not affected.
+ */
+#define KCSAN_SEQLOCK_REGION_MAX 1000
+
+/*
  * Version using sequence counter only.
  * This can be used when code has its own mutex protecting the
  * updating starting before the write_seqcountbeqin() and ending
@@ -115,6 +131,7 @@ repeat:
 		cpu_relax();
 		goto repeat;
 	}
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret;
 }
 
@@ -131,6 +148,7 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret;
 }
 
@@ -183,6 +201,7 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret & ~1;
 }
 
@@ -202,7 +221,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  */
 static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
-	return unlikely(s->sequence != start);
+	kcsan_atomic_next(0);
+	return unlikely(READ_ONCE(s->sequence) != start);
 }
 
 /**
@@ -225,6 +245,7 @@ static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 
 static inline void raw_write_seqcount_begin(seqcount_t *s)
 {
+	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 }
@@ -233,6 +254,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
+	kcsan_nestable_atomic_end();
 }
 
 /**
@@ -271,9 +293,11 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  */
 static inline void raw_write_seqcount_barrier(seqcount_t *s)
 {
+	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 	s->sequence++;
+	kcsan_nestable_atomic_end();
 }
 
 static inline int raw_read_seqcount_latch(seqcount_t *s)
@@ -398,7 +422,9 @@ static inline void write_seqcount_end(seqcount_t *s)
 static inline void write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
+	kcsan_nestable_atomic_begin();
 	s->sequence+=2;
+	kcsan_nestable_atomic_end();
 }
 
 typedef struct {
@@ -430,11 +456,21 @@ typedef struct {
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
-	return read_seqcount_begin(&sl->seqcount);
+	unsigned ret = read_seqcount_begin(&sl->seqcount);
+
+	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry */
+	kcsan_flat_atomic_begin();
+	return ret;
 }
 
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
+	/*
+	 * Assume not nested: read_seqretry may be called multiple times when
+	 * completing read critical section.
+	 */
+	kcsan_flat_atomic_end();
+
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 
