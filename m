Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C4FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A1E21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfLRV5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:57:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:56969 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbfLRVzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:55:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 13:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="222108144"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2019 13:55:46 -0800
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
Subject: [PATCH v2 32/45] KVM: Move initialization of preempt notifier to kvm_vcpu_init()
Date:   Wed, 18 Dec 2019 13:55:17 -0800
Message-Id: <20191218215530.2280-33-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218215530.2280-1-sean.j.christopherson@intel.com>
References: <20191218215530.2280-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the preempt notifier immediately in kvm_vcpu_init() to pave
the way for removing kvm_arch_vcpu_setup(), i.e. to allow arch specific
code to call vcpu_load() during kvm_arch_vcpu_create().

Back when preemption support was added, the location of the call to init
the preempt notifier was perfectly sane.  The overall vCPU creation flow
featured a single arch specific hook and the preempt notifer was used
immediately after its initialization (by vcpu_load()).  E.g.:

        vcpu = kvm_arch_ops->vcpu_create(kvm, n);
        if (IS_ERR(vcpu))
                return PTR_ERR(vcpu);

        preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);

        vcpu_load(vcpu);
        r = kvm_mmu_setup(vcpu);
        vcpu_put(vcpu);
        if (r < 0)
                goto free_vcpu;

Today, the call to preempt_notifier_init() is sandwiched between two
arch specific calls, kvm_arch_vcpu_create() and kvm_arch_vcpu_setup(),
which needlessly forces x86 (and possibly others?) to split its vCPU
creation flow.  Init the preempt notifier prior to any arch specific
call so that each arch can independently decide how best to organize
its creation flow.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 virt/kvm/kvm_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fd8168b8c0e4..876cf3dd2c97 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -348,6 +348,7 @@ static int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	kvm_vcpu_set_dy_eligible(vcpu, false);
 	vcpu->preempted = false;
 	vcpu->ready = false;
+	preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
 
 	r = kvm_arch_vcpu_init(vcpu);
 	if (r < 0)
@@ -2752,8 +2753,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	if (r)
 		goto vcpu_uninit;
 
-	preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
-
 	r = kvm_arch_vcpu_setup(vcpu);
 	if (r)
 		goto vcpu_destroy;
-- 
2.24.1

