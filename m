Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213BAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCA2214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfCMPIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:08:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfCMPIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:08:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAA1E306720B;
        Wed, 13 Mar 2019 15:08:36 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 382711001E6F;
        Wed, 13 Mar 2019 15:08:36 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid hard lockup
Date:   Wed, 13 Mar 2019 11:08:26 -0400
Message-Id: <20190313150826.16862-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 13 Mar 2019 15:08:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With extremely short cfs_period_us setting on a parent task group with a large
number of children the for loop in  sched_cfs_period_timer can run until the
watchdog fires. There is no guarantee that the call to hrtimer_forward_now()
will ever return 0.  The large number of children can make
do_sched_cfs_period_timer() take longer than the period.

[  217.264946] NMI watchdog: Watchdog detected hard LOCKUP on cpu 24
[  217.264948] Modules linked in: sunrpc iTCO_wdt gpio_ich iTCO_vendor_support intel_powerclamp coretemp kvm_intel
+kvm ipmi_ssif irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel ipmi_si intel_cstate joydev
+ipmi_devintf pcspkr hpilo intel_uncore sg hpwdt ipmi_msghandler acpi_power_meter i7core_edac lpc_ich acpi_cpufreq
+ip_tables xfs libcrc32c sr_mod sd_mod cdrom ata_generic radeon i2c_algo_bit drm_kms_helper syscopyarea
+sysfillrect sysimgblt fb_sys_fops ttm ata_piix drm serio_raw crc32c_intel hpsa myri10ge libata dca
+scsi_transport_sas netxen_nic dm_mirror dm_region_hash dm_log dm_mod
[  217.264964] CPU: 24 PID: 46684 Comm: myapp Not tainted 5.0.0-rc7+ #25
[  217.264965] Hardware name: HP ProLiant DL580 G7, BIOS P65 08/16/2015
[  217.264965] RIP: 0010:tg_nop+0x0/0x10
[  217.264966] Code: 83 c9 08 f0 48 0f b1 0f 48 39 c2 74 0e 48 89 c2 f7 c2 00 00 20 00 75 dc 31 c0 c3 b8 01 00 00
+00 c3 66 0f 1f 84 00 00 00 00 00 <66> 66 66 66 90 31 c0 c3 0f 1f 84 00 00 00 00 00 66 66 66 66 90 8b
[  217.264967] RSP: 0000:ffff976a7f703e48 EFLAGS: 00000087
[  217.264967] RAX: ffff976a7c7c8f00 RBX: ffff976a6f4fad00 RCX: ffff976a7c7c90f0
[  217.264968] RDX: ffff976a6f4faee0 RSI: ffff976a7f961f00 RDI: ffff976a6f4fad00
[  217.264968] RBP: ffff976a7f961f00 R08: 0000000000000002 R09: ffffffad2c9b3331
[  217.264969] R10: 0000000000000000 R11: 0000000000000000 R12: ffff976a7c7c8f00
[  217.264969] R13: ffffffffb2305c00 R14: 0000000000000000 R15: ffffffffb22f8510
[  217.264970] FS:  00007f6240678740(0000) GS:ffff976a7f700000(0000) knlGS:0000000000000000
[  217.264970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  217.264971] CR2: 00000000006dee20 CR3: 000000bf2bffc005 CR4: 00000000000206e0
[  217.264971] Call Trace:
[  217.264971]  <IRQ>
[  217.264972]  walk_tg_tree_from+0x29/0xb0
[  217.264972]  unthrottle_cfs_rq+0xe0/0x1a0
[  217.264972]  distribute_cfs_runtime+0xd3/0xf0
[  217.264973]  sched_cfs_period_timer+0xcb/0x160
[  217.264973]  ? sched_cfs_slack_timer+0xd0/0xd0
[  217.264973]  __hrtimer_run_queues+0xfb/0x270
[  217.264974]  hrtimer_interrupt+0x122/0x270
[  217.264974]  smp_apic_timer_interrupt+0x6a/0x140
[  217.264975]  apic_timer_interrupt+0xf/0x20
[  217.264975]  </IRQ>
[  217.264975] RIP: 0033:0x7f6240125fe5
[  217.264976] Code: 44 17 d0 f3 44 0f 7f 47 30 f3 44 0f 7f 44 17 c0 48 01 fa 48 83 e2 c0 48 39 d1 74 a3 66 0f 1f
+84 00 00 00 00 00 66 44 0f 7f 01 <66> 44 0f 7f 41 10 66 44 0f 7f 41 20 66 44 0f 7f 41 30 48 83 c1 40
...

To prevent this we add protection to the loop that detects when the loop has run
too many times and scales the period and quota up, proportionally, so that the timer
can complete before then next period expires.  This preserves the relative runtime
quota while preventing the hard lockup.

A warning is issued reporting this state and the new values.

The scaling by average time over count was suggested by Ben Segall <bsegall@google.com>.

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
---

Note: This is against v5.0 as suggested by the documentation. It won't apply to 5.0+ due to
the change to raw_spin_lock_irqsave. I can respin as needed.

 kernel/sched/fair.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 310d0637fe4b..90cc67bbf592 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4859,19 +4859,51 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+extern const u64 max_cfs_quota_period;
+int cfs_period_autotune_loop_limit   = 8;
+int cfs_period_autotune_cushion_pct  = 15; /* percentage added to period recalculation */
+
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
+	s64 nsstart, nsnow, new_period;
 	int overrun;
 	int idle = 0;
+	int count = 0;
 
 	raw_spin_lock(&cfs_b->lock);
+	nsstart = ktime_to_ns(hrtimer_cb_get_time(timer));
 	for (;;) {
 		overrun = hrtimer_forward_now(timer, cfs_b->period);
 		if (!overrun)
 			break;
 
+		if (++count > cfs_period_autotune_loop_limit) {
+			ktime_t old_period = ktime_to_ns(cfs_b->period);
+
+			nsnow = ktime_to_ns(hrtimer_cb_get_time(timer));
+			new_period = (nsnow - nsstart)/cfs_period_autotune_loop_limit;
+
+			/*  Make sure new period will be larger than old. */
+			if (new_period < old_period) {
+				new_period = old_period;
+			}
+			new_period += (new_period *  cfs_period_autotune_cushion_pct) / 100;
+
+			if (new_period >  max_cfs_quota_period)
+				new_period = max_cfs_quota_period;
+
+			cfs_b->period = ns_to_ktime(new_period);
+			cfs_b->quota += (cfs_b->quota * ((new_period - old_period) * 100)/old_period)/100;
+			pr_warn_ratelimited(
+				"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
+				smp_processor_id(), cfs_b->period/NSEC_PER_USEC, cfs_b->quota/NSEC_PER_USEC);
+
+			/* reset count so we don't come right back in here */
+			count = 0;
+		}
+
 		idle = do_sched_cfs_period_timer(cfs_b, overrun);
 	}
 	if (idle)
-- 
2.18.0

