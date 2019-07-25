Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C470C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF9522BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xONBX0jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbfGYOLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:11:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36161 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfGYOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:11:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEArq81034540
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:10:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEArq81034540
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564063854;
        bh=VIjob6QcoYjrHAJEZvnl4ZsoJePfG2zbZcbN7bPPphQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xONBX0jvayVomc5DhBrc5+/6g+I/uBgzLdUw2bQcxQH/N2KzTgla+Kg6jvTZAbY3J
         JJsq7FGvyGqxVrxWZ3iZtJsNzbF+xbG4HoMNHOeAQtC38WjRsmQSx/RSSVuHNFw0Io
         r84Y2bG8Fhh+bTEm6rPb4hALcY3qur58zfiOhIm6TP57uEZkeqd55irK/U7M96Z2sC
         4Ucfuwmg3vvgTYcoLeHWhcaBnQL1aXfOMPw19kS3q77gPczBeQBAFq5dA8h9W1US0M
         QrFPHSWFUuC7112l/Yyfv61vsZjKGBPeUuEj/6yjnTgCt3GTV4cahb8Gfqybjv3IEA
         sjbc9JDLrhE+w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEAr0f1034536;
        Thu, 25 Jul 2019 07:10:53 -0700
Date:   Thu, 25 Jul 2019 07:10:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-b9fa6442f7043e2cdd247905d4f3b80f2e9605cb@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, peterz@infradead.org
In-Reply-To: <20190722105220.585449120@linutronix.de>
References: <20190722105220.585449120@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] cpumask: Implement cpumask_or_equal()
Git-Commit-ID: b9fa6442f7043e2cdd247905d4f3b80f2e9605cb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b9fa6442f7043e2cdd247905d4f3b80f2e9605cb
Gitweb:     https://git.kernel.org/tip/b9fa6442f7043e2cdd247905d4f3b80f2e9605cb
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:24 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 15:47:37 +0200

cpumask: Implement cpumask_or_equal()

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.585449120@linutronix.de

---
 include/linux/bitmap.h  | 23 +++++++++++++++++++++++
 include/linux/cpumask.h | 14 ++++++++++++++
 lib/bitmap.c            | 20 ++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index f58e97446abc..90528f12bdfa 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -120,6 +120,10 @@ extern int __bitmap_empty(const unsigned long *bitmap, unsigned int nbits);
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
@@ -321,6 +325,25 @@ static inline int bitmap_equal(const unsigned long *src1,
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
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 693124900f0a..0c7db5efe66c 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -475,6 +475,20 @@ static inline bool cpumask_equal(const struct cpumask *src1p,
 						 nr_cpumask_bits);
 }
 
+/**
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
 /**
  * cpumask_intersects - (*src1p & *src2p) != 0
  * @src1p: the first input
diff --git a/lib/bitmap.c b/lib/bitmap.c
index bbe2589e8497..f9e834841e94 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -59,6 +59,26 @@ int __bitmap_equal(const unsigned long *bitmap1,
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
