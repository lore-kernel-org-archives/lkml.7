Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D7CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674EA243D7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsTTioVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfE3BF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:05:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46849 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfE3BF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:05:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so2761181pfm.13;
        Wed, 29 May 2019 18:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Z5Idi/CPSKFvBQKuXpbeCGvfVzaiO/7Q4QPnwgN73w=;
        b=MsTTioVd0Q4UgE8TapYzvgKyK0YFqeLTqVZMeGpF0faA4drW/imNuPVPl88UU70BDd
         Vp0DiHzYxbVftjqJ9I3URqWMEI6pNtXLUFMJxUj+f5e/0Vkc+K+9650LzpkmAo7ZRNvG
         anoAwr9zoV6KEvhL1KCvcz3swsRUSK7EYmVV9VgH/kvbxZQBvDo5xF6HSK5nFL0ZYJwz
         56sGJxWFGw83vCS1iC5hn0KlZP4VT6+/YW3w973NjQO4poAJoZ2/ngMb9lJgcuh0brPq
         CZpXEz4DyxOvfJ7X8FjSB8K1nw5FLAbvoKOXa4h0klV7kTo8zDcO/oyuwVUwp6889QJh
         SHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Z5Idi/CPSKFvBQKuXpbeCGvfVzaiO/7Q4QPnwgN73w=;
        b=ffuvhQKqkMmp6NzgFAxTZyv3nwcpxBAbYMqmUWg66gOnHc3XWr7om2xpSR/pluqnqe
         MP1u2ov8APf/gc1vvVSiDIN5OpF0ZMQRMUiDKj77I2Zbf0azyllxEwwF4KCZO7FRBBv5
         95sCOrQRPlg+yrzYWQVW0cvdWaLFAwOBIRnvpxPR1cLlR1D1vN+PpBSnMtWuXWNu3Hxk
         wRhWfiZdt7Fd8za1qwhSXWhR9klRjrlF6iCM2VbzIVABFF7hjzy23iL65mWggo6GhIA4
         E9U2H7TkfZYVkxOrrDIGUpk8yLwW0Qdxm22jnDvKqPWIwTuWa+UltcQDphH3OuXMRkUk
         OOBg==
X-Gm-Message-State: APjAAAXsZisypqHeFZICy3qC11WWdQq0IJwBN+RLs5Es/2veS75/jOle
        lOgm+KNz50G5zMeAquRmuKA9Rhy2
X-Google-Smtp-Source: APXvYqwk6+JJYGYvr0hdpknvKOIwvBZmtpTrd/Ht+n3ygGFXlv4pYsSVn6lxop4vpnreCEsv7C9VRA==
X-Received: by 2002:a63:fa16:: with SMTP id y22mr1000163pgh.15.1559178325168;
        Wed, 29 May 2019 18:05:25 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id c76sm861965pfc.43.2019.05.29.18.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 18:05:24 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v3 3/3] KVM: X86: Expose PV_SCHED_YIELD CPUID feature bit to guest
Date:   Thu, 30 May 2019 09:05:07 +0800
Message-Id: <1559178307-6835-4-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559178307-6835-1-git-send-email-wanpengli@tencent.com>
References: <1559178307-6835-1-git-send-email-wanpengli@tencent.com>
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
Cc: Liran Alon <liran.alon@oracle.com>
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

