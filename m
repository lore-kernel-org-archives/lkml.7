Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B132C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5788B2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfIPQXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:23:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbfIPQXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:23:08 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 210F82A09BB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:23:07 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j2so129064wre.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 09:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTif/hdyQ2dgFmG83XOhs3M15HFTZ4c2i4bvJhs3seA=;
        b=lnkkeHPRsrPmzPkXr73riZ0QuweubFFMFsyc9mORw/8uH5Q6HDnNKD197TRgVdS/XR
         X213byutpLQMw1LW3IZsajWIjRT183U3iZB6y10exIMApyYmrpId7CDTPTs7bwDyJd9j
         3Afv6uJgYm8rp4mEJDTPhYPo5shw5w2rZMX1czQB6ihTha72xuQYCA1h+DVIwXEfe8nJ
         eGPktW6EkJ+01AgoEyuYOFJZtNaf2TKaA5SqgvkeMuZR6Ld2pkeC5D5cQ/dIl7ywN5Lz
         KQI/ve+81Ul0BfEQoa+R1JWnD3yBc3EUCkJI8iLOibnCdI07WghBPdR1zsfHs7/WdUmq
         sTMA==
X-Gm-Message-State: APjAAAUNVHoOKfKrOrqGrQsQ9ctz6W60CGYN0oJjhHntcxh/C3ntq/Qk
        aH2+tzyReJe2MyIoW1vji+Nyb+sGGzyRU+LzHIHPyo6iaAZLc6aCxj2EdXfSqCqW7GCAYCwmjVO
        navbvsTpOq9rC2PpIsdueUOX5
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr20519wmj.5.1568650985771;
        Mon, 16 Sep 2019 09:23:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJ2BsBwbNvJMLRpYPdToi80JcADK8zG0+oHLr+0eXOrKGkWIoV4bSie2tXYamBJOS5FHSDNw==
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr20494wmj.5.1568650985442;
        Mon, 16 Sep 2019 09:23:05 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q10sm78370575wrd.39.2019.09.16.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 09:23:04 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 2/3] KVM: x86: hyper-v: set NoNonArchitecturalCoreSharing CPUID bit when SMT is impossible
Date:   Mon, 16 Sep 2019 18:22:57 +0200
Message-Id: <20190916162258.6528-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916162258.6528-1-vkuznets@redhat.com>
References: <20190916162258.6528-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V 2019 doesn't expose MD_CLEAR CPUID bit to guests when it cannot
guarantee that two virtual processors won't end up running on sibling SMT
threads without knowing about it. This is done as an optimization as in
this case there is nothing the guest can do to protect itself against MDS
and issuing additional flush requests is just pointless. On bare metal the
topology is known, however, when Hyper-V is running nested (e.g. on top of
KVM) it needs an additional piece of information: a confirmation that the
exposed topology (wrt vCPU placement on different SMT threads) is
trustworthy.

NoNonArchitecturalCoreSharing (CPUID 0x40000004 EAX bit 18) is described in
TLFS as follows: "Indicates that a virtual processor will never share a
physical core with another virtual processor, except for virtual processors
that are reported as sibling SMT threads." From KVM we can give such
guarantee in two cases:
- SMT is unsupported or forcefully disabled (just 'disabled' doesn't work
 as it can become re-enabled during the lifetime of the guest).
- vCPUs are properly pinned so the scheduler won't put them on sibling
SMT threads (when they're not reported as such).

This patch reports NoNonArchitecturalCoreSharing bit in to userspace in the
first case. The second case is outside of KVM's domain of responsibility
(as vCPU pinning is actually done by someone who manages KVM's userspace -
e.g. libvirt pinning QEMU threads).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 7 +++++++
 arch/x86/kvm/hyperv.c              | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index af78cd72b8f3..989a1efe7f5e 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -170,6 +170,13 @@
 /* Recommend using enlightened VMCS */
 #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
 
+/*
+ * Virtual processor will never share a physical core with another virtual
+ * processor, except for virtual processors that are reported as sibling SMT
+ * threads.
+ */
+#define HV_X64_NO_NONARCH_CORESHARING                  BIT(18)
+
 /* Nested features. These are HYPERV_CPUID_NESTED_FEATURES.EAX bits. */
 #define HV_X64_NESTED_GUEST_MAPPING_FLUSH		BIT(18)
 #define HV_X64_NESTED_MSR_BITMAP			BIT(19)
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fff790a3f4ee..9c187d16a9cd 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -23,6 +23,7 @@
 #include "ioapic.h"
 #include "hyperv.h"
 
+#include <linux/cpu.h>
 #include <linux/kvm_host.h>
 #include <linux/highmem.h>
 #include <linux/sched/cputime.h>
@@ -1864,7 +1865,8 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
 			if (evmcs_ver)
 				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
-
+			if (!cpu_smt_possible())
+				ent->eax |= HV_X64_NO_NONARCH_CORESHARING;
 			/*
 			 * Default number of spinlock retry attempts, matches
 			 * HyperV 2016.
-- 
2.20.1

