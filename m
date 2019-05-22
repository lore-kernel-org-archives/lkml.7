Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A8A20863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfEVSSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:18:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728272AbfEVSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:18:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MID8NI040159
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:18:21 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2snah7k2st-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:18:21 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 22 May 2019 19:18:19 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 May 2019 19:18:16 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4MIIFRh34537642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 18:18:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEF6CB2067;
        Wed, 22 May 2019 18:18:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0330B205F;
        Wed, 22 May 2019 18:18:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 22 May 2019 18:18:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 33E4A16C29D3; Wed, 22 May 2019 11:18:17 -0700 (PDT)
Date:   Wed, 22 May 2019 11:18:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Force inlining of rcu_read_lock()
Reply-To: paulmck@linux.ibm.com
References: <20190521204843.11060-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521204843.11060-1-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052218-0040-0000-0000-000004F3113C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011144; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01207081; UDB=6.00633897; IPR=6.00988056;
 MB=3.00027007; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-22 18:18:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052218-0041-0000-0000-000008FF2575
Message-Id: <20190522181817.GF28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 04:48:43PM -0400, Waiman Long wrote:
> It is found that when debugging options are turned on, the
> rcu_read_lock() function may not be inlined at all. That will make
> it harder to debug RCU related problem as the print_lock() function
> in lockdep will print "rcu_read_lock()" instead of the caller of
> rcu_read_lock() function. For example,
> 
> [   10.579995] =============================
> [   10.584033] WARNING: suspicious RCU usage
> [   10.588074] 4.18.0.memcg_v2+ #1 Not tainted
> [   10.593162] -----------------------------
> [   10.597203] include/linux/rcupdate.h:281 Illegal context switch in
> RCU read-side critical section!
> [   10.606220]
> [   10.606220] other info that might help us debug this:
> [   10.606220]
> [   10.614280]
> [   10.614280] rcu_scheduler_active = 2, debug_locks = 1
> [   10.620853] 3 locks held by systemd/1:
> [   10.624632]  #0: (____ptrval____) (&type->i_mutex_dir_key#5){.+.+}, at: lookup_slow+0x42/0x70
> [   10.633232]  #1: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70
> [   10.640954]  #2: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70
> 
> To make sure that the proper caller of rcu_read_lock() is shown, we
> have to force the inlining of the rcu_read_lock() function.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Good point, queued!  I reworked the commit log as follows, is this OK?

							Thanx, Paul

------------------------------------------------------------------------

commit c006ffd7b607f8ee216f6a7a6d845b9514881e92
Author: Waiman Long <longman@redhat.com>
Date:   Tue May 21 16:48:43 2019 -0400

    rcu: Force inlining of rcu_read_lock()
    
    When debugging options are turned on, the rcu_read_lock() function
    might not be inlined. This results in lockdep's print_lock() function
    printing "rcu_read_lock+0x0/0x70" instead of rcu_read_lock()'s caller.
    For example:
    
    [   10.579995] =============================
    [   10.584033] WARNING: suspicious RCU usage
    [   10.588074] 4.18.0.memcg_v2+ #1 Not tainted
    [   10.593162] -----------------------------
    [   10.597203] include/linux/rcupdate.h:281 Illegal context switch in
    RCU read-side critical section!
    [   10.606220]
    [   10.606220] other info that might help us debug this:
    [   10.606220]
    [   10.614280]
    [   10.614280] rcu_scheduler_active = 2, debug_locks = 1
    [   10.620853] 3 locks held by systemd/1:
    [   10.624632]  #0: (____ptrval____) (&type->i_mutex_dir_key#5){.+.+}, at: lookup_slow+0x42/0x70
    [   10.633232]  #1: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70
    [   10.640954]  #2: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70
    
    These "rcu_read_lock+0x0/0x70" strings are not providing any useful
    information.  This commit therefore forces inlining of the rcu_read_lock()
    function so that rcu_read_lock()'s caller is instead shown.
    
    Signed-off-by: Waiman Long <longman@redhat.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 534c05d529b5..a8ed624da555 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -588,7 +588,7 @@ static inline void rcu_preempt_sleep_check(void) { }
  * read-side critical sections may be preempted and they may also block, but
  * only when acquiring spinlocks that are subject to priority inheritance.
  */
-static inline void rcu_read_lock(void)
+static __always_inline void rcu_read_lock(void)
 {
 	__rcu_read_lock();
 	__acquire(RCU);

