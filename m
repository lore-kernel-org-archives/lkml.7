Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B554C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0622721872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfDEOBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:01:15 -0400
Received: from foss.arm.com ([217.140.101.70]:49868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbfDEOBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:01:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 072201BF7;
        Fri,  5 Apr 2019 07:01:13 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2CC9C3F68F;
        Fri,  5 Apr 2019 07:01:09 -0700 (PDT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 21/21] arch: Remove dummy mmiowb() definitions from arch code
Date:   Fri,  5 Apr 2019 14:59:36 +0100
Message-Id: <20190405135936.7266-22-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that no driver code is using mmiowb() directly, we can remove the
dummy definitions remaining in architectures that don't make use of
asm-generic/io.h, as well as the definition in asm-generic/io,h itself.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/alpha/include/asm/io.h       | 2 --
 arch/hexagon/include/asm/io.h     | 2 --
 arch/parisc/include/asm/io.h      | 2 --
 arch/powerpc/include/asm/mmiowb.h | 2 --
 arch/sparc/include/asm/io_64.h    | 2 --
 include/asm-generic/io.h          | 4 ----
 6 files changed, 14 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 4c533fc94d62..ccf9d65166bb 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -513,8 +513,6 @@ extern inline void writeq(u64 b, volatile void __iomem *addr)
 #define writel_relaxed(b, addr)	__raw_writel(b, addr)
 #define writeq_relaxed(b, addr)	__raw_writeq(b, addr)
 
-#define mmiowb()
-
 /*
  * String version of IO memory access ops:
  */
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index e17262ad125e..3d0ae09c2b8e 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -184,8 +184,6 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define writew_relaxed __raw_writew
 #define writel_relaxed __raw_writel
 
-#define mmiowb()
-
 /*
  * Need an mtype somewhere in here, for cache type deals?
  * This is probably too long for an inline.
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 30a8315d5c07..93d37010b375 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -229,8 +229,6 @@ static inline void writeq(unsigned long long q, volatile void __iomem *addr)
 #define writel_relaxed(l, addr)	writel(l, addr)
 #define writeq_relaxed(q, addr)	writeq(q, addr)
 
-#define mmiowb() do { } while (0)
-
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
diff --git a/arch/powerpc/include/asm/mmiowb.h b/arch/powerpc/include/asm/mmiowb.h
index b10180613507..74a00127eb20 100644
--- a/arch/powerpc/include/asm/mmiowb.h
+++ b/arch/powerpc/include/asm/mmiowb.h
@@ -11,8 +11,6 @@
 #define arch_mmiowb_state()	(&local_paca->mmiowb_state)
 #define mmiowb()		mb()
 
-#else
-#define mmiowb()		do { } while (0)
 #endif /* CONFIG_MMIOWB */
 
 #include <asm-generic/mmiowb.h>
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index b162c23ae8c2..688911051b44 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -396,8 +396,6 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
 	}
 }
 
-#define mmiowb()
-
 #ifdef __KERNEL__
 
 /* On sparc64 we have the whole physical IO address space accessible
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bc490a746602..8f3bf95a36d1 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -22,10 +22,6 @@
 #include <asm/mmiowb.h>
 #include <asm-generic/pci_iomap.h>
 
-#ifndef mmiowb
-#define mmiowb() do {} while (0)
-#endif
-
 #ifndef __io_br
 #define __io_br()      barrier()
 #endif
-- 
2.11.0

