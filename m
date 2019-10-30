Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAF4CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5922173E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572445858;
	bh=GQjoAf12zgaAxxf9JUvMUR8DRoufvj0ODUV8LEen+fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PScd38gUzReXd3sHP/dZRqZFrHAReABX79tMKujSGAE0wtRKLzSHREb7TQIe5D0oP
	 zgFxhYtgsE8gVTDFGHnzMHODiEMnLmvIxndTDDJLHoP8Y8BxfK0XNzLPxdUlcA/vyB
	 7w7ju4vT6TmxuUv/LYgVN6k/iJfitdjAs/8Sacoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfJ3Oa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfJ3Oay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:30:54 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D2A9208E3;
        Wed, 30 Oct 2019 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572445854;
        bh=GQjoAf12zgaAxxf9JUvMUR8DRoufvj0ODUV8LEen+fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbXeVnvCQ/zVTih8+8quNjeyYNTaVRLcE3JJ3codtMjHBXnGTuGPVn9lxSa3IfAHQ
         A2htVn2nyMzC2la/kIR434VBzNB9ofqerCHXxrfjofBxtzRrqZVSPOVx32fFLz+dMC
         AYOgB9a5djG5YHBfzdNDshmbxf2jFucFXIgvn9YI=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v4 05/10] lib/refcount: Improve performance of generic REFCOUNT_FULL code
Date:   Wed, 30 Oct 2019 14:30:30 +0000
Message-Id: <20191030143035.19440-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030143035.19440-1-will@kernel.org>
References: <20191030143035.19440-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite the generic REFCOUNT_FULL implementation so that the saturation
point is moved to INT_MIN / 2. This allows us to defer the sanity checks
until after the atomic operation, which removes many uses of cmpxchg()
in favour of atomic_fetch_{add,sub}().

Some crude perf results obtained from lkdtm show substantially less
overhead, despite the checking:

 $ perf stat -r 3 -B -- echo {ATOMIC,REFCOUNT}_TIMING >/sys/kernel/debug/provoke-crash/DIRECT

 # arm64
 ATOMIC_TIMING:                                      46.50451 +- 0.00134 seconds time elapsed  ( +-  0.00% )
 REFCOUNT_TIMING (REFCOUNT_FULL, mainline):          77.57522 +- 0.00982 seconds time elapsed  ( +-  0.01% )
 REFCOUNT_TIMING (REFCOUNT_FULL, this series):       48.7181 +- 0.0256 seconds time elapsed  ( +-  0.05% )

 # x86
 ATOMIC_TIMING:                                      31.6225 +- 0.0776 seconds time elapsed  ( +-  0.25% )
 REFCOUNT_TIMING (!REFCOUNT_FULL, mainline/x86 asm): 31.6689 +- 0.0901 seconds time elapsed  ( +-  0.28% )
 REFCOUNT_TIMING (REFCOUNT_FULL, mainline):          53.203 +- 0.138 seconds time elapsed  ( +-  0.26% )
 REFCOUNT_TIMING (REFCOUNT_FULL, this series):       31.7408 +- 0.0486 seconds time elapsed  ( +-  0.15% )

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Jan Glauber <jglauber@marvell.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/refcount.h | 131 ++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 56 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index e719b5b1220e..e3b218d669ce 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -47,8 +47,8 @@ static inline unsigned int refcount_read(const refcount_t *r)
 #ifdef CONFIG_REFCOUNT_FULL
 #include <linux/bug.h>
 
