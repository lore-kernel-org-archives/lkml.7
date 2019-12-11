Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3664C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8369E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfLKGQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 01:16:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42570 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLKGQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:16:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ievHy-0002WE-K0; Wed, 11 Dec 2019 07:15:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 32F801C287E;
        Wed, 11 Dec 2019 07:15:58 +0100 (CET)
Date:   Wed, 11 Dec 2019 06:15:57 -0000
From:   "tip-bot2 for Flavio Leitner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/cputime, proc/stat: Fix incorrect guest
 nice cpustat value
Cc:     Flavio Leitner <fbl@sysclose.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191205020344.14940-1-frederic@kernel.org>
References: <20191205020344.14940-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157604495799.30329.13726573688253240256.tip-bot2@tip-bot2>
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

Commit-ID:     346da4d2c7ea39de65487b249aaa4733317a40ec
Gitweb:        https://git.kernel.org/tip/346da4d2c7ea39de65487b249aaa4733317a40ec
Author:        Flavio Leitner <fbl@sysclose.org>
AuthorDate:    Thu, 05 Dec 2019 03:03:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 11 Dec 2019 07:09:58 +01:00

sched/cputime, proc/stat: Fix incorrect guest nice cpustat value

The value being used for guest_nice should be CPUTIME_GUEST_NICE
and not CPUTIME_USER.

Fixes: 26dae145a76c ("procfs: Use all-in-one vtime aware kcpustat accessor")
Signed-off-by: Flavio Leitner <fbl@sysclose.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191205020344.14940-1-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/proc/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 37bdbec..fd931d3 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -134,7 +134,7 @@ static int show_stat(struct seq_file *p, void *v)
 		softirq		+= cpustat[CPUTIME_SOFTIRQ];
 		steal		+= cpustat[CPUTIME_STEAL];
 		guest		+= cpustat[CPUTIME_GUEST];
-		guest_nice	+= cpustat[CPUTIME_USER];
+		guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
 		sum		+= kstat_cpu_irqs_sum(i);
 		sum		+= arch_irq_stat_cpu(i);
 
@@ -175,7 +175,7 @@ static int show_stat(struct seq_file *p, void *v)
 		softirq		= cpustat[CPUTIME_SOFTIRQ];
 		steal		= cpustat[CPUTIME_STEAL];
 		guest		= cpustat[CPUTIME_GUEST];
-		guest_nice	= cpustat[CPUTIME_USER];
+		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
