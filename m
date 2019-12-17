Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3685C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82ECA206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfLQBBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:01:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34470 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbfLQAva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:51:30 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1ih15D-0003IO-Mj; Tue, 17 Dec 2019 00:51:27 +0000
Received: from ben by deadeye with local (Exim 4.93-RC7)
        (envelope-from <ben@decadent.org.uk>)
        id 1ih15C-0005RP-Uc; Tue, 17 Dec 2019 00:51:26 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Preeti U Murthy" <preeti@linux.vnet.ibm.com>,
        "Marcelo Tosatti" <mtosatti@redhat.com>
Date:   Tue, 17 Dec 2019 00:45:36 +0000
Message-ID: <lsq.1576543535.485273153@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 002/136] tick: broadcast-hrtimer: Remove overly
 clever return value abuse
In-Reply-To: <lsq.1576543534.33060804@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.80-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b8a62f1ff0ccb18fdc25c6150d1cd394610f4753 upstream.

The assignment of bc_moved in the conditional construct relies on the
fact that in the case of hrtimer_start() invocation the return value
is always 0. It took me a while to understand it.

We want to get rid of the hrtimer_start() return value. Open code the
logic which makes it readable as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/r/20150414203503.404751457@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16 to ease backporting commit b9023b91dd02
 "tick: broadcast-hrtimer: Fix a race in bc_set_next"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/time/tick-broadcast-hrtimer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -66,9 +66,11 @@ static int bc_set_next(ktime_t expires,
 	 * hrtimer_{start/cancel} functions call into tracing,
 	 * calls to these functions must be bound within RCU_NONIDLE.
 	 */
-	RCU_NONIDLE(bc_moved = (hrtimer_try_to_cancel(&bctimer) >= 0) ?
-		!hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED) :
-			0);
+	RCU_NONIDLE({
+			bc_moved = hrtimer_try_to_cancel(&bctimer) >= 0;
+			if (bc_moved)
+				hrtimer_start(&bctimer, expires,
+					      HRTIMER_MODE_ABS_PINNED);});
 	if (bc_moved) {
 		/* Bind the "device" to the cpu */
 		bc->bound_on = smp_processor_id();

