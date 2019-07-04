Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB93BC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8404A218D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfGDQey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59725 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfGDQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gR-0005hk-Tp; Thu, 04 Jul 2019 18:34:07 +0200
Message-Id: <20190704155610.141968740@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:52:04 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 19/25] cpumask: Implement cpumask_or_equal()
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPI code of x86 needs to evaluate whether the target cpumask is equal
to the cpu_online_mask or equal except for the calling CPU.

To replace the current implementation which requires the usage of a
temporary cpumask, which might involve allocations, add a new function
which compares a cpumask to the result of two other cpumasks which are
or'ed together before comparison.

This allows to make the required decision in one go and the calling code
then can check for the calling CPU being set in the target mask with
cpumask_test_cpu().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 include/linux/bitmap.h  |   23 +++++++++++++++++++++++
 include/linux/cpumask.h |   14 ++++++++++++++
 lib/bitmap.c            |   20 ++++++++++++++++++++
 3 files changed, 57 insertions(+)

--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -120,6 +120,10 @@ extern int __bitmap_empty(const unsigned
 extern int __bitmap_full(const unsigned long *bitmap, unsigned int nbits);
 extern int __bitmap_equal(const unsigned long *bitmap1,
 			  const unsigned long *bitmap2, unsigned int nbits);
+extern bool __pure __bitmap_or_equal(const unsigned long *src1,
+				     const unsigned long *src2,
+				     const unsigned long *src3,
+				     unsigned int nbits);
 extern void __bitmap_complement(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits);
 extern void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
@@ -321,6 +325,25 @@ static inline int bitmap_equal(const uns
 	return __bitmap_equal(src1, src2, nbits);
 }
 
+/**
+ * bitmap_or_equal - Check whether the or of two bitnaps is equal to a third
+ * @src1:	Pointer to bitmap 1
+ * @src2:	Pointer to bitmap 2 will be or'ed with bitmap 1
+ * @src3:	Pointer to bitmap 3. Compare to the result of *@src1 | *@src2
+ *
+ * Returns: True if (*@src1 | *@src2) == *@src3, false otherwise
+ */
+static inline bool bitmap_or_equal(const unsigned long *src1,
+				   const unsigned long *src2,
+				   const unsigned long *src3,
+				   unsigned int nbits)
+{
+	if (!small_const_nbits(nbits))
+		return __bitmap_or_equal(src1, src2, src3, nbits);
+
+	return !(((*src1 | *src2) ^ *src3) & BITMAP_LAST_WORD_MASK(nbits));
+}
+
 static inline int bitmap_intersects(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -476,6 +476,20 @@ static inline bool cpumask_equal(const s
 }
 
 /**
+ * cpumask_or_equal - *src1p | *src2p == *src3p
+ * @src1p: the first input
+ * @src2p: the second input
+ * @src3p: the third input
+ */
+static inline bool cpumask_or_equal(const struct cpumask *src1p,
+				    const struct cpumask *src2p,
+				    const struct cpumask *src3p)
+{
+	return bitmap_or_equal(cpumask_bits(src1p), cpumask_bits(src2p),
+			       cpumask_bits(src3p), nr_cpumask_bits);
+}
+
+/**
  * cpumask_intersects - (*src1p & *src2p) != 0
  * @src1p: the first input
  * @src2p: the second input
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -59,6 +59,26 @@ int __bitmap_equal(const unsigned long *
 }
 EXPORT_SYMBOL(__bitmap_equal);
 
+bool __bitmap_or_equal(const unsigned long *bitmap1,
+		       const unsigned long *bitmap2,
+		       const unsigned long *bitmap3,
+		       unsigned int bits)
+{
+	unsigned int k, lim = bits / BITS_PER_LONG;
+	unsigned long tmp;
+
+	for (k = 0; k < lim; ++k) {
+		if ((bitmap1[k] | bitmap2[k]) != bitmap3[k])
+			return false;
+	}
+
+	if (!(bits % BITS_PER_LONG))
+		return true;
+
+	tmp = (bitmap1[k] | bitmap2[k]) ^ bitmap3[k];
+	return (tmp & BITMAP_LAST_WORD_MASK(bits)) == 0;
+}
+
 void __bitmap_complement(unsigned long *dst, const unsigned long *src, unsigned int bits)
 {
 	unsigned int k, lim = BITS_TO_LONGS(bits);


