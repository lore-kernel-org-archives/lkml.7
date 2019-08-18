Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F652C3A59F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728B32186A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfHRWMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 18:12:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfHRWMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 18:12:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7IMC9qo130885
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 18:12:13 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufbth55b1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 18:12:13 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 18 Aug 2019 23:12:12 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 18 Aug 2019 23:12:08 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7IMC8Yp55050550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Aug 2019 22:12:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A0F0B2090;
        Sun, 18 Aug 2019 22:12:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD092B208D;
        Sun, 18 Aug 2019 22:12:07 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 18 Aug 2019 22:12:07 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 54DCA16C11AE; Sun, 18 Aug 2019 15:12:10 -0700 (PDT)
Date:   Sun, 18 Aug 2019 15:12:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Reply-To: paulmck@linux.ibm.com
References: <20190818214948.GA134430@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818214948.GA134430@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081822-0060-0000-0000-0000036D6FE8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011613; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01248783; UDB=6.00659172; IPR=6.01030300;
 MB=3.00028225; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-18 22:12:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081822-0061-0000-0000-00004A9950DD
Message-Id: <20190818221210.GP28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908180245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 05:49:48PM -0400, Joel Fernandes (Google) wrote:
> When we're in hard interrupt context in rcu_read_unlock_special(), we
> can still benefit from invoke_rcu_core() doing wake ups of rcuc
> threads when the !use_softirq parameter is passed.  This is safe
> to do so because:
> 
> 1. We avoid the scheduler deadlock issues thanks to the deferred_qs bit
> introduced in commit 23634ebc1d94 ("rcu: Check for wakeup-safe
> conditions in rcu_read_unlock_special()") by checking for the same in
> this patch.
> 
> 2. in_irq() implies in_interrupt() which implies raising softirq will
> not do any wake ups.
> 
> The rcuc thread which is awakened will run when the interrupt returns.
> 
> We also honor 25102de ("rcu: Only do rcu_read_unlock_special() wakeups
> if expedited") thus doing the rcuc awakening only when none of the
> following are true:
>   1. Critical section is blocking an expedited GP.
>   2. A nohz_full CPU.
> If neither of these cases are true (exp == false), then the "else" block
> will run to do the irq_work stuff.
> 
> This commit is based on a partial revert of d143b3d1cd89 ("rcu: Simplify
> rcu_read_unlock_special() deferred wakeups") with an additional in_irq()
> check added.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

OK, I will bite...  If it is safe to wake up an rcuc kthread, why
is it not safe to do raise_softirq()?

And from the nit department, looks like some whitespace damage on the
comments.

							Thanx, Paul

> ---
> v1->v2: Some minor character encoding issues in changelog corrected.
> 
> Note that I am still testing this patch, but I sent an early RFC for your
> feedback. Thanks!
> 
>  kernel/rcu/tree_plugin.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 2defc7fe74c3..f4b3055026dc 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -621,6 +621,11 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			// Using softirq, safe to awaken, and we get
>  			// no help from enabling irqs, unlike bh/preempt.
>  			raise_softirq_irqoff(RCU_SOFTIRQ);
> +		} else if (exp && in_irq() && !use_softirq &&
> +			   !t->rcu_read_unlock_special.b.deferred_qs) {
> +			// Safe to awaken rcuc kthread which will be
> +                       // scheduled in from the interrupt return path.
> +			invoke_rcu_core();
>  		} else {
>  			// Enabling BH or preempt does reschedule, so...
>  			// Also if no expediting or NO_HZ_FULL, slow is OK.
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 

