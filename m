Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E2EC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F83F21479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921540;
	bh=kEMp6ly1yRA3JcS6DLA3xZ0dHQobM/V8sXKYwAWzRTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vP7x8J16ww8AkGsxKR2cFZUcRiYK1KezFKtl4oOhnpyuU6o4agHmUP5Jm1Na4NyIS
	 KqN7l/NOYVFr1GPGmOXdjFXjiFUQF+J37HgAFu5/qsw/5BMwm3HHTsRvnCivTwdmJh
	 kOTuBla3OxqlHqzjBYwW6/9rtSYG+xjhoR1vyrnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfKPQZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:25:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfKPPmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:42:03 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3630207FA;
        Sat, 16 Nov 2019 15:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918923;
        bh=kEMp6ly1yRA3JcS6DLA3xZ0dHQobM/V8sXKYwAWzRTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWg4TDRcDtjE4KNygbHxFQLpYTw+cZ340MUDm5+w/pnFBWC9Jxo8N3k0Is/IhQoOa
         B5xM923cN1sbXNG4VhKAUovffVJCf89OP3UZ4T97JAnz9dBZT5BHqZf31mKJGKmLCO
         O9MyOu9FgMabLh1rkIJ7FooTt83Hl5rbB4lWfDkA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 048/237] KVM: nVMX: move check_vmentry_postreqs() call to nested_vmx_enter_non_root_mode()
Date:   Sat, 16 Nov 2019 10:38:03 -0500
Message-Id: <20191116154113.7417-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit 7671ce21b13b9596163a29f4712cb2451a9b97dc ]

In preparation of supporting checkpoint/restore for nested state,
commit ca0bde28f2ed ("kvm: nVMX: Split VMCS checks from nested_vmx_run()")
modified check_vmentry_postreqs() to only perform the guest EFER
consistency checks when nested_run_pending is true.  But, in the
normal nested VMEntry flow, nested_run_pending is only set after
check_vmentry_postreqs(), i.e. the consistency check is being skipped.

Alternatively, nested_run_pending could be set prior to calling
check_vmentry_postreqs() in nested_vmx_run(), but placing the
consistency checks in nested_vmx_enter_non_root_mode() allows us
to split prepare_vmcs02() and interleave the preparation with
the consistency checks without having to change the call sites
of nested_vmx_enter_non_root_mode().  In other words, the rest
of the consistency check code in nested_vmx_run() will be joining
the postreqs checks in future patches.

Fixes: ca0bde28f2ed ("kvm: nVMX: Split VMCS checks from nested_vmx_run()")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Jim Mattson <jmattson@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8c7554d7f0a80..3f40edf6fdeb3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12695,6 +12695,9 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, u32 *exit_qual)
 	if (likely(!evaluate_pending_interrupts) && kvm_vcpu_apicv_active(vcpu))
 		evaluate_pending_interrupts |= vmx_has_apicv_interrupt(vcpu);
 
+	if (from_vmentry && check_vmentry_postreqs(vcpu, vmcs12, exit_qual))
+		return EXIT_REASON_INVALID_STATE;
+
 	enter_guest_mode(vcpu);
 
 	if (!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
@@ -12837,13 +12840,6 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 */
 	skip_emulated_instruction(vcpu);
 
-	ret = check_vmentry_postreqs(vcpu, vmcs12, &exit_qual);
-	if (ret) {
-		nested_vmx_entry_failure(vcpu, vmcs12,
-					 EXIT_REASON_INVALID_STATE, exit_qual);
-		return 1;
-	}
-
 	/*
 	 * We're finally done with prerequisite checking, and can start with
 	 * the nested entry.
-- 
2.20.1

