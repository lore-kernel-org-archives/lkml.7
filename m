Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F32C32764
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 09:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9F22073D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 09:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgAAJci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 04:32:38 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:42992 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgAAJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 04:32:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TmU9qf5_1577871126;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmU9qf5_1577871126)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jan 2020 17:32:14 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page-writeback.c: avoid potential division by zero
Date:   Wed,  1 Jan 2020 17:32:04 +0800
Message-Id: <20200101093204.3592-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables 'min', 'max' and 'bw' are unsigned long and
do_div truncates them to 32 bits, which means it can test
non-zero and be truncated to zero for division.
Fix this issue by using div64_ul() instead.

For the two variables 'numerator' and 'denominator',
though they are declared as long, they should actually be
unsigned long (according to the implementation of
the fprop_fraction_percpu() function).

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page-writeback.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 50055d2..2caf780 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -201,11 +201,11 @@ static void wb_min_max_ratio(struct bdi_writeback *wb,
 	if (this_bw < tot_bw) {
 		if (min) {
 			min *= this_bw;
-			do_div(min, tot_bw);
+			min = div64_ul(min, tot_bw);
 		}
 		if (max < 100) {
 			max *= this_bw;
-			do_div(max, tot_bw);
+			max = div64_ul(max, tot_bw);
 		}
 	}
 
@@ -766,7 +766,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
 	struct wb_domain *dom = dtc_dom(dtc);
 	unsigned long thresh = dtc->thresh;
 	u64 wb_thresh;
-	long numerator, denominator;
+	unsigned long numerator, denominator;
 	unsigned long wb_min_ratio, wb_max_ratio;
 
 	/*
@@ -777,7 +777,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc)
 
 	wb_thresh = (thresh * (100 - bdi_min_ratio)) / 100;
 	wb_thresh *= numerator;
-	do_div(wb_thresh, denominator);
+	wb_thresh = div64_ul(wb_thresh, denominator);
 
 	wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
 
@@ -1102,7 +1102,7 @@ static void wb_update_write_bandwidth(struct bdi_writeback *wb,
 	bw = written - min(written, wb->written_stamp);
 	bw *= HZ;
 	if (unlikely(elapsed > period)) {
-		do_div(bw, elapsed);
+		bw = div64_ul(bw, elapsed);
 		avg = bw;
 		goto out;
 	}
-- 
1.8.3.1

