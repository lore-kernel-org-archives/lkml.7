Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8309FC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C35A2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfDVGlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:41:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:59723 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfDVGlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:41:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Apr 2019 23:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,380,1549958400"; 
   d="scan'208";a="225545279"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2019 23:41:48 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org, like.xu@linux.intel.com
Subject: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
Date:   Mon, 22 Apr 2019 14:40:34 +0800
Message-Id: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose Intel V2 Extended Topology Enumeration Leaf to guest only when
host system has multiple software-visible die within each package.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index fd39516..9fc14f2 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -65,6 +65,16 @@ u64 kvm_supported_xcr0(void)
 	return xcr0;
 }
 
+/* We need to check if the host cpu has multi-chip packaging technology. */
+static bool kvm_supported_intel_mcp(void)
+{
+	u32 eax, ignored;
+
+	cpuid_count(0x1f, 0, &eax, &ignored, &ignored, &ignored);
+
+	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && (eax != 0);
+}
+
 #define F(x) bit(X86_FEATURE_##x)
 
 int kvm_update_cpuid(struct kvm_vcpu *vcpu)
@@ -426,6 +436,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 	switch (function) {
 	case 0:
 		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
+		entry->eax = kvm_supported_intel_mcp() ? 0x1f : entry->eax;
 		break;
 	case 1:
 		entry->edx &= kvm_cpuid_1_edx_x86_features;
@@ -544,6 +555,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		entry->edx = edx.full;
 		break;
 	}
+	/* function 0x1f has additional index. */
+	case 0x1f:
 	/* function 0xb has additional index. */
 	case 0xb: {
 		int i, level_type;
-- 
1.8.3.1

