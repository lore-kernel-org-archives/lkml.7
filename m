Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA792C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B505222C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfGYMEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:04:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33764 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbfGYMEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:04:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so50590634wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpcNSrOZdXNuboYz2PwekRRRZTL+bXI7DAARtL9qtcg=;
        b=GNE1BK2AVPrzgJN8v2l7Zuwc673jaKaPXIvb4H28ay91d7iPGhv22+Lopu38MVKDyk
         UD+c4PWtYBiqCyj+AlQ0kOz2zY33KenzP+it70liCSzD9yssJDUaTq+bHS5zlxln4N60
         QGdEA9pE0SWa4cOn2wRWp9aCKJpChWwEeHcnDciDXiNFCW3InbnHMmoVVF7Vr7gOx91q
         cJ9xXvZS8xUcTqMbscN1J7MdRT0Pjti0hHSiTVA3eoSkQmYMDGSq095NFDILc4U0URBB
         IiYkjnFyL98/7AndA9xnilNZQ2X6GB3oayXMuebTe8mwfowVtjN/4G+CyqH3vemDMBaN
         C1TA==
X-Gm-Message-State: APjAAAVSw4dY+Hpya+LeHzBoPc7lqPXqjxFKqAr+0GrjHpFOhPvtKZ0X
        ZPrKPYvwotFSOZIJstinFRzgGw==
X-Google-Smtp-Source: APXvYqx4He1x7voKIcNqkYiWr7LQV5KmQ2ojerHDsiRJ1udhZ8iaYzwknbnENThvKjE1EwzmuNP76Q==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr57627142wrn.197.1564056279314;
        Thu, 25 Jul 2019 05:04:39 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j6sm73793424wrx.46.2019.07.25.05.04.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 05:04:38 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH stable-5.2 1/3] KVM: nVMX: do not use dangling shadow VMCS after guest reset
Date:   Thu, 25 Jul 2019 14:04:34 +0200
Message-Id: <20190725120436.5432-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725120436.5432-1-vkuznets@redhat.com>
References: <20190725120436.5432-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 88dddc11a8d6b09201b4db9d255b3394d9bc9e57 ]

If a KVM guest is reset while running a nested guest, free_nested will
disable the shadow VMCS execution control in the vmcs01.  However,
on the next KVM_RUN vmx_vcpu_run would nevertheless try to sync
the VMCS12 to the shadow VMCS which has since been freed.

This causes a vmptrld of a NULL pointer on my machime, but Jan reports
the host to hang altogether.  Let's see how much this trivial patch fixes.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 46af3a5e9209..b72d6aec4e90 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -184,6 +184,7 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
 {
 	vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL, SECONDARY_EXEC_SHADOW_VMCS);
 	vmcs_write64(VMCS_LINK_POINTER, -1ull);
+	vmx->nested.need_vmcs12_sync = false;
 }
 
 static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
@@ -1321,6 +1322,9 @@ static void copy_shadow_to_vmcs12(struct vcpu_vmx *vmx)
 	u64 field_value;
 	struct vmcs *shadow_vmcs = vmx->vmcs01.shadow_vmcs;
 
+	if (WARN_ON(!shadow_vmcs))
+		return;
+
 	preempt_disable();
 
 	vmcs_load(shadow_vmcs);
@@ -1359,6 +1363,9 @@ static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx)
 	u64 field_value = 0;
 	struct vmcs *shadow_vmcs = vmx->vmcs01.shadow_vmcs;
 
+	if (WARN_ON(!shadow_vmcs))
+		return;
+
 	vmcs_load(shadow_vmcs);
 
 	for (q = 0; q < ARRAY_SIZE(fields); q++) {
@@ -4304,7 +4311,6 @@ static inline void nested_release_vmcs12(struct kvm_vcpu *vcpu)
 		/* copy to memory all shadowed fields in case
 		   they were modified */
 		copy_shadow_to_vmcs12(vmx);
-		vmx->nested.need_vmcs12_sync = false;
 		vmx_disable_shadow_vmcs(vmx);
 	}
 	vmx->nested.posted_intr_nv = -1;
-- 
2.20.1

