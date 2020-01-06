Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB6BC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB54020848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgAFGp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:45:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:46674 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgAFGpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:45:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2020 22:45:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,401,1571727600"; 
   d="scan'208";a="420613782"
Received: from cliu38-mobl3.sh.intel.com (HELO 286ab234718b.sh.intel.com) ([10.239.147.26])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2020 22:45:24 -0800
From:   Chuansheng Liu <chuansheng.liu@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, chuansheng.liu@intel.com
Subject: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized therm_work
Date:   Mon,  6 Jan 2020 06:41:55 +0000
Message-Id: <20200106064155.64-1-chuansheng.liu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ICL platform, it is easy to hit bootup failure with panic
in thermal interrupt handler during early bootup stage.

Such issue makes my platform almost can not boot up with
latest kernel code.

The call stack is like:
kernel BUG at kernel/timer/timer.c:1152!

Call Trace:
__queue_delayed_work
queue_delayed_work_on
therm_throt_process
intel_thermal_interrupt
...

When one CPU is up, the irq is enabled prior to CPU UP
notification which will then initialize therm_worker.
Such race will cause the posssibility that interrupt
handler therm_throt_process() accesses uninitialized
therm_work, then system hit panic at very early bootup
stage.

In my ICL platform, it can be reproduced in several times
of reboot stress. With this fix, the system keeps alive
for more than 200 times of reboot stress.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index b38010b541d6..7320eb3ac029 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -86,6 +86,7 @@ struct _thermal_state {
 	unsigned long		total_time_ms;
 	bool			rate_control_active;
 	bool			new_event;
+	bool			therm_work_active;
 	u8			level;
 	u8			sample_index;
 	u8			sample_count;
@@ -359,7 +360,9 @@ static void therm_throt_process(bool new_event, int event, int level)
 
 		state->baseline_temp = temp;
 		state->last_interrupt_time = now;
-		schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
+		if (state->therm_work_active)
+			schedule_delayed_work_on(this_cpu, &state->therm_work,
+					THERM_THROT_POLL_INTERVAL);
 	} else if (old_event && state->last_interrupt_time) {
 		unsigned long throttle_time;
 
@@ -473,7 +476,8 @@ static int thermal_throttle_online(unsigned int cpu)
 
 	INIT_DELAYED_WORK(&state->package_throttle.therm_work, throttle_active_work);
 	INIT_DELAYED_WORK(&state->core_throttle.therm_work, throttle_active_work);
-
+	state->package_throttle.therm_work_active = true;
+	state->core_throttle.therm_work_active = true;
 	return thermal_throttle_add_dev(dev, cpu);
 }
 
@@ -482,6 +486,8 @@ static int thermal_throttle_offline(unsigned int cpu)
 	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
 
+	state->package_throttle.therm_work_active = false;
+	state->core_throttle.therm_work_active = false;
 	cancel_delayed_work(&state->package_throttle.therm_work);
 	cancel_delayed_work(&state->core_throttle.therm_work);
 
-- 
2.17.1

