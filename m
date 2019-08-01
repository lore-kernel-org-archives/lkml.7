Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3283EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C779E2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yKAMATln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfHAQGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:06:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHAQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:06:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71G6Uwp009849
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 09:06:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71G6Uwp009849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564675591;
        bh=IiKDc4/LOhPS4RFSbD+hymAIvgPezjbz1TH/eRCCNWs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yKAMATlnjAy9ptzq1FNR2PIRTgxwUPAcneJnJPI6/bCnJNKduN8pJYSfqwyc6rlFP
         fTQ4MhXsJFHspPidFr9c4rA6y3q40szdPnVZlxRV1fxhEazV+228B0wAz+RNmvM+jm
         emkJEFDcSeJZO9mouC5D3RnDUO+QyqTiB1O1H1oMJsybij5YBttThRV4A5E7R7NWDE
         Qx8U619dCdooG5pBSL0HlB+hZ675fFcUcV0FkzGf4t6MwJrLHCSL3ImZYFcH8ooaG6
         THVPG78Xv6bVkWRFf+tALR2BNWDOZtdCyMKY1lj2a0RiCncExgsixtgnSHaFt+tyH7
         SCJgNxg+Tx2Rg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71G6Tnn009844;
        Thu, 1 Aug 2019 09:06:29 -0700
Date:   Thu, 1 Aug 2019 09:06:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-b0ccc6eb0d7e0b7d346b118ccc8b38bf18e39b7f@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
        peterz@infradead.org
Reply-To: anna-maria@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190730223828.782664411@linutronix.de>
References: <20190730223828.782664411@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Cleanup the flag/flags confusion
Git-Commit-ID: b0ccc6eb0d7e0b7d346b118ccc8b38bf18e39b7f
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

Commit-ID:  b0ccc6eb0d7e0b7d346b118ccc8b38bf18e39b7f
Gitweb:     https://git.kernel.org/tip/b0ccc6eb0d7e0b7d346b118ccc8b38bf18e39b7f
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:46:42 +0200

posix-timers: Cleanup the flag/flags confusion

do_timer_settime() has a 'flags' argument and uses 'flag' for the interrupt
flags, which is confusing at best.

Rename the argument so 'flags' can be used for interrupt flags as usual.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190730223828.782664411@linutronix.de

---
 kernel/time/posix-timers.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d7f2d91acdac..f5aedd2f60df 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -844,13 +844,13 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	return 0;
 }
 
-static int do_timer_settime(timer_t timer_id, int flags,
+static int do_timer_settime(timer_t timer_id, int tmr_flags,
 			    struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
 	const struct k_clock *kc;
 	struct k_itimer *timr;
-	unsigned long flag;
+	unsigned long flags;
 	int error = 0;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
@@ -860,7 +860,7 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 retry:
-	timr = lock_timer(timer_id, &flag);
+	timr = lock_timer(timer_id, &flags);
 	if (!timr)
 		return -EINVAL;
 
@@ -868,9 +868,9 @@ retry:
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
 	else
-		error = kc->timer_set(timr, flags, new_spec64, old_spec64);
+		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
 
-	unlock_timer(timr, flag);
+	unlock_timer(timr, flags);
 	if (error == TIMER_RETRY) {
 		old_spec64 = NULL;	// We already got the old time...
 		goto retry;
