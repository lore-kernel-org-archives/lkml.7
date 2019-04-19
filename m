Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B265FC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD8B214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfDSC21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:28:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:5539 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfDSC21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 22:28:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 19:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,368,1549958400"; 
   d="scan'208";a="137051741"
Received: from xy-skl-4s.sh.intel.com ([10.239.48.179])
  by orsmga006.jf.intel.com with ESMTP; 18 Apr 2019 19:28:24 -0700
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kvm: x86: refine kvm_get_arch_capabilities()
Date:   Fri, 19 Apr 2019 10:16:24 +0800
Message-Id: <20190419021624.186106-1-xiaoyao.li@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Using X86_FEATURE_ARCH_CAPABILITIES to enumerate the existence of
MSR_IA32_ARCH_CAPABILITIES to avoid using rdmsrl_safe().

2. Since kvm_get_arch_capabilities() is only used in this file, making
it static.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/x86.c              | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a9d03af34030..d4ae67870764 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1526,7 +1526,6 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 		    unsigned long ipi_bitmap_high, u32 min,
 		    unsigned long icr, int op_64_bit);
 
-u64 kvm_get_arch_capabilities(void);
 void kvm_define_shared_msr(unsigned index, u32 msr);
 int kvm_set_shared_msr(unsigned index, u64 val, u64 mask);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a0d1fc80ac5a..ba8e269a8cd2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1205,11 +1205,12 @@ static u32 msr_based_features[] = {
 
 static unsigned int num_msr_based_features;
 
-u64 kvm_get_arch_capabilities(void)
+static u64 kvm_get_arch_capabilities(void)
 {
-	u64 data;
+	u64 data = 0;
 
-	rdmsrl_safe(MSR_IA32_ARCH_CAPABILITIES, &data);
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, data);
 
 	/*
 	 * If we're doing cache flushes (either "always" or "cond")
@@ -1225,7 +1226,6 @@ u64 kvm_get_arch_capabilities(void)
 
 	return data;
 }
-EXPORT_SYMBOL_GPL(kvm_get_arch_capabilities);
 
 static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 {
-- 
2.19.1

