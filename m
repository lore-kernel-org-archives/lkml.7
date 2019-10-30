Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065DBCA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCE421882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572445855;
	bh=VryC9xrmxkxMxWvRe4eojU5afQ2jsn+s9lDGLYs1mzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Agdbkvkdbfb91HbJOrMwb3S4zVDpqT2Rdnw2qWCeVM+plmvtwfuR+O8WWF02xgTQF
	 jzskmZDEwBU7XV/2E3Sjtsx+9K+P8rafAq7lkJwh58d6aTuD7wjKqViV2ljaulLvHA
	 MUvB/ZKwq+dsvqwTAyY1LuxVMKOEkblh5dkrJq5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfJ3Oay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfJ3Oax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:30:53 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C5D20874;
        Wed, 30 Oct 2019 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572445851;
        bh=VryC9xrmxkxMxWvRe4eojU5afQ2jsn+s9lDGLYs1mzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1ms+HhyhcUBFvjpCpWJ6pDrpph9WfIjZ9TOzmFEY9vCEwyxtFRMPQDuPcH9Lk1XE
         z7q82sbSvT797MEOrB/+U33jBsKSxImMJdjuUQvNLsMd8FHAo+WAXYCDUoejZkaHWW
         p5dzUnn3EbhNRW5qw7Q9Dk6ZXnnTKd4nb88ECn38=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v4 04/10] lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
Date:   Wed, 30 Oct 2019 14:30:29 +0000
Message-Id: <20191030143035.19440-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030143035.19440-1-will@kernel.org>
References: <20191030143035.19440-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to improve performance of the REFCOUNT_FULL implementation,
move the bulk of its functions into linux/refcount.h. This allows them
to be inlined in the same way as if they had been provided via
CONFIG_ARCH_HAS_REFCOUNT.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/refcount.h | 237 ++++++++++++++++++++++++++++++++++++--
 lib/refcount.c           | 238 +--------------------------------------
 2 files changed, 229 insertions(+), 246 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index edd505d1a23b..e719b5b1220e 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -45,22 +45,241 @@ static inline unsigned int refcount_read(const refcount_t *r)
 }
 
 #ifdef CONFIG_REFCOUNT_FULL
+#include <linux/bug.h>
 
 #define REFCOUNT_MAX		(UINT_MAX - 1)
 #define REFCOUNT_SATURATED	UINT_MAX
 
