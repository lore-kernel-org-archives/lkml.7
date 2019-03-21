Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF89FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB0E2190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfCURT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:19:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60424 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfCURT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:19:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C606374;
        Thu, 21 Mar 2019 10:19:27 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 853EB3F614;
        Thu, 21 Mar 2019 10:19:25 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>
Subject: [PATCH] kmemleak: powerpc: skip scanning holes in the .bss section
Date:   Thu, 21 Mar 2019 17:19:17 +0000
Message-Id: <20190321171917.62049-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
kvm_tmp[] into the .bss section and then free the rest of unused spaces
back to the page allocator.

kernel_init
  kvm_guest_init
    kvm_free_tmp
      free_reserved_area
        free_unref_page
          free_unref_page_prepare

With DEBUG_PAGEALLOC=y, it will unmap those pages from kernel. As the
result, kmemleak scan will trigger a panic when it scans the .bss
section with unmapped pages.

This patch creates dedicated kmemleak objects for the .data, .bss and
potentially .data..ro_after_init sections to allow partial freeing via
the kmemleak_free_part() in the powerpc kvm_free_tmp() function.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Posting as a proper patch following the inlined one here:

http://lkml.kernel.org/r/20190320181656.GB38229@arrakis.emea.arm.com

Changes from the above:

- Added comment to the powerpc kmemleak_free_part() call

- Only register the .data..ro_after_init in kmemleak if not contained
  within the .data sections (which seems to be the case for lots of
  architectures)

I preserved part of Qian's original commit message but changed the
author since I rewrote the patch.

 arch/powerpc/kernel/kvm.c |  7 +++++++
 mm/kmemleak.c             | 16 +++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 683b5b3805bd..cd381e2291df 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -22,6 +22,7 @@
 #include <linux/kvm_host.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/kmemleak.h>
 #include <linux/kvm_para.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -712,6 +713,12 @@ static void kvm_use_magic_page(void)
 
 static __init void kvm_free_tmp(void)
 {
+	/*
+	 * Inform kmemleak about the hole in the .bss section since the
+	 * corresponding pages will be unmapped with DEBUG_PAGEALLOC=y.
+	 */
+	kmemleak_free_part(&kvm_tmp[kvm_tmp_index],
+			   ARRAY_SIZE(kvm_tmp) - kvm_tmp_index);
 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 707fa5579f66..6c318f5ac234 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1529,11 +1529,6 @@ static void kmemleak_scan(void)
 	}
 	rcu_read_unlock();
 
-	/* data/bss scanning */
-	scan_large_block(_sdata, _edata);
-	scan_large_block(__bss_start, __bss_stop);
-	scan_large_block(__start_ro_after_init, __end_ro_after_init);
-
 #ifdef CONFIG_SMP
 	/* per-cpu sections scanning */
 	for_each_possible_cpu(i)
@@ -2071,6 +2066,17 @@ void __init kmemleak_init(void)
 	}
 	local_irq_restore(flags);
 
+	/* register the data/bss sections */
+	create_object((unsigned long)_sdata, _edata - _sdata,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+	/* only register .data..ro_after_init if not within .data */
+	if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
+		create_object((unsigned long)__start_ro_after_init,
+			      __end_ro_after_init - __start_ro_after_init,
+			      KMEMLEAK_GREY, GFP_ATOMIC);
+
 	/*
 	 * This is the point where tracking allocations is safe. Automatic
 	 * scanning is started during the late initcall. Add the early logged
