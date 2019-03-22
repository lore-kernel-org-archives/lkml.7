Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5495CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233A421917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257433;
	bh=kDT7/Z+//SOMBbK2aI1K39vsZIri2i0Jw70yygMKx68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ULAXRqmU3lapjTYv2QM/a9BGwjTgWt53IX1i0uCxzcYuAPGveX5c8+sD9DQLDlgmK
	 qWjHbT2RWLWo4aqOE3SbvWUen6OKYdSw4+aOkXhBjf4i727gl9SvSnLTIbR0judpMI
	 2Q8UknQWJBq2wULyNp9o4WwcfkTe+DjBjLrotyh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391179AbfCVMXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391149AbfCVMXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72FB621971;
        Fri, 22 Mar 2019 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257423;
        bh=kDT7/Z+//SOMBbK2aI1K39vsZIri2i0Jw70yygMKx68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zh65pW/d25d6MMfbq8p+Mex8DYBpqVnuzjtDXr9+7Dl+ME1nn2xUOLMVQols53phO
         IsxD3AmN7lostY9kgZebidagLXZHsuaT0yPouGczo8ebxtIvgIawjzWdnOn0c2Fz7M
         4Lkj8f69PLMcPosrzr6pJJpb4Pu4UlfIXPRZTPfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 226/238] KVM: VMX: Zero out *all* general purpose registers after VM-Exit
Date:   Fri, 22 Mar 2019 12:17:25 +0100
Message-Id: <20190322111311.688384234@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 0e0ab73c9a0243736bcd779b30b717e23ba9a56d upstream.

...except RSP, which is restored by hardware as part of VM-Exit.

Paolo theorized that restoring registers from the stack after a VM-Exit
in lieu of zeroing them could lead to speculative execution with the
guest's values, e.g. if the stack accesses miss the L1 cache[1].
Zeroing XORs are dirt cheap, so just be ultra-paranoid.

Note that the scratch register (currently RCX) used to save/restore the
guest state is also zeroed as its host-defined value is loaded via the
stack, just with a MOV instead of a POP.

[1] https://patchwork.kernel.org/patch/10771539/#22441255

Fixes: 0cb5b30698fd ("kvm: vmx: Scrub hardware GPRs at VM-exit")
Cc: <stable@vger.kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6449,10 +6449,15 @@ static void __vmx_vcpu_run(struct kvm_vc
 		"mov %%r13, %c[r13](%%" _ASM_CX ") \n\t"
 		"mov %%r14, %c[r14](%%" _ASM_CX ") \n\t"
 		"mov %%r15, %c[r15](%%" _ASM_CX ") \n\t"
+
 		/*
-		* Clear host registers marked as clobbered to prevent
-		* speculative use.
-		*/
+		 * Clear all general purpose registers (except RSP, which is loaded by
+		 * the CPU during VM-Exit) to prevent speculative use of the guest's
+		 * values, even those that are saved/loaded via the stack.  In theory,
+		 * an L1 cache miss when restoring registers could lead to speculative
+		 * execution with the guest's values.  Zeroing XORs are dirt cheap,
+		 * i.e. the extra paranoia is essentially free.
+		 */
 		"xor %%r8d,  %%r8d \n\t"
 		"xor %%r9d,  %%r9d \n\t"
 		"xor %%r10d, %%r10d \n\t"
@@ -6467,8 +6472,11 @@ static void __vmx_vcpu_run(struct kvm_vc
 
 		"xor %%eax, %%eax \n\t"
 		"xor %%ebx, %%ebx \n\t"
+		"xor %%ecx, %%ecx \n\t"
+		"xor %%edx, %%edx \n\t"
 		"xor %%esi, %%esi \n\t"
 		"xor %%edi, %%edi \n\t"
+		"xor %%ebp, %%ebp \n\t"
 		"pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
 	      : ASM_CALL_CONSTRAINT
 	      : "c"(vmx), "d"((unsigned long)HOST_RSP), "S"(evmcs_rsp),


