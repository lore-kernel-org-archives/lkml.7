Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764B9C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4029A20882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577374304;
	bh=ACcMsXJRgvv86ni8jBDQzCMzllT9TiFSBLY7g9uTcEQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IrpQfyJvqwFWDF1KCTZ7V2CLbf8lnDb93o7m/ZAt5kuvOSWY44Wgt/O+cx/tBZ9+i
	 EoAKoTJAoSPXTC6jzZbs0LRlj+Yfu0lha/g9zjhd+Hdjg3+OX6F7zV9XZxERGvyTte
	 H69MWZINjPV0wZP7A8gQgY1fY2TvnOmhpOFBK/XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLZPbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 10:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfLZPbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 10:31:42 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F6520838;
        Thu, 26 Dec 2019 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577374301;
        bh=ACcMsXJRgvv86ni8jBDQzCMzllT9TiFSBLY7g9uTcEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JDdz9fZMaW1BlgOtBZ0f4M7ky4oGVKzckPX6a5hzwxI3P0mmY0lmvEhQLrdSD2/1A
         45JOuqNera1RmgDjHlhvQCY3ZJR3un57Oaj6490x7Upa6b+VI4bHLz7gbkezfQ9XTv
         UXxL1gOhAEGga0UtrzylvyrAUZmTCy5uZl/xKrKo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] locking/refcount: add sparse annotations to dec-and-lock functions
Date:   Thu, 26 Dec 2019 09:29:22 -0600
Message-Id: <20191226152922.2034-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Wrap refcount_dec_and_lock() and refcount_dec_and_lock_irqsave() with
macros using __cond_lock() so that 'sparse' doesn't report warnings
about unbalanced locking when using them.

This is the same thing that's done for their atomic_t equivalents.

Don't annotate refcount_dec_and_mutex_lock(), because mutexes don't
currently have sparse annotations.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/refcount.h | 45 ++++++++++++++++++++++++++++++++++++----
 lib/refcount.c           | 39 +++++-----------------------------
 2 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0ac50cf62d06..6bb5ab9e98ed 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -300,8 +300,45 @@ static inline void refcount_dec(refcount_t *r)
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
-extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock);
-extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
-						       spinlock_t *lock,
-						       unsigned long *flags);
+
+/**
+ * refcount_dec_and_lock - return holding spinlock if able to decrement
+ *                         refcount to 0
+ * @r: the refcount
+ * @lock: the spinlock to be locked
+ *
+ * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
+ * decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides a control dependency such that free() must come after.
+ * See the comment on top.
+ *
+ * Return: true and hold spinlock if able to decrement refcount to 0, false
+ *         otherwise
+ */
+extern __must_check bool _refcount_dec_and_lock(refcount_t *r,
+						spinlock_t *lock);
+#define refcount_dec_and_lock(r, lock) \
+	__cond_lock(lock, _refcount_dec_and_lock(r, lock))
+
+/**
+ * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
+ *                                 interrupts if able to decrement refcount to 0
+ * @r: the refcount
+ * @lock: the spinlock to be locked
+ * @flags: saved IRQ-flags if the is acquired
+ *
+ * Same as refcount_dec_and_lock() above except that the spinlock is acquired
+ * with disabled interrupts.
+ *
+ * Return: true and hold spinlock if able to decrement refcount to 0, false
+ *         otherwise
+ */
+extern __must_check bool _refcount_dec_and_lock_irqsave(refcount_t *r,
+							spinlock_t *lock,
+							unsigned long *flags);
+#define refcount_dec_and_lock_irqsave(r, lock, flags) \
+	__cond_lock(lock, _refcount_dec_and_lock_irqsave(r, lock, flags))
+
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/lib/refcount.c b/lib/refcount.c
index ebac8b7d15a7..f0eb996b28c0 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -125,23 +125,7 @@ bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock)
 }
 EXPORT_SYMBOL(refcount_dec_and_mutex_lock);
 
-/**
- * refcount_dec_and_lock - return holding spinlock if able to decrement
- *                         refcount to 0
- * @r: the refcount
- * @lock: the spinlock to be locked
- *
- * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
- * decrement when saturated at REFCOUNT_SATURATED.
- *
- * Provides release memory ordering, such that prior loads and stores are done
- * before, and provides a control dependency such that free() must come after.
- * See the comment on top.
- *
- * Return: true and hold spinlock if able to decrement refcount to 0, false
- *         otherwise
- */
-bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
+bool _refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 {
 	if (refcount_dec_not_one(r))
 		return false;
@@ -154,23 +138,10 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 
 	return true;
 }
-EXPORT_SYMBOL(refcount_dec_and_lock);
+EXPORT_SYMBOL(_refcount_dec_and_lock);
 
-/**
- * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
- *                                 interrupts if able to decrement refcount to 0
- * @r: the refcount
- * @lock: the spinlock to be locked
- * @flags: saved IRQ-flags if the is acquired
- *
- * Same as refcount_dec_and_lock() above except that the spinlock is acquired
- * with disabled interupts.
- *
- * Return: true and hold spinlock if able to decrement refcount to 0, false
- *         otherwise
- */
-bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
-				   unsigned long *flags)
+bool _refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
+				    unsigned long *flags)
 {
 	if (refcount_dec_not_one(r))
 		return false;
@@ -183,4 +154,4 @@ bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
 
 	return true;
 }
-EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
+EXPORT_SYMBOL(_refcount_dec_and_lock_irqsave);
-- 
2.24.1

