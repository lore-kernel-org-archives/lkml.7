Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C1EC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE8120409
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577185883;
	bh=OxrNQ2gsibIn4jw7hR+CUTPYXhB9+uDPsB7VVD74JHQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ADyErR/iaqJec/u6+ce4ZFYUMD/O8onyiKeFtMUKdU4V8pCpcZGCOUsPWSQ5Zk1RP
	 3HhJ9lRil0He6vw3jyfpdRkBj1+DIoPmnOL3gQG0M0u8NS1d2t7j8GSxqTvc+LMoYf
	 +MfsXTPxjJtjpJoHI82K6A1hC+0Xzqfu0Ie3yFEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLXLLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:11:22 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:39644 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbfLXLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:11:15 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji5l-000169-Tz; Tue, 24 Dec 2019 12:11:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v3 00/32] irqchip/gic-v4: GICv4.1 architecture support
Date:   Tue, 24 Dec 2019 11:10:23 +0000
Message-Id: <20191224111055.11836-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[All I want for Christmas is... another monster GIC series!]

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
  (Linux definitely won't care).

On the other hand, public documentation is not available yet, so that's a
bit annoying...

The series is roughly organised in 5 parts:

(1) Feature detection, errata workaround for TX1
(2) VPE table allocation, new flavours of VMAPP/VMOVP commands
(3) v4.1 doorbell management
(4) Virtual SGI support
(5) Plumbing of virtual SGIs in KVM

Ideally, I'd like to start merging some of this into 5.6.

Notes:

  - This series has uncovered a behaviour that looks like a HW bug on
    the Cavium ThunderX (aka TX1) platform (see patch #3). I'd very
    much welcome some clarification from the Marvell/Cavium folks on
    Cc, as well as an official erratum number if this happens to be an
    actual bug.

    [v3 update]
    People have ignored for two months now, and it is fairly obvious
    that support for this machine is slowly bit-rotting. Maybe I'll
    drop the patch and instead start the process of removing all TX1
    support from the kernel (we'd certainly be better off without it).

* From v2 [2]:
  - Another bunch of fixes thanks to Zenghui Yu's very careful review
  - HW-accelerated SGIs are now optional thanks to new architected
    discovery/selection bits exposed by KVM and used by the guest kernel
  - Rebased on v5.5-rc2

* From v1 [1]:
  - A bunch of minor reworks after Zenghui Yu's review
  - A workaround for what looks like a new and unexpected TX1 bug
  - A subtle reorder of the series so that some patches can go in early

[1] https://lore.kernel.org/lkml/20190923182606.32100-1-maz@kernel.org/
[2] https://lore.kernel.org/lkml/20191027144234.8395-1-maz@kernel.org/

Marc Zyngier (32):
  irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
  irqchip/gic-v3: Add GICv4.1 VPEID size discovery
  irqchip/gic-v3: Workaround Cavium TX1 erratum when reading GICD_TYPER2
  irqchip/gic-v3: Use SGIs without active state if offered
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
  KVM: arm64: GICv4.1: Allow SGIs to switch between HW and SW interrupts
  KVM: arm64: GICv4.1: Plumb SGI implementation selection in the
    distributor
  KVM: arm64: GICv4.1: Reload VLPI configuration on distributor
    enable/disable
  KVM: arm64: GICv4.1: Expose HW-based SGIs in debugfs

 arch/arm/include/asm/arch_gicv3.h      |   2 +
 arch/arm64/include/asm/arch_gicv3.h    |   1 +
 arch/arm64/include/asm/kvm_host.h      |   1 +
 drivers/irqchip/irq-gic-v3-its.c       | 996 +++++++++++++++++++++++--
 drivers/irqchip/irq-gic-v3.c           |  57 +-
 drivers/irqchip/irq-gic-v4.c           | 134 +++-
 include/kvm/arm_vgic.h                 |   4 +
 include/linux/irqchip/arm-gic-common.h |   2 +
 include/linux/irqchip/arm-gic-v3.h     |  76 +-
 include/linux/irqchip/arm-gic-v4.h     |  43 +-
 virt/kvm/arm/arm.c                     |   8 +
 virt/kvm/arm/vgic/vgic-debug.c         |  14 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c       |  68 +-
 virt/kvm/arm/vgic/vgic-mmio.c          |  88 ++-
 virt/kvm/arm/vgic/vgic-v3.c            |   3 +
 virt/kvm/arm/vgic/vgic-v4.c            | 139 +++-
 virt/kvm/arm/vgic/vgic.h               |   1 +
 17 files changed, 1522 insertions(+), 115 deletions(-)

-- 
2.20.1

