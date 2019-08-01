Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0808BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE00E2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbfHAWiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:38:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388228AbfHAWh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:37:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Mb3GP143577
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 18:37:55 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hagxu5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:37:54 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:37:53 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:37:48 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MblZI54067658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:37:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C7FAB2079;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C3D2B2073;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6BD7516C9A51; Thu,  1 Aug 2019 15:37:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 09/12] idle: Prevent late-arriving interrupts from disrupting offline
Date:   Thu,  1 Aug 2019 15:37:44 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801223708.GA14862@linux.ibm.com>
References: <20190801223708.GA14862@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080122-0060-0000-0000-0000036770D2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240734; UDB=6.00654294; IPR=6.01022158;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:37:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0061-0000-0000-00004A62765F
Message-Id: <20190801223747.15560-9-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Scheduling-clock interrupts can arrive late in the CPU-offline process,
after idle entry and the subsequent call to cpuhp_report_idle_dead().
Once execution passes the call to rcu_report_dead(), RCU is ignoring
the CPU, which results in lockdep complaints when the interrupt handler
uses RCU:

------------------------------------------------------------------------

=============================
WARNING: suspicious RCU usage
5.2.0-rc1+ #681 Not tainted
-----------------------------
kernel/sched/fair.c:9542 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

RCU used illegally from offline CPU!
rcu_scheduler_active = 2, debug_locks = 1
no locks held by swapper/5/0.

stack backtrace:
CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.2.0-rc1+ #681
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 dump_stack+0x5e/0x8b
 trigger_load_balance+0xa8/0x390
 ? tick_sched_do_timer+0x60/0x60
 update_process_times+0x3b/0x50
 tick_sched_handle+0x2f/0x40
 tick_sched_timer+0x32/0x70
 __hrtimer_run_queues+0xd3/0x3b0
 hrtimer_interrupt+0x11d/0x270
 ? sched_clock_local+0xc/0x74
 smp_apic_timer_interrupt+0x79/0x200
 apic_timer_interrupt+0xf/0x20
 </IRQ>
RIP: 0010:delay_tsc+0x22/0x50
Code: ff 0f 1f 80 00 00 00 00 65 44 8b 05 18 a7 11 48 0f ae e8 0f 31 48 89 d6 48 c1 e6 20 48 09 c6 eb 0e f3 90 65 8b 05 fe a6 11 48 <41> 39 c0 75 18 0f ae e8 0f 31 48 c1 e2 20 48 09 c2 48 89 d0 48 29
RSP: 0000:ffff8f92c0157ed0 EFLAGS: 00000212 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000005 RBX: ffff8c861f356400 RCX: ffff8f92c0157e64
RDX: 000000321214c8cc RSI: 00000032120daa7f RDI: 0000000000260f15
RBP: 0000000000000005 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8c861ee18000 R15: ffff8c861ee18000
 cpuhp_report_idle_dead+0x31/0x60
 do_idle+0x1d5/0x200
 ? _raw_spin_unlock_irqrestore+0x2d/0x40
 cpu_startup_entry+0x14/0x20
 start_secondary+0x151/0x170
 secondary_startup_64+0xa4/0xb0

------------------------------------------------------------------------

This happens rarely, but can be forced by happen more often by
placing delays in cpuhp_report_idle_dead() following the call to
rcu_report_dead().  With this in place, the following rcutorture
scenario reproduces the problem within a few minutes:

tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 5 --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --configs "TREE04"

This commit uses the crude but effective expedient of moving the disabling
of interrupts within the idle loop to precede the cpu_is_offline()
check.  It also invokes tick_nohz_idle_stop_tick() instead of
tick_nohz_idle_stop_tick_protected() to shut off the scheduling-clock
interrupt, and then removes the latter because there are no other callers.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/tick.h | 10 ----------
 kernel/sched/idle.c  |  5 +++--
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index f92a10b5e112..196a0a7bfc4f 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -134,14 +134,6 @@ extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
-
-static inline void tick_nohz_idle_stop_tick_protected(void)
-{
-	local_irq_disable();
-	tick_nohz_idle_stop_tick();
-	local_irq_enable();
-}
-
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
@@ -164,8 +156,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
-
-static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80940939b733..e4bc4aa739b8 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -241,13 +241,14 @@ static void do_idle(void)
 		check_pgt_cache();
 		rmb();
 
+		local_irq_disable();
+
 		if (cpu_is_offline(cpu)) {
-			tick_nohz_idle_stop_tick_protected();
+			tick_nohz_idle_stop_tick();
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
 		}
 
-		local_irq_disable();
 		arch_cpu_idle_enter();
 
 		/*
-- 
2.17.1

