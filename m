Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A7C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F23208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354671;
	bh=dXcC/Wuwd5tm+L9zOd3+2Jf2gZLtQect1/cUq1QpcvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JN7xWxI6SUOAvjPblgmjwRsNMSNZccssiq8JrsP1dOnFYrc69RY+jD+qNNU02Sj6D
	 JtSalwEDUW0pPxxL6Y2lg2POFseE1e54CChKCQxx+WRZ/jt68/SmTngEyjYoB+b1d0
	 CT4JgMP6G/dQGh2iRQfQwESr2og6kE+VltWJLHyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbfETMRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732086AbfETMRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:17:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4406820815;
        Mon, 20 May 2019 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354668;
        bh=dXcC/Wuwd5tm+L9zOd3+2Jf2gZLtQect1/cUq1QpcvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYcip7vMNrVWkAfbFvctgV1YXKr5rFkcodypbLCrTWLJevNBGV+JBmugUi/RTNgFG
         8qLHOc5tek+aIRbVrJW1HUtEI1PjJOVjagd3m6d4UgV5iCEgJZac6EXr93/6pY0KKt
         tVLaKwQSEMWomjk51iM7iD85Ds8oz6aiTBoH6CxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 44/44] KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated writes
Date:   Mon, 20 May 2019 14:14:33 +0200
Message-Id: <20190520115236.152628700@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115230.720347034@linuxfoundation.org>
References: <20190520115230.720347034@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 11988499e62b310f3bf6f6d0a807a06d3f9ccc96 upstream.

KVM allows userspace to violate consistency checks related to the
guest's CPUID model to some degree.  Generally speaking, userspace has
carte blanche when it comes to guest state so long as jamming invalid
state won't negatively affect the host.

Currently this is seems to be a non-issue as most of the interesting
EFER checks are missing, e.g. NX and LME, but those will be added
shortly.  Proactively exempt userspace from the CPUID checks so as not
to break userspace.

Note, the efer_reserved_bits check still applies to userspace writes as
that mask reflects the host's capabilities, e.g. KVM shouldn't allow a
guest to run with NX=1 if it has been disabled in the host.

Fixes: d80174745ba39 ("KVM: SVM: Only allow setting of EFER_SVME when CPUID SVM is set")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |   33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1073,11 +1073,8 @@ static int do_get_msr_feature(struct kvm
 	return 0;
 }
 
-bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
+static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
-	if (efer & efer_reserved_bits)
-		return false;
-
 	if (efer & EFER_FFXSR) {
 		struct kvm_cpuid_entry2 *feat;
 
@@ -1095,19 +1092,33 @@ bool kvm_valid_efer(struct kvm_vcpu *vcp
 	}
 
 	return true;
+
+}
+bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
+{
+	if (efer & efer_reserved_bits)
+		return false;
+
+	return __kvm_valid_efer(vcpu, efer);
 }
 EXPORT_SYMBOL_GPL(kvm_valid_efer);
 
-static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
+static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u64 old_efer = vcpu->arch.efer;
+	u64 efer = msr_info->data;
 
-	if (!kvm_valid_efer(vcpu, efer))
-		return 1;
+	if (efer & efer_reserved_bits)
+		return false;
 
-	if (is_paging(vcpu)
-	    && (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
-		return 1;
+	if (!msr_info->host_initiated) {
+		if (!__kvm_valid_efer(vcpu, efer))
+			return 1;
+
+		if (is_paging(vcpu) &&
+		    (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
+			return 1;
+	}
 
 	efer &= ~EFER_LMA;
 	efer |= vcpu->arch.efer & EFER_LMA;
@@ -2203,7 +2214,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
 		vcpu->arch.arch_capabilities = data;
 		break;
 	case MSR_EFER:
-		return set_efer(vcpu, data);
+		return set_efer(vcpu, msr_info);
 	case MSR_K7_HWCR:
 		data &= ~(u64)0x40;	/* ignore flush filter disable */
 		data &= ~(u64)0x100;	/* ignore ignne emulation enable */


