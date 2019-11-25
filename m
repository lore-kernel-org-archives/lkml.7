Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74350C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4229520823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfKYITl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:19:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38709 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKYIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:19:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZ9aV-0001TC-U4; Mon, 25 Nov 2019 09:19:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 96DFF1C1AF3;
        Mon, 25 Nov 2019 09:19:12 +0100 (CET)
Date:   Mon, 25 Nov 2019 08:19:12 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/refcount: Define constants for saturation
 and max refcount values
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121115902.2551-2-will@kernel.org>
References: <20191121115902.2551-2-will@kernel.org>
MIME-Version: 1.0
Message-ID: <157466995250.21853.11361308414524177788.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     23e6b169c9917fbd77534f8c5f378cb073f548bd
Gitweb:        https://git.kernel.org/tip/23e6b169c9917fbd77534f8c5f378cb073f548bd
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 11:58:53 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Nov 2019 09:14:13 +01:00

locking/refcount: Define constants for saturation and max refcount values

The REFCOUNT_FULL implementation uses a different saturation point than
the x86 implementation, which means that the shared refcount code in
lib/refcount.c (e.g. refcount_dec_not_one()) needs to be aware of the
difference.

Rather than duplicate the definitions from the lkdtm driver, instead
move them into <linux/refcount.h> and update all references accordingly.

Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191121115902.2551-2-will@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/misc/lkdtm/refcount.c |  8 +-------
 include/linux/refcount.h      | 10 ++++++++-
 lib/refcount.c                | 37 ++++++++++++++++++----------------
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/lkdtm/refcount.c b/drivers/misc/lkdtm/refcount.c
index 0a146b3..abf3b7c 100644
--- a/drivers/misc/lkdtm/refcount.c
+++ b/drivers/misc/lkdtm/refcount.c
@@ -6,14 +6,6 @@
 #include "lkdtm.h"
 #include <linux/refcount.h>
 
-#ifdef CONFIG_REFCOUNT_FULL
-#define REFCOUNT_MAX		(UINT_MAX - 1)
-#define REFCOUNT_SATURATED	UINT_MAX
-#else
-#define REFCOUNT_MAX		INT_MAX
-#define REFCOUNT_SATURATED	(INT_MIN / 2)
-#endif
-
 static void overflow_check(refcount_t *ref)
 {
 	switch (refcount_read(ref)) {
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index e28cce2..79f62e8 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/compiler.h>
+#include <linux/limits.h>
 #include <linux/spinlock_types.h>
 
 struct mutex;
@@ -12,7 +13,7 @@ struct mutex;
  * struct refcount_t - variant of atomic_t specialized for reference counts
  * @refs: atomic_t counter field
  *
- * The counter saturates at UINT_MAX and will not move once
+ * The counter saturates at REFCOUNT_SATURATED and will not move once
  * there. This avoids wrapping the counter and causing 'spurious'
  * use-after-free bugs.
  */
@@ -56,6 +57,9 @@ extern void refcount_dec_checked(refcount_t *r);
 
 #ifdef CONFIG_REFCOUNT_FULL
 
+#define REFCOUNT_MAX		(UINT_MAX - 1)
+#define REFCOUNT_SATURATED	UINT_MAX
+
 #define refcount_add_not_zero	refcount_add_not_zero_checked
 #define refcount_add		refcount_add_checked
 
@@ -68,6 +72,10 @@ extern void refcount_dec_checked(refcount_t *r);
 #define refcount_dec		refcount_dec_checked
 
 #else
+
+#define REFCOUNT_MAX		INT_MAX
+#define REFCOUNT_SATURATED	(INT_MIN / 2)
+
 # ifdef CONFIG_ARCH_HAS_REFCOUNT
 #  include <asm/refcount.h>
 # else
diff --git a/lib/refcount.c b/lib/refcount.c
index 6e904af..48b78a4 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -5,8 +5,8 @@
  * The interface matches the atomic_t interface (to aid in porting) but only
  * provides the few functions one should use for reference counting.
  *
- * It differs in that the counter saturates at UINT_MAX and will not move once
- * there. This avoids wrapping the counter and causing 'spurious'
+ * It differs in that the counter saturates at REFCOUNT_SATURATED and will not
+ * move once there. This avoids wrapping the counter and causing 'spurious'
  * use-after-free issues.
  *
  * Memory ordering rules are slightly relaxed wrt regular atomic_t functions
@@ -48,7 +48,7 @@
  * @i: the value to add to the refcount
  * @r: the refcount
  *
- * Will saturate at UINT_MAX and WARN.
+ * Will saturate at REFCOUNT_SATURATED and WARN.
  *
  * Provides no memory ordering, it is assumed the caller has guaranteed the
  * object memory to be stable (RCU, etc.). It does provide a control dependency
@@ -69,16 +69,17 @@ bool refcount_add_not_zero_checked(unsigned int i, refcount_t *r)
 		if (!val)
 			return false;
 
-		if (unlikely(val == UINT_MAX))
+		if (unlikely(val == REFCOUNT_SATURATED))
 			return true;
 
 		new = val + i;
 		if (new < val)
-			new = UINT_MAX;
+			new = REFCOUNT_SATURATED;
 
 	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &val, new));
 
