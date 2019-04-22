Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F43C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDE2204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963580;
	bh=cw95qiR+/hxhjeTr6I3fp8+CwUoEf97TOazZLESCNtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HYse6yF0Kbc2zCx8JNrWsRGvBxAoka63dRki21PTgSLTWF2GqdClsD+GWMM59ZK3u
	 syTWzT5rRiKvCNuAW7Dw0Gai9qGaETpVyxFnoTTCnrUt16eEqRxFQEz9vauwMnKngV
	 GugRWJCzmStQ0drI2fVm9YAlkppk1kPlqfvbAC9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfDVUGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729493AbfDVToc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9116E204EC;
        Mon, 22 Apr 2019 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962272;
        bh=cw95qiR+/hxhjeTr6I3fp8+CwUoEf97TOazZLESCNtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vs+K7YpseBsw5ENNztF+7CoAS/iUYxgr3TaD88NPVf96r8N1BdQpB7c/Zkczg6GqI
         CGOT4H20T1vot+kVxV2CU15DcB31H9mJX/LEfQ9b0FNdDncmORKz0biyKXAg3ICJ9H
         GEAdElxWase2RaGZCx4+3MvSVSsMfC+jt+Z9dfjU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 79/98] KVM: nVMX: Do not inherit quadrant and invalid for the root shadow EPT
Date:   Mon, 22 Apr 2019 15:41:46 -0400
Message-Id: <20190422194205.10404-79-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit 552c69b1dc714854a5f4e27d37a43c6d797adf7d ]

Explicitly zero out quadrant and invalid instead of inheriting them from
the root_mmu.  Functionally, this patch is a nop as we (should) never
set quadrant for a direct mapped (EPT) root_mmu and nested EPT is only
allowed if EPT is used for L1, and the root_mmu will never be invalid at
this point.

Explicitly setting flags sets the stage for repurposing the legacy
paging bits in role, e.g. nxe, cr0_wp, and sm{a,e}p_andnot_wp, at which
point 'smm' would be the only flag to be inherited from root_mmu.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/x86/kvm/mmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 9ab33cab9486..acab95dcffb6 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4915,11 +4915,15 @@ static union kvm_mmu_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 				   bool execonly)
 {
-	union kvm_mmu_role role;
+	union kvm_mmu_role role = {0};
+	union kvm_mmu_page_role root_base = vcpu->arch.root_mmu.mmu_role.base;
 
-	/* Base role is inherited from root_mmu */
-	role.base.word = vcpu->arch.root_mmu.mmu_role.base.word;
-	role.ext = kvm_calc_mmu_role_ext(vcpu);
+	/* Legacy paging and SMM flags are inherited from root_mmu */
+	role.base.smm = root_base.smm;
+	role.base.nxe = root_base.nxe;
+	role.base.cr0_wp = root_base.cr0_wp;
+	role.base.smep_andnot_wp = root_base.smep_andnot_wp;
+	role.base.smap_andnot_wp = root_base.smap_andnot_wp;
 
 	role.base.level = PT64_ROOT_4LEVEL;
 	role.base.direct = false;
@@ -4927,6 +4931,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	role.base.guest_mode = true;
 	role.base.access = ACC_ALL;
 
+	role.ext = kvm_calc_mmu_role_ext(vcpu);
 	role.ext.execonly = execonly;
 
 	return role;
-- 
2.19.1

