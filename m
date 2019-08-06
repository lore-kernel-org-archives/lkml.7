Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EC5C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ADF216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbfHFGCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:02:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46365 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731766AbfHFGB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:01:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so86570590wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5IKaQpUKaGFD2eXbnxPYilppDEMXmw1IQnFzmbG2kIs=;
        b=NuRJU8pckmeGoofM5tijuSIxrKwfHxiVYyLIl6i6wEfRxfnnAsBcqlfgVzqfu2LzCT
         RTO2rAtHUXtl/ThI9X3OR9LmVNkA5lVMNifmdCMINIUq01/cKvLScXZLxyeWq8xqBdHO
         6Fws2UZgnklzKkRishsoZ66NJeRcqNinIKRyDfyMwdbK444zHMh19RuFDCl/oyz/uuwG
         8ujFRNcJPzSQCJpAhEjEFzayx+nVDmFn4ul132a2Z9b4rwfTUMgITfXv8c8k4K+CaI+e
         1oDKWBuS2gP0cDDqgBjLlL4eWoPOk5fziPz++VNpT6FZ0AaMuWL9mG0ICKyyb0yEDiEK
         YUBg==
X-Gm-Message-State: APjAAAVZmbsWXy8H2peaQuEDBAVHhyGY9TUCaG20bcPWZMhv3sPK89wt
        /8A+0ji6RHfup5k1giqX01KHMA==
X-Google-Smtp-Source: APXvYqzfhabQ3uNqXVjy7dkBXglvC99jIMAh3DG8YLE7Sf8cSzYx13uemFaSwRlYO2vqFDyEOkGY7w==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr2364192wrn.171.1565071316992;
        Mon, 05 Aug 2019 23:01:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id r5sm94216756wmh.35.2019.08.05.23.01.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 23:01:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v2 3/5] x86: KVM: clear interrupt shadow on EMULTYPE_SKIP
Date:   Tue,  6 Aug 2019 08:01:48 +0200
Message-Id: <20190806060150.32360-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806060150.32360-1-vkuznets@redhat.com>
References: <20190806060150.32360-1-vkuznets@redhat.com>
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
  (static_cpu_has(X86_FEATURE_HYPERVISOR) case) we forget to clear
  interrupt shadow.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c6d951cbd76c..eac8253d84d2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6537,6 +6537,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 		kvm_rip_write(vcpu, ctxt->_eip);
 		if (ctxt->eflags & X86_EFLAGS_RF)
 			kvm_set_rflags(vcpu, ctxt->eflags & ~X86_EFLAGS_RF);
+		kvm_x86_ops->set_interrupt_shadow(vcpu, 0);
 		return EMULATE_DONE;
 	}
 
-- 
2.20.1

