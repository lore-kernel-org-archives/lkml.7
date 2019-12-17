Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4330C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CA721582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfLQMkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:40:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55265 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfLQMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:40:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8m-0001oW-Dw; Tue, 17 Dec 2019 13:39:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 922521C2A3B;
        Tue, 17 Dec 2019 13:39:51 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:51 -0000
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] psi: Fix a division error in psi poll()
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jingfeng Xie <xiejingfeng@linux.alibaba.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191203183524.41378-3-hannes@cmpxchg.org>
References: <20191203183524.41378-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <157658639149.30329.11554714780751480566.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c3466952ca1514158d7c16c9cfc48c27d5c5dc0f
Gitweb:        https://git.kernel.org/tip/c3466952ca1514158d7c16c9cfc48c27d5c5dc0f
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Tue, 03 Dec 2019 13:35:24 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:48 +01:00

psi: Fix a division error in psi poll()

The psi window size is a u64 an can be up to 10 seconds right now,
which exceeds the lower 32 bits of the variable. We currently use
div_u64 for it, which is meant only for 32-bit divisors. The result is
garbage pressure sampling values and even potential div0 crashes.

Use div64_u64.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: Jingfeng Xie <xiejingfeng@linux.alibaba.com>
Link: https://lkml.kernel.org/r/20191203183524.41378-3-hannes@cmpxchg.org
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 970db46..ce8f674 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -482,7 +482,7 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 		u32 remaining;
 
 		remaining = win->size - elapsed;
-		growth += div_u64(win->prev_growth * remaining, win->size);
+		growth += div64_u64(win->prev_growth * remaining, win->size);
 	}
 
 	return growth;
