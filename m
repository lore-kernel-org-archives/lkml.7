Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DE9C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A7120830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti2Me5wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfDJJzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:55:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35952 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbfDJJza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:55:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so1871765wml.1;
        Wed, 10 Apr 2019 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=7i5SlzB6pHh66J0GYb7kkJCIFl3+YonnZRmzOlo+++w=;
        b=ti2Me5wxoKo25HKKQwB+dF65zRsFaErnPpgfV8rresaxjyK3P1Q06Dv49Fu4NEk90J
         VGvAamRYEIuycfzyKC/YgmAc/zXBsLcLUGeo6L6qSH4AdOdwGyxQrkrKj/WbR8Wx7E7g
         o5BakOOj6hPlohLdT1/cphUIb77KnUpj5ihBQvTt64FZEuoC0LQwoUPfGs9b4zXx24jI
         2kFu88kwRKyHFXb6ShzHWuO1KquBOWNNonHt/Ae4rrEjbRsnNtbO9VbwlvAo9mS7L+aH
         KowL9K6mmjFdyO6CefDOniHogyX6szoO/czKh1gWoGahoonV9JmPk21zcOvhqsnreyrn
         sW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=7i5SlzB6pHh66J0GYb7kkJCIFl3+YonnZRmzOlo+++w=;
        b=meengXjU6cGLSnVo0wN7oxwyNAlGvxCDOhnqOI+N2Ut3E+gUVdXgIO7y9S9H4+HGwW
         7HjUDsEIwA/uC+JCF8M/sauiCrqkzLWhBB/V5sT8i6x45ZHCw5x0B4TwnCRIyAYpH1cb
         ToBV9CpfSPqrEtVKypExXHVvk39/d/yNPzSUnKLKGOsdMCRI1OyN/pLQnpUWjAKoEGrd
         x0FtLfIekRxWaW2b495x5bXBU7ffPPvd2/UQ6q/E+dWoc0q9k9LyjUZIU8urCdM9l1Yr
         lc+WaJJXzc3QIxKM4tquORURjrQyFgAPlnxdkGwWjFL1Vf9ZjjvzknpPp1QjbbX+VdRK
         z7qQ==
X-Gm-Message-State: APjAAAUDpFj4SpeiP0m5oM5MaMcwWEiGif78OMZmybcG2nUkWrrXkScm
        lulW/CFrXcXslgKznk+NqRjULOAU
X-Google-Smtp-Source: APXvYqxbTEigNqveRBFvSAsWST9oBqt2HCxb37Br90t7NTuEwc7Ve7JXRYKOtV7RHvY6k+ANRLAm6w==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr2220645wmj.41.1554890127964;
        Wed, 10 Apr 2019 02:55:27 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id x192sm2293103wmf.48.2019.04.10.02.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 02:55:27 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: optimize check for valid PAT value
Date:   Wed, 10 Apr 2019 11:55:26 +0200
Message-Id: <1554890126-347-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check will soon be done on every nested vmentry and vmexit,
"parallelize" it using bitwise operations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mtrr.c    | 10 +---------
 arch/x86/kvm/vmx/vmx.c |  2 +-
 arch/x86/kvm/x86.h     |  8 ++++++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index e9ea2d45ae66..9f72cc427158 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -48,11 +48,6 @@ static bool msr_mtrr_valid(unsigned msr)
 	return false;
 }
 
-static bool valid_pat_type(unsigned t)
-{
-	return t < 8 && (1 << t) & 0xf3; /* 0, 1, 4, 5, 6, 7 */
-}
-
 static bool valid_mtrr_type(unsigned t)
 {
 	return t < 8 && (1 << t) & 0x73; /* 0, 1, 4, 5, 6 */
@@ -67,10 +62,7 @@ bool kvm_mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 		return false;
 
 	if (msr == MSR_IA32_CR_PAT) {
-		for (i = 0; i < 8; i++)
-			if (!valid_pat_type((data >> (i * 8)) & 0xff))
-				return false;
-		return true;
+		return kvm_pat_valid(data);
 	} else if (msr == MSR_MTRRdefType) {
 		if (data & ~0xcff)
 			return false;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b6c533afbf27..b74679732cfc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1891,7 +1891,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
-			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
+			if (!kvm_pat_valid(data))
 				return 1;
 			vmcs_write64(GUEST_IA32_PAT, data);
 			vcpu->arch.pat = data;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 28406aa1136d..7bc7ac9d2a44 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -347,4 +347,12 @@ static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
 	__this_cpu_write(current_vcpu, NULL);
 }
 
+static inline bool kvm_pat_valid(u64 data)
+{
+	if (data & 0xF8F8F8F8F8F8F8F8)
+		return false;
+	/* 0, 1, 4, 5, 6, 7 are valid values.  */
+	return (data | ((data & 0x0202020202020202) << 1)) == data;
+}
+
 #endif
-- 
1.8.3.1

