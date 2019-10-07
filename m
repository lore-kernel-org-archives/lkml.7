Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C5C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1032190F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570463246;
	bh=1/LoacIFiKHoqE8WcyrpDEfqVK2cIj7y+towlVmS9KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rlYfUa0n7siA6l4ox7FV2v3Epj0o2mOeBnbUeQT75qH7ko2QMDBdqfQEHl2EXNKDp
	 8Y0KhUBqDbDEtXa+0VS1HsmX1E0Z7Oc6Za34Gj/1tcMAqtIBds89xCpuyeuDive0mH
	 4rgdjdeeAGwr4hK9cpw0Rmwr4oxs5LqXXBD/EtQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfJGPrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbfJGPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:47:23 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 536E821835;
        Mon,  7 Oct 2019 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570463242;
        bh=1/LoacIFiKHoqE8WcyrpDEfqVK2cIj7y+towlVmS9KM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7ljKYcktOf6yjavbkRk0WKBCOHTKYP6PbISi7Y5PLEwSh5SanBqdnnu8Yj2wIbnQ
         pSVmeud1qh5+gzJ3MhDNC/umnbM5AkX7dWeR3FQvXpcuN/KrAYEW9s5UK7uzYW7k1V
         9naGlyQKNYZ8023qowxd36npLHdR2OzLiPlXIa0Q=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v3 06/10] lib/refcount: Move saturation warnings out of line
Date:   Mon,  7 Oct 2019 16:46:59 +0100
Message-Id: <20191007154703.5574-7-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191007154703.5574-1-will@kernel.org>
References: <20191007154703.5574-1-will@kernel.org>
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
index 7f9aa6511142..40ddff74a96c 100644
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
@@ -116,10 +126,8 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
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
@@ -144,11 +152,10 @@ static inline void refcount_add(int i, refcount_t *r)
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
@@ -215,10 +222,8 @@ static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
 		return true;
 	}
 
-	if (unlikely(old - i < 0)) {
-		refcount_set(r, REFCOUNT_SATURATED);
-		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
-	}
+	if (unlikely(old - i < 0))
+		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
 
 	return false;
 }
@@ -253,12 +258,8 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
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
index 3a534fbebdcc..6a61d39f9390 100644
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
+		WARN_ON(1);
+	}
+}
+EXPORT_SYMBOL(refcount_warn_saturate);
+
 /**
  * refcount_dec_if_one - decrement a refcount if it is 1
  * @r: the refcount
-- 
2.23.0.581.g78d2f28ef7-goog

