Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20053C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1CF208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="uQKwZ7Jg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfGLIXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:23:00 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:10819 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1562919779; x=1594455779;
  h=from:to:cc:subject:date:message-id;
  bh=2GHXvodd5mYiOI7g2dcIp8dLyBwMPtlaooER9mc1rHw=;
  b=uQKwZ7Jg7PHZ8DeTmIOtcHBsqI1w2SDCconW1uI7qftZQV3HIDpm+h8a
   xipaRH0bneeM4rsBvt4/tSWR9bpJK8kTKQk75QYDUN8TOb2382j7wkMVg
   ltEWB3DkRrpzU3dq0MUUWvAl1kGbnj2/QuWcb+wEANGAhqmN8kifXalHu
   E=;
X-IronPort-AV: E=Sophos;i="5.62,481,1554768000"; 
   d="scan'208";a="404647834"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Jul 2019 08:22:57 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 8BFEEA252A;
        Fri, 12 Jul 2019 08:22:53 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x6C8MoPk016257;
        Fri, 12 Jul 2019 10:22:50 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x6C8MnRH016242;
        Fri, 12 Jul 2019 10:22:49 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm/arm64: Properly check for MMIO regions
Date:   Fri, 12 Jul 2019 10:22:08 +0200
Message-Id: <1562919728-642-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valid RAM can live outside kernel control (e.g. using "mem=" command-line
parameter). This memory can still be used as valid guest memory for KVM. So
ensure that we validate that this memory is definitely not "RAM" before
assuming that it is an MMIO region.

One way to use memory outside kernel control is:

1- Pass 'mem=' in the kernel command-line to limit the amount of memory managed
   by the kernel.
2- Map this physical memory you want to give to the guest with:
   mmap("/dev/mem", physical_address_offset, ..)
3- Use the user-space virtual address as the "userspace_addr" field in
   KVM_SET_USER_MEMORY_REGION ioctl.

One of the limitations of the current /dev/mem for ARM is that it would map
this memory as uncached without this patch:
https://lkml.org/lkml/2019/7/11/684

This work is similar to the work done on x86 here:
https://lkml.org/lkml/2019/1/31/933

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 virt/kvm/arm/mmu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 06180c9..2105134 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -8,6 +8,7 @@
 #include <linux/kvm_host.h>
 #include <linux/io.h>
 #include <linux/hugetlb.h>
+#include <linux/memblock.h>
 #include <linux/sched/signal.h>
 #include <trace/events/kvm.h>
 #include <asm/pgalloc.h>
@@ -89,7 +90,7 @@ static void kvm_flush_dcache_pud(struct kvm *kvm,
 
 static bool kvm_is_device_pfn(unsigned long pfn)
 {
-	return !pfn_valid(pfn);
+	return !memblock_is_memory(__pfn_to_phys(pfn));
 }
 
 /**
@@ -949,6 +950,7 @@ static void stage2_unmap_memslot(struct kvm *kvm,
 	do {
 		struct vm_area_struct *vma = find_vma(current->mm, hva);
 		hva_t vm_start, vm_end;
+		gpa_t gpa;
 
 		if (!vma || vma->vm_start >= reg_end)
 			break;
@@ -959,11 +961,14 @@ static void stage2_unmap_memslot(struct kvm *kvm,
 		vm_start = max(hva, vma->vm_start);
 		vm_end = min(reg_end, vma->vm_end);
 
-		if (!(vma->vm_flags & VM_PFNMAP)) {
-			gpa_t gpa = addr + (vm_start - memslot->userspace_addr);
-			unmap_stage2_range(kvm, gpa, vm_end - vm_start);
-		}
 		hva = vm_end;
+
+		if ((vma->vm_flags & VM_PFNMAP) &&
+		    !memblock_is_memory(__pfn_to_phys(vma->vm_pgoff)))
+			continue;
+
+		gpa = addr + (vm_start - memslot->userspace_addr);
+		unmap_stage2_range(kvm, gpa, vm_end - vm_start);
 	} while (hva < reg_end);
 }
 
@@ -2329,7 +2334,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		vm_start = max(hva, vma->vm_start);
 		vm_end = min(reg_end, vma->vm_end);
 
-		if (vma->vm_flags & VM_PFNMAP) {
+		if ((vma->vm_flags & VM_PFNMAP) &&
+		    !memblock_is_memory(__pfn_to_phys(vma->vm_pgoff))) {
 			gpa_t gpa = mem->guest_phys_addr +
 				    (vm_start - mem->userspace_addr);
 			phys_addr_t pa;
-- 
2.7.4

