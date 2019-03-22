Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE71C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF392054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257699;
	bh=IjlnTNmI66NfvTRigITNMKCaVuPFT5C/FBsTGZpqiqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EobDa+mh1nhAcbQRyjVrjmfs3dXsYKFfT0/DyW2ddBskdLLkHCyndEuJZ39JMijLc
	 9PulAbYtncoT0vmntgfAQ+ZfvRRL67gufizMpvlv9CYVBKDpregy/7N8GmNDPX4il7
	 fsyKn3UF3j5pry4LQMDZhun/1mxTNETmFaFAz4CU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390771AbfCVMUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390759AbfCVMUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:20:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C0421900;
        Fri, 22 Mar 2019 12:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257245;
        bh=IjlnTNmI66NfvTRigITNMKCaVuPFT5C/FBsTGZpqiqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6cSFvcCSlo4k6xaxb67po67bGqlmSpw+KtwYuPgxlZ13ap10oIR8iAgjoSnYuF+c
         tU4F6MAmJjVCcS3jEgcvalOBcNh56DUok54QBNRMNnMaRBQ/R4zhWrbD/8yM0yuD3e
         GL8/05b3FsjO59g0/WOTxXscPL46FDA/feQElOus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 175/238] Revert "KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()"
Date:   Fri, 22 Mar 2019 12:16:34 +0100
Message-Id: <20190322111308.598088143@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Gardon <bgardon@google.com>

commit 92da008fa21034c369cdb8ca2b629fe5c196826b upstream.

This reverts commit 71883a62fcd6c70639fa12cda733378b4d997409.

The above commit contains an optimization to kvm_zap_gfn_range which
uses gfn-limited TLB flushes, if enabled. If using these limited flushes,
kvm_zap_gfn_range passes lock_flush_tlb=false to slot_handle_level_range
which creates a race when the function unlocks to call cond_resched.
See an example of this race below:

CPU 0                   CPU 1                           CPU 3
// zap_direct_gfn_range
mmu_lock()
// *ptep == pte_1
*ptep = 0
if (lock_flush_tlb)
        flush_tlbs()
mmu_unlock()
                        // In invalidate range
                        // MMU notifier
                        mmu_lock()
                        if (pte != 0)
                                *ptep = 0
                                flush = true
                        if (flush)
                                flush_remote_tlbs()
                        mmu_unlock()
                        return
                        // Host MM reallocates
                        // page previously
                        // backing guest memory.
                                                        // Guest accesses
                                                        // invalid page
                                                        // through pte_1
                                                        // in its TLB!!

Tested: Ran all kvm-unit-tests on a Intel Haswell machine with and
	without this patch. The patch introduced no new failures.

Signed-off-by: Ben Gardon <bgardon@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5635,13 +5635,8 @@ void kvm_zap_gfn_range(struct kvm *kvm,
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	bool flush_tlb = true;
-	bool flush = false;
 	int i;
 
-	if (kvm_available_flush_tlb_with_range())
-		flush_tlb = false;
-
 	spin_lock(&kvm->mmu_lock);
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
 		slots = __kvm_memslots(kvm, i);
@@ -5653,17 +5648,12 @@ void kvm_zap_gfn_range(struct kvm *kvm,
 			if (start >= end)
 				continue;
 
-			flush |= slot_handle_level_range(kvm, memslot,
-					kvm_zap_rmapp, PT_PAGE_TABLE_LEVEL,
-					PT_MAX_HUGEPAGE_LEVEL, start,
-					end - 1, flush_tlb);
+			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
+						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
+						start, end - 1, true);
 		}
 	}
 
-	if (flush)
-		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
-				gfn_end - gfn_start + 1);
-
 	spin_unlock(&kvm->mmu_lock);
 }
 


