Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBA5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFBC218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JdQ8ugYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfCTXsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:48:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11921 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfCTXsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553125697; x=1584661697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s8sajK0+Y5Qxk3l9f3FRoReqL4ztyr9hMhYSgl8VlYs=;
  b=JdQ8ugYrjdK6Vgmty4RZTvyDFJyoHBnQvl4ZO7hdUt9ZS1AeN1xyXX/i
   mR+HqFWnCzzQf5hDYu2GqIcuCAIFIjCsRvgmhlqjp+plmLBr6WgL3Beek
   yXBFUUKHrmFUMbtJYVYQT1SvHDkP68EDPph1A1Is5y3xK4GpR+0xV8xbK
   Yfj7jBaIe5Chj2r/e5Rpk5fVtVtflHm8j4pCguLMzkxiirs3BNrZqFMSu
   0nN/rOh51PwovOp86wTpPe9NdbsvpqRNQMlHZL/sFgbMPlxraRJo4EEAF
   CCqYYEEXyMiAIvlHxzfQIlsaQhFi4cU4/qm8jtDgOdkr79Bf3uBF2hyOW
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,250,1549900800"; 
   d="scan'208";a="103874328"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2019 07:48:16 +0800
IronPort-SDR: zLwf0ZtIXgkBFtGFkJOAifO8Ilvey+b20TWdeXqUySGUKq8VSYoRwNYDhZCYMVLK/MCWulnmYc
 nQYE5clez6yds4ygGe2vqJF6qRjUtTqX/Vty2OGeuIulJ4M4Jt21hkWT6hwF6W+qCUjU8bAG0/
 ny3G6HTJZK9pM2zLTCEo3CY2zSHDtziipEciFS6HMU9u81L9Kwwz06tGFrGuF7qRPffEIxfNSv
 MnWp8wP5dMWZOfSk1RvakX3/wr0G2wH/6nE7Op5/cUiUx+DGSSzprU0h/obobR4I+Qp+V5AMU3
 3BNCGOagJrhf1lFc+Q/BvVlR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 20 Mar 2019 16:27:53 -0700
IronPort-SDR: TW5Zbmthhyvkzhd46KZtqxhnd3w3JqrSsH2O3cUfBjyhO4AXA57gWdo9glBSf+uwzzoLK2yzLl
 z12Xk/ez4h0xYkTJ32lZw3aSYGB0uTonvch+xr+YQdqMqX7b9C8WluoF+iUT8HtbNhI9MEMmg4
 rh7dRLVHbn2lFfALzYLMVD5mxh6iGKTjcPzWGhiifGOn6eUu6FwvJtBZdtqrlTPgouytBFkx1B
 xsKVxXh0sQQ6+3vWQ0QcVkantcZSgBw+yGqBrmAMtJKJdlhvH5mPb5R6G0Es7BdUhOQ1RHP7iQ
 uco=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Mar 2019 16:48:16 -0700
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
        Johan Hovold <johan@kernel.org>,
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
        Will Deacon <will.deacon@arm.com>
Subject: [RFT/RFC PATCH v3 5/5] RISC-V: Parse cpu topology during boot.
Date:   Wed, 20 Mar 2019 16:48:06 -0700
Message-Id: <20190320234806.19748-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320234806.19748-1-atish.patra@wdc.com>
References: <20190320234806.19748-1-atish.patra@wdc.com>
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

