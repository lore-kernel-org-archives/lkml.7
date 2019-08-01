Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A01AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FEA2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbfHAWi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:38:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731855AbfHAWi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:38:27 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MbE7n143826;
        Thu, 1 Aug 2019 18:37:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hagxsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:37:50 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71Mbnla145054;
        Thu, 1 Aug 2019 18:37:49 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hagxs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:37:49 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MZJ3E007787;
        Thu, 1 Aug 2019 22:37:48 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 2u0e87h66a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:37:48 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MblsZ51446264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:37:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79F08B2081;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B36FB2070;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 63E5916C9A4D; Thu,  1 Aug 2019 15:37:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/12] doc: Add rcutree.kthread_prio pointer to stallwarn.txt
Date:   Thu,  1 Aug 2019 15:37:43 -0700
Message-Id: <20190801223747.15560-8-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801223708.GA14862@linux.ibm.com>
References: <20190801223708.GA14862@linux.ibm.com>
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

This commit adds mention of the rcutree.kthread_prio kernel boot parameter
to the discussion of how high-priority real-time tasks can result in
RCU CPU stall warnings.  (However, this does not necessarily help when
the high-priority real-time tasks are using dubious deadlines.)

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/stallwarn.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index 13e88fc00f01..f48f4621ccbc 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -57,6 +57,12 @@ o	A CPU-bound real-time task in a CONFIG_PREEMPT_RT kernel that
 	CONFIG_PREEMPT_RCU case, you might see stall-warning
 	messages.
 
+	You can use the rcutree.kthread_prio kernel boot parameter to
+	increase the scheduling priority of RCU's kthreads, which can
+	help avoid this problem.  However, please note that doing this
+	can increase your system's context-switch rate and thus degrade
+	performance.
+
 o	A periodic interrupt whose handler takes longer than the time
 	interval between successive pairs of interrupts.  This can
 	prevent RCU's kthreads and softirq handlers from running.
-- 
2.17.1

