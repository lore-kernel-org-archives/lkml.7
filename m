Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F964C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFCE227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLRV6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:58:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:56969 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfLRVzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:55:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 13:55:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="222108135"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2019 13:55:45 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 29/45] KVM: Introduce kvm_vcpu_destroy()
Date:   Wed, 18 Dec 2019 13:55:14 -0800
Message-Id: <20191218215530.2280-30-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218215530.2280-1-sean.j.christopherson@intel.com>
References: <20191218215530.2280-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kvm_vcpu_destroy() and wire up all architectures to call the common
function instead of their arch specific implementation.  The common
destruction function will be used by future patches to move allocation
and initialization of vCPUs to common KVM code, i.e. to free resources
that are allocated by arch agnostic code.

No functional change intended.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/mips/kvm/mips.c       | 2 +-
 arch/powerpc/kvm/powerpc.c | 2 +-
 arch/s390/kvm/kvm-s390.c   | 2 +-
 arch/x86/kvm/x86.c         | 2 +-
 include/linux/kvm_host.h   | 1 +
 virt/kvm/arm/arm.c         | 2 +-
 virt/kvm/kvm_main.c        | 6 ++++++
 7 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 73360e021259..8546bc6e09e7 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -156,7 +156,7 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		kvm_arch_vcpu_destroy(vcpu);
+		kvm_vcpu_destroy(vcpu);
 	}
 
 	mutex_lock(&kvm->lock);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 998ef60ac463..e3e2b88d3d8b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -475,7 +475,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 #endif
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_arch_vcpu_destroy(vcpu);
+		kvm_vcpu_destroy(vcpu);
 
 	mutex_lock(&kvm->lock);
 	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1f8ba074cbd6..8543d338a06a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2541,7 +2541,7 @@ static void kvm_free_vcpus(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_arch_vcpu_destroy(vcpu);
+		kvm_vcpu_destroy(vcpu);
 
 	mutex_lock(&kvm->lock);
 	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f21169515910..c808329290e1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9590,7 +9590,7 @@ static void kvm_free_vcpus(struct kvm *kvm)
 		kvm_unload_vcpu_mmu(vcpu);
 	}
 	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_arch_vcpu_destroy(vcpu);
+		kvm_vcpu_destroy(vcpu);
 
 	mutex_lock(&kvm->lock);
 	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7c57f1a5d7b3..9e3371f9a4cd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -581,6 +581,7 @@ static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 
 int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id);
 void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
+void kvm_vcpu_destroy(struct kvm_vcpu *vcpu);
 
 void vcpu_load(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 3cdd1c3be2c7..f569cbb2f123 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -194,7 +194,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		if (kvm->vcpus[i]) {
-			kvm_arch_vcpu_destroy(kvm->vcpus[i]);
+			kvm_vcpu_destroy(kvm->vcpus[i]);
 			kvm->vcpus[i] = NULL;
 		}
 	}
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 281da692c774..c2766a1108b9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -375,6 +375,12 @@ void kvm_vcpu_uninit(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_uninit);
 
+void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+	kvm_arch_vcpu_destroy(vcpu);
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_destroy);
+
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
 {
-- 
2.24.1

