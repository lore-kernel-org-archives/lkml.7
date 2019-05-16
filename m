Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F29C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D7520862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfEPI0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:26:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:24486 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfEPI0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:26:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 01:26:51 -0700
X-ExtLoop1: 1
Received: from skl-s2.bj.intel.com ([10.240.192.102])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2019 01:26:48 -0700
From:   Luwei Kang <luwei.kang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v1 4/6] KVM: VMX: Allocate XSAVE area for Intel PT configuration
Date:   Thu, 16 May 2019 16:25:12 +0800
Message-Id: <1557995114-21629-5-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557995114-21629-1-git-send-email-luwei.kang@intel.com>
References: <1557995114-21629-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate XSAVE area for host and guest Intel PT
configuration when Intel PT working in HOST_GUEST
mode. Intel PT configuration state can be saved
using XSAVES and restored by XRSTORS instruction.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 25 ++++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.h |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4595230..4691665 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1033,6 +1033,7 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
 
 static int pt_init(struct vcpu_vmx *vmx)
 {
+	unsigned int eax, ebx, ecx, edx;
 	u32 pt_state_sz = sizeof(struct pt_state) + sizeof(u64) *
 		intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2;
 
@@ -1044,13 +1045,35 @@ static int pt_init(struct vcpu_vmx *vmx)
 	vmx->pt_desc->host_ctx = (struct pt_state *)(vmx->pt_desc + 1);
 	vmx->pt_desc->guest_ctx = (void *)vmx->pt_desc->host_ctx + pt_state_sz;
 
+	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+	if (ecx & XFEATURE_MASK_PT) {
+		vmx->pt_desc->host_xs = kmem_cache_zalloc(x86_fpu_cache,
+							GFP_KERNEL_ACCOUNT);
+		vmx->pt_desc->guest_xs = kmem_cache_zalloc(x86_fpu_cache,
+							GFP_KERNEL_ACCOUNT);
+		if (!vmx->pt_desc->host_xs || !vmx->pt_desc->guest_xs) {
+			if (vmx->pt_desc->host_xs)
+				kmem_cache_free(x86_fpu_cache,
+						vmx->pt_desc->host_xs);
+			if (vmx->pt_desc->guest_xs)
+				kmem_cache_free(x86_fpu_cache,
+						vmx->pt_desc->guest_xs);
+		} else
+			vmx->pt_desc->pt_xsave = true;
+	}
+
 	return 0;
 }
 
 static void pt_uninit(struct vcpu_vmx *vmx)
 {
-	if (pt_mode == PT_MODE_HOST_GUEST)
+	if (pt_mode == PT_MODE_HOST_GUEST) {
 		kfree(vmx->pt_desc);
+		if (vmx->pt_desc->pt_xsave) {
+			kmem_cache_free(x86_fpu_cache, vmx->pt_desc->host_xs);
+			kmem_cache_free(x86_fpu_cache, vmx->pt_desc->guest_xs);
+		}
+	}
 }
 
 void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 283f69d..e103991 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -69,8 +69,11 @@ struct pt_desc {
 	u64 ctl_bitmask;
 	u32 addr_range;
 	u32 caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
+	bool pt_xsave;
 	struct pt_state *host_ctx;
 	struct pt_state *guest_ctx;
+	struct fpu *host_xs;
+	struct fpu *guest_xs;
 };
 
 /*
-- 
1.8.3.1

