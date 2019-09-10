Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99809C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EAE2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbfIJKvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:51:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:12122 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729493AbfIJKvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:51:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 03:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="189305926"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2019 03:51:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3CD36F3; Tue, 10 Sep 2019 13:51:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] kernel.h: Split out mathematical helpers
Date:   Tue, 10 Sep 2019 13:51:05 +0300
Message-Id: <20190910105105.7714-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
Here is the attempt to start cleaning it up by splitting out mathematical
helpers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/nfs/callback_proc.c        |   1 +
 include/linux/bitops.h        |   3 +-
 include/linux/dcache.h        |   1 +
 include/linux/iommu-helper.h  |   1 +
 include/linux/kernel.h        | 143 --------------------------------
 include/linux/math.h          | 149 ++++++++++++++++++++++++++++++++++
 include/linux/rcu_node_tree.h |   2 +
 7 files changed, 156 insertions(+), 144 deletions(-)
 create mode 100644 include/linux/math.h

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index f39924ba050b..aa00d109600c 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -6,6 +6,7 @@
  *
  * NFSv4 callback procedures
  */
+#include <linux/math.h>
 #include <linux/nfs4.h>
 #include <linux/nfs_fs.h>
 #include <linux/slab.h>
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf074bce3eb3..fbd4917603a0 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -3,9 +3,10 @@
 #define _LINUX_BITOPS_H
 #include <asm/types.h>
 #include <linux/bits.h>
+#include <uapi/linux/kernel.h>
 
 #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
-#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 10090f11ab95..d0fe48715226 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/list.h>
+#include <linux/math.h>
 #include <linux/rculist.h>
 #include <linux/rculist_bl.h>
 #include <linux/spinlock.h>
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index 70d01edcbf8b..16fcd3cdee92 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -4,6 +4,7 @@
 
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 
 static inline unsigned long iommu_device_max_index(unsigned long size,
 						   unsigned long offset,
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 4fa360a13c1e..37882f591929 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -17,7 +17,6 @@
 #include <asm/byteorder.h>
 #include <asm/div64.h>
 #include <uapi/linux/kernel.h>
-#include <asm/div64.h>
 
 #define STACK_MAGIC	0xdeadbeef
 
@@ -90,97 +89,9 @@
 
 #define typeof_member(T, m)	typeof(((T*)0)->m)
 
-#define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
-
-#define DIV_ROUND_DOWN_ULL(ll, d) \
-	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
-
-#define DIV_ROUND_UP_ULL(ll, d) \
-	DIV_ROUND_DOWN_ULL((unsigned long long)(ll) + (d) - 1, (d))
-
-#if BITS_PER_LONG == 32
-# define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP_ULL(ll, d)
-#else
-# define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP(ll,d)
-#endif
-
-/**
- * roundup - round up to the next specified multiple
- * @x: the value to up
- * @y: multiple to round up to
- *
- * Rounds @x up to next multiple of @y. If @y will always be a power
- * of 2, consider using the faster round_up().
- */
-#define roundup(x, y) (					\
-{							\
-	typeof(y) __y = y;				\
-	(((x) + (__y - 1)) / __y) * __y;		\
-}							\
-)
-/**
- * rounddown - round down to next specified multiple
- * @x: the value to round
- * @y: multiple to round down to
- *
- * Rounds @x down to next multiple of @y. If @y will always be a power
- * of 2, consider using the faster round_down().
- */
-#define rounddown(x, y) (				\
-{							\
-	typeof(x) __x = (x);				\
-	__x - (__x % (y));				\
-}							\
-)
-
-/*
- * Divide positive or negative dividend by positive or negative divisor
- * and round to closest integer. Result is undefined for negative
- * divisors if the dividend variable type is unsigned and for negative
- * dividends if the divisor variable type is unsigned.
- */
-#define DIV_ROUND_CLOSEST(x, divisor)(			\
-{							\
-	typeof(x) __x = x;				\
-	typeof(divisor) __d = divisor;			\
-	(((typeof(x))-1) > 0 ||				\
-	 ((typeof(divisor))-1) > 0 ||			\
-	 (((__x) > 0) == ((__d) > 0))) ?		\
-		(((__x) + ((__d) / 2)) / (__d)) :	\
-		(((__x) - ((__d) / 2)) / (__d));	\
-}							\
-)
-/*
- * Same as above but for u64 dividends. divisor must be a 32-bit
- * number.
- */
-#define DIV_ROUND_CLOSEST_ULL(x, divisor)(		\
-{							\
-	typeof(divisor) __d = divisor;			\
-	unsigned long long _tmp = (x) + (__d) / 2;	\
-	do_div(_tmp, __d);				\
-	_tmp;						\
-}							\
-)
-
-/*
- * Multiplies an integer by a fraction, while avoiding unnecessary
- * overflow or loss of precision.
- */
-#define mult_frac(x, numer, denom)(			\
-{							\
-	typeof(x) quot = (x) / (denom);			\
-	typeof(x) rem  = (x) % (denom);			\
-	(quot * (numer)) + ((rem * (numer)) / (denom));	\
-}							\
-)
-
-
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
 
