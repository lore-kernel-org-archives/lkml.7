Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FEEC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8307F214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QCwt9Cjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfD1A0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 20:26:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14542 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfD1A0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 20:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556411165; x=1587947165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C0s3Q/O8qn11niz50wHDStN1x4FtZC5KPQ7JENLP8SA=;
  b=QCwt9CjpujtTCIr5Ae9LGaZXlI35nZ9ah1X2fClj0CFtkDoRDfxQGalR
   +obDXNguXanH8O5DQUSO/wAP2ZL8f2H3UZ3mFiDL8CSZ0tHeg3RCns1lh
   G4tQFtqIjBfCwUgDRzyOJZ0iNffKbaXVNZdNhOAbS7ynaC1QnnBLXReDj
   hR4aTBkVuPWav4kzrmTH99uu1EWYs6uyIcGztKWFcG8wal8z1bqmd2Rp0
   3uK496ATnkvJfDhYlP0ijeKrfq/Zbvoohu5t+USoTPC3mF28UsieeeKJa
   2RJEfpxOIO3go9fZ6A9WUQrenbNaa5DXrZIo66LMsKrxg0rRAr5ISCNAZ
   g==;
X-IronPort-AV: E=Sophos;i="5.60,403,1549900800"; 
   d="scan'208";a="106993915"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2019 08:26:04 +0800
IronPort-SDR: LZ87IoNllupGmvnKgEnnWe22Arr03Qwpq1k/5YnxKGlUY4h8L5VRUP/2cKZQiollVpq63vWblY
 Isv8Rl0PoJPPKzX6ShUbS18LurUPCslrm0M5uoWbmdfGiwvB715KBbCOMEQ+76Vf4g8Wg1JwZS
 UAq4vSAVbfuJKduL8Fov+HbQJaR6dnk4tFL85OkyAZZzErg/1OD/sbOUzVrAsXWl7Ogk5PlKkK
 frIdCXkM7HO8ouqMeoHt/KBGY1yHRLJN02W09rZ8aDJzC0KNPnL7CRtH0QRKR4iy2phD3C1cuh
 0ERn/gfQYAPV4rOL542p8uab
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 27 Apr 2019 17:04:38 -0700
IronPort-SDR: u+PFeKWQ12BYmx3wQh9/mn/2Jk/YxiB/FZFzUhp1CfGT2zYs87b7FKeA2xAuTzBL67IrB/ypud
 qMKsr2v84TUS/6VgObI6p4xN2I2QLG+R2s5vhYjBdiGqVLOEOMLhEhbUhc4bUe2aNgPNbjoaDn
 fuQ4f8jQyBFgFX0t3E6vQKXZbvFXyb20iSBKq/PcY8aj87kfnlfD1W7hSm3gVLScMDySvcIk/Z
 RVCuNCHM5kYv36nRZ51PdPGml/aQjENIbLElzMLTel/h9jgUfORwcE590tLWEWafyZOi8yr7Qt
 6yI=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Apr 2019 17:26:04 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v4 5/5] RISC-V: Parse cpu topology during boot.
Date:   Sat, 27 Apr 2019 17:25:29 -0700
Message-Id: <20190428002529.14229-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190428002529.14229-1-atish.patra@wdc.com>
References: <20190428002529.14229-1-atish.patra@wdc.com>
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
---
 arch/riscv/Kconfig          | 1 +
 arch/riscv/kernel/smpboot.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb56c82d8aa1..ac87a0ec8b5c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -47,6 +47,7 @@ config RISCV
 	select PCI_MSI if PCI
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
+	select GENERIC_ARCH_TOPOLOGY if SMP
 	select ARCH_HAS_PTE_SPECIAL
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

