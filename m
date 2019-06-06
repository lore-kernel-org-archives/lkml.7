Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D68FC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78595207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfFFNv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:51:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfFFNv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:51:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56Di7u6111614
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 09:51:58 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy2spcjv4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:51:57 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 6 Jun 2019 14:51:56 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 14:51:50 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x56Dpn7V34013514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 13:51:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9604B2064;
        Thu,  6 Jun 2019 13:51:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A79A0B205F;
        Thu,  6 Jun 2019 13:51:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.209.205])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jun 2019 13:51:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 279D516C5DA1; Thu,  6 Jun 2019 06:51:49 -0700 (PDT)
Date:   Thu, 6 Jun 2019 06:51:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH RFC tip/core/rcu] Restore barrier() to rcu_read_lock()
 and rcu_read_unlock()
Reply-To: paulmck@linux.ibm.com
References: <20190606131933.GA12576@linux.ibm.com>
 <20190606134233.saqa3insjv75xu6o@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606134233.saqa3insjv75xu6o@gondor.apana.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060613-0052-0000-0000-000003CC3CE1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011223; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01214074; UDB=6.00638159; IPR=6.00995154;
 MB=3.00027206; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-06 13:51:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060613-0053-0000-0000-00006135288C
Message-Id: <20190606135149.GM28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 09:42:33PM +0800, Herbert Xu wrote:
> On Thu, Jun 06, 2019 at 06:19:33AM -0700, Paul E. McKenney wrote:
> > Commit bb73c52bad36 ("rcu: Don't disable preemption for Tiny and Tree
> > RCU readers") removed the barrier() calls from rcu_read_lock() and
> > rcu_write_lock() in CONFIG_PREEMPT=n&&CONFIG_PREEMPT_COUNT=n kernels.
> > Within RCU, this commit was OK, but it failed to account for things like
> > get_user() that can pagefault and that can be reordered by the compiler.
> > Lack of the barrier() calls in rcu_read_lock() and rcu_read_unlock()
> > can cause these page faults to migrate into RCU read-side critical
> > sections, which in CONFIG_PREEMPT=n kernels could result in too-short
> > grace periods and arbitrary misbehavior.  Please see commit 386afc91144b
> > ("spinlocks and preemption points need to be at least compiler barriers")
> > for more details.
> > 
> > This commit therefore restores the barrier() call to both rcu_read_lock()
> > and rcu_read_unlock().  It also removes them from places in the RCU update
> > machinery that used to need compensatory barrier() calls, effectively
> > reverting commit bb73c52bad36 ("rcu: Don't disable preemption for Tiny
> > and Tree RCU readers").
> > 
> > Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> Paul, Linus has already commited his patch:
> 
> commit 66be4e66a7f422128748e3c3ef6ee72b20a6197b
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon Jun 3 13:26:20 2019 -0700
> 
>     rcu: locking and unlocking need to always be at least barriers
> 
> So you'll need to rebase this.

Thank you for letting me know.  Easy enough to do, just remove those
two hunks from my patch.

							Thanx, Paul

