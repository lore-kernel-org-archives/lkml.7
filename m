Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9E4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E342173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfC1Mik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:38:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfC1Mia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:38:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2SCbvGm3318462
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 05:37:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2SCbttE3318458;
        Thu, 28 Mar 2019 05:37:55 -0700
Date:   Thu, 28 Mar 2019 05:37:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7dd47617114921fdd8c095509e5e7b4373cc44a1@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, npiggin@gmail.com,
        oleg@redhat.com, ricardo.neri-calderon@linux.intel.com,
        hpa@zytor.com, dzickus@redhat.com, mpe@ellerman.id.au,
        maxime.coquelin@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          maxime.coquelin@redhat.com, mpe@ellerman.id.au, hpa@zytor.com,
          dzickus@redhat.com, ricardo.neri-calderon@linux.intel.com,
          oleg@redhat.com, npiggin@gmail.com, peterz@infradead.org,
          tglx@linutronix.de
In-Reply-To: <alpine.DEB.2.21.1903262245490.1789@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903262245490.1789@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] watchdog: Respect watchdog cpumask on CPU hotplug
Git-Commit-ID: 7dd47617114921fdd8c095509e5e7b4373cc44a1
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

Commit-ID:  7dd47617114921fdd8c095509e5e7b4373cc44a1
Gitweb:     https://git.kernel.org/tip/7dd47617114921fdd8c095509e5e7b4373cc44a1
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 26 Mar 2019 22:51:02 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Mar 2019 13:32:01 +0100

watchdog: Respect watchdog cpumask on CPU hotplug

The rework of the watchdog core to use cpu_stop_work broke the watchdog
cpumask on CPU hotplug.

The watchdog_enable/disable() functions are now called unconditionally from
the hotplug callback, i.e. even on CPUs which are not in the watchdog
cpumask. As a consequence the watchdog can become unstoppable.

Only invoke them when the plugged CPU is in the watchdog cpumask.

Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1903262245490.1789@nanos.tec.linutronix.de

---
 kernel/watchdog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 403c9bd90413..6a5787233113 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -554,13 +554,15 @@ static void softlockup_start_all(void)
 
 int lockup_detector_online_cpu(unsigned int cpu)
 {
-	watchdog_enable(cpu);
+	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
+		watchdog_enable(cpu);
 	return 0;
 }
 
 int lockup_detector_offline_cpu(unsigned int cpu)
 {
-	watchdog_disable(cpu);
+	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
+		watchdog_disable(cpu);
 	return 0;
 }
 
