Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F368C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2212190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbfKEQRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:17:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389843AbfKEQRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:17:43 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8DF9C0568FD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 16:17:42 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f11so2814942wmc.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 08:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bl1aLROn7TtgvMqB5D32TvDdvphYW0zF7b8CCLtoaP0=;
        b=OqJtivHeq2RPEBPQpd7Zv5XFAA6oxNlw8JPSK6hstc1z+RMZ2Ikuj3EB5gdGqi2Thk
         94TYzJVtQ2M6KEDpNPE28g3wHOnD6PbiMSzte9AxH41fLMkYaStu3kNu85BP0Tp5eNZM
         0HVxPmWAI+oXAYzNO7pIUgNBtP+kREgY6PFhKyUif03f8ZkTRn02YC2EqD5WVqqkq/uw
         E55/4tljbyOEJi6NwwXIN43FNZ1ZSjpOBWFnH2/MVv0MTchr6DWo8dQraar3EGd0i0Xx
         PlCfECigl65XFOqYNT/yl1r0jxbsQxMES4w7KNC3hn73sbB8TMIkHK4V2AziJjth16wI
         mKQQ==
X-Gm-Message-State: APjAAAVjtLgynWsAvMBDvNmoJwIF/N38gJekWFt518LjbaZQVan7BtGO
        Iy64si53tKOsTzwGsy0w4erDGv6dyCCxFrm0dpHDkabLEWc48chYD2NXrloX37QZDzGWzvrPv0b
        biC69KoICSe2Fk1krUPuPI6/l
X-Received: by 2002:a5d:5284:: with SMTP id c4mr11058198wrv.376.1572970661247;
        Tue, 05 Nov 2019 08:17:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNKHp7hctL2Eiz7XQJJw1P0Hq4TMFa85ILfamcF3qBzHreXyW4j2okrurW+bkcNpSiMgZORQ==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr11058116wrv.376.1572970660030;
        Tue, 05 Nov 2019 08:17:40 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e27sm1569410wra.21.2019.11.05.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 08:17:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH RFC] KVM: x86: tell guests if the exposed SMT topology is trustworthy
Date:   Tue,  5 Nov 2019 17:17:37 +0100
Message-Id: <20191105161737.21395-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtualized guests may pick a different strategy to mitigate hardware
vulnerabilities when it comes to hyper-threading: disable SMT completely,
use core scheduling, or, for example, opt in for STIBP. Making the
decision, however, requires an extra bit of information which is currently
missing: does the topology the guest see match hardware or if it is 'fake'
and two vCPUs which look like different cores from guest's perspective can
actually be scheduled on the same physical core. Disabling SMT or doing
core scheduling only makes sense when the topology is trustworthy.

Add two feature bits to KVM: KVM_FEATURE_TRUSTWORTHY_SMT with the meaning
that KVM_HINTS_TRUSTWORTHY_SMT bit answers the question if the exposed SMT
topology is actually trustworthy. It would, of course, be possible to get
away with a single bit (e.g. 'KVM_FEATURE_FAKE_SMT') and not lose backwards
compatibility but the current approach looks more straightforward.

