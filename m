Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01612173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOXGE1zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfLKUtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:49:17 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:41555 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfLKUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:49:14 -0500
Received: by mail-pj1-f73.google.com with SMTP id ie20so12151790pjb.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 12:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pF2WlIU/fL9uff7kBsgxTMqKCCrCXAxDkCSxpnWA8Hc=;
        b=wOXGE1ziHhMbTaWk5y905z7CmNYrHF2stLJ5nTSOyydpukAcfH2AGVCowdYSm4ypL0
         64ZDkbUtjEle5f3WH546F616ttT1IhpXK8uXs27g2zqc6n2k5UGaltx8c+LdvGJk2wLB
         IsyfwA8Xf9K2vl+Gy7e5Ox29QiWDRXmIN5Zi0BnKHdD4doWO5yb5XAKXsqZGzrcxA9lv
         gn/TJstleJ0fjN83ur/dKMmGstvi3C9aSMFq7luP67J+ViXeL4QL26nRBY1EeutWcNUY
         /k86MW3ABKZuyJArYW2ng4RxiE6jy+xeHNBRYURrC70qcyTw2/zxjDul3ZwJoCqLessW
         Ub/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pF2WlIU/fL9uff7kBsgxTMqKCCrCXAxDkCSxpnWA8Hc=;
        b=Mn2KiaPDnoLmVMFOXIL9jXmnbrL50CAksbOWx6C0FCH/R60TRZp0hLvDBhcZLev+i7
         A7IRas2+GYk8D4cQ4bcamX9wTXfo7G+UGmjUrhSYnwjmuOV3CLlesR03P4XudgaK5t9A
         1MJ0Q05eQ1niMCafX0x5/mIMzgAmGoJERv9z/HLqoFDNBoomHxBB62HEaq3jhxqWQc5X
         mSoqFsGfNIivj2CVZZwkTnkYIMw2V8TziJRMGXX7Tl5cum4q+ljD5wW1Ioc7fxx0DQPo
         6pQEciFNfsu4NfUsGw2QeJSaLjLobvA3/4ZDEpZ0awt+BIUicyZ7iOwapK34iu7GEnYM
         WU3g==
X-Gm-Message-State: APjAAAVn+uAo12ZDj5rfamNjZjzMTLuoPOTpm5Z8+o+BxI/6ZxoiIpR0
        Ml7os8Z42HUl8cd/lJuQ0XhysyfWWgwy
X-Google-Smtp-Source: APXvYqz7DGnJhK745r3i0eJnor21BV+iB+U1VIoblnM/Xj/Ff3DlAEHm++Y8oQpKEj9whBnf2R+gfdKZ59rw
X-Received: by 2002:a63:6704:: with SMTP id b4mr6504163pgc.424.1576097353549;
 Wed, 11 Dec 2019 12:49:13 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:47:53 -0800
In-Reply-To: <20191211204753.242298-1-pomonis@google.com>
Message-Id: <20191211204753.242298-14-pomonis@google.com>
Mime-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v2 13/13] KVM: x86: Protect pmu_intel.c from Spectre-v1/L1TF attacks
From:   Marios Pomonis <pomonis@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        Marios Pomonis <pomonis@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes Spectre-v1/L1TF vulnerabilities in intel_find_fixed_event()
and intel_rdpmc_ecx_to_pmc().
kvm_rdpmc() (ancestor of intel_find_fixed_event()) and
reprogram_fixed_counter() (ancestor of intel_rdpmc_ecx_to_pmc()) are
exported symbols so KVM should treat them conservatively from a security
perspective.

Fixes: commit 25462f7f5295 ("KVM: x86/vPMU: Define kvm_pmu_ops to support vPMU function dispatch")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kvm/vmx/pmu_intel.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 7023138b1cb0..34a3a17bb6d7 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -86,10 +86,14 @@ static unsigned intel_find_arch_event(struct kvm_pmu *pmu,
 
 static unsigned intel_find_fixed_event(int idx)
 {
-	if (idx >= ARRAY_SIZE(fixed_pmc_events))
+	u32 event;
+	size_t size = ARRAY_SIZE(fixed_pmc_events);
+
+	if (idx >= size)
 		return PERF_COUNT_HW_MAX;
 
-	return intel_arch_events[fixed_pmc_events[idx]].event_type;
+	event = fixed_pmc_events[array_index_nospec(idx, size)];
+	return intel_arch_events[event].event_type;
 }
 
 /* check if a PMC is enabled by comparing it with globl_ctrl bits. */
@@ -130,16 +134,20 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	bool fixed = idx & (1u << 30);
 	struct kvm_pmc *counters;
+	unsigned int num_counters;
 
 	idx &= ~(3u << 30);
-	if (!fixed && idx >= pmu->nr_arch_gp_counters)
-		return NULL;
-	if (fixed && idx >= pmu->nr_arch_fixed_counters)
+	if (fixed) {
+		counters = pmu->fixed_counters;
+		num_counters = pmu->nr_arch_fixed_counters;
+	} else {
+		counters = pmu->gp_counters;
+		num_counters = pmu->nr_arch_gp_counters;
+	}
+	if (idx >= num_counters)
 		return NULL;
-	counters = fixed ? pmu->fixed_counters : pmu->gp_counters;
 	*mask &= pmu->counter_bitmask[fixed ? KVM_PMC_FIXED : KVM_PMC_GP];
-
-	return &counters[idx];
+	return &counters[array_index_nospec(idx, num_counters)];
 }
 
 static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
-- 
2.24.0.525.g8f36a354ae-goog

