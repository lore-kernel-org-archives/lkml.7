Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB205C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B285023697
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfHaJGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 05:06:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54403 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHaJGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 05:06:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3zKf-0006D1-R7; Sat, 31 Aug 2019 11:06:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D01681C07A5;
        Sat, 31 Aug 2019 11:06:04 +0200 (CEST)
Date:   Sat, 31 Aug 2019 09:06:04 -0000
From:   "tip-bot2 for Josh Hunt" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Restrict period on Nehalem
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, acme@kernel.org,
        Josh Hunt <johunt@akamai.com>, bpuranda@akamai.com,
        mingo@redhat.com, jolsa@redhat.com, tglx@linutronix.de,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1566256411-18820-1-git-send-email-johunt@akamai.com>
References: <1566256411-18820-1-git-send-email-johunt@akamai.com>
MIME-Version: 1.0
Message-ID: <156724236470.10774.16768356657393096116.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     44d3bbb6f5e501b873218142fe08cdf62a4ac1f3
Gitweb:        https://git.kernel.org/tip/44d3bbb6f5e501b873218142fe08cdf62a4ac1f3
Author:        Josh Hunt <johunt@akamai.com>
AuthorDate:    Mon, 19 Aug 2019 19:13:31 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 30 Aug 2019 14:27:47 +02:00

perf/x86/intel: Restrict period on Nehalem

We see our Nehalem machines reporting 'perfevents: irq loop stuck!' in
some cases when using perf:

perfevents: irq loop stuck!
WARNING: CPU: 0 PID: 3485 at arch/x86/events/intel/core.c:2282 intel_pmu_handle_irq+0x37b/0x530
...
RIP: 0010:intel_pmu_handle_irq+0x37b/0x530
...
Call Trace:
<NMI>
? perf_event_nmi_handler+0x2e/0x50
? intel_pmu_save_and_restart+0x50/0x50
perf_event_nmi_handler+0x2e/0x50
nmi_handle+0x6e/0x120
default_do_nmi+0x3e/0x100
do_nmi+0x102/0x160
end_repeat_nmi+0x16/0x50
...
? native_write_msr+0x6/0x20
? native_write_msr+0x6/0x20
</NMI>
intel_pmu_enable_event+0x1ce/0x1f0
x86_pmu_start+0x78/0xa0
x86_pmu_enable+0x252/0x310
__perf_event_task_sched_in+0x181/0x190
? __switch_to_asm+0x41/0x70
? __switch_to_asm+0x35/0x70
? __switch_to_asm+0x41/0x70
? __switch_to_asm+0x35/0x70
finish_task_switch+0x158/0x260
__schedule+0x2f6/0x840
? hrtimer_start_range_ns+0x153/0x210
schedule+0x32/0x80
schedule_hrtimeout_range_clock+0x8a/0x100
? hrtimer_init+0x120/0x120
ep_poll+0x2f7/0x3a0
? wake_up_q+0x60/0x60
do_epoll_wait+0xa9/0xc0
__x64_sys_epoll_wait+0x1a/0x20
do_syscall_64+0x4e/0x110
entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fdeb1e96c03
...
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: acme@kernel.org
Cc: Josh Hunt <johunt@akamai.com>
Cc: bpuranda@akamai.com
Cc: mingo@redhat.com
Cc: jolsa@redhat.com
Cc: tglx@linutronix.de
Cc: namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com
Link: https://lkml.kernel.org/r/1566256411-18820-1-git-send-email-johunt@akamai.com
---
 arch/x86/events/intel/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 648260b..e4c2cb6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3572,6 +3572,11 @@ static u64 bdw_limit_period(struct perf_event *event, u64 left)
 	return left;
 }
 
+static u64 nhm_limit_period(struct perf_event *event, u64 left)
+{
+	return max(left, 32ULL);
+}
+
 PMU_FORMAT_ATTR(event,	"config:0-7"	);
 PMU_FORMAT_ATTR(umask,	"config:8-15"	);
 PMU_FORMAT_ATTR(edge,	"config:18"	);
@@ -4606,6 +4611,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_constraints = intel_nehalem_pebs_event_constraints;
 		x86_pmu.enable_all = intel_pmu_nhm_enable_all;
 		x86_pmu.extra_regs = intel_nehalem_extra_regs;
+		x86_pmu.limit_period = nhm_limit_period;
 
 		mem_attr = nhm_mem_events_attrs;
 
