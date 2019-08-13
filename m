Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B890C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EA220840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfHMNxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:53:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55531 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfHMNxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:53:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so1599767wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a93Im5z5Ix69mZdWJn1THOVc/7bNAs6K4ApoypuzVhg=;
        b=Cs4/RliOJzUexCNA89Zyt+MN4mXGefJu8VZnjJx5+fyn1jtnWnCHC95ZWz+Z9l2+HW
         7Lw0v+TUx7s5STp75BqmRqXgqeNCAarakgXVBypqtofP8rqMweiDVrWcfnmSvTjwe98U
         R35TQAtDVmhageXLNOYv3ykebu4A11se671hf0bj8NIfk4pOos1eAu3/LvR429us8pwO
         OYAH00tGOGTC91g5JE+Sg6srF3F2UhLCv5f+WW7d5W8msjh0kLGabJ4hvcmyWHS+jhef
         wbwQ+vWh+zlD4c+NqGjgyluSJ5qDQQZDWHAXp2I8KIRv84gZwg3Z4vr1M8VXQ7OXAHAp
         EbWg==
X-Gm-Message-State: APjAAAVk2OcE8F28wKK8HkPNiGPHLELRXVnOyJf2sLrF66nPH+yTDQJm
        YfPcDaFPvdegwyIuJY8zg+vWBA==
X-Google-Smtp-Source: APXvYqzbCVFOFWFv973LiK5d08gyFUsBp6auwzFvMEOcVNiaUMCzfnLmLrxEuIGJ1KFK99mE/WaGNg==
X-Received: by 2002:a05:600c:144:: with SMTP id w4mr3477047wmm.94.1565704424653;
        Tue, 13 Aug 2019 06:53:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k1sm15205820wru.49.2019.08.13.06.53.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:53:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v4 5/7] x86: KVM: svm: remove hardcoded instruction length from intercepts
Date:   Tue, 13 Aug 2019 15:53:33 +0200
Message-Id: <20190813135335.25197-6-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813135335.25197-1-vkuznets@redhat.com>
References: <20190813135335.25197-1-vkuznets@redhat.com>
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

Hardcoded RIP advancement remains in vmrun_interception(), this is going to
be taken care of separately.

Reported-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 858feeac01a4..6d16d1898810 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2903,13 +2903,11 @@ static int nop_on_interception(struct vcpu_svm *svm)
 
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
 
@@ -3697,7 +3695,6 @@ static int vmload_interception(struct vcpu_svm *svm)
 
 	nested_vmcb = map.hva;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	nested_svm_vmloadsave(nested_vmcb, svm->vmcb);
@@ -3724,7 +3721,6 @@ static int vmsave_interception(struct vcpu_svm *svm)
 
 	nested_vmcb = map.hva;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	nested_svm_vmloadsave(svm->vmcb, nested_vmcb);
@@ -3775,7 +3771,6 @@ static int stgi_interception(struct vcpu_svm *svm)
 	if (vgif_enabled(svm))
 		clr_intercept(svm, INTERCEPT_STGI);
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 	kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
@@ -3791,7 +3786,6 @@ static int clgi_interception(struct vcpu_svm *svm)
 	if (nested_svm_check_permissions(svm))
 		return 1;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	disable_gif(svm);
@@ -3816,7 +3810,6 @@ static int invlpga_interception(struct vcpu_svm *svm)
 	/* Let's treat INVLPGA the same as INVLPG (can be optimized!) */
 	kvm_mmu_invlpg(vcpu, kvm_rax_read(&svm->vcpu));
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	return kvm_skip_emulated_instruction(&svm->vcpu);
 }
 
@@ -3839,7 +3832,6 @@ static int xsetbv_interception(struct vcpu_svm *svm)
 	u32 index = kvm_rcx_read(&svm->vcpu);
 
 	if (kvm_set_xcr(&svm->vcpu, index, new_bv) == 0) {
-		svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 
@@ -3921,7 +3913,6 @@ static int task_switch_interception(struct vcpu_svm *svm)
 
 static int cpuid_interception(struct vcpu_svm *svm)
 {
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 	return kvm_emulate_cpuid(&svm->vcpu);
 }
 
@@ -4251,7 +4242,6 @@ static int rdmsr_interception(struct vcpu_svm *svm)
 
 		kvm_rax_write(&svm->vcpu, msr_info.data & 0xffffffff);
 		kvm_rdx_write(&svm->vcpu, msr_info.data >> 32);
-		svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 }
@@ -4457,7 +4447,6 @@ static int wrmsr_interception(struct vcpu_svm *svm)
 		return 1;
 	} else {
 		trace_kvm_msr_write(ecx, data);
-		svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 }
-- 
2.20.1

