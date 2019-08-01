Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA8C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A458206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pWJVHDgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbfHATHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:07:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfHATHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:07:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J71MV071392
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:07:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J71MV071392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686421;
        bh=/D0Uw0UCGxNsgjNO5hBuMC6mBXZzX4LZ5XVgmAgwfR0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pWJVHDgsc7O/xYeaUWYZGASfp+fYBhmahquM8hBbWZSNwd7HyLObPLio4dmMn+TCv
         lG81q4egMXbKmGeoeaDqVgUT1nGkUMIrPjXlh6wsoi++rrXoCgqH9RlhZQPdHxURn8
         Bw8C63nluvRo7/YzLCVdXb1KEByUNvrckYdP689+MDrfdqG6VOih/pDhezCwitJYB7
         FVPb0HxfV80ptDC2rBemOYFzQP+M0+ysmxQwOgaRGFhMQhgwk216zneOPJ9W+m3ItI
         FvtfcfH2/K7+mp67Bz6tBakpgkXkaeIXYXIZRmMptY1mKfJ9Q6IfMyHbNalz1ZmoC0
         9SXhHBTLxanDA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J70tH071386;
        Thu, 1 Aug 2019 12:07:00 -0700
Date:   Thu, 1 Aug 2019 12:07:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-a125ecc16453a4fe0ba865c7df87b9c722991fdf@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de,
        anna-maria@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de,
          mingo@kernel.org, anna-maria@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190730223828.600085866@linutronix.de>
References: <20190730223828.600085866@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timerfd: Prepare for PREEMPT_RT
Git-Commit-ID: a125ecc16453a4fe0ba865c7df87b9c722991fdf
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

Commit-ID:  a125ecc16453a4fe0ba865c7df87b9c722991fdf
Gitweb:     https://git.kernel.org/tip/a125ecc16453a4fe0ba865c7df87b9c722991fdf
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:50 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:23 +0200

timerfd: Prepare for PREEMPT_RT

Use the hrtimer_cancel_wait_running() synchronization mechanism to prevent
priority inversion and live locks on PREEMPT_RT.

[ tglx: Split out of combo patch ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190730223828.600085866@linutronix.de


---
 fs/timerfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 6a6fc8aa1de7..48305ba41e3c 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -471,7 +471,11 @@ static int do_timerfd_settime(int ufd, int flags,
 				break;
 		}
 		spin_unlock_irq(&ctx->wqh.lock);
-		cpu_relax();
+
+		if (isalarm(ctx))
+			hrtimer_cancel_wait_running(&ctx->t.alarm.timer);
+		else
+			hrtimer_cancel_wait_running(&ctx->t.tmr);
 	}
 
 	/*
