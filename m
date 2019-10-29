Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31173CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDC22087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbfJ2JxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:53:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47818 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733025AbfJ2Jwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAl-0004MJ-JP; Tue, 29 Oct 2019 10:52:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 37B941C047B;
        Tue, 29 Oct 2019 10:52:19 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:18 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] procfs: Use vtime aware kcpustat accessor to fetch
 CPUTIME_SYSTEM
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016025700.31277-13-frederic@kernel.org>
References: <20191016025700.31277-13-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234273896.29376.11755922776360357059.tip-bot2@tip-bot2>
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

Commit-ID:     ae37fe5c07508e1c3dcdd41c9127e5d50d31013d
Gitweb:        https://git.kernel.org/tip/ae37fe5c07508e1c3dcdd41c9127e5d50d31013d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:17 +01:00

procfs: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM

Now that we have a vtime safe kcpustat accessor for CPUTIME_SYSTEM, use
it to start fixing frozen kcpustat values on nohz_full CPUs.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rjw@rjwysocki.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Link: https://lkml.kernel.org/r/20191016025700.31277-13-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/proc/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 80c305f..5c6bd0a 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -124,7 +124,7 @@ static int show_stat(struct seq_file *p, void *v)
 
 		user += kcs->cpustat[CPUTIME_USER];
 		nice += kcs->cpustat[CPUTIME_NICE];
-		system += kcs->cpustat[CPUTIME_SYSTEM];
+		system += kcpustat_field(kcs, CPUTIME_SYSTEM, i);
 		idle += get_idle_time(kcs, i);
 		iowait += get_iowait_time(kcs, i);
 		irq += kcs->cpustat[CPUTIME_IRQ];
@@ -162,7 +162,7 @@ static int show_stat(struct seq_file *p, void *v)
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user = kcs->cpustat[CPUTIME_USER];
 		nice = kcs->cpustat[CPUTIME_NICE];
-		system = kcs->cpustat[CPUTIME_SYSTEM];
+		system = kcpustat_field(kcs, CPUTIME_SYSTEM, i);
 		idle = get_idle_time(kcs, i);
 		iowait = get_iowait_time(kcs, i);
 		irq = kcs->cpustat[CPUTIME_IRQ];
