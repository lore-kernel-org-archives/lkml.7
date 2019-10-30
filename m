Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD16BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7556D21734
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572445853;
	bh=TEPUyFQs+dqzTGyN97Z7hK7sGG1IpKTp4YsVA0dKxqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fTGnb1YTKR0D++8T519s34AnxOKSM6bm+q7FKp0P2/AD74abH2dAAq3+YcUcDczO1
	 0j/6soFC8C7IIXtgZrvxNHthw3ZYl5NHawejiIGil9dPOzz+ZPrNRfR9MYxg7gcGVH
	 4lmMdUpiB6t6h0fC58h10g0r5ZnqOfc/kxmzdA3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJ3Oaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfJ3Oav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:30:51 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD4C21835;
        Wed, 30 Oct 2019 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572445849;
        bh=TEPUyFQs+dqzTGyN97Z7hK7sGG1IpKTp4YsVA0dKxqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2D3hHCNdWEHJuysWhdpLgAbfJcPswQHHMJElQcxMWg2WEifg7M2C7sG6pPQ3WJSCE
         tBgtDJhiTuDwdlO+V+tZjVsMDrPtpNFBhK1cX96EtIWakJmHYx+uAXGy926sJqToXy
         jF2bB0tOTJGb7+59GIhLVYFhiijJLonLDxq58k7U=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v4 03/10] lib/refcount: Remove unused refcount_*_checked() variants
Date:   Wed, 30 Oct 2019 14:30:28 +0000
Message-Id: <20191030143035.19440-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030143035.19440-1-will@kernel.org>
References: <20191030143035.19440-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The full-fat refcount implementation is exposed via a set of functions
suffixed with "_checked()", the idea being that code can choose to use
the more expensive, yet more secure implementation on a case-by-case
basis.

In reality, this hasn't happened, so with a grand total of zero users,
let's remove the checked variants for now by simply dropping the suffix
and predicating the out-of-line functions on CONFIG_REFCOUNT_FULL=y.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/refcount.h | 25 ++++++-------------
 lib/refcount.c           | 54 +++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 43 deletions(-)

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
index 719b0bc42ab1..a2f670998cee 100644
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
-- 
2.24.0.rc0.303.g954a862665-goog

