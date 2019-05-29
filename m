Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0B2C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAF6241F6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dz4k9tCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfE2VQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:16:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29169 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2VQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559164598; x=1590700598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=amOjgDh6kVgGSeqvAP+D7/HG3VWV3i7Or4bw+vBidq8=;
  b=dz4k9tCCghnwphSTHGl7MRnR5Fwis1ShaUBBFdDuT4EoJpt8T06MFf3Q
   VmME81Phlj+uv7M8dTpz1nUu0e4/c4dRcjg8A8k/KehP2lWMIN1rdpOgU
   czyBiYaUfRENK8NuxesuIoqB/9W7YXIvZFsrV4MZ64wub/2QOcJcu4YWY
   bhrVQDT7Gt6BQywe4jie+O2lbiuz962foCy1NlmUcy2024JUFiCIfSdPc
   0WaMTrvOwQg590sd5hppPsU6QIvLUiVVntLe2lh40EQ26IUjgYNGqoR0w
   HFpuH6PPRJY4sVN1cMPU0SbAdDL0WnISMP+NEO0jcBEmaxdoHxlc8PF4e
   A==;
X-IronPort-AV: E=Sophos;i="5.60,527,1549900800"; 
   d="scan'208";a="114299087"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2019 05:16:38 +0800
IronPort-SDR: FHwHQ7X0CIWMgJJCzAC4KbI5yYFVDAb4jfjS1Wm0pQIekyZw1zXcKSN/f53H1eEL7QpOrCBRQl
 sScDrWWiNeOrfUrJS9Y2DVYNIuUG4KpLu2m92z5pV0xq9H1No4rFL3OF2q0xNIO/Gt7EV+OPPq
 atW95YC2EhF3XTgexJyTIR0xys9V4IMjcjjNctE7GXaXFp+P7W7l3bwQs3zKosLs+5CyEkadl9
 k9Ma9yIRN06eHdvb9aCfKhBpsv6ynCxs/0jT6L4wo1x7bvzE6lQlSD5bSjE/NX1yCG6uybxBLU
 6BdIuJR38limzh/W2k9D77Uf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 May 2019 13:51:48 -0700
IronPort-SDR: BuJEcp7kpiVfH+44FML9Wz7261edwcWa349N3tzjS8K9ckVv1NEsLMReMStYKUXuAzA7EBBfq+
 RSt2rSO4M91JdhcnpsONOcJa61Cu3xOHj0zVEwSQar1iiieDhUgyl/lL0JVGEOkgpi2TN5Wuhw
 7MpMzkbrbsKz1AJvwNJggovpU+SfTQ3y2nA8zO4IGw/9kDxdYB0InSB0sn2oIbQmto8/AGeocn
 ahk0+S0pT06vDa5j3crtO0igUd4/6Q4DGvPWOtp5/XSrj4wYbHPf53pyDUOWFh6hfMOvi/hjwE
 QBw=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 May 2019 14:16:38 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 5/7] RISC-V: Parse cpu topology during boot.
Date:   Wed, 29 May 2019 14:13:38 -0700
Message-Id: <20190529211340.17087-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529211340.17087-1-atish.patra@wdc.com>
References: <20190529211340.17087-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are no topology defined for RISC-V.
Parse the cpu-map node from device tree and setup the
cpu topology.

CPU topology after applying the patch.
$cat /sys/devices/system/cpu/cpu2/topology/core_siblings_list
0-3
$cat /sys/devices/system/cpu/cpu3/topology/core_siblings_list
0-3
$cat /sys/devices/system/cpu/cpu3/topology/physical_package_id
0
$cat /sys/devices/system/cpu/cpu3/topology/core_id
3

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/riscv/Kconfig          | 1 +
 arch/riscv/kernel/smpboot.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0c4b12205632..2d8a16299a85 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -47,6 +47,7 @@ config RISCV
 	select PCI_MSI if PCI
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
+	select GENERIC_ARCH_TOPOLOGY if SMP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MMIOWB
 	select HAVE_EBPF_JIT if 64BIT
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 7a0b62252524..54f89d5b19ba 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/arch_topology.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -43,6 +44,7 @@ static DECLARE_COMPLETION(cpu_running);
 
 void __init smp_prepare_boot_cpu(void)
 {
+	init_cpu_topology();
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -146,6 +148,7 @@ asmlinkage void __init smp_callin(void)
 
 	trap_init();
 	notify_cpu_starting(smp_processor_id());
+	update_siblings_masks(smp_processor_id());
 	set_cpu_online(smp_processor_id(), 1);
 	/*
 	 * Remote TLB flushes are ignored while the CPU is offline, so emit
-- 
2.21.0

