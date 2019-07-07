Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEF9C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD6C20659
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfGGTmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 15:42:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57572 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727606AbfGGTiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 15:38:11 -0400
Received: from 94.197.121.43.threembb.co.uk ([94.197.121.43] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz7-0006iS-Cw; Sun, 07 Jul 2019 20:38:05 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz5-0005cU-Hn; Sun, 07 Jul 2019 20:38:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>
Date:   Sun, 07 Jul 2019 17:54:17 +0100
Message-ID: <lsq.1562518457.293385462@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 077/129] KVM: x86/mmu: Do not cache MMIO accesses
 while memslots are in flux
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
X-SA-Exim-Connect-IP: 94.197.121.43
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.70-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -75,10 +75,15 @@ static inline u32 bit(int bitno)
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 					gva_t gva, gfn_t gfn, unsigned access)
 {
+	u64 gen = kvm_memslots(vcpu->kvm)->generation;
+
+	if (unlikely(gen & 1))
+		return;
+
 	vcpu->arch.mmio_gva = gva & PAGE_MASK;
 	vcpu->arch.access = access;
 	vcpu->arch.mmio_gfn = gfn;
-	vcpu->arch.mmio_gen = kvm_memslots(vcpu->kvm)->generation;
+	vcpu->arch.mmio_gen = gen;
 }
 
 static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)

