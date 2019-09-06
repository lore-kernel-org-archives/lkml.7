Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE2C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BB0206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404394AbfIFCRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:17:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404382AbfIFCRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:17:47 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26813C05AA6B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 02:17:47 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id j12so2631314pll.14
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 19:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBNEjbH++Cplr+hlTTIn2gJ2guzKt/zMnh4i7J+yi14=;
        b=dzcoIdNJOgxkeesgMk7XnHnHTu0KxrvMoiVsYkx1FeqVsDGpkruSmnL2LNutsIzsfh
         zwAJO4qvKctfXrOjZnzznd8TF2QMLKRQOhmhcSJdaWCDC3KkDg665oVmBd+t2I9jhDLF
         w3cFtIjdU5U0Hmq9vYwp90HkSujFAjIL0+fiWEqbUnKUEFKwSqGTdt6peLDAqr0kwllI
         lmRKJj9PRm+7q/+1EFZC4H11WdTIUigI8Ni8yeOnkEL38+fyyEILELsBonO85+2PUCD5
         UdPIzkdTFDFOcBC7X/YFzVnDmzOm/mwVfU7ep8Bn0ikPs+CgP7NNurLDFjMLPIujz7JZ
         BbLg==
X-Gm-Message-State: APjAAAUiNTBjbMXPIDpkGFDuiIJH0ktZyp8gIVuReXCTlyLq6Ao5jcTa
        c+WSpwo1Nv04r8I65QDCikJ6aLsrHHKWXhB5i+n1E+PhuaOAKIsjuhvNlm/LdmTmsFZtxsgvOFd
        zq1DFTTIG08P+HVUoHXLftut4
X-Received: by 2002:a63:2043:: with SMTP id r3mr5988063pgm.311.1567736266116;
        Thu, 05 Sep 2019 19:17:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUec44Alg2d7GbiXyFGAxolQO9nJYnvLN4s2Tf/cBHafByYGpQiuLIicL/1aLfJIR/cNmAwQ==
X-Received: by 2002:a63:2043:: with SMTP id r3mr5988045pgm.311.1567736265811;
        Thu, 05 Sep 2019 19:17:45 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a11sm8212359pfg.94.2019.09.05.19.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:17:45 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>, peterx@redhat.com
Subject: [PATCH v4 4/4] KVM: X86: Tune PLE Window tracepoint
Date:   Fri,  6 Sep 2019 10:17:22 +0800
Message-Id: <20190906021722.2095-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190906021722.2095-1-peterx@redhat.com>
References: <20190906021722.2095-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLE window tracepoint triggers even if the window is not changed,
and the wording can be a bit confusing too.  One example line:

  kvm_ple_window: vcpu 0: ple_window 4096 (shrink 4096)

It easily let people think of "the window now is 4096 which is
shrinked", but the truth is the value actually didn't change (4096).

Let's only dump this message if the value really changed, and we make
the message even simpler like:

  kvm_ple_window: vcpu 4 old 4096 new 8192 (growed)

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/svm.c     | 16 ++++++++--------
 arch/x86/kvm/trace.h   | 22 ++++++----------------
 arch/x86/kvm/vmx/vmx.c | 14 ++++++++------
 arch/x86/kvm/x86.c     |  2 +-
 4 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index d685491fce4d..d5cb6b5a9254 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1269,11 +1269,11 @@ static void grow_ple_window(struct kvm_vcpu *vcpu)
 							pause_filter_count_grow,
 							pause_filter_count_max);
 
-	if (control->pause_filter_count != old)
+	if (control->pause_filter_count != old) {
 		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
-
-	trace_kvm_ple_window_grow(vcpu->vcpu_id,
-				  control->pause_filter_count, old);
+		trace_kvm_ple_window_update(vcpu->vcpu_id,
+					    control->pause_filter_count, old);
+	}
 }
 
 static void shrink_ple_window(struct kvm_vcpu *vcpu)
