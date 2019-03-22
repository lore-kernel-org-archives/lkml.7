Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E582FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B647D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255753;
	bh=ZKBCcmlZgW6ospzXmYvEUHm2WLYgZI5fxGlLqYVoHZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zbrh06gyf1X457w5/wQ4x3Lsd4sp5b47VuijIDA/mtfFdP13suFWk3sn6w7dqiYlH
	 LQiaOv+GDJy09WfgdHJEsGo2IgqjHss/fdlxVcAN18PTjxhkwa9P4mhGhIm4oRiAoW
	 5wkHMrgB0LncU5krtZGF3RN9cZPUfdebD4oIOe5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbfCVLzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733177AbfCVLzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:55:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E5D20850;
        Fri, 22 Mar 2019 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255748;
        bh=ZKBCcmlZgW6ospzXmYvEUHm2WLYgZI5fxGlLqYVoHZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YagCNeM8UnjKmQFj+F5QHXVcLFU09hiNXJWIX6Wwpvt+6dHDFcdH49PB1YQShcSfp
         RPwM/t19nR//rb4GMNitf5o9blI88snQXQxvp60gaCXEwx3e2ap0HGXeCz+cV3xPll
         j69LV2IvuBqAoOe89/mr/AN71ou1QVT8AVFXZ7zQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 179/183] KVM: x86/mmu: Do not cache MMIO accesses while memslots are in flux
Date:   Fri, 22 Mar 2019 12:16:47 +0100
Message-Id: <20190322111254.864235695@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -136,6 +136,11 @@ static inline bool emul_is_noncanonical_
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
@@ -143,7 +148,7 @@ static inline void vcpu_cache_mmio_info(
 	vcpu->arch.mmio_gva = mmu_is_nested(vcpu) ? 0 : gva & PAGE_MASK;
 	vcpu->arch.access = access;
 	vcpu->arch.mmio_gfn = gfn;
-	vcpu->arch.mmio_gen = kvm_memslots(vcpu->kvm)->generation;
+	vcpu->arch.mmio_gen = gen;
 }
 
 static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)


