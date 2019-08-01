Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0690AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C710E2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfHAFOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:14:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42374 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfHAFO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:14:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so22167924wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rVzvHSdpHnxmBSHx6388M2V2K5KEB4njCJcl0o9uwTg=;
        b=IoiIYRG45uDjDpwUH0vaSx+4t2CNXICrCUHBlZGrk/OyhPdTyXcSKI+Th2Q8aRPIZz
         6oHEdrSo3qDPtghFXne0ARhRKjWjY/S3rq6injBSnTXD1SAileG/h22zIPpN32QDnKZY
         RKm6NbZNI7ZD8tdlZkTjvYr9pf4LoYq9ZFKxx46i60mqqd3TLls0oU9ty7EusU7ZB650
         um1G/YN+3p8c03XF2dhOveiczqFcwLiFmqmMuCaZc+7mNkcqmZfCbUxTBbcFWIj+GnD9
         gJGWykOTRKFpNPhXqx7qC1haSS3FsoXJSEXWroOQdNFPPT94Mi1iqs4s/mBsS9Thnxj4
         wa7w==
X-Gm-Message-State: APjAAAWJon5nrkRyBD1mO2psgfCiWAwpfHZF+36vBAd7D4N0oUiVahrg
        Zb0AQ788+X7wvFmhhjimKUVHYw==
X-Google-Smtp-Source: APXvYqw4NEWnwV1J0k6auYd7688aziUWQd2Y5qb/1kJaDZKgzAMNVC9OMcGF7CiEUJ+eNPZtJWhJng==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr47539087wrm.12.1564636467277;
        Wed, 31 Jul 2019 22:14:27 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id a2sm73855351wmj.9.2019.07.31.22.14.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 22:14:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 5/5] x86: KVM: svm: remove hardcoded instruction length from intercepts
Date:   Thu,  1 Aug 2019 07:14:18 +0200
Message-Id: <20190801051418.15905-6-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801051418.15905-1-vkuznets@redhat.com>
References: <20190801051418.15905-1-vkuznets@redhat.com>
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
index f0e7e1b1c017..c6aa66324326 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2907,13 +2907,11 @@ static int nop_on_interception(struct vcpu_svm *svm)
 
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
 
@@ -3701,7 +3699,6 @@ static int vmload_interception(struct vcpu_svm *svm)
 
 	nested_vmcb = map.hva;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	nested_svm_vmloadsave(nested_vmcb, svm->vmcb);
@@ -3728,7 +3725,6 @@ static int vmsave_interception(struct vcpu_svm *svm)
 
 	nested_vmcb = map.hva;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	nested_svm_vmloadsave(svm->vmcb, nested_vmcb);
@@ -3742,8 +3738,8 @@ static int vmrun_interception(struct vcpu_svm *svm)
 	if (nested_svm_check_permissions(svm))
 		return 1;
 
-	/* Save rip after vmrun instruction */
-	kvm_rip_write(&svm->vcpu, kvm_rip_read(&svm->vcpu) + 3);
+	if (!kvm_skip_emulated_instruction(&svm->vcpu))
+		return 1;
 
 	if (!nested_svm_vmrun(svm))
 		return 1;
@@ -3779,7 +3775,6 @@ static int stgi_interception(struct vcpu_svm *svm)
 	if (vgif_enabled(svm))
 		clr_intercept(svm, INTERCEPT_STGI);
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 	kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
@@ -3795,7 +3790,6 @@ static int clgi_interception(struct vcpu_svm *svm)
 	if (nested_svm_check_permissions(svm))
 		return 1;
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	disable_gif(svm);
@@ -3820,7 +3814,6 @@ static int invlpga_interception(struct vcpu_svm *svm)
 	/* Let's treat INVLPGA the same as INVLPG (can be optimized!) */
 	kvm_mmu_invlpg(vcpu, kvm_rax_read(&svm->vcpu));
 
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	return kvm_skip_emulated_instruction(&svm->vcpu);
 }
 
@@ -3843,7 +3836,6 @@ static int xsetbv_interception(struct vcpu_svm *svm)
 	u32 index = kvm_rcx_read(&svm->vcpu);
 
 	if (kvm_set_xcr(&svm->vcpu, index, new_bv) == 0) {
-		svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 
@@ -3920,7 +3912,6 @@ static int task_switch_interception(struct vcpu_svm *svm)
 
 static int cpuid_interception(struct vcpu_svm *svm)
 {
-	svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 	return kvm_emulate_cpuid(&svm->vcpu);
 }
 
@@ -4250,7 +4241,6 @@ static int rdmsr_interception(struct vcpu_svm *svm)
 
 		kvm_rax_write(&svm->vcpu, msr_info.data & 0xffffffff);
 		kvm_rdx_write(&svm->vcpu, msr_info.data >> 32);
-		svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 }
@@ -4456,7 +4446,6 @@ static int wrmsr_interception(struct vcpu_svm *svm)
 		return 1;
 	} else {
 		trace_kvm_msr_write(ecx, data);
-		svm->next_rip = kvm_rip_read(&svm->vcpu) + 2;
 		return kvm_skip_emulated_instruction(&svm->vcpu);
 	}
 }
-- 
2.20.1

