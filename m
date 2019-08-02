Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639C8C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A9F2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564740633;
	bh=T8CBtbYin7L26qVdZiWrdYWFeyECkh7UgsE4pMQ/aps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vA3JW7dUqUcyrNTY39b7FMutEM+qNb9p9rYnuF24npMaMyIU4uZ0UCsKGVJ08znDV
	 aqamSeXczci7GEwM9iTJczpIY2jssZJxKpCr2OFT0IUiG5Qvl6zKShptcZcikTqyEH
	 S4FrkdNANPj+ALQ5K2iUsivCYo/RSUO4EpPUJ13o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391893AbfHBKKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:10:32 -0400
Received: from foss.arm.com ([217.140.110.172]:48860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389243AbfHBKKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:10:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0F8415A2;
        Fri,  2 Aug 2019 03:10:10 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 783853F71F;
        Fri,  2 Aug 2019 03:10:09 -0700 (PDT)
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH 3/6] lib/refcount: Remove unused refcount_*_checked() variants
Date:   Fri,  2 Aug 2019 11:09:57 +0100
Message-Id: <20190802101000.12958-4-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190802101000.12958-1-will@kernel.org>
References: <20190802101000.12958-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The full-fat refcount implementation is exposed via a set of functions
suffixed with "_checked()", the idea being that code can choose to use
the more expensive, yet more secure implementation on a case-by-case
basis.

In reality, this hasn't happened, so with a grand total of zero users,
let's remove the checked variants for now by simply dropping the suffix.

Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/refcount.h | 25 +++++++-----------------
 lib/refcount.c           | 50 ++++++++++++++++++++++++------------------------
 2 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 89066a1471dd..edd505d1a23b 100644
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
index 719b0bc42ab1..75d024ae309f 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -44,7 +44,7 @@
 #include <linux/bug.h>
 
 /**
- * refcount_add_not_zero_checked - add a value to a refcount unless it is 0
+ * refcount_add_not_zero - add a value to a refcount unless it is 0
  * @i: the value to add to the refcount
  * @r: the refcount
  *
@@ -61,7 +61,7 @@
  *
  * Return: false if the passed refcount is 0, true otherwise
  */
-bool refcount_add_not_zero_checked(int i, refcount_t *r)
+bool refcount_add_not_zero(int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -83,10 +83,10 @@ bool refcount_add_not_zero_checked(int i, refcount_t *r)
 
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
@@ -101,14 +101,14 @@ EXPORT_SYMBOL(refcount_add_not_zero_checked);
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
@@ -120,7 +120,7 @@ EXPORT_SYMBOL(refcount_add_checked);
  *
  * Return: true if the increment was successful, false otherwise
  */
-bool refcount_inc_not_zero_checked(refcount_t *r)
+bool refcount_inc_not_zero(refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -140,10 +140,10 @@ bool refcount_inc_not_zero_checked(refcount_t *r)
 
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
@@ -154,14 +154,14 @@ EXPORT_SYMBOL(refcount_inc_not_zero_checked);
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
@@ -180,7 +180,7 @@ EXPORT_SYMBOL(refcount_inc_checked);
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
-bool refcount_sub_and_test_checked(int i, refcount_t *r)
+bool refcount_sub_and_test(int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -203,10 +203,10 @@ bool refcount_sub_and_test_checked(int i, refcount_t *r)
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
@@ -218,14 +218,14 @@ EXPORT_SYMBOL(refcount_sub_and_test_checked);
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
@@ -234,11 +234,11 @@ EXPORT_SYMBOL(refcount_dec_and_test_checked);
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
 
 /**
  * refcount_dec_if_one - decrement a refcount if it is 1
-- 
2.11.0