-#define sector_div(a, b) do_div(a, b)
-
 /**
  * upper_32_bits - return bits 32-63 of a number
  * @n: the number we're accessing
@@ -245,48 +156,6 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 
-/**
- * abs - return absolute value of an argument
- * @x: the value.  If it is unsigned type, it is converted to signed type first.
- *     char is treated as if it was signed (regardless of whether it really is)
- *     but the macro's return type is preserved as char.
- *
- * Return: an absolute value of x.
- */
-#define abs(x)	__abs_choose_expr(x, long long,				\
-		__abs_choose_expr(x, long,				\
-		__abs_choose_expr(x, int,				\
-		__abs_choose_expr(x, short,				\
-		__abs_choose_expr(x, char,				\
-		__builtin_choose_expr(					\
-			__builtin_types_compatible_p(typeof(x), char),	\
-			(char)({ signed char __x = (x); __x<0?-__x:__x; }), \
-			((void)0)))))))
-
-#define __abs_choose_expr(x, type, other) __builtin_choose_expr(	\
-	__builtin_types_compatible_p(typeof(x),   signed type) ||	\
-	__builtin_types_compatible_p(typeof(x), unsigned type),		\
-	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
-
-/**
- * reciprocal_scale - "scale" a value into range [0, ep_ro)
- * @val: value
- * @ep_ro: right open interval endpoint
- *
- * Perform a "reciprocal multiplication" in order to "scale" a value into
- * range [0, @ep_ro), where the upper interval endpoint is right-open.
- * This is useful, e.g. for accessing a index of an array containing
- * @ep_ro elements, for example. Think of it as sort of modulus, only that
- * the result isn't that of modulo. ;) Note that if initial input is a
- * small value, then result will return 0.
- *
- * Return: a result based on @val in interval [0, @ep_ro).
- */
-static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
-{
-	return (u32)(((u64) val * ep_ro) >> 32);
-}
-
 #if defined(CONFIG_MMU) && \
 	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
 #define might_fault() __might_fault(__FILE__, __LINE__)
@@ -487,18 +356,6 @@ extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
 
