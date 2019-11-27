Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9A2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3E82154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889461;
	bh=ezbFv245e3UXk+bOz7/RRYSyfswY6TcgjUeambJ20VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2qdAT4N05WVWrjNn6XtTO0uIhBKE1Zo6A+7bAf5PUxAZg5DpXOBg3RlE/zSfmjL5
	 wbb6gB1m3+QwbyTsL92VF9iAG8k7OAblGmjl0IPI/ZxQX4DNcUPr5db0hqq0nT0TJR
	 RjoVFJ3C4WS07xOAIVPCYTo0Lb4ylY50E+uSGzdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbfK0VRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733284AbfK0VM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:12:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFDD5215E5;
        Wed, 27 Nov 2019 21:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889148;
        bh=ezbFv245e3UXk+bOz7/RRYSyfswY6TcgjUeambJ20VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IS0yCXEayJS/FuS2Ly/YHyj+EK5wWsIGdhy46u4RcXClC1cKkfywBLODY2IMO1JAd
         8oTOgfuGZU/OGxaic0UlSP8hKHWJPKw2qUNrV2E0awIz0NwmeC6fMKna+k8XOxsZnu
         G8KN7GjaHFGWggq4oqm2aZbW5wtCB9BdpMD3NlcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.3 95/95] KVM: PPC: Book3S HV: Flush link stack on guest exit to host kernel
Date:   Wed, 27 Nov 2019 21:32:52 +0100
Message-Id: <20191127203003.310860131@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit af2e8c68b9c5403f77096969c516f742f5bb29e0 upstream.

On some systems that are vulnerable to Spectre v2, it is up to
software to flush the link stack (return address stack), in order to
protect against Spectre-RSB.

When exiting from a guest we do some house keeping and then
potentially exit to C code which is several stack frames deep in the
host kernel. We will then execute a series of returns without
preceeding calls, opening up the possiblity that the guest could have
poisoned the link stack, and direct speculative execution of the host
to a gadget of some sort.

To prevent this we add a flush of the link stack on exit from a guest.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/asm-prototypes.h |    2 ++
 arch/powerpc/kernel/security.c            |    9 +++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   30 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -141,9 +141,11 @@ void _kvmppc_save_tm_pr(struct kvm_vcpu
 extern s32 patch__call_flush_count_cache;
 extern s32 patch__flush_count_cache_return;
 extern s32 patch__flush_link_stack_return;
+extern s32 patch__call_kvm_flush_link_stack;
 extern s32 patch__memset_nocache, patch__memcpy_nocache;
 
 extern long flush_count_cache;
+extern long kvm_flush_link_stack;
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 void kvmppc_save_tm_hv(struct kvm_vcpu *vcpu, u64 msr, bool preserve_nv);
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -400,6 +400,9 @@ static void toggle_count_cache_flush(boo
 
 	if (!enable) {
 		patch_instruction_site(&patch__call_flush_count_cache, PPC_INST_NOP);
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+		patch_instruction_site(&patch__call_kvm_flush_link_stack, PPC_INST_NOP);
+#endif
 		pr_info("link-stack-flush: software flush disabled.\n");
 		link_stack_flush_enabled = false;
 		no_count_cache_flush();
@@ -410,6 +413,12 @@ static void toggle_count_cache_flush(boo
 	patch_branch_site(&patch__call_flush_count_cache,
 			  (u64)&flush_count_cache, BRANCH_SET_LINK);
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	// This enables the branch from guest_exit_cont to kvm_flush_link_stack
+	patch_branch_site(&patch__call_kvm_flush_link_stack,
+			  (u64)&kvm_flush_link_stack, BRANCH_SET_LINK);
+#endif
+
 	pr_info("link-stack-flush: software flush enabled.\n");
 	link_stack_flush_enabled = true;
 
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -11,6 +11,7 @@
  */
 
 #include <asm/ppc_asm.h>
+#include <asm/code-patching-asm.h>
 #include <asm/kvm_asm.h>
 #include <asm/reg.h>
 #include <asm/mmu.h>
@@ -1458,6 +1459,13 @@ guest_exit_cont:		/* r9 = vcpu, r12 = tr
 1:
 #endif /* CONFIG_KVM_XICS */
 
+	/*
+	 * Possibly flush the link stack here, before we do a blr in
+	 * guest_exit_short_path.
+	 */
+1:	nop
+	patch_site 1b patch__call_kvm_flush_link_stack
+
 	/* If we came in through the P9 short path, go back out to C now */
 	lwz	r0, STACK_SLOT_SHORT_PATH(r1)
 	cmpwi	r0, 0
@@ -1933,6 +1941,28 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	mtlr	r0
 	blr
 
+.balign 32
+.global kvm_flush_link_stack
+kvm_flush_link_stack:
+	/* Save LR into r0 */
+	mflr	r0
+
+	/* Flush the link stack. On Power8 it's up to 32 entries in size. */
+	.rept 32
+	bl	.+4
+	.endr
+
+	/* And on Power9 it's up to 64. */
+BEGIN_FTR_SECTION
+	.rept 32
+	bl	.+4
+	.endr
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
+	/* Restore LR */
+	mtlr	r0
+	blr
+
 kvmppc_guest_external:
 	/* External interrupt, first check for host_ipi. If this is
 	 * set, we know the host wants us out so let's do it now


