Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A945C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABCC20879
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfCWRZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:25:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:34655 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfCWRZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:25:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 10:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="331368986"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2019 10:25:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 005C5159; Sat, 23 Mar 2019 19:25:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ray Jui <rjui@broadcom.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] lib: Move mathematic helpers to separate folder
Date:   Sat, 23 Mar 2019 20:25:30 +0300
Message-Id: <20190323172531.80025-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better maintenance and expansion move the mathematic helpers to
the separate folder.

No functional change intended.

Note, the int_sqrt() is not used as a part of lib, so, moved to regular obj.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/Kconfig                     | 14 ++------------
 lib/Makefile                    | 15 ++++++---------
 lib/math/Kconfig                | 11 +++++++++++
 lib/math/Makefile               |  5 +++++
 lib/{ => math}/cordic.c         |  0
 lib/{ => math}/div64.c          |  0
 lib/{ => math}/gcd.c            |  0
 lib/{ => math}/int_sqrt.c       |  0
 lib/{ => math}/lcm.c            |  0
 lib/{ => math}/prime_numbers.c  |  0
 lib/{ => math}/rational.c       |  0
 lib/{ => math}/reciprocal_div.c |  0
 12 files changed, 24 insertions(+), 21 deletions(-)
 create mode 100644 lib/math/Kconfig
 create mode 100644 lib/math/Makefile
 rename lib/{ => math}/cordic.c (100%)
 rename lib/{ => math}/div64.c (100%)
 rename lib/{ => math}/gcd.c (100%)
 rename lib/{ => math}/int_sqrt.c (100%)
 rename lib/{ => math}/lcm.c (100%)
 rename lib/{ => math}/prime_numbers.c (100%)
 rename lib/{ => math}/rational.c (100%)
 rename lib/{ => math}/reciprocal_div.c (100%)

diff --git a/lib/Kconfig b/lib/Kconfig
index a9e56539bd11..fb453afff32e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -29,9 +29,6 @@ config HAVE_ARCH_BITREVERSE
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
 
-config RATIONAL
-	bool
-
 config GENERIC_STRNCPY_FROM_USER
 	bool
 
@@ -44,6 +41,8 @@ config GENERIC_NET_UTILS
 config GENERIC_FIND_FIRST_BIT
 	bool
 
+source "lib/math/Kconfig"
+
 config NO_GENERIC_PCI_IOPORT_MAP
 	bool
 
@@ -514,12 +513,6 @@ config LRU_CACHE
 config CLZ_TAB
 	bool
 
-config CORDIC
-	tristate "CORDIC algorithm"
-	help
-	  This option provides an implementation of the CORDIC algorithm;
-	  calculations are in fixed point. Module will be called cordic.
-
 config DDR
 	bool "JEDEC DDR data"
 	help
@@ -607,9 +600,6 @@ config SBITMAP
 config PARMAN
 	tristate "parman" if COMPILE_TEST
 
-config PRIME_NUMBERS
-	tristate
-
 config STRING_SELFTEST
 	tristate "Test string functions"
 
diff --git a/lib/Makefile b/lib/Makefile
index 3b08673e8881..4eeb814eee2e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -19,7 +19,7 @@ KCOV_INSTRUMENT_dynamic_debug.o := n
 
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
-	 idr.o int_sqrt.o extable.o \
+	 idr.o extable.o \
 	 sha1.o chacha.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
@@ -33,11 +33,11 @@ lib-$(CONFIG_SMP) += cpumask.o
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
 
-obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
+obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
-	 gcd.o lcm.o list_sort.o uuid.o iov_iter.o clz_ctz.o \
+	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
-	 percpu-refcount.o rhashtable.o reciprocal_div.o \
+	 percpu-refcount.o rhashtable.o \
 	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
@@ -90,6 +90,8 @@ endif
 obj-$(CONFIG_DEBUG_INFO_REDUCED) += debug_info.o
 CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 
+obj-y += math/
+
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
@@ -108,7 +110,6 @@ obj-$(CONFIG_DEBUG_LIST) += list_debug.o
 obj-$(CONFIG_DEBUG_OBJECTS) += debugobjects.o
 
 obj-$(CONFIG_BITREVERSE) += bitrev.o
-obj-$(CONFIG_RATIONAL)	+= rational.o
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC_T10DIF)+= crc-t10dif.o
@@ -182,8 +183,6 @@ obj-$(CONFIG_ATOMIC64_SELFTEST) += atomic64_test.o
 
 obj-$(CONFIG_CPU_RMAP) += cpu_rmap.o
 
-obj-$(CONFIG_CORDIC) += cordic.o
-
 obj-$(CONFIG_DQL) += dynamic_queue_limits.o
 
 obj-$(CONFIG_GLOB) += glob.o
@@ -225,8 +224,6 @@ obj-$(CONFIG_ASN1) += asn1_decoder.o
 
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
-obj-$(CONFIG_PRIME_NUMBERS) += prime_numbers.o
-
 hostprogs-y	:= gen_crc32table
 hostprogs-y	+= gen_crc64table
 clean-files	:= crc32table.h
diff --git a/lib/math/Kconfig b/lib/math/Kconfig
new file mode 100644
index 000000000000..73bdf37178d1
--- /dev/null
+++ b/lib/math/Kconfig
@@ -0,0 +1,11 @@
+config CORDIC
+	tristate "CORDIC algorithm"
+	help
+	  This option provides an implementation of the CORDIC algorithm;
+	  calculations are in fixed point. Module will be called cordic.
+
+config PRIME_NUMBERS
+	tristate
+
+config RATIONAL
+	bool
diff --git a/lib/math/Makefile b/lib/math/Makefile
new file mode 100644
index 000000000000..b75878420da6
--- /dev/null
+++ b/lib/math/Makefile
@@ -0,0 +1,5 @@
+obj-y += div64.o gcd.o lcm.o int_sqrt.o reciprocal_div.o
+
+obj-$(CONFIG_CORDIC)		+= cordic.o
+obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
+obj-$(CONFIG_RATIONAL)		+= rational.o
diff --git a/lib/cordic.c b/lib/math/cordic.c
similarity index 100%
rename from lib/cordic.c
rename to lib/math/cordic.c
diff --git a/lib/div64.c b/lib/math/div64.c
similarity index 100%
rename from lib/div64.c
rename to lib/math/div64.c
diff --git a/lib/gcd.c b/lib/math/gcd.c
similarity index 100%
rename from lib/gcd.c
rename to lib/math/gcd.c
diff --git a/lib/int_sqrt.c b/lib/math/int_sqrt.c
similarity index 100%
rename from lib/int_sqrt.c
rename to lib/math/int_sqrt.c
diff --git a/lib/lcm.c b/lib/math/lcm.c
similarity index 100%
rename from lib/lcm.c
rename to lib/math/lcm.c
diff --git a/lib/prime_numbers.c b/lib/math/prime_numbers.c
similarity index 100%
rename from lib/prime_numbers.c
rename to lib/math/prime_numbers.c
diff --git a/lib/rational.c b/lib/math/rational.c
similarity index 100%
rename from lib/rational.c
rename to lib/math/rational.c
diff --git a/lib/reciprocal_div.c b/lib/math/reciprocal_div.c
similarity index 100%
rename from lib/reciprocal_div.c
rename to lib/math/reciprocal_div.c
-- 
2.20.1

