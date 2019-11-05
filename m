Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5775CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3F820717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfKEA3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:29:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39505 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfKEA3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:29:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRmjC-0001tZ-03; Tue, 05 Nov 2019 01:29:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B1D31C0105;
        Tue,  5 Nov 2019 01:29:45 +0100 (CET)
Date:   Tue, 05 Nov 2019 00:29:44 -0000
From:   "tip-bot2 for Michael Zhivich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tsc: Respect tsc command line paraemeter for
 clocksource_tsc_early
Cc:     Michael Zhivich <mzhivich@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191024175945.14338-1-mzhivich@akamai.com>
References: <20191024175945.14338-1-mzhivich@akamai.com>
MIME-Version: 1.0
Message-ID: <157291378499.29376.13943510117369625835.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     63ec58b44fcc05efd1542045abd7faf056ac27d9
Gitweb:        https://git.kernel.org/tip/63ec58b44fcc05efd1542045abd7faf056ac27d9
Author:        Michael Zhivich <mzhivich@akamai.com>
AuthorDate:    Thu, 24 Oct 2019 13:59:45 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 05 Nov 2019 01:24:56 +01:00

x86/tsc: Respect tsc command line paraemeter for clocksource_tsc_early

The introduction of clocksource_tsc_early broke the functionality of
"tsc=reliable" and "tsc=nowatchdog" command line parameters, since
clocksource_tsc_early is unconditionally registered with
CLOCK_SOURCE_MUST_VERIFY and thus put on the watchdog list.

This can cause the TSC to be declared unstable during boot:

  clocksource: timekeeping watchdog on CPU0: Marking clocksource
               'tsc-early' as unstable because the skew is too large:
  clocksource: 'refined-jiffies' wd_now: fffb7018 wd_last: fffb6e9d
               mask: ffffffff
  clocksource: 'tsc-early' cs_now: 68a6a7070f6a0 cs_last: 68a69ab6f74d6
               mask: ffffffffffffffff
  tsc: Marking TSC unstable due to clocksource watchdog

The corresponding elapsed times are cs_nsec=1224152026 and wd_nsec=378942392, so
the watchdog differs from TSC by 0.84 seconds.

This happens when HPET is not available and jiffies are used as the TSC
watchdog instead and the jiffies update is not happening due to lost timer
interrupts in periodic mode, which can happen e.g. with expensive debug
mechanisms enabled or under massive overload conditions in virtualized
environments.

Before the introduction of the early TSC clocksource the command line
parameters "tsc=reliable" and "tsc=nowatchdog" could be used to work around
this issue.

Restore the behaviour by disabling the watchdog if requested on the kernel
command line.

[ tglx: Clarify changelog ]

Fixes: aa83c45762a24 ("x86/tsc: Introduce early tsc clocksource")
Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191024175945.14338-1-mzhivich@akamai.com
---
 arch/x86/kernel/tsc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c59454c..7e322e2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1505,6 +1505,9 @@ void __init tsc_init(void)
 		return;
 	}
 
+	if (tsc_clocksource_reliable || no_tsc_watchdog)
+		clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
+
 	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
 	detect_art();
 }
