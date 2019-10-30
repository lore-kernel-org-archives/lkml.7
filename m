Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28746CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42A021906
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572445861;
	bh=liQ8Jy4pVXaF2iji+tBKROmVVDdNyDQn5R/Bz+t5GCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YX/c6IYTVTx9bSbUQYa1ox/5mKiNdFnabX9cqwveaQSWy1gQn+M7waSH6pAqsXZIt
	 sy+7RwjIy2jhLVZpPVeOlnapevxiORBOyOITSxRmTVppZy5PQG72Ztuqe5G11ZVzXO
	 163uBfOElygHAX938kskp9AXQwTAYbBYOkJ3uz/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfJ3ObA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfJ3Oa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:30:57 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6924A218AC;
        Wed, 30 Oct 2019 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572445856;
        bh=liQ8Jy4pVXaF2iji+tBKROmVVDdNyDQn5R/Bz+t5GCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAHJG7YgveTWQ4Ep4RYo1Z/qXdRbYBmAl+hzWUIYrrfixG+vwWRyX62xajXoMcsXL
         B0UHkNrFFaLX8H2tZJgHrD7gXkTuqERgYiVNN4/ft4Fm7Zx7kdcYeT2NiHn3PHbjLY
         d0V2gcj3BDuVDJqEmV1Hwte23t3sGVO7QvncHUMw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v4 06/10] lib/refcount: Move saturation warnings out of line
Date:   Wed, 30 Oct 2019 14:30:31 +0000
Message-Id: <20191030143035.19440-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030143035.19440-1-will@kernel.org>
References: <20191030143035.19440-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the refcount saturation and warnings inline bloats the text,
despite the fact that these paths should never be executed in normal
operation.

Move the refcount saturation and warnings out of line to reduce the
image size when refcount_t checking is enabled. Relative to an x86_64
defconfig, the sizes reported by bloat-o-meter are:

 # defconfig+REFCOUNT_FULL, inline saturation (i.e. before this patch)
 Total: Before=14762076, After=14915442, chg +1.04%

 # defconfig+REFCOUNT_FULL, out-of-line saturation (i.e. after this patch)
 Total: Before=14762076, After=14835497, chg +0.50%

A side-effect of this change is that we now only get one warning per
refcount saturation type, rather than one per problematic call-site.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/refcount.h | 39 ++++++++++++++++++++-------------------
 lib/refcount.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index e3b218d669ce..1cd0a876a789 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -23,6 +23,16 @@ typedef struct refcount_struct {
 
 #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
 
+enum refcount_saturation_type {
+	REFCOUNT_ADD_NOT_ZERO_OVF,
+	REFCOUNT_ADD_OVF,
+	REFCOUNT_ADD_UAF,
+	REFCOUNT_SUB_UAF,
+	REFCOUNT_DEC_LEAK,
+};
+
+void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
+
 /**
  * refcount_set - set a refcount's value
  * @r: the refcount
@@ -154,10 +164,8 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
 			break;
 	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
 
-	if (unlikely(old < 0 || old + i < 0)) {
-		refcount_set(r, REFCOUNT_SATURATED);
-		WARN_ONCE(1, "refcount_t: saturated; leaking memory.\n");
-	}
+	if (unlikely(old < 0 || old + i < 0))
+		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
 
 	return old;
 }
@@ -182,11 +190,10 @@ static inline void refcount_add(int i, refcount_t *r)
 {
 	int old = atomic_fetch_add_relaxed(i, &r->refs);
 
-	WARN_ONCE(!old, "refcount_t: addition on 0; use-after-free.\n");
-	if (unlikely(old <= 0 || old + i <= 0)) {
-		refcount_set(r, REFCOUNT_SATURATED);
-		WARN_ONCE(old, "refcount_t: saturated; leaking memory.\n");
-	}
+	if (unlikely(!old))
+		refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
+	else if (unlikely(old < 0 || old + i < 0))
+		refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
 }
 
 /**
@@ -253,10 +260,8 @@ static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
 		return true;
 	}
 
-	if (unlikely(old < 0 || old - i < 0)) {
-		refcount_set(r, REFCOUNT_SATURATED);
-		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
-	}
+	if (unlikely(old < 0 || old - i < 0))
+		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
 
 	return false;
 }
@@ -291,12 +296,8 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
  */
 static inline void refcount_dec(refcount_t *r)
 {
-	int old = atomic_fetch_sub_release(1, &r->refs);
-
-	if (unlikely(old <= 1)) {
-		refcount_set(r, REFCOUNT_SATURATED);
-		WARN_ONCE(1, "refcount_t: decrement hit 0; leaking memory.\n");
-	}
+	if (unlikely(atomic_fetch_sub_release(1, &r->refs) <= 1))
+		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
 }
 #else /* CONFIG_REFCOUNT_FULL */
 
diff --git a/lib/refcount.c b/lib/refcount.c
index 3a534fbebdcc..8b7e249c0e10 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -8,6 +8,34 @@
 #include <linux/spinlock.h>
 #include <linux/bug.h>
 
+#define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
+
+void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t)
+{
+	refcount_set(r, REFCOUNT_SATURATED);
+
+	switch (t) {
+	case REFCOUNT_ADD_NOT_ZERO_OVF:
+		REFCOUNT_WARN("saturated; leaking memory");
+		break;
+	case REFCOUNT_ADD_OVF:
+		REFCOUNT_WARN("saturated; leaking memory");
+		break;
+	case REFCOUNT_ADD_UAF:
+		REFCOUNT_WARN("addition on 0; use-after-free");
+		break;
+	case REFCOUNT_SUB_UAF:
+		REFCOUNT_WARN("underflow; use-after-free");
+		break;
+	case REFCOUNT_DEC_LEAK:
+		REFCOUNT_WARN("decrement hit 0; leaking memory");
+		break;
+	default:
+		REFCOUNT_WARN("unknown saturation event!?");
+	}
+}
+EXPORT_SYMBOL(refcount_warn_saturate);
+
 /**
  * refcount_dec_if_one - decrement a refcount if it is 1
  * @r: the refcount
-- 
2.24.0.rc0.303.g954a862665-goog

