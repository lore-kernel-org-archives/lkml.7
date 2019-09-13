Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD14C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D518220CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380716;
	bh=hbgZ6giQbwqTm1/yWXdAQoI7w9rLN26p2P7hlsx9MXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EnK5sniIZCA0jnqqEofWJMG9eTwtP16dn0RyCkMiI0G9m4T7jayLBWYr596rySyvL
	 +LSqN7/c7nYKNOyrbFyIB2S7VPSTnCKD+hffzp7JpLO88kQq0RbF9KQcMYTiUgf7/4
	 YqwhRyGVFXICWEKBznaI6MAxRx3cqvi0tq660J2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390250AbfIMNSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389668AbfIMNSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:18:32 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E27CB206A5;
        Fri, 13 Sep 2019 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380712;
        bh=hbgZ6giQbwqTm1/yWXdAQoI7w9rLN26p2P7hlsx9MXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/p4do2pBcakueacYuHjZxmR6WRfBCAnru9mOwrm+Z8Yu5MDyC8FbmdzPmSgaJHHy
         RjL9t7s9DXWZpyGUoFXNaoZMB8hzFXMfgGgCzxSoe7fCW7Sr1b/qY0UM+3ZWyRGpVV
         KyiL2dH5u4ZKioC56goZXOJAodiAB9uksuu+vJfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 153/190] KVM: VMX: Always signal #GP on WRMSR to MSR_IA32_CR_PAT with bad value
Date:   Fri, 13 Sep 2019 14:06:48 +0100
Message-Id: <20190913130612.141351420@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d28f4290b53a157191ed9991ad05dffe9e8c0c89 ]

The behavior of WRMSR is in no way dependent on whether or not KVM
consumes the value.

Fixes: 4566654bb9be9 ("KVM: vmx: Inject #GP on invalid PAT CR")
Cc: stable@vger.kernel.org
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index feff7ed44a2bb..e4bba840a0708 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4265,9 +4265,10 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
-- 
2.20.1



