Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7239E20652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfCGP6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:58:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34183 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfCGP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:58:48 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27FkcsM001047;
        Thu, 7 Mar 2019 16:58:42 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r2ng25n7s-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 07 Mar 2019 16:58:42 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 00FCB3A;
        Thu,  7 Mar 2019 15:58:41 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C8C465323;
        Thu,  7 Mar 2019 15:58:41 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 16:58:41 +0100
Received: from localhost (10.129.4.33) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019 16:58:41 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-remoteproc@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 2/2] hwspinlock: add the 'in_atomic' API
Date:   Thu, 7 Mar 2019 16:58:23 +0100
Message-ID: <1551974303-24542-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551974303-24542-1-git-send-email-fabien.dessenne@st.com>
References: <1551974303-24542-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.33]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 'in_atomic' mode which can be called from an atomic context.
This mode relies on the existing 'raw' mode (no lock, no preemption/irq
disabling) with the difference that the timeout is not based on jiffies
(jiffies won't increase when irq are disabled) but handled with
busy-waiting udelay() calls.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 Documentation/hwspinlock.txt         | 39 +++++++++++++++++++++++
 drivers/hwspinlock/hwspinlock_core.c | 43 +++++++++++++++++--------
 include/linux/hwspinlock.h           | 61 ++++++++++++++++++++++++++++++++++--
 3 files changed, 127 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwspinlock.txt b/Documentation/hwspinlock.txt
index c3403f9..6f03713 100644
--- a/Documentation/hwspinlock.txt
+++ b/Documentation/hwspinlock.txt
@@ -153,6 +153,22 @@ The function will never sleep.
 
 ::
 
+  int hwspin_lock_timeout_in_atomic(struct hwspinlock *hwlock, unsigned int to);
+
+Lock a previously-assigned hwspinlock with a timeout limit (specified in
+msecs). If the hwspinlock is already taken, the function will busy loop
+waiting for it to be released, but give up when the timeout elapses.
+
+This function shall be called only from an atomic context and the timeout
+value shall not exceed a few msecs.
+
+Returns 0 when successful and an appropriate error code otherwise (most
+notably -ETIMEDOUT if the hwspinlock is still busy after timeout msecs).
+
+The function will never sleep.
+
+::
+
   int hwspin_trylock(struct hwspinlock *hwlock);
 
 
@@ -218,6 +234,19 @@ The function will never sleep.
 
 ::
 
+  int hwspin_trylock_in_atomic(struct hwspinlock *hwlock);
+
+Attempt to lock a previously-assigned hwspinlock, but immediately fail if
+it is already taken.
+
+This function shall be called only from an atomic context.
+
+Returns 0 on success and an appropriate error code otherwise (most
+notably -EBUSY if the hwspinlock was already taken).
+The function will never sleep.
+
+::
+
   void hwspin_unlock(struct hwspinlock *hwlock);
 
 Unlock a previously-locked hwspinlock. Always succeed, and can be called
@@ -264,6 +293,16 @@ This function will never sleep.
 
 ::
 
+  void hwspin_unlock_in_atomic(struct hwspinlock *hwlock);
+
+Unlock a previously-locked hwspinlock.
+
+The caller should **never** unlock an hwspinlock which is already unlocked.
+Doing so is considered a bug (there is no protection against this).
+This function will never sleep.
+
+::
+
   int hwspin_lock_get_id(struct hwspinlock *hwlock);
 
 Retrieve id number of a given hwspinlock. This is needed when an
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 2bad40d..1d61fad 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)    "%s: " fmt, __func__
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
@@ -23,6 +24,9 @@
 
 #include "hwspinlock_internal.h"
 
+/* retry delay used in atomic context */
+#define HWSPINLOCK_RETRY_DELAY_US	100
+
 /* radix tree tags */
 #define HWSPINLOCK_UNUSED	(0) /* tags an hwspinlock as unused */
 
