Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CAA218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfCOPhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfCOPhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:37:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6E6A3082129;
        Fri, 15 Mar 2019 15:37:10 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CBBA100194A;
        Fri, 15 Mar 2019 15:37:09 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] KVM: x86: svm: make sure NMI is injected after nmi_singlestep
Date:   Fri, 15 Mar 2019 16:37:07 +0100
Message-Id: <20190315153707.32003-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 15 Mar 2019 15:37:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that apic test from kvm-unit-tests always hangs on my EPYC 7401P,
the hanging test nmi-after-sti is trying to deliver 30000 NMIs and tracing
shows that we're sometimes able to deliver a few but never all.

When we're trying to inject an NMI we may fail to do so immediately for
various reasons, however, we still need to inject it so enable_nmi_window()
arms nmi_singlestep mode. #DB occurs as expected, but we're not checking
for pending NMIs before entering the guest and unless there's a different
event to process, the NMI will never get delivered.

Make KVM_REQ_EVENT request on the vCPU from db_interception() to make sure
pending NMIs are checked and possibly injected.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- RFC: I'm not sure this is not part of some bigger issue I'm missing.
---
 arch/x86/kvm/svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f13a3a24d360..cc96008a6117 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2687,6 +2687,7 @@ static int npf_interception(struct vcpu_svm *svm)
 static int db_interception(struct vcpu_svm *svm)
 {
 	struct kvm_run *kvm_run = svm->vcpu.run;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	if (!(svm->vcpu.guest_debug &
 	      (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP)) &&
@@ -2697,6 +2698,8 @@ static int db_interception(struct vcpu_svm *svm)
 
 	if (svm->nmi_singlestep) {
 		disable_nmi_singlestep(svm);
+		/* Make sure we check for pending NMIs upon entry */
+		kvm_make_request(KVM_REQ_EVENT, vcpu);
 	}
 
 	if (svm->vcpu.guest_debug &
-- 
2.20.1

