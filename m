Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90134C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7306D215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392888AbfFMQmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:42:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37502 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbfFMGtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:49:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so7695185plb.4;
        Wed, 12 Jun 2019 23:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKPDMBsM8vrHynfTKpftZ1wRPHd2M86wqu3lhZWYIxQ=;
        b=R2CJdlfbpj/3UfeaHuQdolhnNm9LDeeJdpeuXpcRNiLe+DwqyxRyob1wAYNYwxeF8E
         0vuM51t1vACyNFiMxoXNsSr2JeATLleB2RJYMsDTKnP3xwXF+4Iz3a3rpZuTq2vaJBlC
         U0APHCOOpplypfKlZFNucDyQIpBjDAWYCGZDIoFfxLBhw638Yqhr/4JaFZdn7E/uLqsL
         akDXNVZHBPTN7gcqmYC7dAYfmLB6ckn1lNy94KL+c6XP7noFULT4yVF/IZVryPdvvdQB
         czekNaishcLUYDdy0Az9lGpAdqeLavpgvtTgCq6TGsbjcHnfHS+O1L21ioJaZRVYbkqs
         c14Q==
X-Gm-Message-State: APjAAAWl6xhWDSbq1z6JunRdWuJpTrEWfyKj7Cd0kkDwfHXI35AHJ4AU
        5vCA+aGdXZ/SJa7bg16h2/I=
X-Google-Smtp-Source: APXvYqze3spnPy5+jQ2P2RcqO0x3b64/51oCOz9EvFnfH/l48AC8TBWeDKPA5U++WYuimqwPJOokKw==
X-Received: by 2002:a17:902:b695:: with SMTP id c21mr33768438pls.160.1560408572179;
        Wed, 12 Jun 2019 23:49:32 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i3sm1559973pfa.175.2019.06.12.23.49.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 23:49:31 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH 6/9] KVM: x86: Provide paravirtualized flush_tlb_multi()
Date:   Wed, 12 Jun 2019 23:48:10 -0700
Message-Id: <20190613064813.8102-7-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613064813.8102-1-namit@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the new interface of flush_tlb_multi, which also flushes the
local CPU's TLB, instead of flush_tlb_others that does not. This
interface is more performant since it parallelize remote and local TLB
flushes.

The actual implementation of flush_tlb_multi() is almost identical to
that of flush_tlb_others().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/kvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 00d81e898717..d00d551d4a2a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -580,7 +580,7 @@ static void __init kvm_apf_trap_init(void)
 
 static DEFINE_PER_CPU(cpumask_var_t, __pv_tlb_mask);
 
-static void kvm_flush_tlb_others(const struct cpumask *cpumask,
+static void kvm_flush_tlb_multi(const struct cpumask *cpumask,
 			const struct flush_tlb_info *info)
 {
 	u8 state;
@@ -594,6 +594,11 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
 	 * queue flush_on_enter for pre-empted vCPUs
 	 */
 	for_each_cpu(cpu, flushmask) {
+		/*
+		 * The local vCPU is never preempted, so we do not explicitly
+		 * skip check for local vCPU - it will never be cleared from
+		 * flushmask.
+		 */
 		src = &per_cpu(steal_time, cpu);
 		state = READ_ONCE(src->preempted);
 		if ((state & KVM_VCPU_PREEMPTED)) {
@@ -603,7 +608,7 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
 		}
 	}
 
-	native_flush_tlb_others(flushmask, info);
+	native_flush_tlb_multi(flushmask, info);
 }
 
 static void __init kvm_guest_init(void)
@@ -628,9 +633,8 @@ static void __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
 	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
 	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
-		pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
+		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
 		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
-		static_key_disable(&flush_tlb_multi_enabled.key);
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
-- 
2.20.1

