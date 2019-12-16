Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C4C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568E220733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLPG3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 01:29:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8127 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfLPG3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 01:29:08 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6E8FA986D098908E5817;
        Mon, 16 Dec 2019 14:29:05 +0800 (CST)
Received: from linux-CPUxgZ.huawei.com (10.175.104.212) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 14:28:57 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>
Subject: [PATCH] irq-gic-v3: fix NULL dereference of disabled redist_base
Date:   Mon, 16 Dec 2019 14:27:45 +0800
Message-ID: <20191216062745.63397-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we use ACPI MADT GICC structure to pass single redistributor base,
and mark some GICC as disabled, we'll get below call trace during
boot:

[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] Unable to handle kernel paging request at virtual address 000000000000ffe8
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000004
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004
[    0.000000]   CM = 0, WnR = 0
[    0.000000] [000000000000ffe8] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 96000004 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc1 #5
[    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
[    0.000000] pc : gic_iterate_rdists+0x58/0x130
[    0.000000] lr : gic_iterate_rdists+0x80/0x130
[    0.000000] sp : ffff8000113d3cb0
[    0.000000] x29: ffff8000113d3cb0 x28: 0000000000000000
[    0.000000] x27: 0000000000000000 x26: 0000000000000018
[    0.000000] x25: 000000000000ffe8 x24: 000000000000003f
[    0.000000] x23: ffff800010588040 x22: 00000000000005e8
[    0.000000] x21: ffff8000113df7d0 x20: 0000030f00003f11
[    0.000000] x19: 0000000000000000 x18: ffffffffffffffff
[    0.000000] x17: 0000000014aeb8dc x16: 00000000c3ba0ccf
[    0.000000] x15: ffff8000113d9908 x14: ffff8000913d3a37
[    0.000000] x13: ffff8000113d3a45 x12: ffff800011402000
[    0.000000] x11: ffff8000113d39d0 x10: ffff8000113db980
[    0.000000] x9 : 00000000ffffffd0 x8 : ffff8000106dca98
[    0.000000] x7 : 000000000000005b x6 : 0000000000000000
[    0.000000] x5 : 0000000000000000 x4 : ffff8000128c0000
[    0.000000] x3 : ffff8000128a0000 x2 : ffff0003fc3c7000
[    0.000000] x1 : 0000000000000001 x0 : 000000000000ffe8
[    0.000000] Call trace:
[    0.000000]  gic_iterate_rdists+0x58/0x130
[    0.000000]  gic_init_bases+0x200/0x4b4
[    0.000000]  gic_acpi_init+0x148/0x284
[    0.000000]  acpi_match_madt+0x4c/0x84
[    0.000000]  acpi_table_parse_entries_array+0x188/0x278
[    0.000000]  acpi_table_parse_entries+0x70/0x98
[    0.000000]  acpi_table_parse_madt+0x40/0x50
[    0.000000]  __acpi_probe_device_table+0x88/0xe4
[    0.000000]  irqchip_init+0x38/0x40
[    0.000000]  init_IRQ+0x168/0x19c
[    0.000000]  start_kernel+0x328/0x508
[    0.000000] Code: f90017b6 9b3a7f16 f8766853 8b190260 (b9400000)
[    0.000000] ---[ end trace ae5cf232d924bfc1 ]---
[    0.000000] Kernel panic - not syncing: Fatal exception
[    0.000000] Rebooting in 3 seconds..

In this case, nr_redist_regions counts all GICC structures but only
enabled ones have redistributor mapped. So add check to avoid NULL
deference of redist_base.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d6218012097b..bd9d55cadef9 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -781,6 +781,13 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 		u64 typer;
 		u32 reg;
 
+		/*
+		 * redist_base may be NULL if we use single_redist and some GICC
+		 * structure is disabled.
+		 */
+		if (!ptr)
+			continue;
+
 		reg = readl_relaxed(ptr + GICR_PIDR2) & GIC_PIDR2_ARCH_MASK;
 		if (reg != GIC_PIDR2_ARCH_GICv3 &&
 		    reg != GIC_PIDR2_ARCH_GICv4) { /* We're in trouble... */
-- 
2.19.1

