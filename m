Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D1EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651A322BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfGYKrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:47:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfGYKqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:46:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so44536647wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rT2+tyA6pTmguoDJ8MW+YlSOOFSIN1Vu53Mbq2U4pRc=;
        b=qD5kydrjEiwF8J2SB6Em6kQNHe5UR5fdcBNc/U97WCxedMomw0g5582ZHsmCzl+WYd
         BjbefYiMUO6QIEvKROvpMji84nFAp0M5GuDxixbvlIjjMAS9zsxGPCpiYZFAsezyX5i9
         UXutTiyBQ5VpKjgfC9nt7zD8Tn57Ben1/xhixn4bQU9VMhTcBcceg/8xfYzVYs8iKSgH
         89co/iLyp31x74QkNqoYiEACrOzMrm2b2Lru+w2RsGsyBKmIohKXVQDVMi2ND6G2Y6aJ
         CFUH9Uy5f7w6NW4Hpw90innzqS3OQ5nXDZtZpHrOApAprFYqMgubhp62+R01Cu0YqshP
         D65Q==
X-Gm-Message-State: APjAAAVmRmYACe2iQqiznU0knCOv0urFu8U7CQMxIYxMM9WeZN0epCBU
        gFVI/gRr9oUm0YWs6CUl4nQ4zA==
X-Google-Smtp-Source: APXvYqwTcecpPSHGjHuXabH4BPu7LoiVzTbv2SdE24oH8xT1yDoFoSRpS5PQy97iHgQ88CuC5+fdjQ==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr72257839wmk.24.1564051609799;
        Thu, 25 Jul 2019 03:46:49 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f204sm72042696wme.18.2019.07.25.03.46.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:46:49 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH stable-4.19 2/2] KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested
Date:   Thu, 25 Jul 2019 12:46:45 +0200
Message-Id: <20190725104645.30642-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725104645.30642-1-vkuznets@redhat.com>
References: <20190725104645.30642-1-vkuznets@redhat.com>
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
 arch/x86/kvm/vmx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 880bc36a0d5d..4cf16378dffe 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8490,6 +8490,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
 
+	kvm_clear_request(KVM_REQ_GET_VMCS12_PAGES, &vmx->vcpu);
+
 	hrtimer_cancel(&vmx->nested.preemption_timer);
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
-- 
2.20.1

