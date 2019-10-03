Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE87C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0F920865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124451;
	bh=h0rsyqVWWEVXXs6hc1a5kbfGdU7JSDnYzCi6ysQNAjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oDOJN6QwrM5gFu+fP3Q1R+yTTL/3wlFNbJKtzZ6LWO+uA4ZSIr6dPk/Yw5YMdgyhM
	 nEX1otssVnMFWvny6Yg368YyUYUgyUUARUE/dJZ191w3Kw5oMI7ETNQ/CyFixE8F4T
	 FfXOsn8ZA3RLYYLLv0ouzk8H1oN28aCtSzlU8Dh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfJCP7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731378AbfJCP7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:59:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF5A21D81;
        Thu,  3 Oct 2019 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118380;
        bh=h0rsyqVWWEVXXs6hc1a5kbfGdU7JSDnYzCi6ysQNAjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x+SPhiLvgXVdkNPsxvVftd7DhjHEL8V3/5iMHwnNktOh6Cx3BLr/nS2Zo2tjK51gP
         fWkWINAqEqyI4/wME2g4k6mHz/obFZZPgBPqcQXHyb0gtq9OF2KwNWEUsIK/TPj/ko
         VNgBO+Hqswpk2hwSqj9TTIJVF2IGqknsrISBZ5BA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Doug Reiland <doug.reiland@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 83/99] KVM: x86: Manually calculate reserved bits when loading PDPTRS
Date:   Thu,  3 Oct 2019 17:53:46 +0200
Message-Id: <20191003154336.641144460@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 16cfacc8085782dab8e365979356ce1ca87fd6cc upstream.

Manually generate the PDPTR reserved bit mask when explicitly loading
PDPTRs.  The reserved bits that are being tracked by the MMU reflect the
current paging mode, which is unlikely to be PAE paging in the vast
majority of flows that use load_pdptrs(), e.g. CR0 and CR4 emulation,
__set_sregs(), etc...  This can cause KVM to incorrectly signal a bad
PDPTR, or more likely, miss a reserved bit check and subsequently fail
a VM-Enter due to a bad VMCS.GUEST_PDPTR.

Add a one off helper to generate the reserved bits instead of sharing
code across the MMU's calculations and the PDPTR emulation.  The PDPTR
reserved bits are basically set in stone, and pushing a helper into
the MMU's calculation adds unnecessary complexity without improving
readability.

Oppurtunistically fix/update the comment for load_pdptrs().

Note, the buggy commit also introduced a deliberate functional change,
"Also remove bit 5-6 from rsvd_bits_mask per latest SDM.", which was
effectively (and correctly) reverted by commit cd9ae5fe47df ("KVM: x86:
Fix page-tables reserved bits").  A bit of SDM archaeology shows that
the SDM from late 2008 had a bug (likely a copy+paste error) where it
listed bits 6:5 as AVL and A for PDPTEs used for 4k entries but reserved
for 2mb entries.  I.e. the SDM contradicted itself, and bits 6:5 are and
always have been reserved.

Fixes: 20c466b56168d ("KVM: Use rsvd_bits_mask in load_pdptrs()")
Cc: stable@vger.kernel.org
Cc: Nadav Amit <nadav.amit@gmail.com>
Reported-by: Doug Reiland <doug.reiland@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -523,8 +523,14 @@ static int kvm_read_nested_guest_page(st
 				       data, offset, len, access);
 }
 
+static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
+{
+	return rsvd_bits(cpuid_maxphyaddr(vcpu), 63) | rsvd_bits(5, 8) |
+	       rsvd_bits(1, 2);
+}
+
 /*
- * Load the pae pdptrs.  Return true is they are all valid.
+ * Load the pae pdptrs.  Return 1 if they are all valid, 0 otherwise.
  */
 int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
 {
@@ -543,8 +549,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, s
 	}
 	for (i = 0; i < ARRAY_SIZE(pdpte); ++i) {
 		if (is_present_gpte(pdpte[i]) &&
-		    (pdpte[i] &
-		     vcpu->arch.mmu.guest_rsvd_check.rsvd_bits_mask[0][2])) {
+		    (pdpte[i] & pdptr_rsvd_bits(vcpu))) {
 			ret = 0;
 			goto out;
 		}


