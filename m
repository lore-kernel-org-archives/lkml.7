Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999ABC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CB02070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfE0Ojf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:39:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726302AbfE0Ojf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:39:35 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4REbvlt106470
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 10:39:33 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2srf6p85xc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 10:39:33 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 27 May 2019 15:39:32 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 May 2019 15:39:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4REdTwF29556976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 14:39:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECD53B2064;
        Mon, 27 May 2019 14:39:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9E19B205F;
        Mon, 27 May 2019 14:39:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.199.73])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 May 2019 14:39:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A016816C3473; Mon, 27 May 2019 07:39:32 -0700 (PDT)
Date:   Mon, 27 May 2019 07:39:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline() lockdep
 complaint
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052714-0064-0000-0000-000003E588AA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011172; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209348; UDB=6.00635289; IPR=6.00990375;
 MB=3.00027074; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-27 14:39:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052714-0065-0000-0000-00003DA28D44
Message-Id: <20190527143932.GA10527@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905270104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TASKS03 and TREE04 rcutorture scenarios produce the following
lockdep complaint:

================================
WARNING: inconsistent lock state
5.2.0-rc1+ #513 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
migration/1/14 [HC0[0]:SC0[0]:HE1:SE1] takes:
(____ptrval____) (tick_broadcast_lock){?...}, at: tick_broadcast_offline+0xf/0x70
{IN-HARDIRQ-W} state was registered at:
  lock_acquire+0xb0/0x1c0
  _raw_spin_lock_irqsave+0x3c/0x50
  tick_broadcast_switch_to_oneshot+0xd/0x40
  tick_switch_to_oneshot+0x4f/0xd0
  hrtimer_run_queues+0xf3/0x130
  run_local_timers+0x1c/0x50
  update_process_times+0x1c/0x50
  tick_periodic+0x26/0xc0
  tick_handle_periodic+0x1a/0x60
  smp_apic_timer_interrupt+0x80/0x2a0
  apic_timer_interrupt+0xf/0x20
  _raw_spin_unlock_irqrestore+0x4e/0x60
  rcu_nocb_gp_kthread+0x15d/0x590
  kthread+0xf3/0x130
  ret_from_fork+0x3a/0x50
irq event stamp: 171
hardirqs last  enabled at (171): [<ffffffff8a201a37>] trace_hardirqs_on_thunk+0x1a/0x1c
hardirqs last disabled at (170): [<ffffffff8a201a53>] trace_hardirqs_off_thunk+0x1a/0x1c
softirqs last  enabled at (0): [<ffffffff8a264ee0>] copy_process.part.56+0x650/0x1cb0
softirqs last disabled at (0): [<0000000000000000>] 0x0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(tick_broadcast_lock);
  <Interrupt>
    lock(tick_broadcast_lock);

 *** DEADLOCK ***

1 lock held by migration/1/14:
 #0: (____ptrval____) (clockevents_lock){+.+.}, at: tick_offline_cpu+0xf/0x30

stack backtrace:
CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.2.0-rc1+ #513
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x5e/0x8b
 print_usage_bug+0x1fc/0x216
 ? print_shortest_lock_dependencies+0x1b0/0x1b0
 mark_lock+0x1f2/0x280
 __lock_acquire+0x1e0/0x18f0
 ? __lock_acquire+0x21b/0x18f0
 ? _raw_spin_unlock_irqrestore+0x4e/0x60
 lock_acquire+0xb0/0x1c0
 ? tick_broadcast_offline+0xf/0x70
 _raw_spin_lock+0x33/0x40
 ? tick_broadcast_offline+0xf/0x70
 tick_broadcast_offline+0xf/0x70
 tick_offline_cpu+0x16/0x30
 take_cpu_down+0x7d/0xa0
 multi_cpu_stop+0xa2/0xe0
 ? cpu_stop_queue_work+0xc0/0xc0
 cpu_stopper_thread+0x6d/0x100
 smpboot_thread_fn+0x169/0x240
 kthread+0xf3/0x130
 ? sort_range+0x20/0x20
 ? kthread_cancel_delayed_work_sync+0x10/0x10
 ret_from_fork+0x3a/0x50

It turns out that tick_broadcast_offline() can be invoked with interrupts
enabled, so this commit fixes this issue by replacing the raw_spin_lock()
with raw_spin_lock_irqsave().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index e51778c312f1..1daf77020230 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -454,12 +454,14 @@ static void tick_shutdown_broadcast(void)
  */
 void tick_broadcast_offline(unsigned int cpu)
 {
-	raw_spin_lock(&tick_broadcast_lock);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 	cpumask_clear_cpu(cpu, tick_broadcast_mask);
 	cpumask_clear_cpu(cpu, tick_broadcast_on);
 	tick_broadcast_oneshot_offline(cpu);
 	tick_shutdown_broadcast();
-	raw_spin_unlock(&tick_broadcast_lock);
+	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
 
 #endif

