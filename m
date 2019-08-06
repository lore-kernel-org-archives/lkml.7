Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BF82147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfHFGCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:02:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55121 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbfHFGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:02:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so76835795wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tkvvx2iRnaycAi/FkGoOmS/ThrIymYj/5i78t7ct+Z8=;
        b=D2y0vjT37qamErobuPF4fy5z3e9iqeYXoJrphaahSQ54krsQxZI+aRm+d+X+uGWBXH
         josxH/Cm6Ny9REEt5bAzYGE3BC66GHB26SG/7pV4yP8cz/T8y0dUdBpqXYSHSU7pOKkO
         BQcXHklNngq2BOmpgFiD9JqxMCNXziICGZUUG9P02ij5Y1jBIU2LrqIL1RhZ9Q6xEwI4
         JWLBCDcVH9/EcUTWy7n0NfX8yGoVo7HxT8YCv3MiD0GCnVahNei+mYAh3y336EZ2v+R7
         3BIJxSnee8fk+x5kTJ+yyhzJfMVsOz9Vvsr67AU5OXrtE6omb9UMRb8v48R4tPyKpq1n
         jRew==
X-Gm-Message-State: APjAAAUCBdFb8GylkFJk+4l3IHiwwcjojnp7Dc9mYydry9HCujMakHnH
        R9G1JA9pLmP3AlMRA0c831yMuw==
X-Google-Smtp-Source: APXvYqxc5AfCgo4BlXYzJWn0+nyE9MnXkXVpOxzPDyyh7/hDJRDChmIFsHVwdimzqHhqfNjj5xb73w==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr2343169wmm.62.1565071319471;
        Mon, 05 Aug 2019 23:01:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id r5sm94216756wmh.35.2019.08.05.23.01.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 23:01:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v2 5/5] x86: KVM: svm: remove hardcoded instruction length from intercepts
Date:   Tue,  6 Aug 2019 08:01:50 +0200
Message-Id: <20190806060150.32360-6-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806060150.32360-1-vkuznets@redhat.com>
References: <20190806060150.32360-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various intercepts hard-code the respective instruction lengths to optimize
skip_emulated_instruction(): when next_rip is pre-set we skip
kvm_emulate_instruction(vcpu, EMULTYPE_SKIP). The optimization is, however,
incorrect: different (redundant) prefixes could be used to enlarge the
instruction. We can't really avoid decoding.

svm->next_rip is not used when CPU supports 'nrips' (X86_FEATURE_NRIPS)
feature: next RIP is provided in VMCB. The feature is not really new
(Opteron G3s had it already) and the change should have zero affect.

Remove manual svm->next_rip setting with hard-coded instruction lengths.
The only case where we now use svm->next_rip is EXIT_IOIO: the instruction
length is provided to us by hardware.

Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 793a60461abe..dce215250d1f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2905,13 +2905,11 @@ static int nop_on_interception(struct vcpu_svm *svm)
 
 static int halt_interception(struct vcpu_svm *svm)
 {
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 1;
 	return kvm_emulate_halt(&svm->vcpu);
 }
 
 static int vmmcall_interception(struct vcpu_svm *svm)
 {
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	return kvm_emulate_hypercall(&svm->vcpu);
 }
 
@@ -3699,7 +3697,6 @@ static int vmload_interception(struct vcpu_svm *svm)
 
 	nested_vmcb = map.hva;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	nested_svm_vmloadsave(nested_vmcb, svm->vmcb);
@@ -3726,7 +3723,6 @@ static int vmsave_interception(struct vcpu_svm *svm)
 
 	nested_vmcb = map.hva;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	nested_svm_vmloadsave(svm->vmcb, nested_vmcb);
@@ -3740,8 +3736,8 @@ static int vmrun_interception(struct vcpu_svm *svm)
 	if (nested_svm_check_permissions(svm))
 		return 1;
 
-	/* Save rip after vmrun instruction */
-	kvm_rip_write(&svm->vcpu, kvm_rip_read(&svm->vcpu) + 3);
+	if (!kvm_skip_emulated_instruction(&svm->vcpu))
+		return 1;
 
 	if (!nested_svm_vmrun(svm))
 		return 1;
@@ -3777,7 +3773,6 @@ static int stgi_interception(struct vcpu_svm *svm)
 	if (vgif_enabled(svm))
 		clr_intercept(svm, INTERCEPT_STGI);
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 	kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
@@ -3793,7 +3788,6 @@ static int clgi_interception(struct vcpu_svm *svm)
 	if (nested_svm_check_permissions(svm))
 		return 1;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	disable_gif(svm);
@@ -3818,7 +3812,6 @@ static int invlpga_interception(struct vcpu_svm *svm)
 	/* Let's treat INVLPGA the same as INVLPG (can be optimized!) */
 	kvm_mmu_invlpg(vcpu, kvm_rax_read(&svm->vcpu));
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	return kvm_skip_emulated_instruction(&svm->vcpu);
 }
 
@@ -3841,7 +3834,6 @@ static int xsetbv_interception(struct vcpu_svm *svm)
 	u32 index = kvm_rcx_read(&svm->vcpu);
 
 	if (kvm_set_xcr(&svm->vcpu, index, new_bv) == 0) {
-		svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 
@@ -3918,7 +3910,6 @@ static int task_switch_interception(struct vcpu_svm *svm)
 
 static int cpuid_interception(struct vcpu_svm *svm)
 {
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 	return kvm_emulate_cpuid(&svm->vcpu);
 }
 
@@ -4248,7 +4239,6 @@ static int rdmsr_interception(struct vcpu_svm *svm)
 
 		kvm_rax_write(&svm->vcpu, msr_info.data & 0xffffffff);
 		kvm_rdx_write(&svm->vcpu, msr_info.data >> 32);
-		svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 }
@@ -4454,7 +4444,6 @@ static int wrmsr_interception(struct vcpu_svm *svm)
 		return 1;
 	} else {
 		trace_kvm_msr_write(ecx, data);
-		svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 }
-- 
2.20.1