-extern __must_check bool refcount_add_not_zero(int i, refcount_t *r);
-extern void refcount_add(int i, refcount_t *r);
+/*
+ * Variant of atomic_t specialized for reference counts.
+ *
+ * The interface matches the atomic_t interface (to aid in porting) but only
+ * provides the few functions one should use for reference counting.
+ *
+ * It differs in that the counter saturates at REFCOUNT_SATURATED and will not
+ * move once there. This avoids wrapping the counter and causing 'spurious'
+ * use-after-free issues.
+ *
+ * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
+ * and provide only what is strictly required for refcounts.
+ *
+ * The increments are fully relaxed; these will not provide ordering. The
+ * rationale is that whatever is used to obtain the object we're increasing the
+ * reference count on will provide the ordering. For locked data structures,
+ * its the lock acquire, for RCU/lockless data structures its the dependent
+ * load.
+ *
+ * Do note that inc_not_zero() provides a control dependency which will order
+ * future stores against the inc, this ensures we'll never modify the object
+ * if we did not in fact acquire a reference.
+ *
+ * The decrements will provide release order, such that all the prior loads and
+ * stores will be issued before, it also provides a control dependency, which
+ * will order us against the subsequent free().
+ *
+ * The control dependency is against the load of the cmpxchg (ll/sc) that
+ * succeeded. This means the stores aren't fully ordered, but this is fine
+ * because the 1->0 transition indicates no concurrency.
+ *
+ * Note that the allocator is responsible for ordering things between free()
+ * and alloc().
+ *
+ * The decrements dec_and_test() and sub_and_test() also provide acquire
+ * ordering on success.
+ *
+ */
+
+/**
+ * refcount_add_not_zero - add a value to a refcount unless it is 0
+ * @i: the value to add to the refcount
+ * @r: the refcount
+ *
+ * Will saturate at REFCOUNT_SATURATED and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller has guaranteed the
+ * object memory to be stable (RCU, etc.). It does provide a control dependency
+ * and thereby orders future stores. See the comment on top.
+ *
+ * Use of this function is not recommended for the normal reference counting
+ * use case in which references are taken and released one at a time.  In these
+ * cases, refcount_inc(), or one of its variants, should instead be used to
+ * increment a reference count.
+ *
+ * Return: false if the passed refcount is 0, true otherwise
+ */
+static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
+{
+	unsigned int new, val = atomic_read(&r->refs);
+
+	do {
+		if (!val)
+			return false;
+
+		if (unlikely(val == REFCOUNT_SATURATED))
+			return true;
+
+		new = val + i;
+		if (new < val)
+			new = REFCOUNT_SATURATED;
+
+	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &val, new));
+
+	WARN_ONCE(new == REFCOUNT_SATURATED,
+		  "refcount_t: saturated; leaking memory.\n");
+
+	return true;
+}
+
+/**
+ * refcount_add - add a value to a refcount
+ * @i: the value to add to the refcount
+ * @r: the refcount
+ *
+ * Similar to atomic_add(), but will saturate at REFCOUNT_SATURATED and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller has guaranteed the
+ * object memory to be stable (RCU, etc.). It does provide a control dependency
+ * and thereby orders future stores. See the comment on top.
+ *
+ * Use of this function is not recommended for the normal reference counting
+ * use case in which references are taken and released one at a time.  In these
+ * cases, refcount_inc(), or one of its variants, should instead be used to
+ * increment a reference count.
+ */
+static inline void refcount_add(int i, refcount_t *r)
+{
+	WARN_ONCE(!refcount_add_not_zero(i, r), "refcount_t: addition on 0; use-after-free.\n");
+}
+
+/**
+ * refcount_inc_not_zero - increment a refcount unless it is 0
+ * @r: the refcount to increment
+ *
+ * Similar to atomic_inc_not_zero(), but will saturate at REFCOUNT_SATURATED
+ * and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller has guaranteed the
+ * object memory to be stable (RCU, etc.). It does provide a control dependency
+ * and thereby orders future stores. See the comment on top.
+ *
+ * Return: true if the increment was successful, false otherwise
+ */
+static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
+{
+	unsigned int new, val = atomic_read(&r->refs);
+
+	do {
+		new = val + 1;
 
-extern __must_check bool refcount_inc_not_zero(refcount_t *r);
-extern void refcount_inc(refcount_t *r);
+		if (!val)
+			return false;
 
-extern __must_check bool refcount_sub_and_test(int i, refcount_t *r);
+		if (unlikely(!new))
+			return true;
 
-extern __must_check bool refcount_dec_and_test(refcount_t *r);
-extern void refcount_dec(refcount_t *r);
+	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &val, new));
+
+	WARN_ONCE(new == REFCOUNT_SATURATED,
+		  "refcount_t: saturated; leaking memory.\n");
+
+	return true;
+}
+
+/**
+ * refcount_inc - increment a refcount
+ * @r: the refcount to increment
+ *
+ * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
+ *
+ * Provides no memory ordering, it is assumed the caller already has a
+ * reference on the object.
+ *
+ * Will WARN if the refcount is 0, as this represents a possible use-after-free
+ * condition.
+ */
+static inline void refcount_inc(refcount_t *r)
+{
+	WARN_ONCE(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
+}
+
+/**
+ * refcount_sub_and_test - subtract from a refcount and test if it is 0
+ * @i: amount to subtract from the refcount
+ * @r: the refcount
+ *
+ * Similar to atomic_dec_and_test(), but it will WARN, return false and
+ * ultimately leak on underflow and will fail to decrement when saturated
+ * at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides an acquire ordering on success such that free()
+ * must come after.
+ *
+ * Use of this function is not recommended for the normal reference counting
+ * use case in which references are taken and released one at a time.  In these
+ * cases, refcount_dec(), or one of its variants, should instead be used to
+ * decrement a reference count.
+ *
+ * Return: true if the resulting refcount is 0, false otherwise
+ */
+static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
+{
+	unsigned int new, val = atomic_read(&r->refs);
+
+	do {
+		if (unlikely(val == REFCOUNT_SATURATED))
+			return false;
+
+		new = val - i;
+		if (new > val) {
+			WARN_ONCE(new > val, "refcount_t: underflow; use-after-free.\n");
+			return false;
+		}
+
+	} while (!atomic_try_cmpxchg_release(&r->refs, &val, new));
+
+	if (!new) {
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+	return false;
+
+}
+
+/**
+ * refcount_dec_and_test - decrement a refcount and test if it is 0
+ * @r: the refcount
+ *
+ * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
+ * decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides an acquire ordering on success such that free()
+ * must come after.
+ *
+ * Return: true if the resulting refcount is 0, false otherwise
+ */
+static inline __must_check bool refcount_dec_and_test(refcount_t *r)
+{
+	return refcount_sub_and_test(1, r);
+}
+
+/**
+ * refcount_dec - decrement a refcount
+ * @r: the refcount
+ *
+ * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
+ * when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before.
+ */
+static inline void refcount_dec(refcount_t *r)
+{
+	WARN_ONCE(refcount_dec_and_test(r), "refcount_t: decrement hit 0; leaking memory.\n");
+}
 
-#else
+#else /* CONFIG_REFCOUNT_FULL */
 
 #define REFCOUNT_MAX		INT_MAX
 #define REFCOUNT_SATURATED	(INT_MIN / 2)
@@ -103,7 +322,7 @@ static inline void refcount_dec(refcount_t *r)
 	atomic_dec(&r->refs);
 }
 # endif /* !CONFIG_ARCH_HAS_REFCOUNT */
-#endif /* CONFIG_REFCOUNT_FULL */
+#endif /* !CONFIG_REFCOUNT_FULL */
 
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
diff --git a/lib/refcount.c b/lib/refcount.c
index a2f670998cee..3a534fbebdcc 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -1,41 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Variant of atomic_t specialized for reference counts.
- *
- * The interface matches the atomic_t interface (to aid in porting) but only
- * provides the few functions one should use for reference counting.
- *
- * It differs in that the counter saturates at REFCOUNT_SATURATED and will not
- * move once there. This avoids wrapping the counter and causing 'spurious'
- * use-after-free issues.
- *
- * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
- * and provide only what is strictly required for refcounts.
- *
- * The increments are fully relaxed; these will not provide ordering. The
- * rationale is that whatever is used to obtain the object we're increasing the
- * reference count on will provide the ordering. For locked data structures,
- * its the lock acquire, for RCU/lockless data structures its the dependent
- * load.
- *
- * Do note that inc_not_zero() provides a control dependency which will order
- * future stores against the inc, this ensures we'll never modify the object
- * if we did not in fact acquire a reference.
- *
- * The decrements will provide release order, such that all the prior loads and
- * stores will be issued before, it also provides a control dependency, which
- * will order us against the subsequent free().
- *
- * The control dependency is against the load of the cmpxchg (ll/sc) that
- * succeeded. This means the stores aren't fully ordered, but this is fine
- * because the 1->0 transition indicates no concurrency.
- *
- * Note that the allocator is responsible for ordering things between free()
- * and alloc().
- *
- * The decrements dec_and_test() and sub_and_test() also provide acquire
- * ordering on success.
- *
+ * Out-of-line refcount functions common to all refcount implementations.
  */
 
 #include <linux/mutex.h>
@@ -43,207 +8,6 @@
 #include <linux/spinlock.h>
 #include <linux/bug.h>
 
-#ifdef CONFIG_REFCOUNT_FULL
-
-/**
- * refcount_add_not_zero - add a value to a refcount unless it is 0
- * @i: the value to add to the refcount
- * @r: the refcount
- *
- * Will saturate at REFCOUNT_SATURATED and WARN.
- *
- * Provides no memory ordering, it is assumed the caller has guaranteed the
- * object memory to be stable (RCU, etc.). It does provide a control dependency
- * and thereby orders future stores. See the comment on top.
- *
- * Use of this function is not recommended for the normal reference counting
- * use case in which references are taken and released one at a time.  In these
- * cases, refcount_inc(), or one of its variants, should instead be used to
- * increment a reference count.
- *
- * Return: false if the passed refcount is 0, true otherwise
- */
-bool refcount_add_not_zero(int i, refcount_t *r)
-{
-	unsigned int new, val = atomic_read(&r->refs);
-
-	do {
-		if (!val)
-			return false;
-
-		if (unlikely(val == REFCOUNT_SATURATED))
-			return true;
-
-		new = val + i;
-		if (new < val)
-			new = REFCOUNT_SATURATED;
-
-	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &val, new));
-
-	WARN_ONCE(new == REFCOUNT_SATURATED,
-		  "refcount_t: saturated; leaking memory.\n");
-
-	return true;
-}
-EXPORT_SYMBOL(refcount_add_not_zero);
-
-/**
- * refcount_add - add a value to a refcount
- * @i: the value to add to the refcount
- * @r: the refcount
- *
- * Similar to atomic_add(), but will saturate at REFCOUNT_SATURATED and WARN.
- *
- * Provides no memory ordering, it is assumed the caller has guaranteed the
- * object memory to be stable (RCU, etc.). It does provide a control dependency
- * and thereby orders future stores. See the comment on top.
- *
- * Use of this function is not recommended for the normal reference counting
- * use case in which references are taken and released one at a time.  In these
- * cases, refcount_inc(), or one of its variants, should instead be used to
- * increment a reference count.
- */
-void refcount_add(int i, refcount_t *r)
-{
-	WARN_ONCE(!refcount_add_not_zero(i, r), "refcount_t: addition on 0; use-after-free.\n");
-}
-EXPORT_SYMBOL(refcount_add);
-
-/**
- * refcount_inc_not_zero - increment a refcount unless it is 0
- * @r: the refcount to increment
- *
- * Similar to atomic_inc_not_zero(), but will saturate at REFCOUNT_SATURATED
- * and WARN.
- *
- * Provides no memory ordering, it is assumed the caller has guaranteed the
- * object memory to be stable (RCU, etc.). It does provide a control dependency
- * and thereby orders future stores. See the comment on top.
- *
- * Return: true if the increment was successful, false otherwise
- */
-bool refcount_inc_not_zero(refcount_t *r)
-{
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
-}
-EXPORT_SYMBOL(refcount_inc_not_zero);
-
-/**
- * refcount_inc - increment a refcount
- * @r: the refcount to increment
- *
- * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
- *
- * Provides no memory ordering, it is assumed the caller already has a
- * reference on the object.
- *
- * Will WARN if the refcount is 0, as this represents a possible use-after-free
- * condition.
- */
-void refcount_inc(refcount_t *r)
-{
-	WARN_ONCE(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
-}
-EXPORT_SYMBOL(refcount_inc);
-
-/**
- * refcount_sub_and_test - subtract from a refcount and test if it is 0
- * @i: amount to subtract from the refcount
- * @r: the refcount
- *
- * Similar to atomic_dec_and_test(), but it will WARN, return false and
- * ultimately leak on underflow and will fail to decrement when saturated
- * at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides an acquire ordering on success such that free()
- * must come after.
- *
- * Use of this function is not recommended for the normal reference counting
- * use case in which references are taken and released one at a time.  In these
- * cases, refcount_dec(), or one of its variants, should instead be used to
- * decrement a reference count.
- *
- * Return: true if the resulting refcount is 0, false otherwise
- */
-bool refcount_sub_and_test(int i, refcount_t *r)
-{
-	unsigned int new, val = atomic_read(&r->refs);
-
-	do {
-		if (unlikely(val == REFCOUNT_SATURATED))
-			return false;
-
-		new = val - i;
-		if (new > val) {
-			WARN_ONCE(new > val, "refcount_t: underflow; use-after-free.\n");
-			return false;
-		}
-
-	} while (!atomic_try_cmpxchg_release(&r->refs, &val, new));
-
-	if (!new) {
-		smp_acquire__after_ctrl_dep();
-		return true;
-	}
-	return false;
-
-}
-EXPORT_SYMBOL(refcount_sub_and_test);
-
-/**
- * refcount_dec_and_test - decrement a refcount and test if it is 0
- * @r: the refcount
- *
- * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
- * decrement when saturated at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides an acquire ordering on success such that free()
- * must come after.
- *
- * Return: true if the resulting refcount is 0, false otherwise
- */
-bool refcount_dec_and_test(refcount_t *r)
-{
-	return refcount_sub_and_test(1, r);
-}
-EXPORT_SYMBOL(refcount_dec_and_test);
-
-/**
- * refcount_dec - decrement a refcount
- * @r: the refcount
- *
- * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
- * when saturated at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before.
- */
-void refcount_dec(refcount_t *r)
-{
-	WARN_ONCE(refcount_dec_and_test(r), "refcount_t: decrement hit 0; leaking memory.\n");
-}
-EXPORT_SYMBOL(refcount_dec);
-
-#endif /* CONFIG_REFCOUNT_FULL */
-
 /**
  * refcount_dec_if_one - decrement a refcount if it is 1
  * @r: the refcount
-- 
2.24.0.rc0.303.g954a862665-goog

