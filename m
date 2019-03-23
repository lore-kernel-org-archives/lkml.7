Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64727C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A9E2190A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCWL2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:28:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCWL2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 07:28:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2NBS97W996142
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 23 Mar 2019 04:28:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2NBS87H996139;
        Sat, 23 Mar 2019 04:28:08 -0700
Date:   Sat, 23 Mar 2019 04:28:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Atish Patra <tipbot@zytor.com>
Message-ID: <tip-32d0be018f6f5ee2d5d19c4795304613560814cf@git.kernel.org>
Cc:     Damien.LeMoal@wdc.com, mingo@kernel.org, aou@eecs.berkeley.edu,
        tglx@linutronix.de, atish.patra@wdc.com, daniel.lezcano@linaro.org,
        anup@brainfault.org, Anup.Patel@wdc.com,
        linux-kernel@vger.kernel.org, palmer@sifive.com, hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, aou@eecs.berkeley.edu,
          Damien.LeMoal@wdc.com, palmer@sifive.com, hpa@zytor.com,
          atish.patra@wdc.com, Anup.Patel@wdc.com,
          linux-kernel@vger.kernel.org, anup@brainfault.org,
          daniel.lezcano@linaro.org
In-Reply-To: <20190322215411.19362-1-atish.patra@wdc.com>
References: <20190322215411.19362-1-atish.patra@wdc.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/riscv: Fix clocksource mask
Git-Commit-ID: 32d0be018f6f5ee2d5d19c4795304613560814cf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  32d0be018f6f5ee2d5d19c4795304613560814cf
Gitweb:     https://git.kernel.org/tip/32d0be018f6f5ee2d5d19c4795304613560814cf
Author:     Atish Patra <atish.patra@wdc.com>
AuthorDate: Fri, 22 Mar 2019 14:54:11 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Mar 2019 12:25:34 +0100

clocksource/drivers/riscv: Fix clocksource mask

For all riscv architectures (RV32, RV64 and RV128), the clocksource
is a 64 bit incrementing counter.

Fix the clock source mask accordingly.

Tested on both 64bit and 32 bit virt machine in QEMU.

Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-riscv@lists.infradead.org
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Anup Patel <Anup.Patel@wdc.com>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190322215411.19362-1-atish.patra@wdc.com

---
 drivers/clocksource/timer-riscv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index e8163693e936..5e6038fbf115 100644
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
