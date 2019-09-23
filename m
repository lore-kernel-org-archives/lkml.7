Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE40C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E898B20665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263190;
	bh=PYQSpfP3R9Qt4GNq67LYTzixIBSTBWF8HlFGWKRu6ZE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FajMXTchezhl0t4duTKSfSNp70sNIkJ/e2v9Vd3vlDchhK7Mo6jZmBLIuB72AseI1
	 xKyJ/K21bz5LP3BD68EkMDYZw9eCIFUhCqIkR0w4eRvAhnsn5GEFhQgAtKEyI/4UST
	 ibZRQ1EihOgLMqri8jN6zqnJbmzAepzsGwazxFWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438242AbfIWS03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:26:29 -0400
Received: from foss.arm.com ([217.140.110.172]:46600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731405AbfIWS02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:26:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED436142F;
        Mon, 23 Sep 2019 11:26:27 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEC353F694;
        Mon, 23 Sep 2019 11:26:24 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH 00/35] irqchip/gic-v4: GICv4.1 architecture support
Date:   Mon, 23 Sep 2019 19:25:31 +0100
Message-Id: <20190923182606.32100-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Apologies for posting this during the merge window, I'm fighting against
 another deadline which is incompatible with the -rc1 time frame]

This rather long series expands the existing GICv4 support to deal with the
new GICv4.1 architecture, which comes with a set of major improvements
compared to v4.0:

- One architectural doorbell per vcpu, instead of one doorbell per VLPI

- Doorbell entirely managed by the HW, with an "at most once" delivery
  guarantee per non-residency phase and only when requested by the
  hypervisor

- A shared memory scheme between ITSs and redistributors, allowing for an
  optimised residency sequence (the use of VMOVP becomes less frequent)

- Support for direct virtual SGI delivery (the injection path still involves
  the hypervisor), at the cost of losing the active state on SGIs. It
  shouldn't be a big deal, but some guest operating systems might notice
  (Linux definitely won't care)

On the other hand, public documentation is not available yet, so that's a
bit annoying..

The series is roughly organised in 5 parts:

(1) A bunch of reworks to make the checking of some features more
    straightforward,
(2) VPE table allocation, new flavours of VMAPP/VMOVP commands
(3) v4.1 doorbell management
(4) Virtual SGI support
(5) Plumbing of virtual SGIs in KVM

Note that patch #1 has been previously posted, and forms the base of this
work. This has had *very little* testing on a fairly early model, and some
behaviours are unexpected (the VSGI feature clearly misbehaves). But it is
in a shape that should make it possible to review and even debug. Consider
this an opportunity to influence the shape of this code at an early stage!
;-)


Marc Zyngier (35):
  KVM: arm64: vgic-v4: Move the GICv4 residency flow to be driven by
    vcpu_load/put
  irqchip/gic-v3-its: Factor out wait_for_syncr primitive
  irqchip/gic-v3-its: Allow LPI invalidation via the DirectLPI interface
  irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
  irqchip/gic-v3: Add GICv4.1 VPEID size discovery
  irqchip/gic-v3-its: Make is_v4 use a TYPER copy
  irqchip/gic-v3-its: Kill its->ite_size and use TYPER copy instead
  irqchip/gic-v3-its: Kill its->device_ids and use TYPER copy instead
  irqchip/gic-v3-its: Add get_vlpi_map() helper
  irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER) allocation
  irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP
  irqchip/gic-v4.1: Don't use the VPE proxy if RVPEID is set
  irqchip/gic-v4.1: Implement the v4.1 flavour of VMOVP
  irqchip/gic-v4.1: Plumb skeletal VPE irqchip
  irqchip/gic-v4.1: Add mask/unmask doorbell callbacks
  irqchip/gic-v4.1: Add VPE residency callback
  irqchip/gic-v4.1: Add VPE eviction callback
  irqchip/gic-v4.1: Add VPE INVALL callback
  irqchip/gic-v4.1: Suppress per-VLPI doorbell
  irqchip/gic-v4.1: Allow direct invalidation of VLPIs
  irqchip/gic-v4.1: Advertise support v4.1 to KVM
  irqchip/gic-v4.1: Map the ITS SGIR register page
  irqchip/gic-v4.1: Plumb skeletal VSGI irqchip
  irqchip/gic-v4.1: Add initial SGI configuration
  irqchip/gic-v4.1: Plumb mask/unmask SGI callbacks
  irqchip/gic-v4.1: Plumb get/set_irqchip_state SGI callbacks
  irqchip/gic-v4.1: Plumb set_vcpu_affinity SGI callbacks
  irqchip/gic-v4.1: Move doorbell management to the GICv4 abstraction
    layer
  irqchip/gic-v4.1: Add VSGI allocation/teardown
  irqchip/gic-v4.1: Add VSGI property setup
  irqchip/gic-v4.1: Eagerly vmap vPEs
  KVM: arm64: GICv4.1: Let doorbells be auto-enabled
  KVM: arm64: GICv4.1: Add direct injection capability to SGI registers
  KVM: arm64: GICv4.1: Configure SGIs as HW interrupts
  KVM: arm64: GICv4.1: Expose HW-based SGIs in debugfs

 arch/arm/include/asm/arch_gicv3.h      |    2 +
 arch/arm64/include/asm/arch_gicv3.h    |    1 +
 drivers/irqchip/irq-gic-v3-its.c       | 1099 +++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3.c           |   25 +-
 drivers/irqchip/irq-gic-v4.c           |  143 ++-
 include/kvm/arm_vgic.h                 |    5 +-
 include/linux/irqchip/arm-gic-common.h |    2 +
 include/linux/irqchip/arm-gic-v3.h     |   75 +-
 include/linux/irqchip/arm-gic-v4.h     |   45 +-
 virt/kvm/arm/arm.c                     |   12 +-
 virt/kvm/arm/vgic/vgic-debug.c         |   14 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c       |   15 +-
 virt/kvm/arm/vgic/vgic-mmio.c          |   88 +-
 virt/kvm/arm/vgic/vgic-v3.c            |    5 +
 virt/kvm/arm/vgic/vgic-v4.c            |  106 ++-
 virt/kvm/arm/vgic/vgic.c               |    4 -
 virt/kvm/arm/vgic/vgic.h               |    2 -
 17 files changed, 1466 insertions(+), 177 deletions(-)

-- 
2.20.1

