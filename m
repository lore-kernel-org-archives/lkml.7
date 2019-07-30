Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E9EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7016C204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="w9EAKXX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfG3WNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:13:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfG3WNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:13:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMDTvT3398484
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:13:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMDTvT3398484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564524810;
        bh=ys10qE4WEsPZO7KAJEp2LXeIFxeiAzXgX/3H0wsD2xs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=w9EAKXX0bRofbRzGDFN9AjeUmSHTIYc5URQ8AYyFOhgBBojDaYF0qNW9Hu7mzdZxk
         sev+bd/aahO4oBe183X0vDzUVJUv2LzPkVgXGykZ5NqRPG3/jSGC3wq0PMzDWo1Q4S
         1hMFg3VfBUztKCi2y3Zqa3RLyup201hW/r2g1A29l8P4XEppGBILZE2ZiUCFu9szvs
         JQGD9F3XnvsTTYS+W6sVE+tGbCbDWQEuMZFQRWUKg9wLAP9CZkfDipAvEEJVh868VQ
         X9qa3eISCw2JlprpGszj4voJSn8/KP/pJcGKqfY4uwPczM2GpwA2dTcZtL+m7Wvn6V
         4CmwUpTenrpSg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMDTiT3398481;
        Tue, 30 Jul 2019 15:13:29 -0700
Date:   Tue, 30 Jul 2019 15:13:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-2c6db53c4b4a52012e644f1f50bcc958c87f046a@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, bigeasy@linutronix.de, peterz@infradead.org
In-Reply-To: <20190726185753.262895510@linutronix.de>
References: <20190726185753.262895510@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] watchdog: Mark watchdog_hrtimer to expire in hard
 interrupt context
Git-Commit-ID: 2c6db53c4b4a52012e644f1f50bcc958c87f046a
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

Commit-ID:  2c6db53c4b4a52012e644f1f50bcc958c87f046a
Gitweb:     https://git.kernel.org/tip/2c6db53c4b4a52012e644f1f50bcc958c87f046a
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jul 2019 23:57:55 +0200

watchdog: Mark watchdog_hrtimer to expire in hard interrupt context

The watchdog hrtimer must expire in hard interrupt context even on
PREEMPT_RT=y kernels as otherwise the hard/softlockup detection logic would
not work.

No functional change.

[ tglx: Split out from larger combo patch. Added changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.262895510@linutronix.de

---
 kernel/watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f9e7b9306fe..f41334ef0971 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -490,10 +490,10 @@ static void watchdog_enable(unsigned int cpu)
 	 * Start the timer first to prevent the NMI watchdog triggering
 	 * before the timer has a chance to fire.
 	 */
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	hrtimer->function = watchdog_timer_fn;
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 
 	/* Initialize timestamp */
 	__touch_watchdog();