-#define REFCOUNT_MAX		(UINT_MAX - 1)
-#define REFCOUNT_SATURATED	UINT_MAX
+#define REFCOUNT_MAX		INT_MAX
+#define REFCOUNT_SATURATED	(INT_MIN / 2)
 
 /*
  * Variant of atomic_t specialized for reference counts.
@@ -56,9 +56,47 @@ static inline unsigned int refcount_read(const refcount_t *r)
  * The interface matches the atomic_t interface (to aid in porting) but only
  * provides the few functions one should use for reference counting.
  *
- * It differs in that the counter saturates at REFCOUNT_SATURATED and will not
- * move once there. This avoids wrapping the counter and causing 'spurious'
- * use-after-free issues.
+ * Saturation semantics
+ * ====================
+ *
+ * refcount_t differs from atomic_t in that the counter saturates at
+ * REFCOUNT_SATURATED and will not move once there. This avoids wrapping the
+ * counter and causing 'spurious' use-after-free issues. In order to avoid the
+ * cost associated with introducing cmpxchg() loops into all of the saturating
+ * operations, we temporarily allow the counter to take on an unchecked value
+ * and then explicitly set it to REFCOUNT_SATURATED on detecting that underflow
+ * or overflow has occurred. Although this is racy when multiple threads
+ * access the refcount concurrently, by placing REFCOUNT_SATURATED roughly
+ * equidistant from 0 and INT_MAX we minimise the scope for error:
+ *
+ * 	                           INT_MAX     REFCOUNT_SATURATED   UINT_MAX
+ *   0                          (0x7fff_ffff)    (0xc000_0000)    (0xffff_ffff)
+ *   +--------------------------------+----------------+----------------+
+ *                                     <---------- bad value! ---------->
+ *
+ * (in a signed view of the world, the "bad value" range corresponds to
+ * a negative counter value).
+ *
+ * As an example, consider a refcount_inc() operation that causes the counter
+ * to overflow:
+ *
+ * 	int old = atomic_fetch_add_relaxed(r);
+ *	// old is INT_MAX, refcount now INT_MIN (0x8000_0000)
+ *	if (old < 0)
+ *		atomic_set(r, REFCOUNT_SATURATED);
+ *
+ * If another thread also performs a refcount_inc() operation between the two
+ * atomic operations, then the count will continue to edge closer to 0. If it
+ * reaches a value of 1 before /any/ of the threads reset it to the saturated
+ * value, then a concurrent refcount_dec_and_test() may erroneously free the
+ * underlying object. Given the precise timing details involved with the
+ * round-robin scheduling of each thread manipulating the refcount and the need
+ * to hit the race multiple times in succession, there doesn't appear to be a
+ * practical avenue of attack even if using refcount_add() operations with
+ * larger increments.
+ *
+ * Memory ordering
+ * ===============
  *
  * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
  * and provide only what is strictly required for refcounts.
@@ -109,25 +147,19 @@ static inline unsigned int refcount_read(const refcount_t *r)
  */
 static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
 {
-	unsigned int new, val = atomic_read(&r->refs);
+	int old = refcount_read(r);
 
 	do {
-		if (!val)
-			return false;
-
-		if (unlikely(val == REFCOUNT_SATURATED))
-			return true;
-
-		new = val + i;
-		if (new < val)
-			new = REFCOUNT_SATURATED;
+		if (!old)
+			break;
+	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
 
-	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &val, new));
-
-	WARN_ONCE(new == REFCOUNT_SATURATED,
-		  "refcount_t: saturated; leaking memory.\n");
+	if (unlikely(old < 0 || old + i < 0)) {
+		refcount_set(r, REFCOUNT_SATURATED);
+		WARN_ONCE(1, "refcount_t: saturated; leaking memory.\n");
+	}
 
-	return true;
+	return old;
 }
 
 /**
@@ -148,7 +180,13 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
  */
 static inline void refcount_add(int i, refcount_t *r)
 {
-	WARN_ONCE(!refcount_add_not_zero(i, r), "refcount_t: addition on 0; use-after-free.\n");
+	int old = atomic_fetch_add_relaxed(i, &r->refs);
+
+	WARN_ONCE(!old, "refcount_t: addition on 0; use-after-free.\n");
+	if (unlikely(old <= 0 || old + i <= 0)) {
+		refcount_set(r, REFCOUNT_SATURATED);
+		WARN_ONCE(old, "refcount_t: saturated; leaking memory.\n");
+	}
 }
 
 /**
@@ -166,23 +204,7 @@ static inline void refcount_add(int i, refcount_t *r)
  */
 static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
 {
-	unsigned int new, val = atomic_read(&r->refs);
-
-	do {
-		new = val + 1;
-
-		if (!val)
-			return false;
-
-		if (unlikely(!new))
-			return true;
-
-	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &val, new));
-
-	WARN_ONCE(new == REFCOUNT_SATURATED,
-		  "refcount_t: saturated; leaking memory.\n");
-
-	return true;
+	return refcount_add_not_zero(1, r);
 }
 
 /**
@@ -199,7 +221,7 @@ static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
  */
 static inline void refcount_inc(refcount_t *r)
 {
-	WARN_ONCE(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
+	refcount_add(1, r);
 }
 
 /**
@@ -224,26 +246,19 @@ static inline void refcount_inc(refcount_t *r)
  */
 static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
 {
-	unsigned int new, val = atomic_read(&r->refs);
-
-	do {
-		if (unlikely(val == REFCOUNT_SATURATED))
-			return false;
+	int old = atomic_fetch_sub_release(i, &r->refs);
 
-		new = val - i;
-		if (new > val) {
-			WARN_ONCE(new > val, "refcount_t: underflow; use-after-free.\n");
-			return false;
-		}
-
-	} while (!atomic_try_cmpxchg_release(&r->refs, &val, new));
-
-	if (!new) {
+	if (old == i) {
 		smp_acquire__after_ctrl_dep();
 		return true;
 	}
-	return false;
 
+	if (unlikely(old < 0 || old - i < 0)) {
+		refcount_set(r, REFCOUNT_SATURATED);
+		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
+	}
+
+	return false;
 }
 
 /**
@@ -276,9 +291,13 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
  */
 static inline void refcount_dec(refcount_t *r)
 {
-	WARN_ONCE(refcount_dec_and_test(r), "refcount_t: decrement hit 0; leaking memory.\n");
-}
+	int old = atomic_fetch_sub_release(1, &r->refs);
 
+	if (unlikely(old <= 1)) {
+		refcount_set(r, REFCOUNT_SATURATED);
+		WARN_ONCE(1, "refcount_t: decrement hit 0; leaking memory.\n");
+	}
+}
 #else /* CONFIG_REFCOUNT_FULL */
 
 #define REFCOUNT_MAX		INT_MAX
-- 
2.24.0.rc0.303.g954a862665-goog

