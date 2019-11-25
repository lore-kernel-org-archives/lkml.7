Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6829CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3667120823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfKYITr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:19:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38694 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKYIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:19:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZ9aT-0001SF-MP; Mon, 25 Nov 2019 09:19:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 427DD1C1AF4;
        Mon, 25 Nov 2019 09:19:12 +0100 (CET)
Date:   Mon, 25 Nov 2019 08:19:12 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/refcount: Remove unused
 refcount_*_checked() variants
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
In-Reply-To: <20191121115902.2551-4-will@kernel.org>
References: <20191121115902.2551-4-will@kernel.org>
MIME-Version: 1.0
Message-ID: <157466995215.21853.17232384896788510468.tip-bot2@tip-bot2>
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

Commit-ID:     7221762c48c6bbbcc6cc51d8b803c06930215e34
Gitweb:        https://git.kernel.org/tip/7221762c48c6bbbcc6cc51d8b803c06930215e34
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 11:58:55 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Nov 2019 09:15:03 +01:00

locking/refcount: Remove unused refcount_*_checked() variants

The full-fat refcount implementation is exposed via a set of functions
suffixed with "_checked()", the idea being that code can choose to use
the more expensive, yet more secure implementation on a case-by-case
basis.

In reality, this hasn't happened, so with a grand total of zero users,
let's remove the checked variants for now by simply dropping the suffix
and predicating the out-of-line functions on CONFIG_REFCOUNT_FULL=y.

Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191121115902.2551-4-will@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/refcount.h | 25 +++++-------------
 lib/refcount.c           | 54 ++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 89066a1..edd505d 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -44,32 +44,21 @@ static inline unsigned int refcount_read(const refcount_t *r)
 	return atomic_read(&r->refs);
 }
 
-extern __must_check bool refcount_add_not_zero_checked(int i, refcount_t *r);
-extern void refcount_add_checked(int i, refcount_t *r);
-
-extern __must_check bool refcount_inc_not_zero_checked(refcount_t *r);
-extern void refcount_inc_checked(refcount_t *r);
-
-extern __must_check bool refcount_sub_and_test_checked(int i, refcount_t *r);
-
-extern __must_check bool refcount_dec_and_test_checked(refcount_t *r);
-extern void refcount_dec_checked(refcount_t *r);
-
 #ifdef CONFIG_REFCOUNT_FULL
 
 #define REFCOUNT_MAX		(UINT_MAX - 1)
 #define REFCOUNT_SATURATED	UINT_MAX
 
-#define refcount_add_not_zero	refcount_add_not_zero_checked
-#define refcount_add		refcount_add_checked
+extern __must_check bool refcount_add_not_zero(int i, refcount_t *r);
+extern void refcount_add(int i, refcount_t *r);
 
-#define refcount_inc_not_zero	refcount_inc_not_zero_checked
-#define refcount_inc		refcount_inc_checked
+extern __must_check bool refcount_inc_not_zero(refcount_t *r);
+extern void refcount_inc(refcount_t *r);
 
-#define refcount_sub_and_test	refcount_sub_and_test_checked
+extern __must_check bool refcount_sub_and_test(int i, refcount_t *r);
 
-#define refcount_dec_and_test	refcount_dec_and_test_checked
-#define refcount_dec		refcount_dec_checked
+extern __must_check bool refcount_dec_and_test(refcount_t *r);
+extern void refcount_dec(refcount_t *r);
 
 #else
 
diff --git a/lib/refcount.c b/lib/refcount.c
index 719b0bc..a2f6709 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -43,8 +43,10 @@
 #include <linux/spinlock.h>
 #include <linux/bug.h>
 
+#ifdef CONFIG_REFCOUNT_FULL
+
 /**
- * refcount_add_not_zero_checked - add a value to a refcount unless it is 0
+ * refcount_add_not_zero - add a value to a refcount unless it is 0
  * @i: the value to add to the refcount
  * @r: the refcount
  *
@@ -61,7 +63,7 @@
  *
  * Return: false if the passed refcount is 0, true otherwise
  */
-bool refcount_add_not_zero_checked(int i, refcount_t *r)
+bool refcount_add_not_zero(int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -83,10 +85,10 @@ bool refcount_add_not_zero_checked(int i, refcount_t *r)
 
 	return true;
 }
-EXPORT_SYMBOL(refcount_add_not_zero_checked);
+EXPORT_SYMBOL(refcount_add_not_zero);
 
 /**
- * refcount_add_checked - add a value to a refcount
+ * refcount_add - add a value to a refcount
  * @i: the value to add to the refcount
  * @r: the refcount
  *
@@ -101,14 +103,14 @@ EXPORT_SYMBOL(refcount_add_not_zero_checked);
  * cases, refcount_inc(), or one of its variants, should instead be used to
  * increment a reference count.
  */
