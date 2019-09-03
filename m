Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE12C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CC123697
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567527954;
	bh=RfQVQt92+3Wv3MPrBbg81D1UzAB3v3En6KOZI/CkvAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UcPP1URO7gfoFLxB61zJ56gKdzqxprCTdMbeGTuhRlzVp0J8LmJ8PEKRG4K7gSDsb
	 1kJ1bjgZ+I7IaUzOmr+H9/qo/ijJt1YJgLpmUydmxBaWTO5e43L0WSVUNo6umvCCgu
	 bUumdBX+v1u+SLI7mYp+kTA/XH49htk9MY2nMujA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfICQZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbfICQZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:25:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC4923697;
        Tue,  3 Sep 2019 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527945;
        bh=RfQVQt92+3Wv3MPrBbg81D1UzAB3v3En6KOZI/CkvAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYdT/c4E8pr/RZ/I4TtJRJloeasxmeCvt2Irjr4TU6/l6+EFL2ubaXN7gxt1VnZlg
         V+sw6OjWSFh2IgwmNiMGjGL62V4De90Ex3gJqdl4zdXz6wuH9npIfflV1KVQ8EYXhz
         3Wwvod4hYbpwI8ffrwtQqoHHF24LQ8bWGR4R2Ksc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 013/167] KVM: x86: hyperv: keep track of mismatched VP indexes
Date:   Tue,  3 Sep 2019 12:22:45 -0400
Message-Id: <20190903162519.7136-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 87ee613d076351950b74383215437f841ebbeb75 ]

In most common cases VP index of a vcpu matches its vcpu index. Userspace
is, however, free to set any mapping it wishes and we need to account for
that when we need to find a vCPU with a particular VP index. To keep search
algorithms optimal in both cases introduce 'num_mismatched_vp_indexes'
counter showing how many vCPUs with mismatching VP index we have. In case
the counter is zero we can assume vp_index == vcpu_idx.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/hyperv.c           | 26 +++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3245b95ad2d97..b6417454a9d79 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -784,6 +784,9 @@ struct kvm_hv {
 	u64 hv_reenlightenment_control;
 	u64 hv_tsc_emulation_control;
 	u64 hv_tsc_emulation_status;
+
+	/* How many vCPUs have VP index != vCPU index */
+	atomic_t num_mismatched_vp_indexes;
 };
 
 enum kvm_irqchip_mode {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 3f2775aac5545..2bb554b90b3c2 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1045,11 +1045,31 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 	struct kvm_vcpu_hv *hv_vcpu = &vcpu->arch.hyperv;
 
 	switch (msr) {
-	case HV_X64_MSR_VP_INDEX:
-		if (!host || (u32)data >= KVM_MAX_VCPUS)
+	case HV_X64_MSR_VP_INDEX: {
+		struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
+		int vcpu_idx = kvm_vcpu_get_idx(vcpu);
+		u32 new_vp_index = (u32)data;
+
+		if (!host || new_vp_index >= KVM_MAX_VCPUS)
 			return 1;
-		hv_vcpu->vp_index = (u32)data;
+
+		if (new_vp_index == hv_vcpu->vp_index)
+			return 0;
+
+		/*
+		 * The VP index is initialized to vcpu_index by
+		 * kvm_hv_vcpu_postcreate so they initially match.  Now the
+		 * VP index is changing, adjust num_mismatched_vp_indexes if
+		 * it now matches or no longer matches vcpu_idx.
+		 */
+		if (hv_vcpu->vp_index == vcpu_idx)
+			atomic_inc(&hv->num_mismatched_vp_indexes);
+		else if (new_vp_index == vcpu_idx)
+			atomic_dec(&hv->num_mismatched_vp_indexes);
+
+		hv_vcpu->vp_index = new_vp_index;
 		break;
+	}
 	case HV_X64_MSR_VP_ASSIST_PAGE: {
 		u64 gfn;
 		unsigned long addr;
-- 
2.20.1