-	WARN_ONCE(new == UINT_MAX, "refcount_t: saturated; leaking memory.\n");
+	WARN_ONCE(new == REFCOUNT_SATURATED,
+		  "refcount_t: saturated; leaking memory.\n");
 
 	return true;
 }
@@ -89,7 +90,7 @@ EXPORT_SYMBOL(refcount_add_not_zero_checked);
  * @i: the value to add to the refcount
  * @r: the refcount
  *
- * Similar to atomic_add(), but will saturate at UINT_MAX and WARN.
+ * Similar to atomic_add(), but will saturate at REFCOUNT_SATURATED and WARN.
  *
  * Provides no memory ordering, it is assumed the caller has guaranteed the
  * object memory to be stable (RCU, etc.). It does provide a control dependency
@@ -110,7 +111,8 @@ EXPORT_SYMBOL(refcount_add_checked);
  * refcount_inc_not_zero_checked - increment a refcount unless it is 0
  * @r: the refcount to increment
  *
- * Similar to atomic_inc_not_zero(), but will saturate at UINT_MAX and WARN.
+ * Similar to atomic_inc_not_zero(), but will saturate at REFCOUNT_SATURATED
+ * and WARN.
  *
  * Provides no memory ordering, it is assumed the caller has guaranteed the
  * object memory to be stable (RCU, etc.). It does provide a control dependency
@@ -133,7 +135,8 @@ bool refcount_inc_not_zero_checked(refcount_t *r)
 
 	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &val, new));
 
-	WARN_ONCE(new == UINT_MAX, "refcount_t: saturated; leaking memory.\n");
+	WARN_ONCE(new == REFCOUNT_SATURATED,
+		  "refcount_t: saturated; leaking memory.\n");
 
 	return true;
 }
@@ -143,7 +146,7 @@ EXPORT_SYMBOL(refcount_inc_not_zero_checked);
  * refcount_inc_checked - increment a refcount
  * @r: the refcount to increment
  *
- * Similar to atomic_inc(), but will saturate at UINT_MAX and WARN.
+ * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
  *
  * Provides no memory ordering, it is assumed the caller already has a
  * reference on the object.
@@ -164,7 +167,7 @@ EXPORT_SYMBOL(refcount_inc_checked);
  *
  * Similar to atomic_dec_and_test(), but it will WARN, return false and
  * ultimately leak on underflow and will fail to decrement when saturated
- * at UINT_MAX.
+ * at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before, and provides an acquire ordering on success such that free()
@@ -182,7 +185,7 @@ bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
 	unsigned int new, val = atomic_read(&r->refs);
 
 	do {
-		if (unlikely(val == UINT_MAX))
+		if (unlikely(val == REFCOUNT_SATURATED))
 			return false;
 
 		new = val - i;
@@ -207,7 +210,7 @@ EXPORT_SYMBOL(refcount_sub_and_test_checked);
  * @r: the refcount
  *
  * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
- * decrement when saturated at UINT_MAX.
+ * decrement when saturated at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before, and provides an acquire ordering on success such that free()
@@ -226,7 +229,7 @@ EXPORT_SYMBOL(refcount_dec_and_test_checked);
  * @r: the refcount
  *
  * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
- * when saturated at UINT_MAX.
+ * when saturated at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before.
@@ -277,7 +280,7 @@ bool refcount_dec_not_one(refcount_t *r)
 	unsigned int new, val = atomic_read(&r->refs);
 
 	do {
-		if (unlikely(val == UINT_MAX))
+		if (unlikely(val == REFCOUNT_SATURATED))
 			return true;
 
 		if (val == 1)
@@ -302,7 +305,7 @@ EXPORT_SYMBOL(refcount_dec_not_one);
  * @lock: the mutex to be locked
  *
  * Similar to atomic_dec_and_mutex_lock(), it will WARN on underflow and fail
- * to decrement when saturated at UINT_MAX.
+ * to decrement when saturated at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before, and provides a control dependency such that free() must come after.
@@ -333,7 +336,7 @@ EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
  * @lock: the spinlock to be locked
  *
  * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
- * decrement when saturated at UINT_MAX.
+ * decrement when saturated at REFCOUNT_SATURATED.
  *
  * Provides release memory ordering, such that prior loads and stores are done
  * before, and provides a control dependency such that free() must come after.
