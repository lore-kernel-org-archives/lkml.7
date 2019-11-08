Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2CAFC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ED7218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232510;
	bh=w1i4LnluNWu9HOrfPIIA9Bv7MDAafzVn7tCd1kalpQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vy5JA2iUJJeRiAga+axv1MrGcDbpnGOtco+hLSNphQP0BuqYxwfECSeb4mYA9I3iN
	 qybCRdfq+6BSKtfto0xYrzkogoKbPIv4SZExOrIbRgIwqTABULVsY+KueeLCxjXxjm
	 TG+vmVFVhA/fbQP9fZE9JroYYzov1pFRX06B4Wjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfKHRBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:01:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfKHRBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:47 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B5E21D7E;
        Fri,  8 Nov 2019 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573232506;
        bh=w1i4LnluNWu9HOrfPIIA9Bv7MDAafzVn7tCd1kalpQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4GzqY7GaJ/tCwwOBuIgD/9Vjfa+xLyhA3XKsnAnsENVHus/GlmdMugS1pODMtR2B
         93PYBj5mstl8jHY2pUuno4AE87iy55+/3X3/m+x7/kSJVKPiJNoE7NHRUOIFw3vi4I
         fw3iv4Nbn044CoL6uS5gBcEm/OQqbUpZsRRm87/U=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 05/13] alpha: Override READ_ONCE() with barriered implementation
Date:   Fri,  8 Nov 2019 17:01:12 +0000
Message-Id: <20191108170120.22331-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather then relying on the core code to use 'smp_read_barrier_depends()'
as part of the 'READ_ONCE()' definition, instead override 'READ_ONCE()'
in the Alpha code so that it is treated the same way as
'smp_load_acquire()'.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/alpha/include/asm/barrier.h | 61 ++++----------------------------
 arch/alpha/include/asm/rwonce.h  | 22 ++++++++++++
 2 files changed, 29 insertions(+), 54 deletions(-)
 create mode 100644 arch/alpha/include/asm/rwonce.h

diff --git a/arch/alpha/include/asm/barrier.h b/arch/alpha/include/asm/barrier.h
index 92ec486a4f9e..1f6abe2d1392 100644
--- a/arch/alpha/include/asm/barrier.h
+++ b/arch/alpha/include/asm/barrier.h
@@ -2,64 +2,17 @@
 #ifndef __BARRIER_H
 #define __BARRIER_H
 
-#include <asm/compiler.h>
-
 #define mb()	__asm__ __volatile__("mb": : :"memory")
 #define rmb()	__asm__ __volatile__("mb": : :"memory")
 #define wmb()	__asm__ __volatile__("wmb": : :"memory")
 
-/**
- * read_barrier_depends - Flush all pending reads that subsequents reads
- * depend on.
- *
- * No data-dependent reads from memory-like regions are ever reordered
- * over this barrier.  All reads preceding this primitive are guaranteed
- * to access memory (but not necessarily other CPUs' caches) before any
- * reads following this primitive that depend on the data return by
- * any of the preceding reads.  This primitive is much lighter weight than
- * rmb() on most CPUs, and is never heavier weight than is
- * rmb().
- *
- * These ordering constraints are respected by both the local CPU
- * and the compiler.
- *
- * Ordering is not guaranteed by anything other than these primitives,
- * not even by data dependencies.  See the documentation for
- * memory_barrier() for examples and URLs to more information.
- *
- * For example, the following code would force ordering (the initial
- * value of "a" is zero, "b" is one, and "p" is "&a"):
- *
- * <programlisting>
- *	CPU 0				CPU 1
- *
- *	b = 2;
- *	memory_barrier();
- *	p = &b;				q = p;
- *					read_barrier_depends();
- *					d = *q;
- * </programlisting>
- *
- * because the read of "*q" depends on the read of "p" and these
- * two reads are separated by a read_barrier_depends().  However,
- * the following code, with the same initial values for "a" and "b":
- *
- * <programlisting>
- *	CPU 0				CPU 1
- *
- *	a = 2;
- *	memory_barrier();
- *	b = 3;				y = b;
- *					read_barrier_depends();
- *					x = a;
- * </programlisting>
- *
- * does not enforce ordering, since there is no data dependency between
- * the read of "a" and the read of "b".  Therefore, on some CPUs, such
- * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
- * in cases like this where there are no data dependencies.
- */
-#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
+#define __smp_load_acquire(p)						\
+({									\
+	typeof(*p) ___p1 = (*(volatile typeof(*p) *)(p));		\
+	compiletime_assert_atomic_type(*p);				\
+	mb();								\
+	___p1;								\
+})
 
 #ifdef CONFIG_SMP
 #define __ASM_SMP_MB	"\tmb\n"
diff --git a/arch/alpha/include/asm/rwonce.h b/arch/alpha/include/asm/rwonce.h
new file mode 100644
index 000000000000..ef5601352b55
--- /dev/null
+++ b/arch/alpha/include/asm/rwonce.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Google LLC.
+ */
+#ifndef __ASM_RWONCE_H
+#define __ASM_RWONCE_H
+
+#include <asm/barrier.h>
+
+/*
+ * Alpha is apparently daft enough to reorder address-dependent loads
+ * on some CPU implementations. Knock some common sense into it with
+ * a memory barrier in READ_ONCE().
+ */
+#define __read_once_size_1(p)	__smp_load_acquire((u8 *)(p))
+#define __read_once_size_2(p)	__smp_load_acquire((u16 *)(p))
+#define __read_once_size_4(p)	__smp_load_acquire((u32 *)(p))
+#define __read_once_size_8(p)	__smp_load_acquire((u64 *)(p))
+
+#include <asm-generic/rwonce.h>
+
+#endif /* __ASM_RWONCE_H */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

