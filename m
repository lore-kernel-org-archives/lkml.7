Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541E5ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8E420679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570463244;
	bh=3g3+jTGXd27OaTJMHb+QdPEN5r1Sz7eZI3v+NL4ISi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f12zeRWLH6uoGFmbttT/En4nuivHrPimlj50gzpPRfBHAc/h/iylN0f+H+QYEs6L5
	 v1QoJ9ituAbz/xCvdaqzwsHSl+oxYUiUfBcODAYFPaT+SiPXBF0V0xsZ9zhDS1w3xX
	 gDfo+7tCKEtl5+GmmmenHvpQxg4IEwKCT2BK/aiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfJGPrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbfJGPrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:47:21 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9A821721;
        Mon,  7 Oct 2019 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570463239;
        bh=3g3+jTGXd27OaTJMHb+QdPEN5r1Sz7eZI3v+NL4ISi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXUkmNPrghOgVC0cjHwvg8kJH44dmEEq/Uz5T7NBoAyoa1IkESrApCQDl3FL3AuxT
         ztILaZ9SZQedHfFk5lz6hmMB6z0dNKSdx07kzepV3PrmXJjWfUPaRo2dooIhNTxQLS
         Fr1RDze0ftSDN2Wo2ADQqjqvog4jtARJ6gy5TzBg=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v3 05/10] lib/refcount: Improve performance of generic REFCOUNT_FULL code
Date:   Mon,  7 Oct 2019 16:46:58 +0100
Message-Id: <20191007154703.5574-6-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191007154703.5574-1-will@kernel.org>
References: <20191007154703.5574-1-will@kernel.org>
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
 include/linux/refcount.h | 87 ++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 53 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index e719b5b1220e..7f9aa6511142 100644
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
@@ -109,25 +109,19 @@ static inline unsigned int refcount_read(const refcount_t *r)
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
@@ -148,7 +142,13 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
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
@@ -166,23 +166,7 @@ static inline void refcount_add(int i, refcount_t *r)
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
@@ -199,7 +183,7 @@ static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
  */
 static inline void refcount_inc(refcount_t *r)
 {
-	WARN_ONCE(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
+	refcount_add(1, r);
 }
 
 /**
@@ -224,26 +208,19 @@ static inline void refcount_inc(refcount_t *r)
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
 
+	if (unlikely(old - i < 0)) {
+		refcount_set(r, REFCOUNT_SATURATED);
+		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
+	}
+
+	return false;
 }
 
 /**
@@ -276,9 +253,13 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
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
2.23.0.581.g78d2f28ef7-goog

