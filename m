Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB4220811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582542;
	bh=wl5wIp2aD3am9trgEnq4QK59v0CURmSAhbUEL0IZw9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZumrwjgUWJEUq3eQ0MLS77dXGh2nbOMEn4lHfumYIoBTUD27Yifpp8kUd8jqHQHk4
	 sZ3C4Cm07BzJJLl6vYBEGgBrGvcEjO2RqpFemHcuj/AZ5ACb0v8RLsBzhvWpsmkHhM
	 r5/A0sGM946ac0diaRj8SJ/21ssHGzjY5ZxLlkBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfCZGjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732647AbfCZGjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:11 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3740220879;
        Tue, 26 Mar 2019 06:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582350;
        bh=wl5wIp2aD3am9trgEnq4QK59v0CURmSAhbUEL0IZw9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bv+jW4CofX5ncO0juKuqIofzoA0IVxzoJUqgp2//Qilc9dWLPwXO4Uxe3iRKZD7Al
         SP5HChUjAS+mKTU8gfywH9xC6xJVvcKCVIPibhxDtZENgnaqFBIuZSXMixV2zlUB2+
         /4QNZL+v3c1SXU8xD/qHXwFWRO2+5B6ssCXWAh+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 5.0 29/52] clocksource/drivers/riscv: Fix clocksource mask
Date:   Tue, 26 Mar 2019 15:30:16 +0900
Message-Id: <20190326042702.424504276@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Atish Patra <atish.patra@wdc.com>

commit 32d0be018f6f5ee2d5d19c4795304613560814cf upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/timer-riscv.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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
@@ -103,8 +103,7 @@ static int __init riscv_timer_init_dt(st
 	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
 	clocksource_register_hz(cs, riscv_timebase);
 
-	sched_clock_register(riscv_sched_clock,
-			BITS_PER_LONG, riscv_timebase);
+	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",


