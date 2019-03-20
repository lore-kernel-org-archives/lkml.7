Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7555BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40979217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p/mmDdoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfCTBXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:23:20 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58805 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfCTBXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553044991; x=1584580991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s8sajK0+Y5Qxk3l9f3FRoReqL4ztyr9hMhYSgl8VlYs=;
  b=p/mmDdojvPDaxAT2GZoO/7X7qcbydkokC3wY4ZQhSjAs62yNY/vgXWzE
   M7pJvnIArF6GgEXoGm4ogDMl6xJMTid7u4klX2KlIa+EG8S24CDPoouju
   QVYNxZxd+tEuRqyJAIl+VzjtqyrScg1QtZNCo3BejGoGyw5K/OUFt+L+/
   UFsFxK7tuDuu+zjwszklvXq/oGWmLrQD4ZkUh+6E8stMxebi0i93NYK96
   ZAJzjQIkPnGY4IKoJdMr+7F6fAl9Fdstiz3OxZEhR8B1jvLSlWqGj8bMH
   aOLob8h/gGJk4G/Kvg7FOG4KHIVbk+OkKoQRF4VgGETS92UyCkE95/EXH
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,498,1544457600"; 
   d="scan'208";a="209334033"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 09:23:01 +0800
IronPort-SDR: ZSCjO78nagcTKoKZGF15Ft3F+6Vqpkkh+FMP28J69Ouki3QURLwHm8J4flo6ihGyH98itzmbIp
 AT466zEOPrT+tI2IF1BFJGT7C+6bWQcNmM7ilXkjSTTWkoNhJ2IA9o3VC1Ug3tWf4OVHeCs1ke
 qYig5nsvO5Mg3gBZAPCSqRwiE+XvqfW9+OTwSvhUScYPpge9MRqYYBng7r1a2GjPE7Mwm2Gd4O
 z+EfFhBBbygVuaktNquv/40dsntycpqNVpcJvKr8uFXRcYG7OZn2Z1MdvVHTBdM4/2WsHJGpdO
 CZs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Mar 2019 18:02:39 -0700
IronPort-SDR: 7ewcJGwtdw1Bf+9Hx8qbkswK2bQ36UhDlgzsirbxYImQVPyGxNNSJ08RkKvFY5C56vHTnOHLK+
 0BFpINbW/yBhvuKyV+dc3ltHSxuu2PupuxExbrh9S1/cfGpJ98NMYQxiJ21g0KPoxZI31SOkun
 itoqAjWahzU2c5kgbwEy71+MG4c971MaZyTBaESpHrzVp+4tYPNat80yjSmkoVyMGiHKBXjKrq
 EQexS25nFe0rWbGhOl/pGyWsOpkW+dj2+rarvgGLoa9Ge8ryMlswwOL4x2kT3i7X1qXk5xl+NK
 iYY=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2019 18:23:00 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
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
        Will Deacon <will.deacon@arm.com>
Subject: [RFT/RFC PATCH v2 4/4] RISC-V: Parse cpu topology during boot.
Date:   Tue, 19 Mar 2019 18:22:51 -0700
Message-Id: <20190320012251.2728-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320012251.2728-1-atish.patra@wdc.com>
References: <20190320012251.2728-1-atish.patra@wdc.com>
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
index eb56c82d..ac87a0ec 100644
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
index f41eb193..a8fe590c 100644
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

