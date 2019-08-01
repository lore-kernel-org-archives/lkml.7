Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A64C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43372083B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbfHAWib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:38:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389791AbfHAWi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:38:28 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Mb3mm143607;
        Thu, 1 Aug 2019 18:37:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hagxsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:37:49 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71Mbnc9145022;
        Thu, 1 Aug 2019 18:37:49 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hagxrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:37:48 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MZPHR024026;
        Thu, 1 Aug 2019 22:37:47 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 2u0e85w6h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:37:47 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71Mblta54067656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:37:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1935EB2079;
        Thu,  1 Aug 2019 22:37:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFD7EB2077;
        Thu,  1 Aug 2019 22:37:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:37:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 55DB016C9A4A; Thu,  1 Aug 2019 15:37:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/12] rcu: Add destroy_work_on_stack() to match INIT_WORK_ONSTACK()
Date:   Thu,  1 Aug 2019 15:37:40 -0700
Message-Id: <20190801223747.15560-5-paulmck@linux.ibm.com>
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

The synchronize_rcu_expedited() function has an INIT_WORK_ONSTACK(),
but lacks the corresponding destroy_work_on_stack().  This commit
therefore adds destroy_work_on_stack().

Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Andrea Arcangeli <aarcange@redhat.com>
---
 kernel/rcu/tree_exp.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index af7e7b9c86af..513b403b683b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -792,6 +792,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  */
 void synchronize_rcu_expedited(void)
 {
+	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
 	unsigned long s;
@@ -817,7 +818,7 @@ void synchronize_rcu_expedited(void)
 		return;  /* Someone else did our work for us. */
 
 	/* Ensure that load happens before action based on it. */
-	if (unlikely(rcu_scheduler_active == RCU_SCHEDULER_INIT)) {
+	if (unlikely(boottime)) {
 		/* Direct call during scheduler init and early_initcalls(). */
 		rcu_exp_sel_wait_wake(s);
 	} else {
@@ -835,5 +836,8 @@ void synchronize_rcu_expedited(void)
 
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
+
+	if (likely(!boottime))
+		destroy_work_on_stack(&rew.rew_work);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.17.1

