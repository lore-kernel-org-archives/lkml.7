Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC57EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A245F21929
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697383;
	bh=7DZ5PjMP7b5x4rM5b1G+HAZcSZk95Iof1H4TK11oOBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EKEAQ487bhLybEYhKRXGO4+O7ohKrPJyoN2np88nwg4DDquLq6wdl20EeD699+RGo
	 il2v/kdkHZTjyHwt1v/GPcQ3aWI5d3kRzBJBinEUfZzl5e+FiVd1EpRT6NeauvoCw6
	 KpHtKgNLoJdotW/pSnctQJImAV4B+FsIyur3hs1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbfJJItl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388033AbfJJItg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:49:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BA321D71;
        Thu, 10 Oct 2019 08:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697375;
        bh=7DZ5PjMP7b5x4rM5b1G+HAZcSZk95Iof1H4TK11oOBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgV3+TdHf56LRix19LdyEVUQk9q3aArPackt6x2bHqIVoJhOhSJeYSWyhQj2iJTQN
         SCaw56zS7QtSVjCE4IVzXFTsJmOd3yVcCxQ0WKSv+aSDvhu7gdSN+2c8tqGXKoRedg
         k/+E/RzXfxKAA15fRHZouuPN6MEBni7PiwVqVuPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.19 090/114] KVM: arm64: Set SCTLR_EL2.DSSBS if SSBD is forcefully disabled and !vhe
Date:   Thu, 10 Oct 2019 10:36:37 +0200
Message-Id: <20191010083612.834026878@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 7c36447ae5a090729e7b129f24705bb231a07e0b ]

When running without VHE, it is necessary to set SCTLR_EL2.DSSBS if SSBD
has been forcefully disabled on the kernel command-line.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_host.h |   11 +++++++++++
 arch/arm64/kvm/hyp/sysreg-sr.c    |   11 +++++++++++
 2 files changed, 22 insertions(+)

--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -398,6 +398,8 @@ struct kvm_vcpu *kvm_mpidr_to_vcpu(struc
 
 DECLARE_PER_CPU(kvm_cpu_context_t, kvm_host_cpu_state);
 
+void __kvm_enable_ssbs(void);
+
 static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 				       unsigned long hyp_stack_ptr,
 				       unsigned long vector_ptr)
@@ -418,6 +420,15 @@ static inline void __cpu_init_hyp_mode(p
 	 */
 	BUG_ON(!static_branch_likely(&arm64_const_caps_ready));
 	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
+
+	/*
+	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
+	 * at EL2.
+	 */
+	if (!has_vhe() && this_cpu_has_cap(ARM64_SSBS) &&
+	    arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE) {
+		kvm_call_hyp(__kvm_enable_ssbs);
+	}
 }
 
 static inline bool kvm_arch_check_sve_has_vhe(void)
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -293,3 +293,14 @@ void kvm_vcpu_put_sysregs(struct kvm_vcp
 
 	vcpu->arch.sysregs_loaded_on_cpu = false;
 }
+
+void __hyp_text __kvm_enable_ssbs(void)
+{
+	u64 tmp;
+
+	asm volatile(
+	"mrs	%0, sctlr_el2\n"
+	"orr	%0, %0, %1\n"
+	"msr	sctlr_el2, %0"
+	: "=&r" (tmp) : "L" (SCTLR_ELx_DSSBS));
+}


