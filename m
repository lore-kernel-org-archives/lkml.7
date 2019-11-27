Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B63C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BC4217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887668;
	bh=QYahGcoXfpYMI3HLfFJgkerkVbrp22ZuxmbEIqzZPUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xOWGetvbM7zhqRPj/8RCMQjMIwNEMTNXR669YqP7cbEOuhQIs3yrWCWnVditgAYpk
	 TmluH6DVMjXskq4Ww1+ixtViOZxbrjaycFjbpGfgJ/qZt6Vk9jKnKuVMBgunzFbLDH
	 phZGAu9krSPEyLYOndF1Lr6GlyojPYxCUCCWB/X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfK0Urs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbfK0Urn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:47:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF0B21823;
        Wed, 27 Nov 2019 20:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887663;
        bh=QYahGcoXfpYMI3HLfFJgkerkVbrp22ZuxmbEIqzZPUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xyBTMTx1uQvC6xh912HHHseOlGIJYEhbo7rtYUwhiMRbd9er3Th2wonr/kNkZ8RgO
         NUt/qjQIP/Wjw3lUPBJqBhEBsi9miPjTU/7hZZZ+t41ebygvsc6oXXzKq+/c9HTmfP
         6IQ7pKTm/m4fIDpQpqYJmHk+iaM9BK6rqAx1q0/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 044/211] KVM: nVMX: reset cache/shadows when switching loaded VMCS
Date:   Wed, 27 Nov 2019 21:29:37 +0100
Message-Id: <20191127203058.337637590@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit b7031fd40fcc741b0f9b0c04c8d844e445858b84 ]

Reset the vm_{entry,exit}_controls_shadow variables as well as the
segment cache after loading a new VMCS in vmx_switch_vmcs().  The
shadows/cache track VMCS data, i.e. they're stale every time we
switch to a new VMCS regardless of reason.

This fixes a bug where stale control shadows would be consumed after
a nested VMExit due to a failed consistency check.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ab6384efc7916..1c4e5eb8be835 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10000,6 +10000,10 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	vmx_vcpu_load(vcpu, cpu);
 	vcpu->cpu = cpu;
 	put_cpu();
+
+	vm_entry_controls_reset_shadow(vmx);
+	vm_exit_controls_reset_shadow(vmx);
+	vmx_segment_cache_clear(vmx);
 }
 
 /*
@@ -11428,7 +11432,6 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, bool from_vmentry)
 		vmx->nested.vmcs01_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
 
 	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
-	vmx_segment_cache_clear(vmx);
 
 	if (prepare_vmcs02(vcpu, vmcs12, from_vmentry, &exit_qual)) {
 		leave_guest_mode(vcpu);
@@ -12172,9 +12175,6 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	}
 
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-	vm_entry_controls_reset_shadow(vmx);
-	vm_exit_controls_reset_shadow(vmx);
-	vmx_segment_cache_clear(vmx);
 
 	/* Update any VMCS fields that might have changed while L2 ran */
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
-- 
2.20.1



