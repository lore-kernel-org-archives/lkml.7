Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF747C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C632084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390395AbfHAXJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:09:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730790AbfHAXI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:08:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71N7GiQ101827;
        Thu, 1 Aug 2019 19:08:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u457urjud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:13 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71N7PUI103204;
        Thu, 1 Aug 2019 19:08:13 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u457urjtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:08:13 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71N4wS3002985;
        Thu, 1 Aug 2019 23:08:12 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2u0e87hb4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:08:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71N8A7132571800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:08:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6B70B2068;
        Thu,  1 Aug 2019 23:08:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A81C6B205F;
        Thu,  1 Aug 2019 23:08:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:08:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 144CF16C9A37; Thu,  1 Aug 2019 16:08:12 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 01/18] rcu/nocb: Use separate flag to indicate disabled ->cblist
Date:   Thu,  1 Aug 2019 16:07:53 -0700
Message-Id: <20190801230810.21570-1-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801230744.GA19115@linux.ibm.com>
References: <20190801230744.GA19115@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULLing the RCU_NEXT_TAIL pointer was a clever way to save a byte, but
forward-progress considerations would require that this pointer be both
NULL and non-NULL, which, absent a quantum-computer port of the Linux
kernel, simply won't happen.  This commit therefore creates as separate
->enabled flag to replace the current NULL checks.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rcu_segcblist.h | 1 +
 kernel/rcu/rcu_segcblist.c    | 3 ++-
 kernel/rcu/rcu_segcblist.h    | 2 +-
 kernel/rcu/tree_plugin.h      | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 87404cb015f1..f48888040332 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -67,6 +67,7 @@ struct rcu_segcblist {
 	unsigned long gp_seq[RCU_CBLIST_NSEGS];
 	long len;
 	long len_lazy;
+	u8 enabled;
 };
 
 #define RCU_SEGCBLIST_INITIALIZER(n) \
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 9bd5f6023c21..b305dcac34c9 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -58,6 +58,7 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 		rsclp->tails[i] = &rsclp->head;
 	rsclp->len = 0;
 	rsclp->len_lazy = 0;
+	rsclp->enabled = 1;
 }
 
 /*
@@ -69,7 +70,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 	WARN_ON_ONCE(!rcu_segcblist_empty(rsclp));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(rsclp));
 	WARN_ON_ONCE(rcu_segcblist_n_lazy_cbs(rsclp));
-	rsclp->tails[RCU_NEXT_TAIL] = NULL;
+	rsclp->enabled = 0;
 }
 
 /*
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 822a39da0533..b2de7b32da29 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -63,7 +63,7 @@ static inline long rcu_segcblist_n_nonlazy_cbs(struct rcu_segcblist *rsclp)
  */
 static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 {
-	return !!rsclp->tails[RCU_NEXT_TAIL];
+	return rsclp->enabled;
 }
 
 /*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0a3f8680b450..b8a43cf9bb4e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2189,8 +2189,8 @@ static bool init_nocb_callback_list(struct rcu_data *rdp)
 				rcu_segcblist_n_cbs(&rdp->cblist));
 		atomic_long_set(&rdp->nocb_q_count_lazy,
 				rcu_segcblist_n_lazy_cbs(&rdp->cblist));
-		rcu_segcblist_init(&rdp->cblist);
 	}
+	rcu_segcblist_init(&rdp->cblist);
 	rcu_segcblist_disable(&rdp->cblist);
 	return true;
 }
-- 
2.17.1

