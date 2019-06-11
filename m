Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFADC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EAE2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7YtPvpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404447AbfFKHed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:34:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36470 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404374AbfFKHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:34:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so982226pfl.3;
        Tue, 11 Jun 2019 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KiK1sq6GLpZIcwmBcLvrW6rSd5iYr3Yl60n90C4FhKI=;
        b=i7YtPvpKHxs3dfZ9dPikQImsgqFjtNJxtRVnhxwS8AhWrPhho9oasi+27l5ZuAuO90
         2RItdIDnMgxqfPbwqYueISYC9Vc8TwUfu+No+i8Y8NZFPWQY4D1ZSUy8jjFOiOuoSJXT
         vtcNPobFq/eK8FrSx082AhcmFO/gO2OYITSMseG6HJJcU89+1EOGYR16yzErvHZ8Nrr2
         qJqRHBMdJhfKv3SFcyof9ScjKmLO3SPuELdwynPVj7hSsNJ6WKV2/3/7Lf8LyMLOaCtZ
         NNDquiicw8cqWOJW9K1wvP7HJD9gVNUa8UCYEDLIKGuonnNy+G2rUgo1BmVH3QiDUCX/
         enLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiK1sq6GLpZIcwmBcLvrW6rSd5iYr3Yl60n90C4FhKI=;
        b=iudrz5gfOTPnulZkjlNN/UrIzFIG0WiqI6ESO/ijnz+xWWykAaVW0z5eUkTVw3XNKD
         TCpgR6z/EHZSFrgZtsG0rAIpzPzEcBwtv0g8c8UW34KoMBdrol/NcivnVaKbPIcN72eP
         Sef5o/DeOiODzYdEGfWY14uDy5Wwt8B9P8zyLvGGEoe5FNdjesB3Kzo2bx5k51STrzn+
         CtDF2FwQ3HqvaGwevcUtWIjU3PfpXAcRFveEOKV1l7wfVIBjyA7aDBQIvM2WcUeps1fT
         u/9ylbJ9IW4HWGj5fqWx7AmUFXcJwaJnxPXUIKQstE4CQZ9OvEhxP/YIolDsmoyVlHbG
         0Lkg==
X-Gm-Message-State: APjAAAXnUQRBMTmQ5y0PaX2VPIJyyE+bQQJSYvxVMh3zv5iRN0y+kLz0
        XfSKahRqK/G2TbJU97a6cD9kd/KO
X-Google-Smtp-Source: APXvYqwCId+VuuH2ogy+M94QbDVmB7z5myYykQrvTUHZC+jPGp/cb+wR7jbHzZpQwVK6n0vrF2nMRQ==
X-Received: by 2002:aa7:9256:: with SMTP id 22mr66307954pfp.69.1560238469395;
        Tue, 11 Jun 2019 00:34:29 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id 14sm6860800pfj.36.2019.06.11.00.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 00:34:28 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 4/5] KVM: VMX: Add get/set residency msrs logic
Date:   Tue, 11 Jun 2019 15:34:10 +0800
Message-Id: <1560238451-19495-5-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560238451-19495-1-git-send-email-wanpengli@tencent.com>
References: <1560238451-19495-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Add logic to get/set the residency msrs. Then current idle
power-state residency statistics can be consult by guest, and 
be save/restore during live migration.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2ebaa90..852f51e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1715,6 +1715,9 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_FEATURE_CONTROL:
 		msr_info->data = vmx->msr_ia32_feature_control;
 		break;
+	case MSR_CORE_C3_RESIDENCY ... MSR_CORE_C7_RESIDENCY:
+		msr_info->data = kvm_residency_read(vcpu, msr_info->index);
+		break;
 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
 		if (!nested_vmx_allowed(vcpu))
 			return 1;
@@ -1928,6 +1931,11 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (msr_info->host_initiated && data == 0)
 			vmx_leave_nested(vcpu);
 		break;
+	case MSR_CORE_C3_RESIDENCY ... MSR_CORE_C7_RESIDENCY:
+		if (!msr_info->host_initiated)
+			return 1;
+		kvm_residency_write(vcpu, msr_info->index, data);
+		break;
 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
 		if (!msr_info->host_initiated)
 			return 1; /* they are read-only */
-- 
2.7.4