@@ -68,11 +72,11 @@ static DEFINE_MUTEX(hwspinlock_tree_lock);
  * user need some time-consuming or sleepable operations under the hardware
  * lock, they need one sleepable lock (like mutex) to protect the operations.
  *
- * If the mode is not HWLOCK_RAW, upon a successful return from this function,
- * preemption (and possibly interrupts) is disabled, so the caller must not
- * sleep, and is advised to release the hwspinlock as soon as possible. This is
- * required in order to minimize remote cores polling on the hardware
- * interconnect.
+ * If the mode is neither HWLOCK_IN_ATOMIC nor HWLOCK_RAW, upon a successful
+ * return from this function, preemption (and possibly interrupts) is disabled,
+ * so the caller must not sleep, and is advised to release the hwspinlock as
+ * soon as possible. This is required in order to minimize remote cores polling
+ * on the hardware interconnect.
  *
  * The user decides whether local interrupts are disabled or not, and if yes,
  * whether he wants their previous state to be saved. It is up to the user
@@ -112,6 +116,7 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 		ret = spin_trylock_irq(&hwlock->lock);
 		break;
 	case HWLOCK_RAW:
+	case HWLOCK_IN_ATOMIC:
 		ret = 1;
 		break;
 	default:
@@ -136,6 +141,7 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 			spin_unlock_irq(&hwlock->lock);
 			break;
 		case HWLOCK_RAW:
+		case HWLOCK_IN_ATOMIC:
 			/* Nothing to do */
 			break;
 		default:
@@ -179,11 +185,14 @@ EXPORT_SYMBOL_GPL(__hwspin_trylock);
  * user need some time-consuming or sleepable operations under the hardware
  * lock, they need one sleepable lock (like mutex) to protect the operations.
  *
- * If the mode is not HWLOCK_RAW, upon a successful return from this function,
- * preemption is disabled (and possibly local interrupts, too), so the caller
- * must not sleep, and is advised to release the hwspinlock as soon as possible.
- * This is required in order to minimize remote cores polling on the
- * hardware interconnect.
+ * If the mode is HWLOCK_IN_ATOMIC (called from an atomic context) the timeout
+ * is handled with busy-waiting delays, hence shall not exceed few msecs.
+ *
+ * If the mode is neither HWLOCK_IN_ATOMIC nor HWLOCK_RAW, upon a successful
+ * return from this function, preemption (and possibly interrupts) is disabled,
+ * so the caller must not sleep, and is advised to release the hwspinlock as
+ * soon as possible. This is required in order to minimize remote cores polling
+ * on the hardware interconnect.
  *
  * The user decides whether local interrupts are disabled or not, and if yes,
  * whether he wants their previous state to be saved. It is up to the user
