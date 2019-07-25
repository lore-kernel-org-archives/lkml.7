Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB07C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E327522BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404361AbfGYLts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:49:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55514 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404287AbfGYLto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:49:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so44704203wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 04:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z59Fx3FchhtcYpGTAy6/0+pqXBGTFpbIQm7SLJs066s=;
        b=BXffoAynqc42vu42zGOLYovUMNO1uWCyuqZYkqKuVqGs3yJcq6EbqeXdeXU8Qo+TMh
         SnavA0ktbb2ymsNe+MqP7jDrgXUQNPeSi4kTCb5O2+c7xzm4EdQ8PxnSxxMIaU1zbEav
         nEIwBCd0h8yMX4gcfdmvoWtVTRkcmH6NGBdFxazFm74O2Uw6Si/pd9y+He3UXaFHBG0x
         Q1WC9XCnFHiiQ+lAS2Zx28pj1GsOGcC9KXREImSnP1GJRI6rH1Kl5sckDV1v3NUxRcZ8
         YhuiM/no2UC0bl/MqiJ3vd/9Dfz5LfG7+OV5g52WwrTWWcPHUpK8ceHzjS3UW6rPGXjV
         Pndw==
X-Gm-Message-State: APjAAAWq05Fmm3ww1DMnMopvwOuRpc8fdpTwzAkEsr9n6bv2NPoD3/O5
        tC8u/bOEXqtHZksqCJyAGCQ/dA==
X-Google-Smtp-Source: APXvYqxRX1Odd/FqOub1CpfyIe42j8zssRTmGESC5RT9PX9QN36ChMZZssuNdKvI3JcnDGwivfGf1A==
X-Received: by 2002:a7b:c0c6:: with SMTP id s6mr3698651wmh.115.1564055382411;
        Thu, 25 Jul 2019 04:49:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t140sm44784683wmt.0.2019.07.25.04.49.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 04:49:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH stable-5.1 2/3] KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested
Date:   Thu, 25 Jul 2019 13:49:37 +0200
Message-Id: <20190725114938.3976-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725114938.3976-1-vkuznets@redhat.com>
References: <20190725114938.3976-1-vkuznets@redhat.com>
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
index 3f48006a43ec..f78975d4a7fa 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -212,6 +212,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
 
+	kvm_clear_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
+
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	free_vpid(vmx->nested.vpid02);
-- 
2.20.1

