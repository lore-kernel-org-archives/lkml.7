Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD37C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEA3206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbfHAWhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:37:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729432AbfHAWhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:37:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Mb7Vi125390;
        Thu, 1 Aug 2019 18:37:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u477ykn7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:37:09 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71Mb8GY125401;
        Thu, 1 Aug 2019 18:37:08 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u477ykn6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:37:08 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MZOKA019586;
        Thu, 1 Aug 2019 22:37:07 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 2u0e85xfty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:37:07 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71Mb7FK50463072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:37:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08AA0B2077;
        Thu,  1 Aug 2019 22:37:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC7F3B2073;
        Thu,  1 Aug 2019 22:37:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:37:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3C8E816C9A39; Thu,  1 Aug 2019 15:37:08 -0700 (PDT)
Date:   Thu, 1 Aug 2019 15:37:08 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/12] Miscellaneous fixes for v5.4
Message-ID: <20190801223708.GA14862@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains miscellaneous fixes:

1.	Make lockdep's print_lock() address visible.

2.	Fix tick_broadcast_offline() lockdep complaint.

3.	Restore barrier() to rcu_read_lock() and rcu_read_unlock().

4.	Add kernel parameter to dump trace after RCU CPU stall warning.

5.	Add destroy_work_on_stack() to match INIT_WORK_ONSTACK().

6.	Avoid srcutorture security-based pointer obfuscation.

7.	Change return type of rcu_spawn_one_boost_kthread(), courtesy of
	Byungchul Park.

8.	Add rcutree.kthread_prio pointer to stallwarn.txt.

9.	Prevent late-arriving interrupts from disrupting offline, courtesy
	of Peter Zijlstra.

10.	Remove redundant "if" condition from rcu_gp_is_expedited().

11.	Use common outgoing-CPU-notification code for arm.

12.	Fix spelling mistake "greate"->"great", courtesy of Mukesh Ojha.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Requirements/Requirements.html |   71 ++++++++++++++++
 Documentation/RCU/stallwarn.txt                         |    6 +
 Documentation/admin-guide/kernel-parameters.txt         |    4 
 arch/arm/kernel/smp.c                                   |    6 -
 include/linux/tick.h                                    |   10 --
 kernel/locking/lockdep.c                                |    2 
 kernel/rcu/rcu.h                                        |    1 
 kernel/rcu/rcu_segcblist.h                              |   21 ----
 kernel/rcu/srcutree.c                                   |    5 -
 kernel/rcu/tree_exp.h                                   |    8 +
 kernel/rcu/tree_plugin.h                                |   31 ++----
 kernel/rcu/tree_stall.h                                 |    4 
 kernel/rcu/update.c                                     |    5 -
 kernel/sched/core.c                                     |   57 +++++++++++-
 kernel/sched/idle.c                                     |    5 -
 15 files changed, 164 insertions(+), 72 deletions(-)
