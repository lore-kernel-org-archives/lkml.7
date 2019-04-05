Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91AEC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740802171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paZEgbl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDEWrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:47:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34661 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfDEWrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:47:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so9748833wrq.1;
        Fri, 05 Apr 2019 15:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eHbCkhdoOpnF8F/axoSBJ39P2CF2Q6TWQy+leIkw+5c=;
        b=paZEgbl0ANuDUeSLzJfs7pQ1oPQlb/YOXIvvxEfU74A3NrzUQwf1Yc6oScSCvbD+Jj
         3KmO0eKfnNPwt0ZGC8NsmngSU1Ap/FI4zn/Q3nkeEmuSgYrI82VDEs9TDAH4hgqHMPo9
         MNYXbq88Z5UF/azLTqN+eMYGyth6SacvrnjYuiTSCqPTUNkHKErDDJI5RmkbG8cFRQB1
         UEWEK/GznewViPqsGfwYX23jQSZKV5d2TDLMBQ9SfQTBtfe4IrfJQpVnPUSMjtTImSWG
         V2oHCaQ6BfsJi0aUTFT6Ovb288PTBd34dU90NbqyQbIfhwXJCmpOnYAJ8cTlUV29zCZ/
         akJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=eHbCkhdoOpnF8F/axoSBJ39P2CF2Q6TWQy+leIkw+5c=;
        b=G+IjQKaMw8JAW96ginxquMqM1JjqUoih2LqX25DHYhTW6OitYtDNLb2a78sBfc0CTp
         AgkcblNBrgapiKp3yBDMf9tRFHU833V6uaSIosvYaoOHeZSAiHeu/6AXuek8i23kdoTE
         DgoP2qNLXGtNwR1PC2DP8/enblv3C167tfA0+zdktHuxWIxRbHWOkP7OZmERv6E1soGL
         P2muB7BexTSBxmpI6pAfM5nEwVv7ajNjeq0ZjmnowP6bYNMXpr8v2qm9btJZHIRlhDJr
         COJT3Sb3lVPXecB10AfqHCsZaTBiQSJT9yPXEaK1/K3+6DL08tHtE572mWlWBa+udNNb
         iYIQ==
X-Gm-Message-State: APjAAAVfJtPqwNmQ6hhzI6CnCBAaf0qiB4FjC4k4awkiE1psCrNQDpw2
        5oihJqRUZDeok2DXmdfH87nUrJaN
X-Google-Smtp-Source: APXvYqzZNWG9stoUbB/7xPZQMf6GOKatODqaThK8bn68OzEh/P/z5nngdZjU2CtcJLb+6M6EFDNdMg==
X-Received: by 2002:adf:db05:: with SMTP id s5mr10428695wri.247.1554504419660;
        Fri, 05 Apr 2019 15:46:59 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 7sm81190791wrc.81.2019.04.05.15.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:46:59 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Marc Orr <marcorr@google.com>
Subject: [PATCH 2/2] KVM: x86: nVMX: fix x2APIC VTPR read intercept
Date:   Sat,  6 Apr 2019 00:46:56 +0200
Message-Id: <1554504416-8720-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554504416-8720-1-git-send-email-pbonzini@redhat.com>
References: <1554504416-8720-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Orr <marcorr@google.com>

Referring to the "VIRTUALIZING MSR-BASED APIC ACCESSES" chapter of the
SDM, when "virtualize x2APIC mode" is 1 and "APIC-register
virtualization" is 0, a RDMSR of 808H should return the VTPR from the
virtual APIC page.

However, for nested, KVM currently fails to disable the read intercept
for this MSR. This means that a RDMSR exit takes precedence over
"virtualize x2APIC mode", and KVM passes through L1's TPR to L2,
instead of sourcing the value from L2's virtual APIC page.

This patch fixes the issue by disabling the read intercept, in VMCS02,
for the VTPR when "APIC-register virtualization" is 0.

The issue described above and fix prescribed here, were verified with
a related patch in kvm-unit-tests titled "Test VMX's virtualize x2APIC
mode w/ nested".

Signed-off-by: Marc Orr <marcorr@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Fixes: c992384bde84f ("KVM: vmx: speed up MSR bitmap merge")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 897d70e3d291..7ec9bb1dd723 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -578,7 +578,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 		nested_vmx_disable_intercept_for_msr(
 			msr_bitmap_l1, msr_bitmap_l0,
 			X2APIC_MSR(APIC_TASKPRI),
-			MSR_TYPE_W);
+			MSR_TYPE_R | MSR_TYPE_W);
 
 		if (nested_cpu_has_vid(vmcs12)) {
 			nested_vmx_disable_intercept_for_msr(
-- 
1.8.3.1

