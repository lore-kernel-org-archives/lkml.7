Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCDCC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2DB20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JX3l8AN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfF0Tza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:55:30 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23412 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF0Tz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561665327; x=1593201327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FdusRwcmVMWHwhKYZKA8Sg9X99lDeoGVE78siWre56A=;
  b=JX3l8AN45vC+lbi5Dt6PYvzRmzL6LqbSFJhyFNV6wk/mojay1/8SZ5Bj
   QgHDWlZx4RhsVa929ni804NZejGBwyFyyU+IwSvybu3LVQgeBIhJJtCni
   RrK+Om9jGroa7ktNtsiHb639SBWYB1rAKr+Yq08CBeZYvv9wVJQgXlIrO
   ow0VVua0synWiEcHrPSSXSHWTRXoi9CLff9CkU33L7w2Mj7+QeRrjqgtc
   aBRN5eWXhlAYd/QJWm5a5ZwEJOZE6qz5tDOxpYSMuiFqe1/qsHkfUQXCx
   DdywiG9bfxv4Bt/RUeyyKKqPm0kh7HlsY54b7C3yrmvpfCHjUVuu1TYcW
   w==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="112927450"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 03:55:27 +0800
IronPort-SDR: Qdmkp33cQxW+NE2zr0XSQxnbFewo2ZZkviZaZprliJAwTrFbOei6FLmZRLtSUCo2Nh1IELDtCL
 wewiII49M7HWxSTHyyOKog3KoXL2vjmC7AfYVD7GNDJ9ezV7gTNCxg3wtPdHyl3kBUXvpFsCXS
 IEBUDWxYB9NvlXVkRb0vkF8Co9GByMgFruRmGhQgMbx/a9wWieL48v63h7HEPdD3Y7p/ooncVs
 Ew9DSEZDBmG2UmUHGQhKM1LatXXCoqrxSDnJHZqYujT0z0iRe53MdzEr3wVP9/vLjZm+hYLODo
 KgancvFWSIiCvyFG1SeRgG88
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 27 Jun 2019 12:54:40 -0700
IronPort-SDR: d1yMyLnC7Wu1GshTWNxTIlhczi+9O2jjCAHWfUDPztekbDm4XE3u04aDnlpTjRMmeh1CKLfui8
 P5UxBmYCTr8owGXsaC1vRfQs8i60QviKT47INux220RIG///tw1U65SK0XPTNY5dFv1fHZ+wEA
 Fhcra5QKct/RqS2YsuHLX3+i0hct8lXif7gbGJ3496ZQwlw8OY00Puha2jArrzVWz3BeTvE8zE
 zdOurgEpIZtkLqdZ98a+B+F3gbW2gJPkJ0jf1xfnBRk+3cJuhLtM9pz9qONTyZKb5acHeakOf+
 vm4=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 12:55:27 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v8 5/7] RISC-V: Parse cpu topology during boot.
Date:   Thu, 27 Jun 2019 12:53:00 -0700
Message-Id: <20190627195302.28300-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627195302.28300-1-atish.patra@wdc.com>
References: <20190627195302.28300-1-atish.patra@wdc.com>
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
Acked-by: Paul Walmsley <paul.walmsley@sifive.com>
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
index 7462a44304fe..18ae6da5115e 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/arch_topology.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -35,6 +36,7 @@ static DECLARE_COMPLETION(cpu_running);
 
 void __init smp_prepare_boot_cpu(void)
 {
+	init_cpu_topology();
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -138,6 +140,7 @@ asmlinkage void __init smp_callin(void)
 
 	trap_init();
 	notify_cpu_starting(smp_processor_id());
+	update_siblings_masks(smp_processor_id());
 	set_cpu_online(smp_processor_id(), 1);
 	/*
 	 * Remote TLB flushes are ignored while the CPU is offline, so emit
-- 
2.21.0

