Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E371C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EABB206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="T+//7okF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfHAPwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:52:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfHAPwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:52:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71FqFqu005035
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 08:52:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71FqFqu005035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564674735;
        bh=V81xyc1CKtZZ0EXikPqyhZhJimH7JUJHZlBrjH8C1qE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=T+//7okFVJ6B/CZSScoFc+A9vYpe8ZeTl+zZPOpPH/5rc7+L5SqKKj6Qp6HO9JvK6
         iz6thKXN2z1pJMuVgo0uCF3v92mcbBerB0TTraL9LboMjayoYimknrGU/99U8iuCPz
         KXo36mw5IWHOWY/bOSR/o9bJlfmbDazKYcPVZ0F2onDv9b2htAT0tw9wqGX/czmBVV
         jtI+8RuNzmkQzdPRAwGahnWXJYTW0m0yNcJSGev4dIOFAL1bdEqx3iqI5Lnp9LcJ5e
         EQieK03b6OvHNFLljPdPAvsID8jVqBPBOPknRleTD3Ia8eMEN29Y1q33UlgsOvw0bj
         LoFs5YMtEbR2A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71FqExN005032;
        Thu, 1 Aug 2019 08:52:14 -0700
Date:   Thu, 1 Aug 2019 08:52:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-ae6683d815895c2be1e60e1942630fa99488055b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          bigeasy@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190726185752.981398465@linutronix.de>
References: <20190726185752.981398465@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Introduce HARD expiry mode
Git-Commit-ID: ae6683d815895c2be1e60e1942630fa99488055b
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

Commit-ID:  ae6683d815895c2be1e60e1942630fa99488055b
Gitweb:     https://git.kernel.org/tip/ae6683d815895c2be1e60e1942630fa99488055b
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:43:16 +0200

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
