Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2080FC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F052E21743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404470AbfHHRbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:31:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42002 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404379AbfHHRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:31:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so45824236wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QNclWHn7I50/yByYJpJAi95dRXHnd68QPD5QLdpAaY=;
        b=YuPRwzwPyFx91z+DVx35TPwS6z9Ab/4HiWqYONTJ9D1Bgta1gHfDe2zkm88hHjVL0g
         bCacUFbegXlbGkSRH8N5Q/tTq4oDenNu0onzQ4MrlHu3tp5Pji4KiFJNZpTNMVFgjZN6
         erZdRfm4N4lRQnbhVmrVEs4YhvWviiruXBisIoq462nJ0GOMFG/Mm1HSJQrpOK+sccuc
         xr8xaQkJ+AzYgUPG2tI1DlOubWGKUOzkriTp39waQY+K+rejuzra66NrKsbQXsLMGeLN
         XixztnX6r5KLQmIz6l807UlnEnSECHpaBbvcF6o5yTVLani05Knd+ozW/hlBFHgjcZos
         oQuA==
X-Gm-Message-State: APjAAAVQFd+LBsEBvc9NQz3Qrx3hZeYANtOha0LH9rONJrVtlGnQSv/Z
        L0+lvvivB9+R/Rz8vMuiQoLEDw==
X-Google-Smtp-Source: APXvYqzRg2bisd+LGUzlteXdIflm96RWkFrIQbtPx50BZLXO8WM7jtxu3zCYfl0aQY7Vo371sdiuuA==
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr14769850wrx.100.1565285459920;
        Thu, 08 Aug 2019 10:30:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g25sm2136859wmk.39.2019.08.08.10.30.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 10:30:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 3/7] x86: KVM: clear interrupt shadow on EMULTYPE_SKIP
Date:   Thu,  8 Aug 2019 19:30:47 +0200
Message-Id: <20190808173051.6359-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808173051.6359-1-vkuznets@redhat.com>
References: <20190808173051.6359-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing x86_emulate_instruction(EMULTYPE_SKIP) interrupt shadow has to
be cleared if and only if the skipping is successful.

There are two immediate issues:
- In SVM skip_emulated_instruction() we are not zapping interrupt shadow
  in case kvm_emulate_instruction(EMULTYPE_SKIP) is used to advance RIP
  (!nrpip_save).
- In VMX handle_ept_misconfig() when running as a nested hypervisor we
  (static_cpu_has(X86_FEATURE_HYPERVISOR) case) forget to clear interrupt
  shadow.

Note that we intentionally don't handle the case when the skipped
instruction is supposed to prolong the interrupt shadow ("MOV/POP SS") as
skip-emulation of those instructions should not happen under normal
circumstances.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a97818b1111d..50e0b25092c7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6539,6 +6539,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 		kvm_rip_write(vcpu, ctxt->_eip);
 		if (ctxt->eflags & X86_EFLAGS_RF)
 			kvm_set_rflags(vcpu, ctxt->eflags & ~X86_EFLAGS_RF);
+		kvm_x86_ops->set_interrupt_shadow(vcpu, 0);
 		return EMULATE_DONE;
 	}
 
-- 
2.20.1

