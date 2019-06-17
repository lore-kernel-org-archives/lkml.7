Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1C2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CA9206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PqD+Hhai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfFQTA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:00:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59831 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560798054; x=1592334054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FdusRwcmVMWHwhKYZKA8Sg9X99lDeoGVE78siWre56A=;
  b=PqD+HhaiNKJNUOGzobNYAMXSa9gAAv5diRw+LwwltvxhbcO5rKD6DjRY
   Vci2u+hIBNB3aqJ2Bj8/LTcIQ+W10GCcL6bzYJOe5hh4HakCAj6xshca9
   9eKRgpxh7bNfCMWnrmau0jU7MDOLjEIF68wN0Xpts0Q7CotON+/Fi0s92
   JsLh7AlMsvazBbW8i+cDheuuQ7DXL5e/35w0b1VPWb8GvnGZy6xUimdW6
   x0m8TJcnKcvrZzXVf0rTgfYmK7usUAZTJ+0B5b61PixvxDbKaF9hpWdTS
   8bEvZygjtfiETNBLugbThcZTT/MQJY6HZPiDsVxVWTFwcQqw+qG+upoWH
   A==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; 
   d="scan'208";a="115695468"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 03:00:54 +0800
IronPort-SDR: yX31RTyq0YqhdaKQ181QVLvSGihHq9xhErX2ifWogwiHtL76XPfq5MfyqTHtS3KpOKNpESewdr
 P6JazOxuxG5b3y8FvHT8kyKQY1UxMeM9JHBnItkQuRHjL/vmo0QURnoEqwu/y7/9C8W87GNT4Q
 5uJxXJyVTRRhUn4mzAkabKmmn/9z5m/ijq+RwOxLuyFr0WXr+5LvO0Z4ngngSBFhncKUMgs1WL
 HuWw/dLfXdiZLHaFBs1StOS5bdSUIjhfuiigka7KHHsNVExA531uaoIyJ1bCXWsBpDqkMMPs0B
 Qb+/J5P7tCxF1COeNGvrL8Sk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 17 Jun 2019 12:00:27 -0700
IronPort-SDR: zJubSC4vCo5jqsd42gSsbVN/4doMi68FO7XiOle1TUfLfMPXN6wZP2lcTR+aBUYXaFVE5T7mCV
 Yp3NzoCU4Y2XpnoKnDsi/VUpWSP9tNuczvEyZoD6d1c9yPq6OJSTb5tdVJ46EG19vadZxhQsea
 a9RXFQLbpka2H3p+WDc23vduv3b3WkQ/LZqWi04t3SrejMK4FwC2XcI6ITBJ2At29H2CRGEUaa
 v69yCj/PPY4KbZeSRiM5PpS7Blo2ZKFbth72KvUGe7x0U/yg20Ub6/loOEkI6UbyeLzfiWZeVJ
 EQc=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Jun 2019 12:00:51 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 5/7] RISC-V: Parse cpu topology during boot.
Date:   Mon, 17 Jun 2019 11:59:18 -0700
Message-Id: <20190617185920.29581-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617185920.29581-1-atish.patra@wdc.com>
References: <20190617185920.29581-1-atish.patra@wdc.com>
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

