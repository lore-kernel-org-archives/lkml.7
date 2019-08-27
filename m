Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED7FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C1F2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfH0QEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10917 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbfH0QEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:04:11 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B9B67FDCA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:04:11 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w11so11626057wru.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XqWagcDFu3I/3+ooG2WadK5AEABMMtW/Vv17jrsAvY=;
        b=SnfqafSC9chOrjJwCNyLU7vliZKv5qNDYnjBJqwNHxbzQj5cjJn6ZzpUFz6ftSk+2m
         Uda1D/opE0qrqqiIullYXt6ByEiZP7oYl11cq2hHSONKimjqFTqmwqFB1uCvrmAfyMlt
         UD3bWluDL41kZB01Gbr+XEEcNtRdezzBzKG+0pSASxmr1w8WnXAev+gKldZzmtGCqNxV
         gNupsPdgzMxDtaJ4a+evdb0DFkjC9ncgW0Fhi71Wk+p9sWtclLmnAuMx/iWRRGjbrI4/
         wPiEb/st6PbKs7xLw1CGZLW87NvqyYYhuPLyQNWOBnI18XQ3BiPGA4IdKv392FyvT4GR
         uZqA==
X-Gm-Message-State: APjAAAXo+8vADDlt2E2y45A37g2Zlatjlq6D1KvV4GgGxNt5i+ZdGkjj
        GrMnavxMDsC7YyLq00rOhtVODHqq6gvcQmOESlaWpSTXFhKcr6oa/qOCMEm+GFwMgcQIdEt2856
        MwWECx2LP0LxiC5Kxfyr2ynyu
X-Received: by 2002:a7b:c157:: with SMTP id z23mr29337862wmi.104.1566921849783;
        Tue, 27 Aug 2019 09:04:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybdX7p/8QSoNaXF11fp+waAg3kYnqCagdBNshParsrqdkSV4cb0vJ1fCD53SJ5jbyMRhQ3aw==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr29337838wmi.104.1566921849575;
        Tue, 27 Aug 2019 09:04:09 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n8sm13461246wro.89.2019.08.27.09.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:04:08 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 2/3] KVM: x86: svm: remove unneeded nested_enable_evmcs() hook
Date:   Tue, 27 Aug 2019 18:04:03 +0200
Message-Id: <20190827160404.14098-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190827160404.14098-1-vkuznets@redhat.com>
References: <20190827160404.14098-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 5158917c7b019 ("KVM: x86: nVMX: Allow nested_enable_evmcs to
be NULL") the code in x86.c is prepared to see nested_enable_evmcs being
NULL and in VMX case it actually is when nesting is disabled. Remove the
unneeded stub from SVM code.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 40175c42f116..6d52c65d625b 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -7122,13 +7122,6 @@ static int svm_unregister_enc_region(struct kvm *kvm,
 	return ret;
 }
 
-static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
-				   uint16_t *vmcs_version)
-{
-	/* Intel-only feature */
-	return -ENODEV;
-}
-
 static bool svm_need_emulation_on_page_fault(struct kvm_vcpu *vcpu)
 {
 	unsigned long cr4 = kvm_read_cr4(vcpu);
@@ -7337,7 +7330,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
 	.mem_enc_reg_region = svm_register_enc_region,
 	.mem_enc_unreg_region = svm_unregister_enc_region,
 
-	.nested_enable_evmcs = nested_enable_evmcs,
+	.nested_enable_evmcs = NULL,
 	.nested_get_evmcs_version = NULL,
 
 	.need_emulation_on_page_fault = svm_need_emulation_on_page_fault,
-- 
2.20.1

