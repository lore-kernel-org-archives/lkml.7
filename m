Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7C2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D33206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aJJ1JTnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfHATHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:07:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfHATHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:07:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J7irB071439
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:07:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J7irB071439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686465;
        bh=E/20MrLzTLVJSaghRrZ9fyTvR1Rn0kg+sQhIR9d4Ozw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aJJ1JTnIIQ7aApDgGqb8SXUOeRx/SrToa+E+lWaTnWsCxdwN0KpvL43ZgqrqgeJJS
         hKYBOfQFofD8v6jUU4Q/m0A8PlcOfLrSCy2QFlWAOBW/hTJ7CpSQBZtua4ghcissTg
         N1+Nia6tK0O289ZP7NjkTSTXgfbNf0nkev5Xa9Zo8nL29a16kUeNSwNkCqfCdSzost
         AjhV84F6DhZWJFsTYzlCM4NtyGgO4d4l9msstdHGlCFkDoTHDbqhxTXdAjDxk1mMNW
         aPrGnF8E6USxLJGRnn9PrF+GaRKWSdTVrp/WEwICiIKmTM9TbGLpZSDIHefuy/Go/f
         uo+hFOY81G1kw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J7hCs071436;
        Thu, 1 Aug 2019 12:07:43 -0700
Date:   Thu, 1 Aug 2019 12:07:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-c7e6d704a0097e59667495cf52dcc4e1085e620b@git.kernel.org>
Cc:     peterz@infradead.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        anna-maria@linutronix.de, hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          mingo@kernel.org, anna-maria@linutronix.de
In-Reply-To: <20190730223828.690771827@linutronix.de>
References: <20190730223828.690771827@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] itimers: Prepare for PREEMPT_RT
Git-Commit-ID: c7e6d704a0097e59667495cf52dcc4e1085e620b
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

Commit-ID:  c7e6d704a0097e59667495cf52dcc4e1085e620b
Gitweb:     https://git.kernel.org/tip/c7e6d704a0097e59667495cf52dcc4e1085e620b
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:24 +0200

itimers: Prepare for PREEMPT_RT

Use the hrtimer_cancel_wait_running() synchronization mechanism to prevent
priority inversion and live locks on PREEMPT_RT.

As a benefit the retry loop gains the missing cpu_relax() on !RT.

[ tglx: Split out of combo patch ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190730223828.690771827@linutronix.de


---
 kernel/time/itimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 02068b2d5862..9d26fd4ba4c0 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -213,6 +213,7 @@ again:
 		/* We are sharing ->siglock with it_real_fn() */
 		if (hrtimer_try_to_cancel(timer) < 0) {
 			spin_unlock_irq(&tsk->sighand->siglock);
+			hrtimer_cancel_wait_running(timer);
 			goto again;
 		}
 		expires = timeval_to_ktime(value->it_value);