@@ -1287,11 +1287,11 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
 						    pause_filter_count,
 						    pause_filter_count_shrink,
 						    pause_filter_count);
-	if (control->pause_filter_count != old)
+	if (control->pause_filter_count != old) {
 		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
-
-	trace_kvm_ple_window_shrink(vcpu->vcpu_id,
-				    control->pause_filter_count, old);
+		trace_kvm_ple_window_update(vcpu->vcpu_id,
+					    control->pause_filter_count, old);
+	}
 }
 
 static __init int svm_hardware_setup(void)
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index afe8d269c16c..ae924566c401 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -890,37 +890,27 @@ TRACE_EVENT(kvm_pml_full,
 	TP_printk("vcpu %d: PML full", __entry->vcpu_id)
 );
 
-TRACE_EVENT(kvm_ple_window,
-	TP_PROTO(bool grow, unsigned int vcpu_id, unsigned int new,
-		 unsigned int old),
-	TP_ARGS(grow, vcpu_id, new, old),
+TRACE_EVENT(kvm_ple_window_update,
+	TP_PROTO(unsigned int vcpu_id, unsigned int new, unsigned int old),
+	TP_ARGS(vcpu_id, new, old),
 
 	TP_STRUCT__entry(
-		__field(                bool,      grow         )
 		__field(        unsigned int,   vcpu_id         )
 		__field(        unsigned int,       new         )
 		__field(        unsigned int,       old         )
 	),
 
 	TP_fast_assign(
-		__entry->grow           = grow;
 		__entry->vcpu_id        = vcpu_id;
 		__entry->new            = new;
 		__entry->old            = old;
 	),
 
-	TP_printk("vcpu %u: ple_window %u (%s %u)",
-	          __entry->vcpu_id,
-	          __entry->new,
-	          __entry->grow ? "grow" : "shrink",
-	          __entry->old)
+	TP_printk("vcpu %u old %u new %u (%s)",
+	          __entry->vcpu_id, __entry->old, __entry->new,
+		  __entry->old < __entry->new ? "growed" : "shrinked")
 );
 
-#define trace_kvm_ple_window_grow(vcpu_id, new, old) \
-	trace_kvm_ple_window(true, vcpu_id, new, old)
-#define trace_kvm_ple_window_shrink(vcpu_id, new, old) \
-	trace_kvm_ple_window(false, vcpu_id, new, old)
-
 TRACE_EVENT(kvm_pvclock_update,
 	TP_PROTO(unsigned int vcpu_id, struct pvclock_vcpu_time_info *pvclock),
 	TP_ARGS(vcpu_id, pvclock),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b172b675d420..1dbb63ffdd6d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5233,10 +5233,11 @@ static void grow_ple_window(struct kvm_vcpu *vcpu)
 					    ple_window_grow,
 					    ple_window_max);
 
-	if (vmx->ple_window != old)
+	if (vmx->ple_window != old) {
 		vmx->ple_window_dirty = true;
-
-	trace_kvm_ple_window_grow(vcpu->vcpu_id, vmx->ple_window, old);
+		trace_kvm_ple_window_update(vcpu->vcpu_id,
+					    vmx->ple_window, old);
+	}
 }
 
 static void shrink_ple_window(struct kvm_vcpu *vcpu)
@@ -5248,10 +5249,11 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
 					      ple_window_shrink,
 					      ple_window);
 
-	if (vmx->ple_window != old)
+	if (vmx->ple_window != old) {
 		vmx->ple_window_dirty = true;
-
-	trace_kvm_ple_window_shrink(vcpu->vcpu_id, vmx->ple_window, old);
+		trace_kvm_ple_window_update(vcpu->vcpu_id,
+					    vmx->ple_window, old);
+	}
 }
 
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 93b0bd45ac73..69ad184edc90 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10082,7 +10082,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_invlpga);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_skinit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_nested_intercepts);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_write_tsc_offset);
-EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_ple_window);
+EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_ple_window_update);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_pml_full);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_pi_irte_update);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_unaccelerated_access);
-- 
2.21.0