@@ -198,7 +207,7 @@ int __hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int to,
 					int mode, unsigned long *flags)
 {
 	int ret;
-	unsigned long expire;
+	unsigned long expire, atomic_delay = 0;
 
 	expire = msecs_to_jiffies(to) + jiffies;
 
@@ -212,8 +221,15 @@ int __hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int to,
 		 * The lock is already taken, let's check if the user wants
 		 * us to try again
 		 */
-		if (time_is_before_eq_jiffies(expire))
-			return -ETIMEDOUT;
+		if (mode == HWLOCK_IN_ATOMIC) {
+			udelay(HWSPINLOCK_RETRY_DELAY_US);
+			atomic_delay += HWSPINLOCK_RETRY_DELAY_US;
+			if (atomic_delay > to * 1000)
+				return -ETIMEDOUT;
+		} else {
+			if (time_is_before_eq_jiffies(expire))
+				return -ETIMEDOUT;
+		}
 
 		/*
 		 * Allow platform-specific relax handlers to prevent
@@ -276,6 +292,7 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 		spin_unlock_irq(&hwlock->lock);
 		break;
 	case HWLOCK_RAW:
+	case HWLOCK_IN_ATOMIC:
 		/* Nothing to do */
 		break;
 	default:
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 0afe693..bfe7c1f 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -14,9 +14,10 @@
 #include <linux/sched.h>
 
 /* hwspinlock mode argument */
-#define HWLOCK_IRQSTATE	0x01	/* Disable interrupts, save state */
-#define HWLOCK_IRQ	0x02	/* Disable interrupts, don't save state */
-#define HWLOCK_RAW	0x03
+#define HWLOCK_IRQSTATE		0x01 /* Disable interrupts, save state */
+#define HWLOCK_IRQ		0x02 /* Disable interrupts, don't save state */
+#define HWLOCK_RAW		0x03
+#define HWLOCK_IN_ATOMIC	0x04 /* Called while in atomic context */
 
 struct device;
 struct device_node;
@@ -223,6 +224,23 @@ static inline int hwspin_trylock_raw(struct hwspinlock *hwlock)
 }
 
 /**
+ * hwspin_trylock_in_atomic() - attempt to lock a specific hwspinlock
+ * @hwlock: an hwspinlock which we want to trylock
+ *
+ * This function attempts to lock an hwspinlock, and will immediately fail
+ * if the hwspinlock is already taken.
+ *
+ * This function shall be called only from an atomic context.
+ *
+ * Returns 0 if we successfully locked the hwspinlock, -EBUSY if
+ * the hwspinlock was already taken, and -EINVAL if @hwlock is invalid.
+ */
+static inline int hwspin_trylock_in_atomic(struct hwspinlock *hwlock)
+{
+	return __hwspin_trylock(hwlock, HWLOCK_IN_ATOMIC, NULL);
+}
+
+/**
  * hwspin_trylock() - attempt to lock a specific hwspinlock
  * @hwlock: an hwspinlock which we want to trylock
  *
@@ -313,6 +331,28 @@ int hwspin_lock_timeout_raw(struct hwspinlock *hwlock, unsigned int to)
 }
 
 /**
+ * hwspin_lock_timeout_in_atomic() - lock an hwspinlock with timeout limit
+ * @hwlock: the hwspinlock to be locked
+ * @to: timeout value in msecs
+ *
+ * This function locks the underlying @hwlock. If the @hwlock
+ * is already taken, the function will busy loop waiting for it to
+ * be released, but give up when @timeout msecs have elapsed.
+ *
+ * This function shall be called only from an atomic context and the timeout
+ * value shall not exceed a few msecs.
+ *
+ * Returns 0 when the @hwlock was successfully taken, and an appropriate
+ * error code otherwise (most notably an -ETIMEDOUT if the @hwlock is still
+ * busy after @timeout msecs). The function will never sleep.
+ */
+static inline
+int hwspin_lock_timeout_in_atomic(struct hwspinlock *hwlock, unsigned int to)
+{
+	return __hwspin_lock_timeout(hwlock, to, HWLOCK_IN_ATOMIC, NULL);
+}
+
+/**
  * hwspin_lock_timeout() - lock an hwspinlock with timeout limit
  * @hwlock: the hwspinlock to be locked
  * @to: timeout value in msecs
@@ -387,6 +427,21 @@ static inline void hwspin_unlock_raw(struct hwspinlock *hwlock)
 }
 
 /**
+ * hwspin_unlock_in_atomic() - unlock hwspinlock
+ * @hwlock: a previously-acquired hwspinlock which we want to unlock
+ *
+ * This function will unlock a specific hwspinlock.
+ *
+ * @hwlock must be already locked (e.g. by hwspin_trylock()) before calling
+ * this function: it is a bug to call unlock on a @hwlock that is already
+ * unlocked.
+ */
+static inline void hwspin_unlock_in_atomic(struct hwspinlock *hwlock)
+{
+	__hwspin_unlock(hwlock, HWLOCK_IN_ATOMIC, NULL);
+}
+
+/**
  * hwspin_unlock() - unlock hwspinlock
  * @hwlock: a previously-acquired hwspinlock which we want to unlock
  *
-- 
2.7.4

