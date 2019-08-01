Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAC6C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F327520B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ag+oZXRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfHAQ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:26:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56535 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731751AbfHAQ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:26:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71FvRNQ006132
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 08:57:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71FvRNQ006132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564675048;
        bh=tqG6uf1LTHRhGWfpbJJjcy8tDR/Y6YbbAiLd3AAvQvg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ag+oZXRfuKa/UiwKrSCHOCrzQhZwLYapW2eoTxp7Wz2ocdqHb+tSQTx/usGV3RJ0n
         gM4Js0fBHzjPNKkmg776PDBPnWX5p9EFK+7/+twEeR7xfSuYW+eEcu5fENpm9a+2dO
         SLrD8Wsn/LtQiWbKJL4QWSsm9YlOZdnLOXUvMIakBjEpB6e3XOBkfYqD8QpQs2+315
         9ndpG7lPb89b8yjgh6sfR6hhAkgvCvyNrNEmJqJooMYYxhWD2NdEBXHiBrcKbMStkR
         U8ayDK7ZoZJ6YIgivRlxhFi2j1LM53EHPURbgLvoZAMchiOL4exjE43EFCzK5zkJRa
         UZUjZ1XFpuAlw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71FvRaY006128;
        Thu, 1 Aug 2019 08:57:27 -0700
Date:   Thu, 1 Aug 2019 08:57:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-edd2f987491fb47949a9612743435d6d0f61f614@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          bigeasy@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190726185753.551967692@linutronix.de>
References: <20190726185753.551967692@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Move unmarked hrtimers to soft interrupt
 expiry on RT
Git-Commit-ID: edd2f987491fb47949a9612743435d6d0f61f614
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

Commit-ID:  edd2f987491fb47949a9612743435d6d0f61f614
Gitweb:     https://git.kernel.org/tip/edd2f987491fb47949a9612743435d6d0f61f614
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:43:19 +0200

hrtimer: Move unmarked hrtimers to soft interrupt expiry on RT

On PREEMPT_RT not all hrtimers can be expired in hard interrupt context
even if that is perfectly fine on a PREEMPT_RT=n kernel, e.g. because they
take regular spinlocks. Also for latency reasons PREEMPT_RT tries to defer
most hrtimers' expiry into softirq context.

hrtimers marked with HRTIMER_MODE_HARD must be kept in hard interrupt
context expiry mode. Add the required logic.

No functional change for PREEMPT_RT=n kernels.

[ tglx: Split out of a larger combo patch. Added changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.551967692@linutronix.de


---
 kernel/time/hrtimer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ace301a56f4..90dcc4d95e91 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1275,8 +1275,17 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
-	int base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	struct hrtimer_cpu_base *cpu_base;
+	int base;
+
+	/*
+	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
+	 * marked for hard interrupt expiry mode are moved into soft
+	 * interrupt context for latency reasons and because the callbacks
+	 * can invoke functions which might sleep on RT, e.g. spin_lock().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(mode & HRTIMER_MODE_HARD))
+		softtimer = true;
 
 	memset(timer, 0, sizeof(struct hrtimer));
 
@@ -1290,6 +1299,7 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	if (clock_id == CLOCK_REALTIME && mode & HRTIMER_MODE_REL)
 		clock_id = CLOCK_MONOTONIC;
 
+	base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
 	timer->is_hard = !softtimer;
