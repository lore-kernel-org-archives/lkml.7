Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88215206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfCKL7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:59:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55368 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCKL7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:59:10 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id cb9b810278c7f12d; Mon, 11 Mar 2019 12:59:08 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH] cpufreq: intel_pstate: Fix up iowait_boost computation
Date:   Mon, 11 Mar 2019 12:57:25 +0100
Message-ID: <2396291.FVDonix7jd@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit b8bd1581aa61 ("cpufreq: intel_pstate: Rework iowait
boosting to be less aggressive") the handling of the case when
the SCHED_CPUFREQ_IOWAIT flag is set again after a few iterations of
intel_pstate_update_util() is a bit inconsistent, because the
new value of cpu->iowait_boost may be lower than ONE_EIGHTH_FP
if it was set before, but has not dropped down to zero just yet.

Fix that up by ensuring that the new value of cpu->iowait_boost
will always be at least ONE_EIGHTH_FP then.

Fixes: b8bd1581aa61 ("cpufreq: intel_pstate: Rework iowait boosting to be less aggressive")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1806,7 +1806,7 @@ static void intel_pstate_update_util(str
 		/* Start over if the CPU may have been idle. */
 		if (delta_ns > TICK_NSEC) {
 			cpu->iowait_boost = ONE_EIGHTH_FP;
-		} else if (cpu->iowait_boost) {
+		} else if (cpu->iowait_boost >= ONE_EIGHTH_FP) {
 			cpu->iowait_boost <<= 1;
 			if (cpu->iowait_boost > int_tofp(1))
 				cpu->iowait_boost = int_tofp(1);

