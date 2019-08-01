Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7DEC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0563E206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbfHAXIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:08:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731936AbfHAXIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:08:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71N8AWh029248
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 19:08:10 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4860ab80-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 19:08:09 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Aug 2019 00:07:49 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 00:07:43 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71N7g4J13173504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:07:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB431B2064;
        Thu,  1 Aug 2019 23:07:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC9B4B205F;
        Thu,  1 Aug 2019 23:07:42 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:07:42 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2426916C9A3D; Thu,  1 Aug 2019 16:07:44 -0700 (PDT)
Date:   Thu, 1 Aug 2019 16:07:44 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/18] No-CBs cblist updates for v5.3-rc2
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080123-2213-0000-0000-000003B873FA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240744; UDB=6.00654300; IPR=6.01022167;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 23:07:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080123-2214-0000-0000-00005F7BA2F1
Message-Id: <20190801230744.GA19115@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=536 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series reduces memory footprint (RCU callbacks posted by no-CBs CPUs)
by causing the no-CBs CPUs to use the existing ->cblist segmented callback
list.  This allows these callbacks to take advantage of RCU grace periods
that were started by something other than the corresponding rcuog kthread:

1.	Use separate flag to indicate disabled ->cblist.

2.	Use separate flag to indicate offloaded ->cblist.

3.	Add checks for offloaded callback processing.

4.	Make rcutree_migrate_callbacks() start at leaf rcu_node structure.

5.	Check for deferred nocb wakeups before nohz_full early exit.

6.	Remove deferred wakeup checks for extended quiescent states.

7.	Allow lockless use of rcu_segcblist_restempty().

8.	Allow lockless use of rcu_segcblist_empty().

9.	Leave ->cblist enabled for no-CBs CPUs.

10.	Use rcu_segcblist for no-CBs CPUs.

11.	Remove obsolete nocb_head and nocb_tail fields.

12.	Remove obsolete nocb_q_count and nocb_q_count_lazy fields.

13.	Remove obsolete nocb_cb_tail and nocb_cb_head fields.

14.	Remove obsolete nocb_gp_head and nocb_gp_tail fields.

15.	Use build-time no-CBs check in rcu_do_batch().

16.	Use build-time no-CBs check in rcu_core().

17.	Use build-time no-CBs check in rcu_pending().

18.	Suppress uninitialized false-positive in nocb_gp_wait().

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcu_segcblist.h |    2 
 include/trace/events/rcu.h    |    1 
 kernel/rcu/rcu_segcblist.c    |   64 +++-
 kernel/rcu/rcu_segcblist.h    |   16 -
 kernel/rcu/tree.c             |  188 +++++++------
 kernel/rcu/tree.h             |   29 --
 kernel/rcu/tree_plugin.h      |  588 ++++++++++++++----------------------------
 7 files changed, 374 insertions(+), 514 deletions(-)

