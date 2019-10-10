Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D28E22469
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697894;
	bh=jIqrl1sjn2TnFZ4meR1ru6R1Ltoxy8y99iGJKxKL9fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Yld8q2+b6y9ZuJ9sngv5KRft0TFGi+VunnQZUgx+xCM+WhV1xJImccNXCQ8F1gQM
	 nkIKV9EqdFNNL5e/JLMig/w9UeR/mUcd6go0Fc+afH3/BlyvBcQH45OBN6pwVX5pON
	 szsujge2t92Q4wfw9GUFjJB+J0yawGuFGHNTPJxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbfJJI6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388555AbfJJIqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:46:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A2C2064A;
        Thu, 10 Oct 2019 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697162;
        bh=jIqrl1sjn2TnFZ4meR1ru6R1Ltoxy8y99iGJKxKL9fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2A1LT3imUZgeGWtnoWdpPDkvb4dphsHPxRa35i3MdhSnqxJ5gzFwCNec8YPfijRQf
         l9LVPuY+4uirlCQa4pDHBJzP5+xJTix+XkOr90ZZ2b/0IoTnNOdYJKW+HkCqlOMQOP
         T44glGcUfJIlSDq9O5h4brJnX9rtggbFsWqEYKwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0f1819555fbdce992df9@syzkaller.appspotmail.com,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 008/114] KVM: X86: Fix userspace set invalid CR4
Date:   Thu, 10 Oct 2019 10:35:15 +0200
Message-Id: <20191010083548.415612034@linuxfoundation.org>
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

From: Wanpeng Li <wanpengli@tencent.com>

commit 3ca94192278ca8de169d78c085396c424be123b3 upstream.

Reported by syzkaller:

	WARNING: CPU: 0 PID: 6544 at /home/kernel/data/kvm/arch/x86/kvm//vmx/vmx.c:4689 handle_desc+0x37/0x40 [kvm_intel]
	CPU: 0 PID: 6544 Comm: a.out Tainted: G           OE     5.3.0-rc4+ #4
	RIP: 0010:handle_desc+0x37/0x40 [kvm_intel]
	Call Trace:
	 vmx_handle_exit+0xbe/0x6b0 [kvm_intel]
	 vcpu_enter_guest+0x4dc/0x18d0 [kvm]
	 kvm_arch_vcpu_ioctl_run+0x407/0x660 [kvm]
	 kvm_vcpu_ioctl+0x3ad/0x690 [kvm]
	 do_vfs_ioctl+0xa2/0x690
	 ksys_ioctl+0x6d/0x80
	 __x64_sys_ioctl+0x1a/0x20
	 do_syscall_64+0x74/0x720
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe

When CR4.UMIP is set, guest should have UMIP cpuid flag. Current
kvm set_sregs function doesn't have such check when userspace inputs
sregs values. SECONDARY_EXEC_DESC is enabled on writes to CR4.UMIP
in vmx_set_cr4 though guest doesn't have UMIP cpuid flag. The testcast
triggers handle_desc warning when executing ltr instruction since
guest architectural CR4 doesn't set UMIP. This patch fixes it by
adding valid CR4 and CPUID combination checking in __set_sregs.

syzkaller source: https://syzkaller.appspot.com/x/repro.c?x=138efb99600000

Reported-by: syzbot+0f1819555fbdce992df9@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -791,34 +791,42 @@ int kvm_set_xcr(struct kvm_vcpu *vcpu, u
 }
 EXPORT_SYMBOL_GPL(kvm_set_xcr);
 
-int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+static int kvm_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
-	unsigned long old_cr4 = kvm_read_cr4(vcpu);
-	unsigned long pdptr_bits = X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE |
-				   X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE;
-
 	if (cr4 & CR4_RESERVED_BITS)
-		return 1;
+		return -EINVAL;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) && (cr4 & X86_CR4_OSXSAVE))
-		return 1;
+		return -EINVAL;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_SMEP) && (cr4 & X86_CR4_SMEP))
-		return 1;
+		return -EINVAL;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_SMAP) && (cr4 & X86_CR4_SMAP))
-		return 1;
+		return -EINVAL;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_FSGSBASE) && (cr4 & X86_CR4_FSGSBASE))
-		return 1;
+		return -EINVAL;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_PKU) && (cr4 & X86_CR4_PKE))
-		return 1;
+		return -EINVAL;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_LA57) && (cr4 & X86_CR4_LA57))
-		return 1;
+		return -EINVAL;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_UMIP) && (cr4 & X86_CR4_UMIP))
+		return -EINVAL;
+
+	return 0;
+}
+
+int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+{
+	unsigned long old_cr4 = kvm_read_cr4(vcpu);
+	unsigned long pdptr_bits = X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE |
+				   X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE;
+
+	if (kvm_valid_cr4(vcpu, cr4))
 		return 1;
 
 	if (is_long_mode(vcpu)) {
@@ -8237,10 +8245,6 @@ EXPORT_SYMBOL_GPL(kvm_task_switch);
 
 static int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
-	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
-			(sregs->cr4 & X86_CR4_OSXSAVE))
-		return  -EINVAL;
-
 	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG)) {
 		/*
 		 * When EFER.LME and CR0.PG are set, the processor is in
@@ -8259,7 +8263,7 @@ static int kvm_valid_sregs(struct kvm_vc
 			return -EINVAL;
 	}
 
-	return 0;
+	return kvm_valid_cr4(vcpu, sregs->cr4);
 }
 
 static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)


