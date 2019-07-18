Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0F0C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689E220880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbfGRNSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46743 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfGRNSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:18:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3731B30842A1;
        Thu, 18 Jul 2019 13:18:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id E660160635;
        Thu, 18 Jul 2019 13:18:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 Jul 2019 15:18:35 +0200 (CEST)
Date:   Thu, 18 Jul 2019 15:18:34 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190718131834.GA22211@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 18 Jul 2019 13:18:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People report that utime and stime from /proc/<pid>/stat become very wrong
when the numbers are big enough. In particular, the monitored application
can run all the time in user-space but only stime grows.

This is because scale_stime() is very inaccurate. It tries to minimize the
relative error, but the absolute error can be huge.

Andrew wrote the test-case:

	int main(int argc, char **argv)
	{
	    struct task_cputime c;
	    struct prev_cputime p;
	    u64 st, pst, cst;
	    u64 ut, put, cut;
	    u64 x;
	    int i = -1; // one step not printed

	    if (argc != 2)
	    {
		printf("usage: %s <start_in_seconds>\n", argv[0]);
		return 1;
	    }
	    x = strtoull(argv[1], NULL, 0) * SEC;
	    printf("start=%lld\n", x);

	    p.stime = 0;
	    p.utime = 0;

	    while (i++ < NSTEPS)
	    {
		x += STEP;
		c.stime = x;
		c.utime = x;
		c.sum_exec_runtime = x + x;
		pst = cputime_to_clock_t(p.stime);
		put = cputime_to_clock_t(p.utime);
		cputime_adjust(&c, &p, &ut, &st);
		cst = cputime_to_clock_t(st);
		cut = cputime_to_clock_t(ut);
		if (i)
		    printf("ut(diff)/st(diff): %20lld (%4lld)  %20lld (%4lld)\n",
			cut, cut - put, cst, cst - pst);
	    }
	}

For example,

	$ ./stime 300000
	start=300000000000000
	ut(diff)/st(diff):            299994875 (   0)             300009124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300011124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300013124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300015124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300017124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300019124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300021124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300023124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300025124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300027124 (2000)
	ut(diff)/st(diff):            299994875 (   0)             300029124 (2000)
	ut(diff)/st(diff):            299996875 (2000)             300029124 (   0)
	ut(diff)/st(diff):            299998875 (2000)             300029124 (   0)
	ut(diff)/st(diff):            300000875 (2000)             300029124 (   0)
	ut(diff)/st(diff):            300002875 (2000)             300029124 (   0)
	ut(diff)/st(diff):            300004875 (2000)             300029124 (   0)
	ut(diff)/st(diff):            300006875 (2000)             300029124 (   0)
	ut(diff)/st(diff):            300008875 (2000)             300029124 (   0)
	ut(diff)/st(diff):            300010875 (2000)             300029124 (   0)
	ut(diff)/st(diff):            300012055 (1180)             300029944 ( 820)
	ut(diff)/st(diff):            300012055 (   0)             300031944 (2000)
	ut(diff)/st(diff):            300012055 (   0)             300033944 (2000)
	ut(diff)/st(diff):            300012055 (   0)             300035944 (2000)
	ut(diff)/st(diff):            300012055 (   0)             300037944 (2000)

shows the problem even when sum_exec_runtime is not that big: 300000 secs.

The new implementation of scale_stime() does the additional div64_u64_rem()
in a loop but see the comment, as long it is used by cputime_adjust() this
can happen only once.

Reported-by: Andrew Fox <afox@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sched/cputime.c | 66 ++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2305ce8..ad055a3 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -525,47 +525,55 @@ void account_idle_ticks(unsigned long ticks)
 }
 
 /*
- * Perform (stime * rtime) / total, but avoid multiplication overflow by
- * losing precision when the numbers are big.
+ * Perform (stime * rtime) / total, but avoid multiplication overflow
+ * by losing precision when the numbers are big.
+ *
+ * NOTE! currently the only user is cputime_adjust() and thus
+ *
+ *	stime < total && rtime > total
+ *
+ * this means that the end result is always precise and the additional
+ * div64_u64_rem() inside the main loop is called at most once.
  */
 static u64 scale_stime(u64 stime, u64 rtime, u64 total)
 {
-	u64 scaled;
+	u64 res = 0, div, rem;
 
-	for (;;) {
-		/* Make sure "rtime" is the bigger of stime/rtime */
+	/* can stime * rtime overflow ? */
+	while (ilog2(stime) + ilog2(rtime) > 62) {
 		if (stime > rtime)
 			swap(rtime, stime);
 
-		/* Make sure 'total' fits in 32 bits */
-		if (total >> 32)
-			goto drop_precision;
-
-		/* Does rtime (and thus stime) fit in 32 bits? */
-		if (!(rtime >> 32))
-			break;
-
-		/* Can we just balance rtime/stime rather than dropping bits? */
-		if (stime >> 31)
-			goto drop_precision;
-
-		/* We can grow stime and shrink rtime and try to make them both fit */
-		stime <<= 1;
-		rtime >>= 1;
-		continue;
+		if (rtime >= total) {
+			/*
+			 * (rtime * stime) / total is equal to
+			 *
+			 *	(rtime / total) * stime +
+			 *	(rtime % total) * stime / total
+			 *
+			 * if nothing overflows. Can the 1st multiplication
+			 * overflow? Yes, but we do not care: this can only
+			 * happen if the end result can't fit in u64 anyway.
+			 *
+			 * So the code below does
+			 *
+			 *	res += (rtime / total) * stime;
+			 *	rtime = rtime % total;
+			 */
+			div = div64_u64_rem(rtime, total, &rem);
+			res += div * stime;
+			rtime = rem;
+			continue;
+		}
 
-drop_precision:
-		/* We drop from rtime, it has more bits than stime */
+		/* drop precision */
 		rtime >>= 1;
 		total >>= 1;
+		if (!total)
+			return res;
 	}
 
-	/*
-	 * Make sure gcc understands that this is a 32x32->64 multiply,
-	 * followed by a 64/32->64 divide.
-	 */
-	scaled = div_u64((u64) (u32) stime * (u64) (u32) rtime, (u32)total);
-	return scaled;
+	return res + div64_u64(stime * rtime, total);
 }
 
 /*
-- 
2.5.0


