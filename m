Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C2BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AC1206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389994AbfHAWns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:43:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389970AbfHAWnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:43:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MfekP023464;
        Thu, 1 Aug 2019 18:43:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48mgrvdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:43:01 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71Mfw3f024004;
        Thu, 1 Aug 2019 18:43:00 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48mgrvct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:43:00 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MeiaL023094;
        Thu, 1 Aug 2019 22:42:59 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 2u0e85xg18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:42:59 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MgwfD13042592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:42:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C34AFB206C;
        Thu,  1 Aug 2019 22:42:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE8F5B2076;
        Thu,  1 Aug 2019 22:42:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:42:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 16A0C16C9A4A; Thu,  1 Aug 2019 15:43:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 4/8] rcu/sync: Remove custom check for RCU readers
Date:   Thu,  1 Aug 2019 15:42:54 -0700
Message-Id: <20190801224258.16679-4-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801224240.GA16092@linux.ibm.com>
References: <20190801224240.GA16092@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The rcu/sync code currently does a special check for being in an RCU
read-side critical section.  With RCU consolidating flavors and the
generic helper added earlier in this series, this check is no longer need.
This commit switches to the generic helper, saving a couple of lines
of code.

Cc: Oleg Nesterov <oleg@redhat.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rcu_sync.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
index 9b83865d24f9..0027d4c8087c 100644
--- a/include/linux/rcu_sync.h
+++ b/include/linux/rcu_sync.h
@@ -31,9 +31,7 @@ struct rcu_sync {
  */
 static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&
-			 !rcu_read_lock_bh_held() &&
-			 !rcu_read_lock_sched_held(),
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
 			 "suspicious rcu_sync_is_idle() usage");
 	return !READ_ONCE(rsp->gp_state); /* GP_IDLE */
 }
-- 
2.17.1

