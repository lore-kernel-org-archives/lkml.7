Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067BEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE7920708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKVUEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:04:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:5075 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfKVUEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:04:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 12:04:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,231,1571727600"; 
   d="scan'208";a="210349828"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2019 12:04:51 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Open code shared_msr_update() in its only caller
Date:   Fri, 22 Nov 2019 12:04:50 -0800
Message-Id: <20191122200450.26239-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold shared_msr_update() into its sole user to eliminate its pointless
bounds check, its godawful printk, its misleading comment (it's called
under a global lock), and its woefully inaccurate name.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a256e09f321a..35b571c769bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -262,23 +262,6 @@ static void kvm_on_user_return(struct user_return_notifier *urn)
 	}
 }
 
-static void shared_msr_update(unsigned slot, u32 msr)
-{
-	u64 value;
-	unsigned int cpu = smp_processor_id();
-	struct kvm_shared_msrs *smsr = per_cpu_ptr(shared_msrs, cpu);
-
-	/* only read, and nobody should modify it at this time,
-	 * so don't need lock */
-	if (slot >= shared_msrs_global.nr) {
-		printk(KERN_ERR "kvm: invalid MSR slot!");
-		return;
-	}
-	rdmsrl_safe(msr, &value);
-	smsr->values[slot].host = value;
-	smsr->values[slot].curr = value;
-}
-
 void kvm_define_shared_msr(unsigned slot, u32 msr)
 {
 	BUG_ON(slot >= KVM_NR_SHARED_MSRS);
@@ -290,10 +273,16 @@ EXPORT_SYMBOL_GPL(kvm_define_shared_msr);
 
 static void kvm_shared_msr_cpu_online(void)
 {
-	unsigned i;
+	unsigned int cpu = smp_processor_id();
+	struct kvm_shared_msrs *smsr = per_cpu_ptr(shared_msrs, cpu);
+	u64 value;
+	int i;
 
-	for (i = 0; i < shared_msrs_global.nr; ++i)
-		shared_msr_update(i, shared_msrs_global.msrs[i]);
+	for (i = 0; i < shared_msrs_global.nr; ++i) {
+		rdmsrl_safe(shared_msrs_global.msrs[i], &value);
+		smsr->values[i].host = value;
+		smsr->values[i].curr = value;
+	}
 }
 
 int kvm_set_shared_msr(unsigned slot, u64 value, u64 mask)
-- 
2.24.0

