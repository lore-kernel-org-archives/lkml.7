Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB664C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2A522C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404483AbfGYMEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:04:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46622 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbfGYMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:04:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so50471177wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATZLcaR/HIow2boROv7fCJVEaRNc/1d0DL3a+Phooao=;
        b=ZNADQzrqYe7TRcwieT+AYXCzhN/THDDUwziqJapIHqvte3K4WuGcPA2tI6hG5QxZ7P
         GTh1g06zXJCsFOwTDoFs1BVr99Beuka5obCpAqtcZ322IEmMn1HL4/5SVLkEWsTuwOqf
         fWoFrlbExhBnktE3aOd3e21proQZuwfTCIzZicpus+7OwTE1WwpXl+nBu3nNuteRWAA7
         +OvNN24AcC3aacfrGM3jpgt1SFdXAbMNiwBeRZywI6Dc3QmFk1zQQ7rj3lKS9mALPB3g
         qbHzzibD6Oehrr+eaO9oMox+skXSkb6mgsgh8jViD04woSUQlqCH3IWjBhDU7Fka0WgP
         rYCg==
X-Gm-Message-State: APjAAAWxhektbwUAe5vV+L51SxAcQsk6FLwo2yDYAySZSZ70t6wb/SBI
        guTfjNtAGDIaQOk0qL3OKyYqwA==
X-Google-Smtp-Source: APXvYqxtPp1xiigUHF5IAWdhvDJjoUGWQcNlA5s+H6uYrJtpLmI8AduvNTKlhwxemRJWDcAFVTnyDA==
X-Received: by 2002:adf:df8b:: with SMTP id z11mr38719748wrl.62.1564056280351;
        Thu, 25 Jul 2019 05:04:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j6sm73793424wrx.46.2019.07.25.05.04.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 05:04:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH stable-5.2 2/3] KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested
Date:   Thu, 25 Jul 2019 14:04:35 +0200
Message-Id: <20190725120436.5432-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725120436.5432-1-vkuznets@redhat.com>
References: <20190725120436.5432-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

[ Upstream commit cf64527bb33f6cec2ed50f89182fc4688d0056b6 ]

Letting this pend may cause nested_get_vmcs12_pages to run against an
invalid state, corrupting the effective vmcs of L1.

This was triggerable in QEMU after a guest corruption in L2, followed by
a L1 reset.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Cc: stable@vger.kernel.org
Fixes: 7f7f1ba33cf2 ("KVM: x86: do not load vmcs12 pages while still in SMM")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b72d6aec4e90..df6e26894e25 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -210,6 +210,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
 
+	kvm_clear_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
+
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	free_vpid(vmx->nested.vpid02);
-- 
2.20.1

