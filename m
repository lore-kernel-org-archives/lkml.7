Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC69C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB6320873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfEOPbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:31:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727528AbfEOPbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:31:10 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09D863D7F10CCB1EF08C;
        Wed, 15 May 2019 23:31:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 May 2019
 23:30:54 +0800
Subject: Re: Does it make sense to flush ap_list of offlined vcpu?
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <73927ccf-1582-2e91-051b-b22854df3290@huawei.com>
 <86mujucftn.wl-marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <01dda493-29d9-34e3-d35a-4ea3de1e1618@huawei.com>
Date:   Wed, 15 May 2019 23:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <86mujucftn.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Our situation is for guest system crash and kdump feature. The detailed steps are as below:

1. Guest system crash.
2. One of VCPU is chosen as primary VCPU.
3. The primary VCPU sends IPIs to other VCPUs (by crash_smp_send_stop), to request them to offline.
4. The other VCPUs receiving the IPI will run ipi_cpu_crash_stop(), and finally call psci CPU_OFF interface.
5. The primary VCPU will restart the kernel from the beginning, re-initializing GIC, ITS, and some devices.
5.1. ITS device table baser will be written and in KVM all devices will be freed by vgic_its_free_device_list().
5.2. Guest OS re-maps the device and event ID, and KVM adds LPI irq by vgic_add_lpi().

Since the system is in emergency mode, it does try to move IRQs from other VCPUs to the primary VCPU.

The issue happens if qemu still tries to inject MSI irq to offlined VCPU; it will increase the ref_count of the irq, so the irq will not be really freed in vgic_its_free_device_list()->vgic_put_irq(). Then in vgic_add_lpi(), it will still find the old irq with the same LPI number and try to reuse it. But the old irq is targeted to the offlined VCPU, so it will never get a chance to be processed, and finally the kdump process hangs.

This issue can reproduced by below commands in guest OS with kdump support (like centos), in a VM with a virtio SCSI disk:

dd if=/dev/zero of=/home/tmp bs=512 count=2000000 oflag=direct &
sleep 10
taskset -c 1 echo c > /proc/sysrq-trigger

We wrote a rough patch as below to fix this issue. Please advise.
Thanks,
Heyi

---
  virt/kvm/arm/psci.c      | 2 ++
  virt/kvm/arm/vgic/vgic.c | 9 ++++++++-
  2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index 34d08ee..ab908e5 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -26,6 +26,7 @@
  #include <asm/kvm_host.h>

  #include <kvm/arm_psci.h>
+#include "vgic.h"

  /*
   * This is an implementation of the Power State Coordination Interface
@@ -99,6 +100,7 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
  {
      vcpu->arch.power_off = true;
      kvm_make_request(KVM_REQ_SLEEP, vcpu);
+    vgic_flush_pending_lpis(vcpu);
      kvm_vcpu_kick(vcpu);
  }

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 7115acf..645c96a 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -157,10 +157,13 @@ void vgic_flush_pending_lpis(struct kvm_vcpu *vcpu)
      struct vgic_irq *irq, *tmp;
      unsigned long flags;

+    pr_debug("Start to flush irqs for vcpu %d\n", vcpu->vcpu_id);
+
      spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);

      list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
          if (irq->intid >= VGIC_MIN_LPI) {
+            pr_debug("flush irq %d\n", irq->intid);
              spin_lock(&irq->irq_lock);
              list_del(&irq->ap_list);
              irq->vcpu = NULL;
@@ -336,7 +339,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,

  retry:
      vcpu = vgic_target_oracle(irq);
-    if (irq->vcpu || !vcpu) {
+    if (irq->vcpu || !vcpu || unlikely(vcpu->arch.power_off)) {
          /*
           * If this IRQ is already on a VCPU's ap_list, then it
           * cannot be moved or modified and there is no more work for
@@ -348,6 +351,10 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
           */
          spin_unlock_irqrestore(&irq->irq_lock, flags);

+        if (unlikely(vcpu && vcpu->arch.power_off))
+            pr_debug("Attempt to inject irq %d to offlined VCPU %d",
+                 irq->intid, vcpu->vcpu_id);
+
          /*
           * We have to kick the VCPU here, because we could be
           * queueing an edge-triggered interrupt for which we
-- 
1.8.3.1



On 2019/5/11 2:41, Marc Zyngier wrote:
> On Thu, 09 May 2019 16:26:04 +0100,
> Heyi Guo <guoheyi@huawei.com> wrote:
>> Hi folks,
>>
>> When guest OS calls PSCI CPU_OFF, the corresponding VCPU will be put
>> in sleep state. But if there is still IRQ remaining in this VCPU's
>> ap_list, this will block all the following triggers of this IRQ even
>> to other VCPUs. Does it make sense to flush the ap_list of the VCPU
>> when it is requested to be offlined? Or did I miss something?
> I can't see a good reason to do so: If a vcpu gets offlined, the guest
> OS has to move interrupt routed to that vcpu to another one. There is
> nothing in the GIC architecture that the interrupt will be moved to
> another vcpu (well, it could be done with 1:N, which is not really
> virtualizable, and not advertised by KVM). That's not different from
> what would happen on bare metal.
>
> Thanks,
>
> 	M.
>


