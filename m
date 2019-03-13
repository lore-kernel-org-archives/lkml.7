Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D536C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35BA2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IxW5mbW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfCMO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:57:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41057 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:57:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id v10so2207007qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Un1Wj5GPEV4DDdwQhW14uochoQcu3HXcwsxXJUzPAR4=;
        b=IxW5mbW8OXhWYBl5olTK0B4P4DCUucECOk4BS6ZorrPhOInBXBY8Ll0COS9gSTZgjc
         W42sTm9x9tH3qiNfjLBfVuCc63CEIutI4JDGjggyTlcovacih/UCrW/erEvpQYwiTvU0
         dxNBramECvQraogjqbu1WQJP5xCmW5sy5ZRXyxEStYJ7R49ZNkdEke86Rebr6B5VQkgS
         aUZIrQXhpoiCg63BuS56GnFtuB/VMLt+c7L6Hy0bfYht0GQLci1aUVfzT8UYDS7sL0dU
         vc0hruN0qK6Nc5F7nnTlpyQJABDow6oCBb3jBb2Zj+FWGm9JqYaYIjNSv94DE9+DUs2B
         HFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Un1Wj5GPEV4DDdwQhW14uochoQcu3HXcwsxXJUzPAR4=;
        b=sHynCYea42MYN/iVYXlGVw+oBWcXYP3FsXTrm1f17/XRoDHL1fcLnlVCfjmPrnvyAZ
         RTDh6gHIpo523dZpl5FaEB0zjvYVFmIJnCASRLYr1ssMVbfBGCu2vazBmHlYvugq/6uT
         X3fm5j3J1TrsXh/0wntnq/rfsFmKR/ZZiX0FfdTu2DpjMygg9yvdvek12VreLHZ4OXnt
         xHANzmASzk9qWGw9YicjX6/+7RUWuCYw316aCjVypdpdHRDWSXAhgDmhRMxGWBnkrePB
         J2zOundziqwpuc8Y/CCN+Cp/tDXpostgzRiquJAjXyJi99GMrVft85bBjhD3NGIM/c8a
         EesA==
X-Gm-Message-State: APjAAAU55dshO5o7za5tyeBISJ9L3WbtLiPSXwCaX85zVHo5VGev5FMt
        o2mwNr7uY/DqKC0rDHfmi+6lFCH+pUY=
X-Google-Smtp-Source: APXvYqytxb63jyMnDlJeptDoovBqtzEN/GpsodLxiXOb+sB9nGXC86ZavBMJf5o3MI71ggxndlF0+A==
X-Received: by 2002:ac8:371d:: with SMTP id o29mr4020271qtb.389.1552489063708;
        Wed, 13 Mar 2019 07:57:43 -0700 (PDT)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a43sm8172501qta.54.2019.03.13.07.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 07:57:42 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] kmemleak: skip scanning holes in the .bss section
Date:   Wed, 13 Mar 2019 10:57:17 -0400
Message-Id: <20190313145717.46369-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
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
result, kmemleak scan will trigger a panic below when it scans the .bss
section with unmapped pages.

Since this is done way before the first kmemleak_scan(), just go
lockless to make the implementation simple and skip those pages when
scanning the .bss section. Later, those pages could be tracked by
kmemleak again once allocated by the page allocator. Overall, this is
such a special case, so no need to make it a generic to let kmemleak
gain an ability to skip blocks in scan_large_block() for now.

BUG: Unable to handle kernel data access at 0xc000000001610000
Faulting instruction address: 0xc0000000003cc178
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA pSeries
CPU: 3 PID: 130 Comm: kmemleak Kdump: loaded Not tainted 5.0.0+ #9
REGS: c0000004b05bf940 TRAP: 0300   Not tainted  (5.0.0+)
NIP [c0000000003cc178] scan_block+0xa8/0x190
LR [c0000000003cc170] scan_block+0xa0/0x190
Call Trace:
[c0000004b05bfbd0] [c0000000003cc170] scan_block+0xa0/0x190 (unreliable)
[c0000004b05bfc30] [c0000000003cc2c0] scan_large_block+0x60/0xa0
[c0000004b05bfc70] [c0000000003ccc64] kmemleak_scan+0x254/0x960
[c0000004b05bfd40] [c0000000003cdd50] kmemleak_scan_thread+0xec/0x12c
[c0000004b05bfdb0] [c000000000104388] kthread+0x1b8/0x1c0
[c0000004b05bfe20] [c00000000000b364] ret_from_kernel_thread+0x5c/0x78
Instruction dump:
7fa3eb78 4844667d 60000000 60000000 60000000 60000000 3bff0008 7fbcf840
409d00b8 4bfffeed 2fa30000 409e00ac <e87f0000> e93e0128 7fa91840
419dffdc

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: make the function __init per Andrew.

 arch/powerpc/kernel/kvm.c |  3 +++
 include/linux/kmemleak.h  |  4 ++++
 mm/kmemleak.c             | 25 ++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 683b5b3805bd..5cddc8fc56bb 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/pagemap.h>
+#include <linux/kmemleak.h>
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -712,6 +713,8 @@ static void kvm_use_magic_page(void)
 
 static __init void kvm_free_tmp(void)
 {
+	kmemleak_bss_hole(&kvm_tmp[kvm_tmp_index],
+			  &kvm_tmp[ARRAY_SIZE(kvm_tmp)]);
 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
 }
diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 5ac416e2d339..17d3684e81ab 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -46,6 +46,7 @@ extern void kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
 extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
 extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
 extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
+extern void kmemleak_bss_hole(void *start, void *stop) __init;
 
 static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
 					    int min_count, slab_flags_t flags,
@@ -131,6 +132,9 @@ static inline void kmemleak_not_leak_phys(phys_addr_t phys)
 static inline void kmemleak_ignore_phys(phys_addr_t phys)
 {
 }
+static inline void kmemleak_bss_hole(void *start, void *stop)
+{
+}
 
 #endif	/* CONFIG_DEBUG_KMEMLEAK */
 
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 707fa5579f66..a2d894d3de07 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -237,6 +237,10 @@ static int kmemleak_skip_disable;
 /* If there are leaks that can be reported */
 static bool kmemleak_found_leaks;
 
+/* Skip scanning of a range in the .bss section. */
+static void *bss_hole_start;
+static void *bss_hole_stop;
+
 static bool kmemleak_verbose;
 module_param_named(verbose, kmemleak_verbose, bool, 0600);
 
@@ -1265,6 +1269,18 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
 
+/**
+ * kmemleak_bss_hole - skip scanning a range in the .bss section
+ *
+ * @start:	start of the range
+ * @stop:	end of the range
+ */
+void __init kmemleak_bss_hole(void *start, void *stop)
+{
+	bss_hole_start = start;
+	bss_hole_stop = stop;
+}
+
 /*
  * Update an object's checksum and return true if it was modified.
  */
@@ -1531,7 +1547,14 @@ static void kmemleak_scan(void)
 
 	/* data/bss scanning */
 	scan_large_block(_sdata, _edata);
-	scan_large_block(__bss_start, __bss_stop);
+
+	if (bss_hole_start) {
+		scan_large_block(__bss_start, bss_hole_start);
+		scan_large_block(bss_hole_stop, __bss_stop);
+	} else {
+		scan_large_block(__bss_start, __bss_stop);
+	}
+
 	scan_large_block(__start_ro_after_init, __end_ro_after_init);
 
 #ifdef CONFIG_SMP
-- 
2.17.2 (Apple Git-113)

