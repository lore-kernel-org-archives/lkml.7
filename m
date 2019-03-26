Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E84C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CB72087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbfCZXPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:15:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732770AbfCZXPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:15:39 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QN9KMQ067562
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:15:38 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rftk1pvej-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:15:38 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:15:37 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:15:33 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNFVH715073420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:15:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82E62B206E;
        Tue, 26 Mar 2019 23:15:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64F1EB2067;
        Tue, 26 Mar 2019 23:15:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:15:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8251516C60F3; Tue, 26 Mar 2019 16:15:32 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/2] srcu: Check for in-flight callbacks in _cleanup_srcu_struct()
Date:   Tue, 26 Mar 2019 16:15:30 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326231512.GA19843@linux.ibm.com>
References: <20190326231512.GA19843@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0040-0000-0000-000004D7AED6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180134; UDB=6.00606765; IPR=6.00960849;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:15:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0041-0000-0000-000008E2D024
Message-Id: <20190326231531.20047-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If someone fails to drain the corresponding SRCU callbacks (for
example, by failing to invoke srcu_barrier()) before invoking either
cleanup_srcu_struct() or cleanup_srcu_struct_quiesced(), the resulting
diagnostic is an ambiguous use-after-free diagnostic, and even then
only if you are running something like KASAN.  This commit therefore
improves SRCU diagnostics by adding checks for in-flight callbacks at
_cleanup_srcu_struct() time.

Note that these diagnostics can still be defeated, for example, by
invoking call_srcu() concurrently with cleanup_srcu_struct().  Which is
a really bad idea, but sometimes all too easy to do.  But even then,
these diagnostics have at least some probability of catching the problem.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index a60b8ba9e1ac..4f30f3ecabc1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -387,6 +387,8 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
 			del_timer_sync(&sdp->delay_work);
 			flush_work(&sdp->work);
 		}
+		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
+			return; /* Forgot srcu_barrier(), so just leak it! */
 	}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
 	    WARN_ON(srcu_readers_active(ssp))) {
-- 
2.17.1

