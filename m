Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DEDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8887020818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKKJdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:33:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55838 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKKJdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:33:03 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU63n-00038m-9p; Mon, 11 Nov 2019 10:32:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E0F6D1C03AB;
        Mon, 11 Nov 2019 10:32:34 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:32:34 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use mul_u32_u32()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        ktkhai@virtuozzo.com, mgorman@suse.de, qais.yousef@arm.com,
        qperret@google.com, rostedt@goodmis.org,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108131909.717931380@infradead.org>
References: <20191108131909.717931380@infradead.org>
MIME-Version: 1.0
Message-ID: <157346475453.29376.12759548199068622692.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2eeb01a28c9233333bf229a5b4b0559f4bd22b52
Gitweb:        https://git.kernel.org/tip/2eeb01a28c9233333bf229a5b4b0559f4bd22b52
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Nov 2019 14:15:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 08:35:20 +01:00

sched/fair: Use mul_u32_u32()

While reading the code I encountered another site where we should be
using mul_u32_u32() because GCC just won't take a hint.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bsegall@google.com
Cc: dietmar.eggemann@arm.com
Cc: juri.lelli@redhat.com
Cc: ktkhai@virtuozzo.com
Cc: mgorman@suse.de
Cc: qais.yousef@arm.com
Cc: qperret@google.com
Cc: rostedt@goodmis.org
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20191108131909.717931380@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1789193..ba97d1a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -229,8 +229,7 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
 		}
 	}
 
-	/* hint to use a 32x32->64 mul */
-	fact = (u64)(u32)fact * lw->inv_weight;
+	fact = mul_u32_u32(fact, lw->inv_weight);
 
 	while (fact >> 32) {
 		fact >>= 1;
