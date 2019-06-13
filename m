Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DA2C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3545120673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfFMWhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:37:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfFMWhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:37:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DMWHoX014019;
        Thu, 13 Jun 2019 18:36:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3x5ftmbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 18:36:07 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5DMWPn8014412;
        Thu, 13 Jun 2019 18:36:07 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3x5ftmb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 18:36:07 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5DMYFFs032479;
        Thu, 13 Jun 2019 22:36:06 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 2t1x6frgq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 22:36:06 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DMa5I839321908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 22:36:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D589B206A;
        Thu, 13 Jun 2019 22:36:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC9D5B2067;
        Thu, 13 Jun 2019 22:36:04 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.175.192])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jun 2019 22:36:04 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F17A516C8EAB; Thu, 13 Jun 2019 15:36:04 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:36:04 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 6/9] rcu: Upgrade sync_exp_work_done() to
 smp_mb()
Message-ID: <20190613223604.GE28207@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190530145942.GA30318@linux.ibm.com>
 <20190530150015.30995-6-paulmck@linux.ibm.com>
 <20190606074849.GD3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606074849.GD3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 09:48:49AM +0200, Peter Zijlstra wrote:
> On Thu, May 30, 2019 at 08:00:12AM -0700, Paul E. McKenney wrote:
> > The sync_exp_work_done() function uses smp_mb__before_atomic(), but
> > there is no obvious atomic in the ensuing code.  The ordering is
> > absolutely required for grace periods to work correctly, so this
> > commit upgrades the smp_mb__before_atomic() to smp_mb().
> > 
> 
> Did this commit want a Fixes: line? Such that robots can find the right
> kernels to backport this to?

Indeed it does, and thanks to Andrea for finding the commit.

							Thanx, Paul

------------------------------------------------------------------------

commit 96050c68be33edef18800ad6748f61f81db81a20
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Sat Apr 20 01:40:54 2019 -0700

    rcu: Upgrade sync_exp_work_done() to smp_mb()
    
    The sync_exp_work_done() function uses smp_mb__before_atomic(), but
    there is no obvious atomic in the ensuing code.  The ordering is
    absolutely required for grace periods to work correctly, so this
    commit upgrades the smp_mb__before_atomic() to smp_mb().
    
    Fixes: 6fba2b3767ea ("rcu: Remove deprecated RCU debugfs tracing code")
    Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 9c990df880d1..d969650a72c6 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -259,8 +259,7 @@ static bool sync_exp_work_done(unsigned long s)
 {
 	if (rcu_exp_gp_seq_done(s)) {
 		trace_rcu_exp_grace_period(rcu_state.name, s, TPS("done"));
-		/* Ensure test happens before caller kfree(). */
-		smp_mb__before_atomic(); /* ^^^ */
+		smp_mb(); /* Ensure test happens before caller kfree(). */
 		return true;
 	}
 	return false;
