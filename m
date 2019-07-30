Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E0CC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15620205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wg7PDTVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfG3WKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:10:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfG3WKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:10:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMARJb3398074
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:10:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMARJb3398074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564524628;
        bh=Hzp4h0qY979ITDmjmeXOkosx3IHSUzZiQE90FPuXXfo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wg7PDTVGvBEMaElS1YiQeto3D2H3lqXSMohDFamOGI9c0+AxCuCEYLhJbUDPShtwZ
         TJdqC6j9M0zoVc2QQWWBDakvniFZr7kZ9TJpZqdbGDDkZdqvIAoq8aZgjiLAGiAUzX
         w49HL02j0qWr7uQL665cLWmEEfuee2T4Daw8mw75qTxFYvei91aiEtOl5E84J9NJhw
         dKFYts55wuXiKZ91UtWQ/oXPEC2IlEK47pTTrZe87sEpBuHsbI+6Kf5DW9NsQx/55c
         cueiLYbheiKT/oSbe5cPyzHQs7ogLfPjL1o0pUlsCCA39wUimT7oDi+D/Bg6mLhp+a
         Wsr+JTuI9rl2Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMARDh3398071;
        Tue, 30 Jul 2019 15:10:27 -0700
Date:   Tue, 30 Jul 2019 15:10:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-b04b3857625d7d91fd11fcc39da138d7602bfadd@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, bigeasy@linutronix.de, tglx@linutronix.de,
          hpa@zytor.com, peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190726185752.981398465@linutronix.de>
References: <20190726185752.981398465@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Introduce HARD expiry mode
Git-Commit-ID: b04b3857625d7d91fd11fcc39da138d7602bfadd
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

Commit-ID:  b04b3857625d7d91fd11fcc39da138d7602bfadd
Gitweb:     https://git.kernel.org/tip/b04b3857625d7d91fd11fcc39da138d7602bfadd
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jul 2019 23:57:53 +0200

hrtimer: Introduce HARD expiry mode

On PREEMPT_RT not all hrtimers can be expired in hard interrupt context
even if that is perfectly fine on a PREEMPT_RT=n kernel, e.g. because they
take regular spinlocks. Also for latency reasons PREEMPT_RT tries to defer
most hrtimers' expiry into soft interrupt context.

But there are hrtimers which must be expired in hard interrupt context even
when PREEMPT_RT is enabled:

  - hrtimers which must expiry in hard interrupt context, e.g. scheduler,
    perf, watchdog related hrtimers

  - latency critical hrtimers, e.g. nanosleep, ..., kvm lapic timer

Add a new mode flag HRTIMER_MODE_HARD which allows to mark these timers so
PREEMPT_RT will not move them into softirq expiry mode.

[ tglx: Split out of a larger combo patch. Added changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185752.981398465@linutronix.de

---
 include/linux/hrtimer.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 24072a0942c0..15c2ba6b6316 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -38,6 +38,7 @@ enum hrtimer_mode {
 	HRTIMER_MODE_REL	= 0x01,
 	HRTIMER_MODE_PINNED	= 0x02,
 	HRTIMER_MODE_SOFT	= 0x04,
+	HRTIMER_MODE_HARD	= 0x08,
 
 	HRTIMER_MODE_ABS_PINNED = HRTIMER_MODE_ABS | HRTIMER_MODE_PINNED,
 	HRTIMER_MODE_REL_PINNED = HRTIMER_MODE_REL | HRTIMER_MODE_PINNED,
@@ -48,6 +49,11 @@ enum hrtimer_mode {
 	HRTIMER_MODE_ABS_PINNED_SOFT = HRTIMER_MODE_ABS_PINNED | HRTIMER_MODE_SOFT,
 	HRTIMER_MODE_REL_PINNED_SOFT = HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_SOFT,
 
+	HRTIMER_MODE_ABS_HARD	= HRTIMER_MODE_ABS | HRTIMER_MODE_HARD,
+	HRTIMER_MODE_REL_HARD	= HRTIMER_MODE_REL | HRTIMER_MODE_HARD,
+
+	HRTIMER_MODE_ABS_PINNED_HARD = HRTIMER_MODE_ABS_PINNED | HRTIMER_MODE_HARD,
+	HRTIMER_MODE_REL_PINNED_HARD = HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_HARD,
 };
 
 /*