There were some offline discussions on whether this new feature bit should
be complemented with a 're-enlightenment' mechanism for live migration (so
it can change in guest's lifetime) but it doesn't seem to be very
practical: what a sane guest is supposed to do if it's told that SMT
topology is about to become fake other than kill itself? Also, it seems to
make little sense to do e.g. CPU pinning on the source but not on the
destination.

There is also one additional piece of the information missing. A VM can be
sharing physical cores with other VMs (or other userspace tasks on the
host) so does KVM_FEATURE_TRUSTWORTHY_SMT imply that it's not the case or
not? It is unclear if this changes anything and can probably be left out
of scope (just don't do that).

Similar to the already existent 'NoNonArchitecturalCoreSharing' Hyper-V
enlightenment, the default value of KVM_HINTS_TRUSTWORTHY_SMT is set to
!cpu_smt_possible(). KVM userspace is thus supposed to pass it to guest's
CPUIDs in case it is '1' (meaning no SMT on the host at all) or do some
extra work (like CPU pinning and exposing the correct topology) before
passing '1' to the guest.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 Documentation/virt/kvm/cpuid.rst     | 27 +++++++++++++++++++--------
 arch/x86/include/uapi/asm/kvm_para.h |  2 ++
 arch/x86/kvm/cpuid.c                 |  7 ++++++-
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/cpuid.rst b/Documentation/virt/kvm/cpuid.rst
index 01b081f6e7ea..64b94103fc90 100644
--- a/Documentation/virt/kvm/cpuid.rst
+++ b/Documentation/virt/kvm/cpuid.rst
@@ -86,6 +86,10 @@ KVM_FEATURE_PV_SCHED_YIELD        13          guest checks this feature bit
                                               before using paravirtualized
                                               sched yield.
 
+KVM_FEATURE_TRUSTWORTHY_SMT       14          set when host supports 'SMT
+                                              topology is trustworthy' hint
+                                              (KVM_HINTS_TRUSTWORTHY_SMT).
+
 KVM_FEATURE_CLOCSOURCE_STABLE_BIT 24          host will warn if no guest-side
                                               per-cpu warps are expeced in
                                               kvmclock
@@ -97,11 +101,18 @@ KVM_FEATURE_CLOCSOURCE_STABLE_BIT 24          host will warn if no guest-side
 
 Where ``flag`` here is defined as below:
 
-================== ============ =================================
-flag               value        meaning
-================== ============ =================================
-KVM_HINTS_REALTIME 0            guest checks this feature bit to
-                                determine that vCPUs are never
-                                preempted for an unlimited time
-                                allowing optimizations
-================== ============ =================================
+================================= =========== =================================
+flag                              value       meaning
+================================= =========== =================================
+KVM_HINTS_REALTIME                0           guest checks this feature bit to
+                                              determine that vCPUs are never
+                                              preempted for an unlimited time
+                                              allowing optimizations
+
+KVM_HINTS_TRUSTWORTHY_SMT         1           the bit is set when the exposed
+                                              SMT topology is trustworthy, this
+                                              means that two guest vCPUs will
+                                              never share a physical core
+                                              unless they are exposed as SMT
+                                              threads.
+================================= =========== =================================
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 2a8e0b6b9805..183239d5dfad 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -31,8 +31,10 @@
 #define KVM_FEATURE_PV_SEND_IPI	11
 #define KVM_FEATURE_POLL_CONTROL	12
 #define KVM_FEATURE_PV_SCHED_YIELD	13
+#define KVM_FEATURE_TRUSTWORTHY_SMT	14
 
 #define KVM_HINTS_REALTIME      0
+#define KVM_HINTS_TRUSTWORTHY_SMT	1
 
 /* The last 8 bits are used to indicate how to interpret the flags field
  * in pvclock structure. If no bits are set, all flags are ignored.
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f68c0c753c38..dab527a7081f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -712,7 +712,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT) |
 			     (1 << KVM_FEATURE_PV_SEND_IPI) |
 			     (1 << KVM_FEATURE_POLL_CONTROL) |
-			     (1 << KVM_FEATURE_PV_SCHED_YIELD);
+			     (1 << KVM_FEATURE_PV_SCHED_YIELD) |
+			     (1 << KVM_FEATURE_TRUSTWORTHY_SMT);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
@@ -720,6 +721,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 		entry->ebx = 0;
 		entry->ecx = 0;
 		entry->edx = 0;
+
+		if (!cpu_smt_possible())
+			entry->edx |= (1 << KVM_HINTS_TRUSTWORTHY_SMT);
+
 		break;
 	case 0x80000000:
 		entry->eax = min(entry->eax, 0x8000001f);
-- 
2.20.1

