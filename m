Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B1C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC63121726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390931AbfHBPPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:15:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389312AbfHBPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72F6Xqf078663;
        Fri, 2 Aug 2019 11:14:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4ntc54qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:14:36 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x72F6cvD079170;
        Fri, 2 Aug 2019 11:14:35 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4ntc54pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:14:35 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x72FAmTE020270;
        Fri, 2 Aug 2019 15:14:34 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 2u0e875118-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 15:14:34 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72FEYei14811432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 15:14:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68EBEB2068;
        Fri,  2 Aug 2019 15:14:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49D8DB2064;
        Fri,  2 Aug 2019 15:14:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 15:14:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C0A6E16C9993; Fri,  2 Aug 2019 08:14:35 -0700 (PDT)
Date:   Fri, 2 Aug 2019 08:14:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/14] No-CBs bypass addition for v5.4
Message-ID: <20190802151435.GA1081@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=647 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series is a sneak preview of additional work for the move of no-CBs
CPUs to the ->cblist segmented RCU callback list.  This work adds
a ->nocb_bypass list with its own lock to further reduce contention.
This series also includes some nascent work to turn the scheduling-clock
interrupt back on for nohz_full CPUs doing heavy rcutorture work or RCU
callback invocation, both of which can remain in the kernel for long
time periods, which in turn can impede CPU hotplug removals.  (On some
systems "impede" means up to seven minutes for stop-machine to actually
get things to stop, a problem that has not yet been observed on no-CBs
CPUs that are not also nohz_full CPUs.)

1.	Atomic ->len field in rcu_segcblist structure.

2.	Add bypass callback queueing in ->nocb_bypass with its own
	->nocb_bypass_lock.

3.	(Experimental) Check use and usefulness of ->nocb_lock_contended.

4.	Print no-CBs diagnostics when rcutorture writer unduly delayed.

5.	Avoid synchronous wakeup in __call_rcu_nocb_wake().

6.	Advance CBs after merge in rcutree_migrate_callbacks() to
	avoid unnecessary invocation delays.

7.	Reduce nocb_cb_wait() leaf rcu_node ->lock contention.

8.	Reduce __call_rcu_nocb_wake() leaf rcu_node ->lock contention.

9.	Don't wake no-CBs GP kthread if timer posted under overload,
	thus reducing overhead in the overload case.

10.	Allow rcu_do_batch() to dynamically adjust batch sizes, courtesy
	of Eric Dumazet.

11.	(Experimental) Add TICK_DEP_BIT_RCU, courtesy of Frederic Weisbecker.

12.	Force on tick when invoking lots of callbacks to reduce the
	probability of long stop-machine delays.

13.	Force on tick for readers and callback flooders, again to reduce
	the probability of long stop-machine delays.

14.	(Experimental and likely quite imperfect) Make multi_cpu_stop()
	enable tick on all online CPUs, yet again to reduce the
	probability of long stop-machine delays.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcu_segcblist.h |    4 
 include/linux/tick.h          |    7 
 kernel/rcu/rcu_segcblist.c    |  116 +++++++++-
 kernel/rcu/rcu_segcblist.h    |   17 +
 kernel/rcu/rcutorture.c       |   25 +-
 kernel/rcu/tree.c             |   41 +++
 kernel/rcu/tree.h             |   35 ++-
 kernel/rcu/tree_plugin.h      |  486 +++++++++++++++++++++++++++++++++++++-----
 kernel/rcu/tree_stall.h       |    5 
 kernel/stop_machine.c         |    9 
 kernel/time/tick-sched.c      |    2 
 11 files changed, 667 insertions(+), 80 deletions(-)
