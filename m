Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57396C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A783208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbfCZXby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:31:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733007AbfCZXb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:31:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNT5FM134000
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:31:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfst61ag3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:31:26 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:31:25 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:31:20 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNVJDo12517434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:31:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D620EB2065;
        Tue, 26 Mar 2019 23:31:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9184B206C;
        Tue, 26 Mar 2019 23:31:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:31:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 91A1116C611D; Tue, 26 Mar 2019 16:31:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH tip/core/rcu 8/9] locktorture: NULL cxt.lwsa and cxt.lrsa to allow bad-arg detection
Date:   Tue, 26 Mar 2019 16:31:17 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326233054.GA21523@linux.ibm.com>
References: <20190326233054.GA21523@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0052-0000-0000-000003A18889
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180139; UDB=6.00617576; IPR=6.00960854;
 MB=3.00026170; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:31:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0053-0000-0000-00006048DFB7
Message-Id: <20190326233118.23057-8-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, lock_torture_cleanup() uses the values of cxt.lwsa and cxt.lrsa
to detect bad parameters that prevented locktorture from initializing,
let alone running.  In this case, lock_torture_cleanup() does no cleanup
aside from invoking torture_cleanup_begin() and torture_cleanup_end(),
as required to permit future torture tests to run.  However, this
heuristic fails if the run with bad parameters was preceded by a previous
run that actually ran:  In this case, both cxt.lwsa and cxt.lrsa will
remain non-zero, which means that the current lock_torture_cleanup()
invocation will be unable to detect the fact that it should skip cleanup,
which can result in charming outcomes such as double frees.

This commit therefore NULLs out both cxt.lwsa and cxt.lrsa at the end
of any run that actually ran.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Josh Triplett <josh@joshtriplett.org>
---
 kernel/locking/locktorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ad40a2617063..80a463d31a8d 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -829,7 +829,9 @@ static void lock_torture_cleanup(void)
 						"End of test: SUCCESS");
 
 	kfree(cxt.lwsa);
+	cxt.lwsa = NULL;
 	kfree(cxt.lrsa);
+	cxt.lrsa = NULL;
 
 end:
 	torture_cleanup_end();
-- 
2.17.1

