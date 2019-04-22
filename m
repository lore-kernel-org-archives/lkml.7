Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4793C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4F3204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963564;
	bh=8P5NYuag8dkMcjMoSzPUQkd5WOIKhdU1lklgLEmKxFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gyw4r6larHoY+/viGK9uXEom4f8m58MSZ2/Cf6yXAAzNv2SL9nxhq14to+7AeW5UP
	 nRjAY2zK75NWK+A+9vH+/oIZUlA/10xVJxBOSED6FWLaQzqZnQVnYGgU4BvTZRjuXc
	 5GCuse+IsdQ+GH8znicV+eD0K/+rNvQGgvFuD23o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbfDVUGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbfDVTof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C588C217D4;
        Mon, 22 Apr 2019 19:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962274;
        bh=8P5NYuag8dkMcjMoSzPUQkd5WOIKhdU1lklgLEmKxFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vivficklkGLgjFe3GSAy+R7HR6XJP4QOZQjOYO2TNjMhGQjUKREfm/CZjJ4RFQB2G
         6NizNvyOSmBQDfhPxAoUtFC+G8W3QiXObUsIiMn6YrVy/u3O523qSKajDiw4G5c0sU
         s7n+nLVzAwh/xbhr0ynyn9+MO6unBQtyHQAlQ2e8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        Jim Mattson <jmattson@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 80/98] KVM: SVM: Workaround errata#1096 (insn_len maybe zero on SMAP violation)
Date:   Mon, 22 Apr 2019 15:41:47 -0400
Message-Id: <20190422194205.10404-80-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Singh, Brijesh" <brijesh.singh@amd.com>

[ Upstream commit 05d5a48635259e621ea26d01e8316c6feeb34190 ]

Errata#1096:

On a nested data page fault when CR.SMAP=1 and the guest data read
generates a SMAP violation, GuestInstrBytes field of the VMCB on a
VMEXIT will incorrectly return 0h instead the correct guest
instruction bytes .

Recommend Workaround:

To determine what instruction the guest was executing the hypervisor
will have to decode the instruction at the instruction pointer.

The recommended workaround can not be implemented for the SEV
guest because guest memory is encrypted with the guest specific key,
and instruction decoder will not be able to decode the instruction
bytes. If we hit this errata in the SEV guest then log the message
and request a guest shutdown.

Reported-by: Venkatesh Srinivas <venkateshs@google.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/mmu.c              |  8 +++++---
 arch/x86/kvm/svm.c              | 32 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c          |  6 ++++++
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 71d763ad2637..9f2d890733a9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1198,6 +1198,8 @@ struct kvm_x86_ops {
 	int (*nested_enable_evmcs)(struct kvm_vcpu *vcpu,
 				   uint16_t *vmcs_version);
 	uint16_t (*nested_get_evmcs_version)(struct kvm_vcpu *vcpu);
+
+	bool (*need_emulation_on_page_fault)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index acab95dcffb6..77dbb57412cc 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5395,10 +5395,12 @@ emulate:
 	 * This can happen if a guest gets a page-fault on data access but the HW
 	 * table walker is not able to read the instruction page (e.g instruction
 	 * page is not present in memory). In those cases we simply restart the
-	 * guest.
+	 * guest, with the exception of AMD Erratum 1096 which is unrecoverable.
 	 */
-	if (unlikely(insn && !insn_len))
-		return 1;
+	if (unlikely(insn && !insn_len)) {
+		if (!kvm_x86_ops->need_emulation_on_page_fault(vcpu))
+			return 1;
+	}
 
 	er = x86_emulate_instruction(vcpu, cr2, emulation_type, insn, insn_len);
 
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index a9b8e38d78ad..3605c5cd5f1d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7098,6 +7098,36 @@ static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 	return -ENODEV;
 }
 
+static bool svm_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
+{
+	bool is_user, smap;
+
+	is_user = svm_get_cpl(vcpu) == 3;
+	smap = !kvm_read_cr4_bits(vcpu, X86_CR4_SMAP);
+
+	/*
+	 * Detect and workaround Errata 1096 Fam_17h_00_0Fh
+	 *
+	 * In non SEV guest, hypervisor will be able to read the guest
+	 * memory to decode the instruction pointer when insn_len is zero
+	 * so we return true to indicate that decoding is possible.
+	 *
+	 * But in the SEV guest, the guest memory is encrypted with the
+	 * guest specific key and hypervisor will not be able to decode the
+	 * instruction pointer so we will not able to workaround it. Lets
+	 * print the error and request to kill the guest.
+	 */
+	if (is_user && smap) {
+		if (!sev_guest(vcpu->kvm))
+			return true;
+
+		pr_err_ratelimited("KVM: Guest triggered AMD Erratum 1096\n");
+		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
+	}
+
+	return false;
+}
+
 static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = has_svm,
 	.disabled_by_bios = is_disabled,
@@ -7231,6 +7261,8 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 
 	.nested_enable_evmcs = nested_enable_evmcs,
 	.nested_get_evmcs_version = nested_get_evmcs_version,
+
+	.need_emulation_on_page_fault = svm_need_emulation_on_page_fault,
 };
 
 static int __init svm_init(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a0a770816429..7794c41a73bf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7522,6 +7522,11 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static bool vmx_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
 static __init int hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
@@ -7824,6 +7829,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.set_nested_state = NULL,
 	.get_vmcs12_pages = NULL,
 	.nested_enable_evmcs = NULL,
+	.need_emulation_on_page_fault = vmx_need_emulation_on_page_fault,
 };
 
 static void vmx_cleanup_l1d_flush(void)
-- 
2.19.1

