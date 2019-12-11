Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA88C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D9222B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3TMDN4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLKUtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:49:09 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54483 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfLKUtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:49:07 -0500
Received: by mail-ua1-f74.google.com with SMTP id x2so6558175uaj.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 12:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dcdfpo/SN401J0ADf28PICm6rQuV1bm1m38AbFi1Sng=;
        b=v3TMDN4qBJP3ynZ8Qz07hxFn0g7CmdhMrFlr6NODGSx4qxZOgw/U1dSWChJLsNoBFU
         7o8pV4BMWbpBqjD6gu4Gdmv0xE/OBK1gccVoJ0bnS3ZRZnWGPo5T2Px1Q6YSdeaaL4Zb
         Am8YnUqJMTkV0PHCV/SkNcfObE9Rzx04NJNKADv8xjkDDtIr6nG6BQUEUNgcAx2S0btH
         ozH1FeW6BVukSfrh2iRl1Qgt8SyV5gxfnZDQdMSMZKXnJiDbXITVNibsl0Li6HSAkLlm
         boO17LswojP4waDI6My0MeA5ulsFh2uTc/I7tVczPcIGjUicNyH4KSSJs3JrD2/CqNVR
         GYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dcdfpo/SN401J0ADf28PICm6rQuV1bm1m38AbFi1Sng=;
        b=qKIcVGG1rRfOqlwdC6CzISfuoGgkDZPuAtLiUsTKG/SVkOqIpnF0sFv7KPVRk6X1jZ
         bv3TXoqlBxCoSjz4WAP1deuZRQalwuG07qfvYwEeL12GRKVuV+/P2rKc8VJoRtkXdeXP
         l91NwYWJkOkOH5ilaL43/GNlR5vkCkXbOPNCrXXiil9DCJW1txifkqKbYPD6s9Oi0V3w
         gexcYzmTcb1wTl/s6dzHbB88Yd/Z4x3bIKDFG+E8zPnErE6wVJN8gMcH+O7ktva3e9FK
         HCmeHiBHcKfPH8pVam/GFU3glz3B11cSQUQ5D11gqZOizAz49n00QvKuaADI2QSVcDfF
         HuOA==
X-Gm-Message-State: APjAAAU2DhjDQkI3H8v/tpF82P47d0geOtH0lDM3vsaAuaoyzvX910hS
        weR/0iMRuBMR9ZXnyDgvaY8NR8oGmyRc
X-Google-Smtp-Source: APXvYqzjD7iLTfwDWn+XE1jFSwfRs9TIrn3KfDXaYEgjRYFqoUbAWMKL38XdPFyOM/7T7xlp2u+Dzp5GDaUe
X-Received: by 2002:a67:bd13:: with SMTP id y19mr4440913vsq.143.1576097346928;
 Wed, 11 Dec 2019 12:49:06 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:47:51 -0800
In-Reply-To: <20191211204753.242298-1-pomonis@google.com>
Message-Id: <20191211204753.242298-12-pomonis@google.com>
Mime-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v2 11/13] KVM: x86: Protect exit_reason from being used in
 Spectre-v1/L1TF attacks
From:   Marios Pomonis <pomonis@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        Marios Pomonis <pomonis@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a Spectre-v1/L1TF vulnerability in vmx_handle_exit().
While exit_reason is set by the hardware and therefore should not be
attacker-influenced, an unknown exit_reason could potentially be used to
perform such an attack.

Fixes: commit 55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")

Signed-off-by: Marios Pomonis <pomonis@google.com>
Signed-off-by: Nick Finco <nifi@google.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kvm/vmx/vmx.c | 55 +++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 82b25f1812aa..78f2fef97d93 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5918,34 +5918,39 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (exit_reason < kvm_vmx_max_exit_handlers
-	    && kvm_vmx_exit_handlers[exit_reason]) {
+	if (exit_reason >= kvm_vmx_max_exit_handlers)
+		goto unexpected_vmexit;
 #ifdef CONFIG_RETPOLINE
-		if (exit_reason == EXIT_REASON_MSR_WRITE)
-			return kvm_emulate_wrmsr(vcpu);
-		else if (exit_reason == EXIT_REASON_PREEMPTION_TIMER)
-			return handle_preemption_timer(vcpu);
-		else if (exit_reason == EXIT_REASON_PENDING_INTERRUPT)
-			return handle_interrupt_window(vcpu);
-		else if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
-			return handle_external_interrupt(vcpu);
-		else if (exit_reason == EXIT_REASON_HLT)
-			return kvm_emulate_halt(vcpu);
-		else if (exit_reason == EXIT_REASON_EPT_MISCONFIG)
-			return handle_ept_misconfig(vcpu);
+	if (exit_reason == EXIT_REASON_MSR_WRITE)
+		return kvm_emulate_wrmsr(vcpu);
+	else if (exit_reason == EXIT_REASON_PREEMPTION_TIMER)
+		return handle_preemption_timer(vcpu);
+	else if (exit_reason == EXIT_REASON_PENDING_INTERRUPT)
+		return handle_interrupt_window(vcpu);
+	else if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
+		return handle_external_interrupt(vcpu);
+	else if (exit_reason == EXIT_REASON_HLT)
+		return kvm_emulate_halt(vcpu);
+	else if (exit_reason == EXIT_REASON_EPT_MISCONFIG)
+		return handle_ept_misconfig(vcpu);
 #endif
-		return kvm_vmx_exit_handlers[exit_reason](vcpu);
-	} else {
-		vcpu_unimpl(vcpu, "vmx: unexpected exit reason 0x%x\n",
-				exit_reason);
-		dump_vmcs();
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
+
+	exit_reason = array_index_nospec(exit_reason,
+					 kvm_vmx_max_exit_handlers);
+	if (!kvm_vmx_exit_handlers[exit_reason])
+		goto unexpected_vmexit;
+
+	return kvm_vmx_exit_handlers[exit_reason](vcpu);
+
+unexpected_vmexit:
+	vcpu_unimpl(vcpu, "vmx: unexpected exit reason 0x%x\n", exit_reason);
+	dump_vmcs();
+	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	vcpu->run->internal.suberror =
 			KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON;
-		vcpu->run->internal.ndata = 1;
-		vcpu->run->internal.data[0] = exit_reason;
-		return 0;
-	}
+	vcpu->run->internal.ndata = 1;
+	vcpu->run->internal.data[0] = exit_reason;
+	return 0;
 }
 
 /*
-- 
2.24.0.525.g8f36a354ae-goog

