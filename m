Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBC8C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CE9214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380721;
	bh=SZXIqfAgaTS7F61Q7t87qyxuyGL/Zu829fTaZan6ApQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ibsGxIS6G+q2LbVNMXx91rdfT7KQu36xAWi3lyX4d9gAKfV5O2CepisVifjr1laZR
	 g1CeujNgrtsgKk1SwwUkOEdPcvc0cX14wKPYhX4uw81V6MRwj51LGWMHP2jqr6PPB2
	 yoHuNibrC6Mr2KtNp076ZJVABkwdMQbCME3HAUUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390273AbfIMNSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390253AbfIMNSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:18:39 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1177420CC7;
        Fri, 13 Sep 2019 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380718;
        bh=SZXIqfAgaTS7F61Q7t87qyxuyGL/Zu829fTaZan6ApQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nluEfs5d4vjsHcH/6z/7eXK4w3kNTMs+AcxsicrSiWaZz+Rl3xBmasg5J9EqYe9NH
         bSlxdiZail2r/WMaxre+C8m0g5VG6oClx45VR6K+mRv7TTHVeE/aLlpWcOVslZr03x
         fqYiATWNors5Wt3waJI1XNnGCAVePUquqAi2AkTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Tao Xu <tao3.xu@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 155/190] KVM: VMX: check CPUID before allowing read/write of IA32_XSS
Date:   Fri, 13 Sep 2019 14:06:50 +0100
Message-Id: <20190913130612.306210059@linuxfoundation.org>
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

[ Upstream commit 4d763b168e9c5c366b05812c7bba7662e5ea3669 ]

Raise #GP when guest read/write IA32_XSS, but the CPUID bits
say that it shouldn't exist.

Fixes: 203000993de5 (kvm: vmx: add MSR logic for XSAVES)
Reported-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Reported-by: Tao Xu <tao3.xu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 82253d31842a2..2938b4bcc9684 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4135,7 +4135,10 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		return vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
 				       &msr_info->data);
 	case MSR_IA32_XSS:
-		if (!vmx_xsaves_supported())
+		if (!vmx_xsaves_supported() ||
+		    (!msr_info->host_initiated &&
+		     !(guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
+		       guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))))
 			return 1;
 		msr_info->data = vcpu->arch.ia32_xss;
 		break;
@@ -4302,7 +4305,10 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		return vmx_set_vmx_msr(vcpu, msr_index, data);
 	case MSR_IA32_XSS:
-		if (!vmx_xsaves_supported())
+		if (!vmx_xsaves_supported() ||
+		    (!msr_info->host_initiated &&
+		     !(guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
+		       guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))))
 			return 1;
 		/*
 		 * The only supported bit as of Skylake is bit 8, but
-- 
2.20.1



