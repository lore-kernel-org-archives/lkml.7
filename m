Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE61C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430502075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfDDMbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:31:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726790AbfDDMbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:31:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 269E9F4AF30746A93AA2;
        Thu,  4 Apr 2019 20:31:04 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 20:30:53 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <marc.zyngier@arm.com>, <christoffer.dall@arm.com>
CC:     <eric.auger@redhat.com>, <andre.przywara@arm.com>,
        <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>,
        <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm/arm64: vgic: Restrict setting irq->targets only in GICv2
Date:   Thu, 4 Apr 2019 12:30:15 +0000
Message-ID: <1554381015-13056-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ad275b8bb1e6 ("KVM: arm/arm64: vgic-new: vgic_init: implement
vgic_init") had set irq->targets in kvm_vgic_vcpu_init(), regardless of
the GIC architecture (v2 or v3). When the number of vcpu reaches 32
(in v3), UBSAN will complain about it.

 ================================================================================
 UBSAN: Undefined behaviour in arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-init.c:223:21
 shift exponent 32 is too large for 32-bit type 'unsigned int'
 CPU: 13 PID: 833 Comm: CPU 32/KVM Kdump: loaded Not tainted 5.1.0-rc1+ #16
 Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.58 10/24/2018
 Call trace:
  dump_backtrace+0x0/0x190
  show_stack+0x24/0x30
  dump_stack+0xc8/0x114
  ubsan_epilogue+0x14/0x50
  __ubsan_handle_shift_out_of_bounds+0x118/0x188
  kvm_vgic_vcpu_init+0x1d4/0x200
  kvm_arch_vcpu_init+0x3c/0x48
  kvm_vcpu_init+0xa8/0x100
  kvm_arch_vcpu_create+0x94/0x120
  kvm_vm_ioctl+0x57c/0xe58
  do_vfs_ioctl+0xc4/0x7f0
  ksys_ioctl+0x8c/0xa0
  __arm64_sys_ioctl+0x28/0x38
  el0_svc_common+0xa0/0x190
  el0_svc_handler+0x38/0x78
  el0_svc+0x8/0xc
 ================================================================================

This patch Restricts setting irq->targets in GICv2, which only supports
a maximum of eight PEs, to keep UBSAN quiet. And since irq->mpidr will
only be used by SPI in GICv3, we decided to set mpidr to 0 for SGI and
PPI.

Like commit ab2d5eb03dbb ("KVM: arm/arm64: vgic: Always initialize the
group of private IRQs"), we should also take the creating order of the
VGIC and VCPUs into consideration.

Cc: Eric Auger <eric.auger@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/vgic/vgic-init.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 3bdb31e..0cba92e 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -220,7 +220,6 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 		irq->intid = i;
 		irq->vcpu = NULL;
 		irq->target_vcpu = vcpu;
-		irq->targets = 1U << vcpu->vcpu_id;
 		kref_init(&irq->refcount);
 		if (vgic_irq_is_sgi(i)) {
 			/* SGIs */
@@ -231,10 +230,14 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 			irq->config = VGIC_CONFIG_LEVEL;
 		}
 
-		if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+		if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
 			irq->group = 1;
-		else
+			irq->mpidr = 0;
+		} else {
 			irq->group = 0;
+			if (vcpu->vcpu_id < VGIC_V2_MAX_CPUS)
+				irq->targets = 1U << vcpu->vcpu_id;
+		}
 	}
 
 	if (!irqchip_in_kernel(vcpu->kvm))
@@ -297,10 +300,13 @@ int vgic_init(struct kvm *kvm)
 
 		for (i = 0; i < VGIC_NR_PRIVATE_IRQS; i++) {
 			struct vgic_irq *irq = &vgic_cpu->private_irqs[i];
-			if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+			if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
 				irq->group = 1;
-			else
+				irq->mpidr = 0;
+			} else {
 				irq->group = 0;
+				irq->targets = 1U << vcpu->vcpu_id;
+			}
 		}
 	}
 
-- 
1.8.3.1


