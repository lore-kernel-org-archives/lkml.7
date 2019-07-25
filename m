Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C85DC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B84218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="coojm5Oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfGYQRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:17:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfGYQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:17:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGHVIQ1075304
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:17:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGHVIQ1075304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071452;
        bh=st3obXGHa7UGavDjAsr6yooXSLYLwEddQ6y7fGDZon4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=coojm5OeGjMLn/RmrJV96w4qgZiVJRN+PwKfhQHbe9/17IhkT2G3jg6qFlyPop1y1
         VV715OjYocbZBRWbKIvq9oA5T3OzQv2iCdSuRP9/jhBkXv36gGfLyUmDTxh1/fYxPw
         Ogf2I/RiQ9z9foXjALkKG8JPyVOsVbQ/jiKVl/JXKZ37Ze6SBC6Fshrp4V0NFmSMuC
         i+dXasS0LQmD+p0/Rf4woaMkle/twMCpXFhjDd1nk7bXHpt6OLb6HuqrKqm1RtqvkP
         RLGlwtf1b0SqJCPxYeouGE3iel2Vh8SL7DNVgaX68BbLlolmAxHPC7nLe6lUJRE4bD
         3fCVebpeGmY/w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGHUI61075300;
        Thu, 25 Jul 2019 09:17:30 -0700
Date:   Thu, 25 Jul 2019 09:17:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Wang <tipbot@zytor.com>
Message-ID: <tip-65d74e91694e1afac40c96fb64a9ef120757729e@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, wang.yi59@zte.com.cn,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, peterz@infradead.org, wang.yi59@zte.com.cn,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1562301307-43002-1-git-send-email-wang.yi59@zte.com.cn>
References: <1562301307-43002-1-git-send-email-wang.yi59@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/stats: Fix unlikely() use of sched_info_on()
Git-Commit-ID: 65d74e91694e1afac40c96fb64a9ef120757729e
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

Commit-ID:  65d74e91694e1afac40c96fb64a9ef120757729e
Gitweb:     https://git.kernel.org/tip/65d74e91694e1afac40c96fb64a9ef120757729e
Author:     Yi Wang <wang.yi59@zte.com.cn>
AuthorDate: Fri, 5 Jul 2019 12:35:07 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:55 +0200

sched/stats: Fix unlikely() use of sched_info_on()

sched_info_on() is called with unlikely hint, however, the test
is to be a constant(1) on which compiler will do nothing when
make defconfig, so remove the hint.

Also, fix a lack of {}.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: up2wing@gmail.com
Cc: wang.liang82@zte.com.cn
Cc: xue.zhihong@zte.com.cn
Link: https://lkml.kernel.org/r/1562301307-43002-1-git-send-email-wang.yi59@zte.com.cn
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/stats.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index aa0de240fb41..ba683fe81a6e 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -157,9 +157,10 @@ static inline void sched_info_dequeued(struct rq *rq, struct task_struct *t)
 {
 	unsigned long long now = rq_clock(rq), delta = 0;
 
-	if (unlikely(sched_info_on()))
+	if (sched_info_on()) {
 		if (t->sched_info.last_queued)
 			delta = now - t->sched_info.last_queued;
+	}
 	sched_info_reset_dequeued(t);
 	t->sched_info.run_delay += delta;
 
@@ -192,7 +193,7 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
  */
 static inline void sched_info_queued(struct rq *rq, struct task_struct *t)
 {
-	if (unlikely(sched_info_on())) {
+	if (sched_info_on()) {
 		if (!t->sched_info.last_queued)
 			t->sched_info.last_queued = rq_clock(rq);
 	}
@@ -239,7 +240,7 @@ __sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct
 static inline void
 sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
-	if (unlikely(sched_info_on()))
+	if (sched_info_on())
 		__sched_info_switch(rq, prev, next);
 }
 
