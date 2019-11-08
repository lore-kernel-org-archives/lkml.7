Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98986FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7499B214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfKHHdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 02:33:15 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:48524 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbfKHHdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 02:33:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=xiejingfeng@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ThU0D.W_1573198392;
Received: from 30.5.113.47(mailfrom:xiejingfeng@linux.alibaba.com fp:SMTPD_---0ThU0D.W_1573198392)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Nov 2019 15:33:13 +0800
User-Agent: Microsoft-MacOutlook/10.1f.0.191103
Date:   Fri, 08 Nov 2019 15:33:24 +0800
Subject: [PATCH] psi:fix divide by zero in psi_update_stats
From:   tim <xiejingfeng@linux.alibaba.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Message-ID: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
Thread-Topic: [PATCH] psi:fix divide by zero in psi_update_stats
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In psi_update_stats, it is possible that period has value like
0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls div_u64 which
truncates u64 period to u32, results in zero divisor.
Use div64_u64() instead of div_u64()  if the divisor is u64 to avoid
truncation to 32-bit on 64-bit platforms.

Signed-off-by: xiejingfeng <xiejingfeng@linux.alibaba.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 517e3719027e..399d6f106de5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -291,7 +291,7 @@ static void calc_avgs(unsigned long avg[3], int missed_periods,
 	}
 
 	/* Sample the most recent active period */
-	pct = div_u64(time * 100, period);
+	pct = div64_u64(time * 100, period);
 	pct *= FIXED_1;
 	avg[0] = calc_load(avg[0], EXP_10s, pct);
 	avg[1] = calc_load(avg[1], EXP_60s, pct);
-- 
2.14.4.44.g2045bb



