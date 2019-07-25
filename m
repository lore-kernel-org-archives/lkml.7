Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1FAC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630B522BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbfGYLt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:49:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35390 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404327AbfGYLtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:49:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so50469040wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 04:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5eFHQcAJJ1arMcU18ItSiGCK+xpQYpQYRWNTnt4Sl8M=;
        b=Dsb9dlgD6Hpo7hUnv8Z/1mKdp3kcD6InKXsWwZ70OhY2zfo+ds67w7ztcgV//65Hjh
         +rj6WDPpnAzXnerKk7bzSs4hEnj0cU6fqAoD3MkgJmNviMKIBvX3IiYfYq2P5GR4IkMn
         5NdD5NaXaq76+1JJkNnwcznUtBkQ2jIF1nK46xKP9XADKnmwBtnPkSx6doIT8PH4BDV2
         ly1SOu4sFRZitCPOmJwjaRHaSIww9nZyXonWEpdR/SVxtZKtZRqDWuSH8APlilm2XtiA
         LzZH/hsMiAWRCNnxKJlnUR24VGHkbRySKX4qCjymHul5zdGw8KpThkX7ASCYfgWWNXeE
         3bHA==
X-Gm-Message-State: APjAAAUOV3rod7EY3nYuGJ56K3TRtUC5RtEBAxbf41iowm/4pbrIMJ4n
        esX/gPf6TQVjG+HBHJtV+vnGfw==
X-Google-Smtp-Source: APXvYqwHF+F+rdSQWjhG31Xnxl9xMrRVHiLRHocchVFoV1vta3opzCIwlmlEKq6AN3HyyfnnQNNydw==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr57465609wrx.51.1564055383632;
        Thu, 25 Jul 2019 04:49:43 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t140sm44784683wmt.0.2019.07.25.04.49.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 04:49:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH stable-5.1 3/3] Revert "kvm: x86: Use task structs fpu field for user"
Date:   Thu, 25 Jul 2019 13:49:38 +0200
Message-Id: <20190725114938.3976-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725114938.3976-1-vkuznets@redhat.com>
References: <20190725114938.3976-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit ec269475cba7bcdd1eb8fdf8e87f4c6c81a376fe ]

This reverts commit 240c35a3783ab9b3a0afaba0dde7291295680a6b
("kvm: x86: Use task structs fpu field for user", 2018-11-06).
The commit is broken and causes QEMU's FPU state to be destroyed
when KVM_RUN is preempted.

Fixes: 240c35a3783a ("kvm: x86: Use task structs fpu field for user")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 7 ++++---
 arch/x86/kvm/x86.c              | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c79abe7ca093..564729a4a25c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -609,15 +609,16 @@ struct kvm_vcpu_arch {
 
 	/*
 	 * QEMU userspace and the guest each have their own FPU state.
-	 * In vcpu_run, we switch between the user, maintained in the
-	 * task_struct struct, and guest FPU contexts. While running a VCPU,
-	 * the VCPU thread will have the guest FPU context.
+	 * In vcpu_run, we switch between the user and guest FPU contexts.
+	 * While running a VCPU, the VCPU thread will have the guest FPU
+	 * context.
 	 *
 	 * Note that while the PKRU state lives inside the fpu registers,
 	 * it is switched out separately at VMENTER and VMEXIT time. The
 	 * "guest_fpu" state here contains the guest FPU context, with the
 	 * host PRKU bits.
 	 */
+	struct fpu user_fpu;
 	struct fpu *guest_fpu;
 
 	u64 xcr0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 37028ea85d4c..aede8fa2ea9a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8172,7 +8172,7 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
-	copy_fpregs_to_fpstate(&current->thread.fpu);
+	copy_fpregs_to_fpstate(&vcpu->arch.user_fpu);
 	/* PKRU is separately restored in kvm_x86_ops->run.  */
 	__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu->state,
 				~XFEATURE_MASK_PKRU);
@@ -8185,7 +8185,7 @@ static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
 	copy_fpregs_to_fpstate(vcpu->arch.guest_fpu);
-	copy_kernel_to_fpregs(&current->thread.fpu.state);
+	copy_kernel_to_fpregs(&vcpu->arch.user_fpu.state);
 	preempt_enable();
 	++vcpu->stat.fpu_reload;
 	trace_kvm_fpu(0);
-- 
2.20.1

