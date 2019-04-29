Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD9C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104402075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YAW/2TIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfD2T7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:59:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31849 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfD2T7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556567952; x=1588103952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GQpKXJ6rfJbjxybm+qOYB3z1XmPhKagdgdILF7N0WwA=;
  b=YAW/2TIUfZ6lfg8BpWVwIopOzQoC4esUvLA8i/wMz9QGn541VGHTXWVT
   DM5E4cz4JuAY5fhbrvRJZUB/CkEtDwPH3epgGIXj72TCuzCi9P+bWRJfb
   bqQnerhds8/7j8lz48+vmT5lYHq6ZM13olSYMKlmfOWw/MRJ8T6AVFSvs
   bS55gFBQpGH7dXv5M8FtVUbZiDHJHiC+UYjDC9Y4aZ6J9QtuqutmM7e3y
   KcJ1NmfAWQEDaVQNdsbWI7F4urwaqKbgX4VsBP2Tx0X5nxEsT076qR5I1
   nic/hcCkViPZUGlQmU3XDhurNVtW0dk90F7VytADh9FJLE3SifKQYuTKt
   A==;
X-IronPort-AV: E=Sophos;i="5.60,410,1549900800"; 
   d="scan'208";a="108309666"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 03:58:12 +0800
IronPort-SDR: YNGJGFSbVLJq1vFE7parTqt8eRgoLGwZBPS8IVC0MBHhjLuYuYws9uW2hqd0iqKHM5m0t+2UQk
 ArmV/tUMa14Etwh0RTbhw119Zs/IVa5PVQ8nrGOApdxSA0ad1dMT6bmQ/9TxfD0rj8Lk2JzzeZ
 KHsFeC6p3oBtF1Sr4W+Xz0lWRZCXwbO2K/qiQF4WWKEUrSYWX/K5Lz/zWW/sU8QBZTHB1olQb/
 9j2/zPVXS6iXBBGRfCmLSCio6AN8TxmUMoKmeEx2Szsjte4O4yBgqkJAutkQv7IeOAeLIDhgxP
 imcyt/fYV+VqA8Dx+yGMhp7l
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 Apr 2019 12:34:34 -0700
IronPort-SDR: wz9YGcayYviARxURW0XYZuUzYVCZFmYVx0XdGd5JZHZiNh02M12LMvPMG8IMYcAtZPZcy1EeDb
 h3W9jYm/1FQlZZHxDvV7Prowbsd3Hyz1a/RTdWFHN0r5GMxoiiiDXhfxhLeiwqugDGnA05Ljq4
 moiPxBN2X9YhDPIWKJYtQve9/hgsixthYTDEgtOkb23Yld3IOO/JdsyvvCGFG92A8VPkK75xXs
 A9KKcfbWLwIjssH3PDU+LBp77MSbbrSFkbhUoC8pi5FigiTn+C/eTzzxNX9qF9uVZ00cmOxTce
 epM=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2019 12:58:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>,
        Changbin Du <changbin.du@intel.com>,
        Gary Guo <gary@garyguo.net>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 1/3] x86: Move DEBUG_TLBFLUSH option.
Date:   Mon, 29 Apr 2019 12:57:57 -0700
Message-Id: <20190429195759.18330-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190429195759.18330-1-atish.patra@wdc.com>
References: <20190429195759.18330-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_TLBFLUSH was added in 'commit 3df3212f9722 ("x86/tlb: add
tlb_flushall_shift knob into debugfs")' to support tlb_flushall_shift
knob. The knob was removed in 'commit e9f4e0a9fe27 ("x86/mm: Rip out
complicated, out-of-date, buggy TLB flushing")'.  However, the debug
option was never removed from Kconfig. It was reused in commit
'9824cf9753ec ("mm: vmstats: tlb flush counters")' but the commit text
was never updated accordingly.

Update the Kconfig option description as per its current usage.

Take this opprtunity to make this kconfig option a common option as it
touches the common vmstat code. Introduce another arch specific config
HAVE_ARCH_DEBUG_TLBFLUSH that can be selected to enable this config.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/x86/Kconfig       |  1 +
 arch/x86/Kconfig.debug | 19 -------------------
 mm/Kconfig.debug       | 13 +++++++++++++
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 62fc3fda1a05..4c59f59e9491 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -132,6 +132,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_VMAP_STACK		if X86_64
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
+	select HAVE_ARCH_DEBUG_TLBFLUSH		if DEBUG_KERNEL
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 15d0fbe27872..0c8f9931e901 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -124,25 +124,6 @@ config DOUBLEFAULT
 	  option saves about 4k and might cause you much additional grey
 	  hair.
 
-config DEBUG_TLBFLUSH
-	bool "Set upper limit of TLB entries to flush one-by-one"
-	depends on DEBUG_KERNEL
-	---help---
-
-	X86-only for now.
-
-	This option allows the user to tune the amount of TLB entries the
-	kernel flushes one-by-one instead of doing a full TLB flush. In
-	certain situations, the former is cheaper. This is controlled by the
-	tlb_flushall_shift knob under /sys/kernel/debug/x86. If you set it
-	to -1, the code flushes the whole TLB unconditionally. Otherwise,
-	for positive values of it, the kernel will use single TLB entry
-	invalidating instructions according to the following formula:
-
-	flush_entries <= active_tlb_entries / 2^tlb_flushall_shift
-
-	If in doubt, say "N".
-
 config IOMMU_DEBUG
 	bool "Enable IOMMU debugging"
 	depends on GART_IOMMU && DEBUG_KERNEL
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index e3df921208c0..760c3fda8b57 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -111,3 +111,16 @@ config DEBUG_RODATA_TEST
     depends on STRICT_KERNEL_RWX
     ---help---
       This option enables a testcase for the setting rodata read-only.
+
+config HAVE_ARCH_DEBUG_TLBFLUSH
+	bool
+	depends on DEBUG_KERNEL
+
+config DEBUG_TLBFLUSH
+	bool "Save tlb flush statstics to vmstat"
+	depends on HAVE_ARCH_DEBUG_TLBFLUSH
+	help
+
+	Add tlbflush statstics to vmstat. It is really helpful understand tlbflush
+	performance and behavior. It should be enabled only for debugging purpose
+	by individual architectures explicitly by selecting HAVE_ARCH_DEBUG_TLBFLUSH.
-- 
2.21.0

