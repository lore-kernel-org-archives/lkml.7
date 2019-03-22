Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC11C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA2F2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256651;
	bh=Q/W3NwF/0aElKhhHgr8UGWy4QjWoaut0ayzvMIi7xI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VM5Uy77XXfDeItm7J5aLdOwmOZDK5urLUgEtPqy20Sdyn0imrArJPyFk0fVrWji/P
	 7YRtQK59pwz7kf3wrxyn7vCUk/a9ZOuVapKDwNE9Cka+6g/oA8QdEceFF5o9mwzfH9
	 vf14k1jlsdJQDZ6Q0+wlv95E6n8quUBgvJ8Hm30k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbfCVMKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388861AbfCVMKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2B220830;
        Fri, 22 Mar 2019 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256643;
        bh=Q/W3NwF/0aElKhhHgr8UGWy4QjWoaut0ayzvMIi7xI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS/tt+jOWvqZnm9l1mNB295pQ/LOi/ZLnl3lt+59I83I4NTjz6qxmZ1Xw2cM1cJxh
         tsJ1FNbdIIiPKTDcqhaExcZxylPlokNaWuBwsanKtcRNLJSluza2B174bYyTD9JgUl
         Gaxn+vudFP4Oflha0emU1PlhY/rTbB4h6TbdqXX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 275/280] KVM: x86/mmu: Do not cache MMIO accesses while memslots are in flux
Date:   Fri, 22 Mar 2019 12:17:08 +0100
Message-Id: <20190322111347.016510644@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit ddfd1730fd829743e41213e32ccc8b4aa6dc8325 upstream.

When installing new memslots, KVM sets bit 0 of the generation number to
indicate that an update is in-progress.  Until the update is complete,
there are no guarantees as to whether a vCPU will see the old or the new
memslots.  Explicity prevent caching MMIO accesses so as to avoid using
an access cached from the old memslots after the new memslots have been
installed.

Note that it is unclear whether or not disabling caching during the
update window is strictly necessary as there is no definitive
documentation as to what ordering guarantees KVM provides with respect
to updating memslots.  That being said, the MMIO spte code does not
allow reusing sptes created while an update is in-progress, and the
associated documentation explicitly states:

    We do not want to use an MMIO sptes created with an odd generation
    number, ...  If KVM is unlucky and creates an MMIO spte while the
    low bit is 1, the next access to the spte will always be a cache miss.

At the very least, disabling the per-vCPU MMIO cache during updates will
make its behavior consistent with the MMIO spte behavior and
documentation.

Fixes: 56f17dd3fbc4 ("kvm: x86: fix stale mmio cache bug")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -181,6 +181,11 @@ static inline bool emul_is_noncanonical_
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 					gva_t gva, gfn_t gfn, unsigned access)
 {
+	u64 gen = kvm_memslots(vcpu->kvm)->generation;
+
+	if (unlikely(gen & 1))
+		return;
+
 	/*
 	 * If this is a shadow nested page table, the "GVA" is
 	 * actually a nGPA.
@@ -188,7 +193,7 @@ static inline void vcpu_cache_mmio_info(
 	vcpu->arch.mmio_gva = mmu_is_nested(vcpu) ? 0 : gva & PAGE_MASK;
 	vcpu->arch.access = access;
 	vcpu->arch.mmio_gfn = gfn;
-	vcpu->arch.mmio_gen = kvm_memslots(vcpu->kvm)->generation;
+	vcpu->arch.mmio_gen = gen;
 }
 
 static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)


