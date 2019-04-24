Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8D121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127785;
	bh=pCGKVJXLOTuvtSnsaIR67mKMwzAMj32f4ruL9rHcF0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWOfodlP3/7+LpXF8/cgIDVxusfX8ig3VlescPYp6L8Lex8emvkA/X6mjueM0yugf
	 rMxyBszyZYm1p8OiiZowFIkNOauMeJyfopQ7BnWzpwpLcBhDeT7+4jq82hTmP8sdMo
	 fNU98fEgEHjN+6EWF5C0yc9gNXM9gdWfna6ePR0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392210AbfDXRnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391916AbfDXRfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:33 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7842054F;
        Wed, 24 Apr 2019 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127332;
        bh=pCGKVJXLOTuvtSnsaIR67mKMwzAMj32f4ruL9rHcF0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiSLGLIrbooUrFKa4aFc1gZeFhp6GTzLzHXd8wuJ0CjAyIYqVsc61xkaGDaI/WzaP
         HxXUEPxchfA75ZE8DO3y9DGhwWpDJjYSItKskSjiLV+apFICvPXnuUMZ3NJvhBQRH6
         hFWhTYm1YAE71pqkkyygdmEJ5ho5Dr0a9IJFBrPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 051/115] KVM: x86: svm: make sure NMI is injected after nmi_singlestep
Date:   Wed, 24 Apr 2019 19:09:47 +0200
Message-Id: <20190424170927.981638369@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 99c221796a810055974b54c02e8f53297e48d146 upstream.

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
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2687,6 +2687,7 @@ static int npf_interception(struct vcpu_
 static int db_interception(struct vcpu_svm *svm)
 {
 	struct kvm_run *kvm_run = svm->vcpu.run;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	if (!(svm->vcpu.guest_debug &
 	      (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP)) &&
@@ -2697,6 +2698,8 @@ static int db_interception(struct vcpu_s
 
 	if (svm->nmi_singlestep) {
 		disable_nmi_singlestep(svm);
+		/* Make sure we check for pending NMIs upon entry */
+		kvm_make_request(KVM_REQ_EVENT, vcpu);
 	}
 
 	if (svm->vcpu.guest_debug &


