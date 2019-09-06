Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9304C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C38206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404379AbfIFCRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:17:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404360AbfIFCRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:17:44 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87F2D7EBB1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 02:17:43 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id v15so3371850pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 19:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaVd3OQltvocaICCaNdt1dKy4a2qSML25Bhj/yWBYnU=;
        b=QP59Tg1+6MCiCWvpY/HIfShWmCnXL7Nx7Fv/dnFBiLctjKrZGeRdhHyVwWBl+aQlKj
         vOMpRBwh5GL2cJIU6bBe8uPs8oT7LBb9dY3BpEfHdbkIBrUW/Yc64byFD5pSBm+WpGBm
         izTsDuBWLxU8Wym7Rtu4+G32GPickTRMh1nSUSjNDk2vuDXLY+InqabEChMATFoMv4bH
         0vhvVR4VQ5x6xnt/cO2EEgK4GChBAzvfllQiBzA9KenlECZeaPw5JS8DNNVXeCT2yNUd
         qwu89moW2T5rmffzOQzhLIrKaU5wDVWsBfbCRV4r8bAuxNl33oIM7e279hU5nyLyGCNP
         uLLg==
X-Gm-Message-State: APjAAAXL5niCZ+JHiVqIv8BrkYv5DYxl//HcvDcloYxYdLEevzcf9Tn/
        c49NB1hxnzijAngt7XhnXoHFGlVLLjBleJQudfLcn15Rajh4XdU41M0KwpEl6+TQsXotpv6KMUj
        5f3yijOTpgbkSmm2vOuuCf/c+
X-Received: by 2002:a63:c70d:: with SMTP id n13mr5894829pgg.171.1567736262657;
        Thu, 05 Sep 2019 19:17:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7tCMCiTYtonlv5aU6ntwW21CQCMXwSpkGQ7RtzncHXfkgelMohyB6SmVihEwweFhDyPJ17g==
X-Received: by 2002:a63:c70d:: with SMTP id n13mr5894815pgg.171.1567736262401;
        Thu, 05 Sep 2019 19:17:42 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a11sm8212359pfg.94.2019.09.05.19.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:17:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>, peterx@redhat.com
Subject: [PATCH v4 3/4] KVM: VMX: Change ple_window type to unsigned int
Date:   Fri,  6 Sep 2019 10:17:21 +0800
Message-Id: <20190906021722.2095-4-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190906021722.2095-1-peterx@redhat.com>
References: <20190906021722.2095-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VMX ple_window is 32 bits wide, so logically it can overflow with
an int.  The module parameter is declared as unsigned int which is
good, however the dynamic variable is not.  Switching all the
ple_window references to use unsigned int.

The tracepoint changes will also affect SVM, but SVM is using an even
smaller width (16 bits) so it's always fine.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/trace.h   | 9 +++++----
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 arch/x86/kvm/vmx/vmx.h | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 8a7570f8c943..afe8d269c16c 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -891,14 +891,15 @@ TRACE_EVENT(kvm_pml_full,
 );
 
 TRACE_EVENT(kvm_ple_window,
-	TP_PROTO(bool grow, unsigned int vcpu_id, int new, int old),
+	TP_PROTO(bool grow, unsigned int vcpu_id, unsigned int new,
+		 unsigned int old),
 	TP_ARGS(grow, vcpu_id, new, old),
 
 	TP_STRUCT__entry(
 		__field(                bool,      grow         )
 		__field(        unsigned int,   vcpu_id         )
-		__field(                 int,       new         )
-		__field(                 int,       old         )
+		__field(        unsigned int,       new         )
+		__field(        unsigned int,       old         )
 	),
 
 	TP_fast_assign(
@@ -908,7 +909,7 @@ TRACE_EVENT(kvm_ple_window,
 		__entry->old            = old;
 	),
 
-	TP_printk("vcpu %u: ple_window %d (%s %d)",
+	TP_printk("vcpu %u: ple_window %u (%s %u)",
 	          __entry->vcpu_id,
 	          __entry->new,
 	          __entry->grow ? "grow" : "shrink",
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 42ed3faa6af8..b172b675d420 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5227,7 +5227,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 static void grow_ple_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	int old = vmx->ple_window;
+	unsigned int old = vmx->ple_window;
 
 	vmx->ple_window = __grow_ple_window(old, ple_window,
 					    ple_window_grow,
@@ -5242,7 +5242,7 @@ static void grow_ple_window(struct kvm_vcpu *vcpu)
 static void shrink_ple_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	int old = vmx->ple_window;
+	unsigned int old = vmx->ple_window;
 
 	vmx->ple_window = __shrink_ple_window(old, ple_window,
 					      ple_window_shrink,
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 82d0bc3a4d52..64d5a4890aa9 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -253,7 +253,7 @@ struct vcpu_vmx {
 	struct nested_vmx nested;
 
 	/* Dynamic PLE window. */
-	int ple_window;
+	unsigned int ple_window;
 	bool ple_window_dirty;
 
 	bool req_immediate_exit;
-- 
2.21.0

