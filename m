Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC64BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F952087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfCZXNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:13:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731583AbfCZXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:12:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNA1j5075169
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:12:58 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rft2r04f9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:12:58 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:12:57 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:12:53 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNCqfr22806596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:12:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22152B2065;
        Tue, 26 Mar 2019 23:12:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0237CB205F;
        Tue, 26 Mar 2019 23:12:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:12:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 17A6F16C60F3; Tue, 26 Mar 2019 16:12:53 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:12:53 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/18] Miscellaneous fixes for v5.2
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032623-0068-0000-0000-000003AB7494
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180132; UDB=6.00617572; IPR=6.00960848;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:12:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0069-0000-0000-000047F21E07
Message-Id: <20190326231253.GA18343@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=997 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains miscellaneous fixes.

1.	Unconditionally expedite during suspend/hibernate (unless the
	real-time guys have disabled expediting altogether, that is).

2.	Avoid unnecessary softirq when system is idle, courtesy of
	Joel Fernandes.

3.	rcu_qs -- Use raise_softirq_irqoff to not save irqs twice,
	courtesy of Cyrill Gorcunov.

4.	Make exit_rcu() handle non-preempted RCU readers.

5.	Set rcutree.kthread_prio sysfs access to read-only, courtesy
	of Liu Song.

6.	MAINTAINERS: RCU now has its own email list.

7.	MAINTAINERS: Add -rcu branch name ("dev").

8.	rcu: Move common code out of if-else block, courtesy of Akira
	Yokosawa.

9.	Allow rcu_nocbs= to specify all CPUs.

10.	Report error for bad rcu_nocbs= parameter values.

11.	Fix self-wakeups for grace-period kthread, courtesy of Neeraj
	Upadhyay.

12.	Default jiffies_to_sched_qs to jiffies_till_sched_qs, courtesy
	of Neeraj Upadhyay.

13.	Do a single rhp->func read in rcu_head_after_call_rcu(),
	courtesy of Neeraj Upadhyay.

14.	Update jiffies_to_sched_qs and adjust_jiffies_till_sched_qs()
	comments.

15.	Fix force_qs_rnp() header comment, courtesy of Zhouyi Zhou.

16.	Eliminate redundant NULL-pointer check.

17.	Fix typo in tree_exp.h comment.

18.	Correct READ_ONCE()/WRITE_ONCE() for ->rcu_read_unlock_special.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    4 +-
 MAINTAINERS                                     |   16 ++++----
 include/linux/rcupdate.h                        |    6 ++-
 kernel/rcu/tiny.c                               |    2 -
 kernel/rcu/tree.c                               |   31 +++++++--------
 kernel/rcu/tree_exp.h                           |    4 +-
 kernel/rcu/tree_plugin.h                        |   48 +++++++++++++++---------
 7 files changed, 63 insertions(+), 48 deletions(-)