-u64 int_pow(u64 base, unsigned int exp);
-unsigned long int_sqrt(unsigned long);
-
-#if BITS_PER_LONG < 64
-u32 int_sqrt64(u64 x);
-#else
-static inline u32 int_sqrt64(u64 x)
-{
-	return (u32)int_sqrt(x);
-}
-#endif
-
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
diff --git a/include/linux/math.h b/include/linux/math.h
new file mode 100644
index 000000000000..fa95172c1a5f
--- /dev/null
+++ b/include/linux/math.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MATH_H
+#define _LINUX_MATH_H
+
+#include <uapi/linux/kernel.h>
+#include <asm/div64.h>
+
+#define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
+
+#define DIV_ROUND_DOWN_ULL(ll, d) \
+	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
+
+#define DIV_ROUND_UP_ULL(ll, d) \
+	DIV_ROUND_DOWN_ULL((unsigned long long)(ll) + (d) - 1, (d))
+
+#if BITS_PER_LONG == 32
+# define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP_ULL(ll, d)
+#else
+# define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP(ll,d)
+#endif
+
+/**
+ * roundup - round up to the next specified multiple
+ * @x: the value to up
+ * @y: multiple to round up to
+ *
+ * Rounds @x up to next multiple of @y. If @y will always be a power
+ * of 2, consider using the faster round_up().
+ */
+#define roundup(x, y) (					\
+{							\
+	typeof(y) __y = y;				\
+	(((x) + (__y - 1)) / __y) * __y;		\
+}							\
+)
+/**
+ * rounddown - round down to next specified multiple
+ * @x: the value to round
+ * @y: multiple to round down to
+ *
+ * Rounds @x down to next multiple of @y. If @y will always be a power
+ * of 2, consider using the faster round_down().
+ */
+#define rounddown(x, y) (				\
+{							\
+	typeof(x) __x = (x);				\
+	__x - (__x % (y));				\
+}							\
+)
+
+/*
+ * Divide positive or negative dividend by positive or negative divisor
+ * and round to closest integer. Result is undefined for negative
+ * divisors if the dividend variable type is unsigned and for negative
+ * dividends if the divisor variable type is unsigned.
+ */
+#define DIV_ROUND_CLOSEST(x, divisor)(			\
+{							\
+	typeof(x) __x = x;				\
+	typeof(divisor) __d = divisor;			\
+	(((typeof(x))-1) > 0 ||				\
+	 ((typeof(divisor))-1) > 0 ||			\
+	 (((__x) > 0) == ((__d) > 0))) ?		\
+		(((__x) + ((__d) / 2)) / (__d)) :	\
+		(((__x) - ((__d) / 2)) / (__d));	\
+}							\
+)
+/*
+ * Same as above but for u64 dividends. divisor must be a 32-bit
+ * number.
+ */
+#define DIV_ROUND_CLOSEST_ULL(x, divisor)(		\
+{							\
+	typeof(divisor) __d = divisor;			\
+	unsigned long long _tmp = (x) + (__d) / 2;	\
+	do_div(_tmp, __d);				\
+	_tmp;						\
+}							\
+)
+
+/*
+ * Multiplies an integer by a fraction, while avoiding unnecessary
+ * overflow or loss of precision.
+ */
+#define mult_frac(x, numer, denom)(			\
+{							\
+	typeof(x) quot = (x) / (denom);			\
+	typeof(x) rem  = (x) % (denom);			\
+	(quot * (numer)) + ((rem * (numer)) / (denom));	\
+}							\
+)
+
+#define sector_div(a, b) do_div(a, b)
+
+/**
+ * abs - return absolute value of an argument
+ * @x: the value.  If it is unsigned type, it is converted to signed type first.
+ *     char is treated as if it was signed (regardless of whether it really is)
+ *     but the macro's return type is preserved as char.
+ *
+ * Return: an absolute value of x.
+ */
+#define abs(x)	__abs_choose_expr(x, long long,				\
+		__abs_choose_expr(x, long,				\
+		__abs_choose_expr(x, int,				\
+		__abs_choose_expr(x, short,				\
+		__abs_choose_expr(x, char,				\
+		__builtin_choose_expr(					\
+			__builtin_types_compatible_p(typeof(x), char),	\
+			(char)({ signed char __x = (x); __x<0?-__x:__x; }), \
+			((void)0)))))))
+
+#define __abs_choose_expr(x, type, other) __builtin_choose_expr(	\
+	__builtin_types_compatible_p(typeof(x),   signed type) ||	\
+	__builtin_types_compatible_p(typeof(x), unsigned type),		\
+	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
+
+/**
+ * reciprocal_scale - "scale" a value into range [0, ep_ro)
+ * @val: value
+ * @ep_ro: right open interval endpoint
+ *
+ * Perform a "reciprocal multiplication" in order to "scale" a value into
+ * range [0, @ep_ro), where the upper interval endpoint is right-open.
+ * This is useful, e.g. for accessing a index of an array containing
+ * @ep_ro elements, for example. Think of it as sort of modulus, only that
+ * the result isn't that of modulo. ;) Note that if initial input is a
+ * small value, then result will return 0.
+ *
+ * Return: a result based on @val in interval [0, @ep_ro).
+ */
+static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
+{
+	return (u32)(((u64) val * ep_ro) >> 32);
+}
+
+u64 int_pow(u64 base, unsigned int exp);
+unsigned long int_sqrt(unsigned long);
+
+#if BITS_PER_LONG < 64
+u32 int_sqrt64(u64 x);
+#else
+static inline u32 int_sqrt64(u64 x)
+{
+	return (u32)int_sqrt(x);
+}
+#endif
+
+#endif	/* _LINUX_MATH_H */
diff --git a/include/linux/rcu_node_tree.h b/include/linux/rcu_node_tree.h
index b8e094b125ee..78feb8ba7358 100644
--- a/include/linux/rcu_node_tree.h
+++ b/include/linux/rcu_node_tree.h
@@ -20,6 +20,8 @@
 #ifndef __LINUX_RCU_NODE_TREE_H
 #define __LINUX_RCU_NODE_TREE_H
 
+#include <linux/math.h>
+
 /*
  * Define shape of hierarchy based on NR_CPUS, CONFIG_RCU_FANOUT, and
  * CONFIG_RCU_FANOUT_LEAF.
-- 
2.23.0

