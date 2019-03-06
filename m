Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8310CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD8E20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfCFNAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:00:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729167AbfCFNAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:00:49 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 92C9EF98DC81A5D0CC9F;
        Wed,  6 Mar 2019 21:00:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Mar 2019 21:00:37 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <tglx@linutronix.de>, <edumazet@google.com>,
        <linux-kernel@vger.kernel.org>, <yaohongbo@huawei.com>
Subject: [RFC PATCH 2/2] hrtimer: Prevent overflow for relative refrences
Date:   Wed, 6 Mar 2019 21:13:26 +0800
Message-ID: <20190306131326.10275-3-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306131326.10275-1-yaohongbo@huawei.com>
References: <20190306131326.10275-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran Syzkaller testsuite, and got the following call trace.

===============================================================
UBSAN: Undefined behaviour in ../kernel/time/hrtimer.c:514:11
signed integer overflow:
9223372036854775807 - -240652746 cannot be represented in type 'long
long int'
CPU: 1 PID: 9308 Comm: trinity-c5 Not tainted 4.19.25-dirty #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 dump_stack+0xdd/0x12a
 ubsan_epilogue+0x10/0x65
 handle_overflow+0x1a8/0x212
 ? val_to_string.constprop.2+0x137/0x137
 ? print_lock_contention_bug+0x190/0x190
 ? __next_base+0x2b/0xc0
 ? __hrtimer_run_queues+0xca/0x830
 __ubsan_handle_sub_overflow+0x11/0x19
 __hrtimer_next_event_base+0x1a9/0x1b0
 __hrtimer_get_next_event+0x96/0x140
 hrtimer_interrupt+0x391/0x610
 smp_apic_timer_interrupt+0x137/0x3d0
 apic_timer_interrupt+0xf/0x20

===============================================================

Use ktime_sub_safe() which has the necessary sanity checks in place and
limits the result to the valid range.

Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 kernel/time/hrtimer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cadc5bcbfc9e..2195b35af085 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -527,7 +527,8 @@ static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
 
 			timer = container_of(next, struct hrtimer, node);
 		}
-		expires = ktime_sub(hrtimer_get_expires(timer), base->offset);
+		expires = ktime_sub_safe(hrtimer_get_expires(timer),
+					 base->offset);
 		if (expires < expires_next) {
 			expires_next = expires;
 
@@ -781,7 +782,8 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *base = timer->base;
-	ktime_t expires = ktime_sub(hrtimer_get_expires(timer), base->offset);
+	ktime_t expires = ktime_sub_safe(hrtimer_get_expires(timer),
+					 base->offset);
 
 	WARN_ON_ONCE(hrtimer_get_expires_tv64(timer) < 0);
 
-- 
2.20.1

