Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437892175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WkgqJKa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfCVVyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:54:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15514 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCVVyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553291658; x=1584827658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RhPWR/oqGZTHzl6ZH9I2xdRDXGA1istoNPUJXot1OEQ=;
  b=WkgqJKa7dxdHxUo1Y61sE9ZHnXZRvhDmp4cZHyILuuB1vJJgeOJfD/Dh
   fib6JXQvLRbjqq+0Xs//elBWf516iRi8Angjl+w7tAyspSBxCTo2bnq5/
   fsS/RLQS3eUf7rmr8YCrdLKwplUVWhwdgMwFHm+wyiMcbNJa8yX5hYFqT
   8TQ0vJpsgZ8aqbkCwueL5y2Qe4BP9aLB/KdVmW6dJs4tH7QwMUudX0xXm
   vYb+3GRwctPBWj8OZTzfIQ4JJiIOdL611LZhCBxM3VttWW2I2XIivheVQ
   0j384C/aEncW7p78sZP8pR3AEJucKVoO6Ff2xwQFFoHW43iLzOT07iHIr
   w==;
X-IronPort-AV: E=Sophos;i="5.58,498,1544457600"; 
   d="scan'208";a="209606997"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2019 05:54:17 +0800
IronPort-SDR: ijVHiePuCvQQSXKIF4yqwFGdXx0abgpsyW4XsUYOt4sj4oeMLaS57+STuJgiQW/rN7YPp6f39v
 qdlE3UC3SgQizvR7ebQeTqX11tmDlx/tp4Y/iTZW1uWtmZE/3xrE7Exy77juLq2KPggIs97UXR
 91Ie3+yHyldnFX9hW2cjgdcgjHM5zuUkR+RJD2SDYJdqbK5vkbZh1RLWb1g0Y9K/fsVV+2v8YR
 wDXB2Jw8OFu4O5Fn52bnTZ5veI004dwDA/0CymvcuJk1HJkyHLRdoiRS6iiK2Fc9RKvhQHYk+h
 fYyQt233cbriHkgZGd7vW9ne
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 22 Mar 2019 14:31:50 -0700
IronPort-SDR: LwXnijMbOfyBZ8NEuujdKPU+fNSGF47JW9DaLSOW3DyS+/X86awOTUCEsn2faPgtSJMcamZ9+Q
 jGj7Qz5KHgywPODC+dkiCehua8+zh+saiIHtVs9sWz7NU5YgGoCfHVR1gqLmzNOMX0r/cXd/Ex
 8lPU/8WLWyvtBHN3cyDD867UQlsCuI0KToAB+nc6JnT59n4TxVNsan9K6KlRUBoEXruQo/0S6L
 qXpxQQOaShsxhz5XFSSNAor0cQXnty/aZvtJT5UbX7uTUL7LezoDDMgSMlnkEmz8AlEHTcmJha
 lPU=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Mar 2019 14:54:17 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <Anup.Patel@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH] clocksource/drivers/riscv: Fix clocksource mask
Date:   Fri, 22 Mar 2019 14:54:11 -0700
Message-Id: <20190322215411.19362-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all riscv architectures (RV32, RV64 and RV128), the clocksource
is a 64 bit incrementing counter.

Fix the clock source mask accordingly.

Tested on both 64bit and 32 bit virt machine in QEMU.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/clocksource/timer-riscv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index e8163693..5e6038fb 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -58,7 +58,7 @@ static u64 riscv_sched_clock(void)
 static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
 	.name		= "riscv_clocksource",
 	.rating		= 300,
-	.mask		= CLOCKSOURCE_MASK(BITS_PER_LONG),
+	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		= riscv_clocksource_rdtime,
 };
@@ -120,8 +120,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		return error;
 	}
 
-	sched_clock_register(riscv_sched_clock,
-			BITS_PER_LONG, riscv_timebase);
+	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
-- 
2.21.0

