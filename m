Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBA421900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfCVNTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:19:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45577 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfCVNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:19:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MDJKeB591917
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 06:19:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MDJJBT591914;
        Fri, 22 Mar 2019 06:19:19 -0700
Date:   Fri, 22 Mar 2019 06:19:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-0f0b7e1cc7abf8e1a8b301f2868379d611d05ae2@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          juri.lelli@redhat.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190307120913.13168-1-juri.lelli@redhat.com>
References: <20190307120913.13168-1-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Add option to disable tsc clocksource
 watchdog
Git-Commit-ID: 0f0b7e1cc7abf8e1a8b301f2868379d611d05ae2
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

Commit-ID:  0f0b7e1cc7abf8e1a8b301f2868379d611d05ae2
Gitweb:     https://git.kernel.org/tip/0f0b7e1cc7abf8e1a8b301f2868379d611d05ae2
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Thu, 7 Mar 2019 13:09:13 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 14:14:58 +0100

x86/tsc: Add option to disable tsc clocksource watchdog

Clocksource watchdog has been found responsible for generating latency
spikes (in the 10-20 us range) when woken up to check for TSC stability.

Add an option to disable it at boot.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bigeasy@linutronix.de
Cc: linux-rt-users@vger.kernel.org
Cc: peterz@infradead.org
Cc: bristot@redhat.com
Cc: williams@redhat.com
Link: https://lkml.kernel.org/r/20190307120913.13168-1-juri.lelli@redhat.com

---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 arch/x86/kernel/tsc.c                           | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..c4d830003b21 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4703,6 +4703,10 @@
 			[x86] unstable: mark the TSC clocksource as unstable, this
 			marks the TSC unconditionally unstable at bootup and
 			avoids any further wobbles once the TSC watchdog notices.
+			[x86] nowatchdog: disable clocksource watchdog. Used
+			in situations with strict latency requirements (where
+			interruptions from clocksource watchdog are not
+			acceptable).
 
 	turbografx.map[2|3]=	[HW,JOY]
 			TurboGraFX parallel port interface
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3fae23834069..aab0c82e0a0d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -283,6 +283,7 @@ int __init notsc_setup(char *str)
 __setup("notsc", notsc_setup);
 
 static int no_sched_irq_time;
+static int no_tsc_watchdog;
 
 static int __init tsc_setup(char *str)
 {
@@ -292,6 +293,8 @@ static int __init tsc_setup(char *str)
 		no_sched_irq_time = 1;
 	if (!strcmp(str, "unstable"))
 		mark_tsc_unstable("boot parameter");
+	if (!strcmp(str, "nowatchdog"))
+		no_tsc_watchdog = 1;
 	return 1;
 }
 
@@ -1349,7 +1352,7 @@ static int __init init_tsc_clocksource(void)
 	if (tsc_unstable)
 		goto unreg;
 
-	if (tsc_clocksource_reliable)
+	if (tsc_clocksource_reliable || no_tsc_watchdog)
 		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 
 	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
