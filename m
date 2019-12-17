Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFAFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5322921582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfLQVcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:32:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:17440 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbfLQVcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:32:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 13:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="227639455"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2019 13:32:42 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] KVM: x86: Expand build-time assertion on reverse CPUID usage
Date:   Tue, 17 Dec 2019 13:32:41 -0800
Message-Id: <20191217213242.11712-5-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217213242.11712-1-sean.j.christopherson@intel.com>
References: <20191217213242.11712-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add build-time checks to ensure KVM isn't trying to do a reverse CPUID
lookup on Linux-defined feature bits, along with comments to explain
the gory details of X86_FEATUREs and bit().

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.c |  3 ++-
 arch/x86/kvm/cpuid.h | 39 +++++++++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index cfafa320a8cf..a3b41e87e810 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -281,8 +281,9 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
 	return r;
 }
 
-static void cpuid_mask(u32 *word, int wordnum)
+static __always_inline void cpuid_mask(u32 *word, int wordnum)
 {
+	reverse_cpuid_check(wordnum);
 	*word &= boot_cpu_data.x86_capability[wordnum];
 }
 
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 8c77d829e27d..fc5a4cde260b 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -56,18 +56,41 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
 };
 
-static inline u32 bit(int bitno)
+/*
+ * Reverse CPUID and its derivatives can only be used for hardware-defined
+ * feature words, i.e. words whose bits directly correspond to a CPUID leaf.
+ * Retrieving a feature bit or masking guest CPUID from a Linux-defined word
+ * is nonsensical as the bit number/mask is an arbitrary software-defined value
+ * and can't be used by KVM to query/control guest capabilities.  And obviously
+ * the leaf being queried must have an entry in the lookup table.
+ */
+static __always_inline void reverse_cpuid_check(unsigned x86_leaf)
 {
-	return BIT(bitno & 31);
-}
-
-static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
-{
-	unsigned x86_leaf = x86_feature / 32;
-
+	BUILD_BUG_ON(x86_leaf == CPUID_LNX_1);
+	BUILD_BUG_ON(x86_leaf == CPUID_LNX_2);
+	BUILD_BUG_ON(x86_leaf == CPUID_LNX_3);
+	BUILD_BUG_ON(x86_leaf == CPUID_LNX_4);
 	BUILD_BUG_ON(x86_leaf >= ARRAY_SIZE(reverse_cpuid));
 	BUILD_BUG_ON(reverse_cpuid[x86_leaf].function == 0);
+}
 
+/*
+ * Retrieve the bit mask from an X86_FEATURE_* definition.  Features contain
+ * the hardware defined bit number (stored in bits 4:0) and a software defined
+ * "word" (stored in bits 31:5).  The word is used to index into arrays of
+ * bit masks that hold the per-cpu feature capabilities, e.g. this_cpu_has().
+ */
+static __always_inline u32 bit(int x86_feature)
+{
+	reverse_cpuid_check(x86_feature / 32);
+	return 1 << (x86_feature & 31);
+}
+
+static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
+{
+	unsigned x86_leaf = x86_feature / 32;
+
+	reverse_cpuid_check(x86_leaf);
 	return reverse_cpuid[x86_leaf];
 }
 
-- 
2.24.1

