Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA2EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7494920857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfDBOiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:38:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbfDBOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:38:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32EXpdO049122
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 10:38:00 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rm9e0s317-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 10:38:00 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 2 Apr 2019 15:37:59 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 15:37:54 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32Ebrp323134322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 14:37:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C064DB2067;
        Tue,  2 Apr 2019 14:37:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0815B2065;
        Tue,  2 Apr 2019 14:37:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 14:37:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BA2D916C2A3D; Tue,  2 Apr 2019 07:37:58 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:37:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH RFC v2 tip/core/rcu 0/4] Real-time elimination of RCU_SOFTIRQ
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040214-0072-0000-0000-00000414707D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010861; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183287; UDB=6.00619479; IPR=6.00964035;
 MB=3.00026261; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 14:37:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040214-0073-0000-0000-00004BAF84F8
Message-Id: <20190402143758.GA15134@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=581 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series is v2 of an early posting of code to add a boot-time option to
move RCU's softirq processing to per-CPU kthreads.  This is not done
by default for performance reasons, nor are these reasons theoretical.
In fact, earlier attempts to do just this were not met with silence.

The patches are as follows:

1.      Enable elimination of Tree-RCU softirq processing via a new
	rcutree.use_softirq kernel boot parameter.  This defaults to 1,
	so boot with "rcutree.use_softirq=0" to move RCU_SOFTIRQ work
	to the rcuc kthreads.  Courtesy of Sebastian Andrzej Siewior.

2.      Improve wakeup-safety checks in rcu_read_unlock_special(),
	thus allowing both rcuc kthreads and reasonably snappy
	expedited RCU grace periods.

3.	Only do rcu_read_unlock_special() wakeups if expedited.

4.	Allow rcu_read_unlock_special() to raise_softirq() if in_irq().

Changes since v1:

o	Inspired by feedback from Peter Zijlstra, avoid expensive wakeups
	unless there is a high probability that the current task or CPU
	is blocking an expedited grace period.

o	Account for the possibility of long-term scheduling-clock-free
	kernel sojourns in NO_HZ_FULL kernels.

o	As an exception to the above, allow use of raise_softirq_irqoff()
	when in an interrupt handler, in which case this is an extremely
	low-overhead option.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    6 
 include/linux/sched.h                           |    2 
 kernel/rcu/tree.c                               |  138 +++++++++++++++++--
 kernel/rcu/tree.h                               |    2 
 kernel/rcu/tree_plugin.h                        |  167 +++++-------------------
 5 files changed, 172 insertions(+), 143 deletions(-)

