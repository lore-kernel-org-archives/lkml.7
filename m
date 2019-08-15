Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E034C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4191220644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfHOWxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:53:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:41757 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730491AbfHOWxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:53:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 15:53:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="179505147"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2019 15:53:43 -0700
From:   thor.thayer@linux.intel.com
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [RESEND] mtd: spi-nor: Fix Cadence QSPI RCU Schedule Stall
Date:   Thu, 15 Aug 2019 17:55:36 -0500
Message-Id: <1565909736-11379-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The current Cadence QSPI driver sometimes caused a
"rcu_sched self-detected stall" while writing large files.

Stall Report:
'# mtd_debug write /dev/mtd1 0 48816464 blob.img
[ 1815.454227] rcu: INFO: rcu_sched self-detected stall on CPU
[ 1815.459789] rcu:     0-....: (2099 ticks this GP) idle=8c6/1/0x40000002
 softirq=6492/6492 fqs=935
[ 1815.468442] rcu:      (t=2100 jiffies g=8749 q=247)
	<snip> (abbreviated backtrace)
[ 1815.772086] [<c05a3ea0>] (cqspi_exec_flash_cmd) (cqspi_read_reg)
[ 1815.786203] [<c05a5488>] (cqspi_read_reg) from (read_sr)
[ 1815.803790] [<c05a0330>] (read_sr) from
	(spi_nor_wait_till_ready_with_timeout)
[ 1815.816610] [<c05a182c>] (spi_nor_wait_till_ready_with_timeout) from
	(spi_nor_write+0x104/0x1d0)
[ 1815.836791] [<c05a1a44>] (spi_nor_write) from (part_write+0x50/0x58)
	<snip>
[ 1815.997961] cadence-qspi ff809000.spi: Flash command execution timed out.
[ 1816.004733] error -110 reading SR
file_to_flash: write, size 0x2e8e150, n 0x2e8e150
write(): Connection timed out

This was caused by a tight loop in cqspi_wait_for_bit(). Fix by using
readl_relaxed_poll_timeout() which sleeps 10us while polling a register.

Fit onto 80 character line by truncating the bool clear parameter

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 67f15a1f16fd..7bef63947b29 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -241,23 +242,13 @@ struct cqspi_driver_platdata {
 
 #define CQSPI_IRQ_STATUS_MASK		0x1FFFF
 
-static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clear)
+static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
 {
-	unsigned long end = jiffies + msecs_to_jiffies(CQSPI_TIMEOUT_MS);
 	u32 val;
 
-	while (1) {
-		val = readl(reg);
-		if (clear)
-			val = ~val;
-		val &= mask;
-
-		if (val == mask)
-			return 0;
-
-		if (time_after(jiffies, end))
-			return -ETIMEDOUT;
-	}
+	return readl_relaxed_poll_timeout(reg, val,
+					  (((clr ? ~val : val) & mask) == mask),
+					  10, CQSPI_TIMEOUT_MS * 1000);
 }
 
 static bool cqspi_is_idle(struct cqspi_st *cqspi)
-- 
2.7.4

