Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E987C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234C92175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rPjpMQQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbfEXAHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:07:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37268 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388695AbfEXAHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558656450; x=1590192450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1SdLFPXetAg3nrR1IO1V0QDUQiFziWocOM5xU46X9ZA=;
  b=rPjpMQQRVORrbh3Vpl23/a7TrpbKlWygVD2c0BxzF4Qr4sJtVkfjny63
   nAqYJ/sdD6vJnj8RBxXsI0Q7KK0T3GrRGz2RisIY5Ntgrg8z9jG8x0aWi
   Rbeck+F8Q4r26YAp90zgSRRSi25yRlUqAUmMFsQR0DLu3ocJMnlJwyw4A
   L6kuSA1BCfJDCOksVb49Uc52s7kqN+ajjlP8STGbtQ9GF6ztdJC+MbS5J
   4dpGxE3r6pCYeO/ZfAjzdliv3WIJKQAcmZf+w0OMtjH5KhXJJntxSxvOs
   3MbZOwxH5bTj7mYDeooehWBBLUMlPDQe8DHptENl5UupksXAKJYlXQEmd
   A==;
X-IronPort-AV: E=Sophos;i="5.60,505,1549900800"; 
   d="scan'208";a="108976467"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2019 08:07:29 +0800
IronPort-SDR: CwSFiBJC1pzGKT2S0VQjGTixSsPh9VZfZHW7/xiqbp4PJy0LI03N55eqCfh4HYKD09zFvJ1hnx
 HlZaVUfGamU9iUsNAlLgn5kL9PqiFQ2RfgeKWfJh92Sk6Y91jmuiZKpzdZ4E9ST0mfH7OKGU0d
 r8EMfDN2LshObVIKwIHgBAz//8CKM3WcYqx0XKqS/Vy8Vm8g8MJber0+8t01pUeLD0HjCfLimD
 +IYb3cQzfhyJK6zDiNwQqrxNDM0yKOsTj4G7iEAWgJh4xodmuV6hlzL48AKprNEh2czYv5071C
 F/DEzipTnYiSCkVvpponpnFR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 May 2019 16:45:10 -0700
IronPort-SDR: vXZ4XSK9LUBf5ZWszJwtTb4rMMV3fmbYhZ9isZM07tLp+6dAKXjytTd62sv0dWJ8c/dczi8vdf
 mzOOjmZgY3QlclHixf+HXkdq/yoR0AAbYKM2dyB0enq32mtvDtDj/iv39I9tTxD0TwXPKbzLnY
 nejq/gMxiXVGbT+s3f6f5QVmYuhcmRDsmCJaaflh2xH9uibLsniWOkerekb7gLCcDpL0yO7uEH
 lE4RMqeetQG8MqlLY9aZUB6cyQ18OzEzucsr75+tYmSsQi2IYQFYVLxJLHzZ5M667YzZbAS4Ae
 p/Q=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 May 2019 17:07:28 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
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
Subject: [RFT PATCH v5 5/5] RISC-V: Parse cpu topology during boot.
Date:   Thu, 23 May 2019 17:06:52 -0700
Message-Id: <20190524000653.13005-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524000653.13005-1-atish.patra@wdc.com>
References: <20190524000653.13005-1-atish.patra@wdc.com>
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
index ee32c66e1af3..be319d902275 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -46,6 +46,7 @@ config RISCV
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