-void refcount_add_checked(int i, refcount_t *r)
+void refcount_add(int i, refcount_t *r)
 {
-	WARN_ONCE(!refcount_add_not_zero_checked(i, r), "refcount_t: addition on 0; use-after-free.\n");
+	WARN_ONCE(!refcount_add_not_zero(i, r), "refcount_t: addition on 0; use-after-free.\n");
 }
-EXPORT_SYMBOL(refcount_add_checked);
+EXPORT_SYMBOL(refcount_add);
 
 /**
- * refcount_inc_not_zero_checked - increment a refcount unless it is 0
+ * refcount_inc_not_zero - increment a refcount unless it is 0
  * @r: the refcount to increment
  *
  * Similar to atomic_inc_not_zero(), but will saturate at REFCOUNT_SATURATED
@@ -120,7 +122,7 @@ EXPORT_SYMBOL(refcount_add_checked);
  *
  * Return: true if the increment was successful, false otherwise
  */
-bool refcount_inc_not_zero_checked(refcount_t *r)
+bool refcount_inc_not_zero(refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -140,10 +142,10 @@ bool refcount_inc_not_zero_checked(refcount_t *r)
 
 	return true;
 }
-EXPORT_SYMBOL(refcount_inc_not_zero_checked);
+EXPORT_SYMBOL(refcount_inc_not_zero);
 
 /**
- * refcount_inc_checked - increment a refcount
+ * refcount_inc - increment a refcount
  * @r: the refcount to increment
  *
  * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
@@ -154,14 +156,14 @@ EXPORT_SYMBOL(refcount_inc_not_zero_checked);
  * Will WARN if the refcount is 0, as this represents a possible use-after-free
  * condition.
  */
-void refcount_inc_checked(refcount_t *r)
+void refcount_inc(refcount_t *r)
 {
-	WARN_ONCE(!refcount_inc_not_zero_checked(r), "refcount_t: increment on 0; use-after-free.\n");
+	WARN_ONCE(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
 }
-EXPORT_SYMBOL(refcount_inc_checked);
+EXPORT_SYMBOL(refcount_inc);
 
 /**
- * refcount_sub_and_test_checked - subtract from a refcount and test if it is 0
+ * refcount_sub_and_test - subtract from a refcount and test if it is 0
  * @i: amount to subtract from the refcount
  * @r: the refcount
  *
@@ -180,7 +182,7 @@ EXPORT_SYMBOL(refcount_inc_checked);
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
-bool refcount_sub_and_test_checked(int i, refcount_t *r)
+bool refcount_sub_and_test(int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -203,10 +205,10 @@ bool refcount_sub_and_test_checked(int i, refcount_t *r)
 	return false;
 
 }
-EXPORT_SYMBOL(refcount_sub_and_test_checked);
+EXPORT_SYMBOL(refcount_sub_and_test);
 
 /**
- * refcount_dec_and_test_checked - decrement a refcount and test if it is 0
+ * refcount_dec_and_test - decrement a refcount and test if it is 0
  * @r: the refcount
  *
  * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
@@ -218,14 +220,14 @@ EXPORT_SYMBOL(refcount_sub_and_test_checked);
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
-bool refcount_dec_and_test_checked(refcount_t *r)
+bool refcount_dec_and_test(refcount_t *r)
 {
-	return refcount_sub_and_test_checked(1, r);
+	return refcount_sub_and_test(1, r);
 }
-EXPORT_SYMBOL(refcount_dec_and_test_checked);
+EXPORT_SYMBOL(refcount_dec_and_test);
 
 /**
- * refcount_dec_checked - decrement a refcount
+ * refcount_dec - decrement a refcount
  * @r: the refcount
  *
  * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
@@ -234,11 +236,13 @@ EXPORT_SYMBOL(refcount_dec_and_test_checked);
  * Provides release memory ordering, such that prior loads and stores are done
  * before.
  */
-void refcount_dec_checked(refcount_t *r)
+void refcount_dec(refcount_t *r)
 {
-	WARN_ONCE(refcount_dec_and_test_checked(r), "refcount_t: decrement hit 0; leaking memory.\n");
+	WARN_ONCE(refcount_dec_and_test(r), "refcount_t: decrement hit 0; leaking memory.\n");
 }
-EXPORT_SYMBOL(refcount_dec_checked);
+EXPORT_SYMBOL(refcount_dec);
+
+#endif /* CONFIG_REFCOUNT_FULL */
 
 /**
  * refcount_dec_if_one - decrement a refcount if it is 1
