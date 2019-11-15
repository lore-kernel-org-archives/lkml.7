Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DA4C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119F92073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798919;
	bh=DapC7MFQ0nomUONrp9RWoECZsN52MGyL7iftAmoKWwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WZUE4yMKImDUroVxHyDJBIyuVZyfpANSqtfaQJG9X4aWNLvWJ6dUfLoG75CVte7Xt
	 i2mxvNr50DQ2PFhoXPZwlxjJSjuemMzomngQnLL0oWNNbn2TfDnfOyVfJXGLKyCFmm
	 kJwK6PJ36BOcoVrHbN+fE7f0okhtTqiY/MbPXHtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfKOGV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbfKOGVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:21:55 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D1972073A;
        Fri, 15 Nov 2019 06:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798914;
        bh=DapC7MFQ0nomUONrp9RWoECZsN52MGyL7iftAmoKWwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYprjwg7pPIlHplhBrOAoFYKdB1kzV9oTPsSNCmZx9ce1SwIKJAX0TACLxz9skols
         y3g1B4DkHt8JaUSldSWoZYwFO1Kpnrt3LmWo8mOpXCvvPGyX3CFAVJE2Qsa2lPWhRp
         A8aOoH1kscw8DL17Cqj01HrInBzi6xOJfUgKv8iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/31] kvm: mmu: Dont read PDPTEs when paging is not enabled
Date:   Fri, 15 Nov 2019 14:20:30 +0800
Message-Id: <20191115062010.110140555@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
References: <20191115062009.813108457@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junaid Shahid <junaids@google.com>

[ Upstream commit d35b34a9a70edae7ef923f100e51b8b5ae9fe899 ]

kvm should not attempt to read guest PDPTEs when CR0.PG = 0 and
CR4.PAE = 1.

Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -587,7 +587,7 @@ static bool pdptrs_changed(struct kvm_vc
 	gfn_t gfn;
 	int r;
 
-	if (is_long_mode(vcpu) || !is_pae(vcpu))
+	if (is_long_mode(vcpu) || !is_pae(vcpu) || !is_paging(vcpu))
 		return false;
 
 	if (!test_bit(VCPU_EXREG_PDPTR,
@@ -7491,7 +7491,7 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct
 		kvm_update_cpuid(vcpu);
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
-	if (!is_long_mode(vcpu) && is_pae(vcpu)) {
+	if (!is_long_mode(vcpu) && is_pae(vcpu) && is_paging(vcpu)) {
 		load_pdptrs(vcpu, vcpu->arch.walk_mmu, kvm_read_cr3(vcpu));
 		mmu_reset_needed = 1;
 	}


