Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51802C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC5A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfH1H7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:59:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfH1H7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:59:10 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCEEE81DE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:59:09 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id d65so677192wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBboHqcZl+GeeqMr+xhVz73awkXrj2sOIO6d13g0iRE=;
        b=Vuttczpjp66FF8Eegn68lwoQSPY0DVZpFCnXV4ABMXElHd27kHpGZ0Jy2YtR9EmcEe
         T2SgOle6XeIQQS+QsqkyNEbYQexGu5/PM+wba3EIy32bRdgICL3xUylMxJKjLdc800GN
         4KbfRD3cqic9feYtecpRy8QxHNF0wU6Fgo1a4gDxSkv8H4R80YMWIJCZMmTSGzXPAjCc
         0C7ARoGxcdM3HdgOdkx9CmJuuYFqMWGcWiE7MeatwAT3vcuRsTMOO3OUlb1F/iE2IRdp
         hvibwOBPTMLCjxOnkhsVJLH2t2/W6CDabAibSFMI5rItOUI837jnf6RyHNLQMrauozdi
         p3XA==
X-Gm-Message-State: APjAAAVO2pXFdpkPeCoH10DU9HJ+FfesXVhkTwNcUOnp/v+tV2yUE0rz
        YZtkJ/4GKk4cgvycov8pZj4vlqmVvJtVFx0C3TBcbZRVBaggSwubyABNFfqMrlUKMERtMgAA/Cn
        Uwf/NQstD8voODfXNxPG8qf02
X-Received: by 2002:adf:f18c:: with SMTP id h12mr2713823wro.47.1566979148632;
        Wed, 28 Aug 2019 00:59:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyg75w3y/I6ECh2ht91PCD+cPI1HSKMT6eKRHsTiLiLoq2ckp9NA9BsenuangkEk7V6n9c+3A==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr2713808wro.47.1566979148444;
        Wed, 28 Aug 2019 00:59:08 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a190sm2448469wme.8.2019.08.28.00.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:59:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH v2 1/2] KVM: x86: svm: remove unneeded nested_enable_evmcs() hook
Date:   Wed, 28 Aug 2019 09:59:04 +0200
Message-Id: <20190828075905.24744-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828075905.24744-1-vkuznets@redhat.com>
References: <20190828075905.24744-1-vkuznets@redhat.com>
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
Reviewed-by: Jim Mattson <jmattson@google.com>
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

