Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8445C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1EC229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997126;
	bh=XzcmVw6O0WsNJmZ6Z51KPfrhZeLNXpF1hpRhXfiQhSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aMT2nC7X6Linrpd780roAPBmiIMzaXjSwB1POm+KXeB2cjt9j+zmbcs595fNVK7VH
	 vMxsMqZzNTyO4DRzBTX5yDmH+zF69iRfINcyrCsPQL9+Izq9p2qDTCD79uHQV6ECI/
	 nCf6k9+0IAB6T9kDYeiHyX73jyE9b4iStMMezRWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389744AbfGXTio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389655AbfGXTim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:38:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D0F214AF;
        Wed, 24 Jul 2019 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997121;
        bh=XzcmVw6O0WsNJmZ6Z51KPfrhZeLNXpF1hpRhXfiQhSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muWro4cshN81ch2aOCLh9bpH0n2n0B+wi/jRc1wNHdLbpIoPnyulxnl/losStuQ1N
         g/YhglhbQNwFNm3urOGtx/IO5jO7S0SnkhzWlcpv/eHWCfQQK9ujIrAxoelDAUlKrm
         53rFUlqwkCRpg7HP7bN1xW7Gb9i7DhyTRKx+zCdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.2 327/413] KVM: VMX: Always signal #GP on WRMSR to MSR_IA32_CR_PAT with bad value
Date:   Wed, 24 Jul 2019 21:20:18 +0200
Message-Id: <20190724191759.260753063@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit d28f4290b53a157191ed9991ad05dffe9e8c0c89 upstream.

The behavior of WRMSR is in no way dependent on whether or not KVM
consumes the value.

Fixes: 4566654bb9be9 ("KVM: vmx: Inject #GP on invalid PAT CR")
Cc: stable@vger.kernel.org
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1896,9 +1896,10 @@ static int vmx_set_msr(struct kvm_vcpu *
 					      MSR_TYPE_W);
 		break;
 	case MSR_IA32_CR_PAT:
+		if (!kvm_pat_valid(data))
+			return 1;
+
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
-			if (!kvm_pat_valid(data))
-				return 1;
 			vmcs_write64(GUEST_IA32_PAT, data);
 			vcpu->arch.pat = data;
 			break;


