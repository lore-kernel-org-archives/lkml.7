Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B81AC04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D81A2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhmqGhRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfE1HvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:51:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37092 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfE1HvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:51:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so10974951pff.4;
        Tue, 28 May 2019 00:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/suq6wlpwcJ3ogbpvRkyctj8x187X3vDma99VWceU4=;
        b=fhmqGhRRa8i8a6S8GSmhVDciQYdTzBHI8j7g3gBIlXSDPxDSOedp/VUnDbrv9X+u+7
         p8hzNpoXUdMR6+uHxAoox+5EESk1C9OQYZ/A74lZKKG+o7TjFV48PkMx4Wyz2BP7V9i3
         oRACxdQUZNk4U1DoJN3Lh71P7S1BBzjMxz4BG4IlQu/yAytuwN0lrT8bmOwZKsc8NMHP
         QRNgJA4XF7lJmv9OFDQR/wzM6lnGZYuUAxLz2PONuQet6+MhrCYES7ZhRW0YGKfaur6X
         wWTwm2tk9Pb/vVrLPXrgHv7ZQqrWBEnus3rGKFPPEfG0A6CquNM+kWAyZzPK0MFXEg+h
         2fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/suq6wlpwcJ3ogbpvRkyctj8x187X3vDma99VWceU4=;
        b=XNF8T4vMZyL5u5ZOANV1dpHeOpM6o1xPOlM5QBrHU5ThKE68Z1eyPG4ThNnb7eOAs7
         ldjaKjOUgRIqQy2UF3lTTuQpzN8JACC/ZA8w0kzcyWIM1WHiiLxZKsa1ncHeo04SPjFF
         VN7H+tQ7XRMH9Ifr3hvVbpCesO7ecbacbXZHyKmw9YdquadV3up3lIGKF+l53JSl4Wj6
         D+juY/JppDaW4LYpjYLnCEkUpHxg1W5eTeB/1RD+uHyaEYNfLttG6hKus5uvWwHKHp8x
         aPfUJ+e5gteX8jVD/lZHwWaTlc1sWGS/oZizSvzXm+aMzxs1qjKOMp/yxFjM6cQH2YXp
         VYyQ==
X-Gm-Message-State: APjAAAWF85Eh2gNq+WBz+wLw1B3aPUrbgvySsUlnnVkqiuRh/jjYd9zL
        5GH7S7QqbJe5epIcakwr8cUdAsp/
X-Google-Smtp-Source: APXvYqx2orV7SyXM3bS035NmgSHft4vsSFCAjVZ8qQQO+Ml3q/pKYbpNhUBpHu6rRnhhYK8smX5obQ==
X-Received: by 2002:a63:dc09:: with SMTP id s9mr90719142pgg.425.1559029875282;
        Tue, 28 May 2019 00:51:15 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id q20sm18201400pgq.66.2019.05.28.00.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 00:51:14 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH RESEND v2 3/3] KVM: X86: Expose PV_SCHED_YIELD CPUID feature bit to guest
Date:   Tue, 28 May 2019 15:50:57 +0800
Message-Id: <1559029857-2750-4-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559029857-2750-1-git-send-email-wanpengli@tencent.com>
References: <1559004795-19927-3-git-send-email-wanpengli@tencent.com>
 <1559029857-2750-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Expose PV_SCHED_YIELD feature bit to guest, the guest can check this
feature bit before using paravirtualized sched yield.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/cpuid.txt | 4 ++++
 arch/x86/kvm/cpuid.c                | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
index 97ca194..1c39683 100644
--- a/Documentation/virtual/kvm/cpuid.txt
+++ b/Documentation/virtual/kvm/cpuid.txt
@@ -66,6 +66,10 @@ KVM_FEATURE_PV_SEND_IPI            ||    11 || guest checks this feature bit
                                    ||       || before using paravirtualized
                                    ||       || send IPIs.
 ------------------------------------------------------------------------------
+KVM_FEATURE_PV_SHED_YIELD          ||    12 || guest checks this feature bit
+                                   ||       || before using paravirtualized
+                                   ||       || sched yield.
+------------------------------------------------------------------------------
 KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
                                    ||       || per-cpu warps are expected in
                                    ||       || kvmclock.
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e18a9f9..c018fc8 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -643,7 +643,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			     (1 << KVM_FEATURE_PV_UNHALT) |
 			     (1 << KVM_FEATURE_PV_TLB_FLUSH) |
 			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT) |
-			     (1 << KVM_FEATURE_PV_SEND_IPI);
+			     (1 << KVM_FEATURE_PV_SEND_IPI) |
+			     (1 << KVM_FEATURE_PV_SCHED_YIELD);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
-- 
2.7.4

