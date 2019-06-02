Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C497FC28CC3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9950C274DE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfFBBNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 21:13:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbfFBBNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 21:13:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x521CEU4112421
        for <linux-kernel@vger.kernel.org>; Sat, 1 Jun 2019 21:12:59 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sunh65g21-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 21:12:59 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 2 Jun 2019 02:12:58 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 2 Jun 2019 02:12:55 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x521CsLE29884686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 2 Jun 2019 01:12:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00679B2064;
        Sun,  2 Jun 2019 01:12:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEDE2B205F;
        Sun,  2 Jun 2019 01:12:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.201])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  2 Jun 2019 01:12:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6A53C16C2FCE; Sat,  1 Jun 2019 18:12:53 -0700 (PDT)
Date:   Sat, 1 Jun 2019 18:12:53 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     tglx@linutronix.de, mingo@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, mojha@codeaurora.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH HACK RFC] cpu: Prevent late-arriving interrupts from
 disrupting offline
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060201-2213-0000-0000-00000398F1E9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011200; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01211941; UDB=6.00636855; IPR=6.00992984;
 MB=3.00027148; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-02 01:12:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060201-2214-0000-0000-00005EAA30E5
Message-Id: <20190602011253.GA6167@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-01_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906020007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
rcu_report_dead().  With this in place, the folloiwng rcutorture
scenario reproduces the problem within a few minute:

tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 5 --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --configs "TREE04"

This commit uses the crude by effective expedient of disabling interrupts
via local_irq_disable() just prior to the call to rcu_report_dead().
This passes light testing.  Of course, preventing the scheduling-clock
interrupt might be preferable.  However, this commit does have the
advantage of allowing progress to be made on other RCU bugs.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 448efc06bb2d..3b33d83b793d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -930,6 +930,7 @@ void cpuhp_report_idle_dead(void)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
 	BUG_ON(st->state != CPUHP_AP_OFFLINE);
+	local_irq_disable();
 	rcu_report_dead(smp_processor_id());
 	st->state = CPUHP_AP_IDLE_DEAD;
 	udelay(1000);

