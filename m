Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3550C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF40D23404
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389915AbfHWCMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:12:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389311AbfHWCMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z3o-0000wk-3P; Fri, 23 Aug 2019 04:12:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BF6CF1C0883;
        Fri, 23 Aug 2019 04:12:15 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:15 -0000
From:   tip-bot2 for Julien Grall <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Protect lockless access to timer->base
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Julien Grall <julien.grall@arm.com>
In-Reply-To: <20190821092409.13225-2-julien.grall@arm.com>
References: <20190821092409.13225-2-julien.grall@arm.com>
MIME-Version: 1.0
Message-ID: <156652633563.11652.10492988947576826957.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dd2261ed45aaeddeb77768f291d604179bcab096
Gitweb:        https://git.kernel.org/tip/dd2261ed45aaeddeb77768f291d604179bcab096
Author:        Julien Grall <julien.grall@arm.com>
AuthorDate:    Wed, 21 Aug 2019 10:24:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 Aug 2019 16:10:01 +02:00

hrtimer: Protect lockless access to timer->base

The update to timer->base is protected by the base->cpu_base->lock().
However, hrtimer_cancel_wait_running() does access it lockless.  So the
compiler is allowed to refetch timer->base which can cause havoc when the
timer base is changed concurrently.

Use READ_ONCE() to prevent this.

[ tglx: Adapted from a RT patch ]

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190821092409.13225-2-julien.grall@arm.com
---
 kernel/time/hrtimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8333537..f48864e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1214,7 +1214,8 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
  */
 void hrtimer_cancel_wait_running(const struct hrtimer *timer)
 {
-	struct hrtimer_clock_base *base = timer->base;
+	/* Lockless read. Prevent the compiler from reloading it below */
+	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
 	if (!timer->is_soft || !base || !base->cpu_base) {
 		cpu_relax();
