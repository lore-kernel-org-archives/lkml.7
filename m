Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83AB2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCJLdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 07:33:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36400 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfCJLdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 07:33:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h2wiB-00005u-9p; Sun, 10 Mar 2019 12:33:47 +0100
Subject: [GIT pull] core udpate for 5.1
Message-ID: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 10 Mar 2019 12:33:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-for-linus

A single commit adding a command line parameter which allows to set the
watchdog threshold on the kernel command-line, so kernels with massive
debug facilities enabled won't trigger the watchdog during early boot and
before the threshold can be changed via sysctl.


Thanks,

	tglx

------------------>
Laurence Oberman (1):
      watchdog/core: Add watchdog_thresh command line parameter


 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 kernel/watchdog.c                               | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b90fe3b6bc6c..79b5b473001b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4957,6 +4957,14 @@
 			or other driver-specific files in the
 			Documentation/watchdog/ directory.
 
+	watchdog_thresh=
+			[KNL]
+			Set the hard lockup detector stall duration
+			threshold in seconds. The soft lockup detector
+			threshold is set to twice the value. A value of 0
+			disables both lockup detectors. Default is 10
+			seconds.
+
 	workqueue.watchdog_thresh=
 			If CONFIG_WQ_WATCHDOG is configured, workqueue can
 			warn stall conditions and dump internal state to
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 977918d5d350..8fbfda94a67b 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -199,6 +199,13 @@ static int __init nosoftlockup_setup(char *str)
 }
 __setup("nosoftlockup", nosoftlockup_setup);
 
+static int __init watchdog_thresh_setup(char *str)
+{
+	get_option(&str, &watchdog_thresh);
+	return 1;
+}
+__setup("watchdog_thresh=", watchdog_thresh_setup);
+
 #ifdef CONFIG_SMP
 int __read_mostly sysctl_softlockup_all_cpu_backtrace;
 

