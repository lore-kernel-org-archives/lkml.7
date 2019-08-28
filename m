Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89564C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572AA22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567029508;
	bh=wqTBhQa/FwO0l3GXke48jyDV4xVzzW9I3m0RsMaiJhI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yZZEbkdRdwfBlOHLXjjH/NizJpFNLv1QzP5RNVEPmbmbDWO/57ovdEgQXoq2heQoq
	 opTY2iJaQ0w3JTFKvsdUblRoWA4S6ItA5GFlltXKmdFqdqDR9MO9q/iC/Jont8koAn
	 bHrF2vhnSIXLwn3LLCNAZgu1Y8otEED9jgovo57I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfH1V61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:58:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbfH1V60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:58:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SLpkLC096457;
        Wed, 28 Aug 2019 17:57:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up00dkf06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:57:52 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SLrBsw109245;
        Wed, 28 Aug 2019 17:57:51 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up00dkeyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:57:51 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SLtWRM019299;
        Wed, 28 Aug 2019 21:57:51 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 2un65k2fur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 21:57:51 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SLvonB52232568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 21:57:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AB8AB2065;
        Wed, 28 Aug 2019 21:57:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFED7B205F;
        Wed, 28 Aug 2019 21:57:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 21:57:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B3F0016C65C1; Wed, 28 Aug 2019 14:57:51 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:57:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 3/5] rcu/tree: Add support for debug_objects debugging
 for kfree_rcu()
Message-ID: <20190828215751.GB26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d657e37.1c69fb81.54250.01df@mx.google.com>
 <20190828213119.GY26530@linux.ibm.com>
 <20190828214320.GE75931@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828214320.GE75931@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:43:20PM -0400, Joel Fernandes wrote:
> On Wed, Aug 28, 2019 at 02:31:19PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 27, 2019 at 03:01:57PM -0400, Joel Fernandes (Google) wrote:
> > > Make use of RCU's debug_objects debugging support
> > > (CONFIG_DEBUG_OBJECTS_RCU_HEAD) similar to call_rcu() and other flavors.
> > 
> > Other flavors?  Ah, call_srcu(), rcu_barrier(), and srcu_barrier(),
> > right?
> 
> Yes.
> 
> > > We queue the object during the kfree_rcu() call and dequeue it during
> > > reclaim.
> > > 
> > > Tested that enabling CONFIG_DEBUG_OBJECTS_RCU_HEAD successfully detects
> > > double kfree_rcu() calls.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > The code looks good!
> 
> thanks, does that mean you'll ack/apply it? :-P

Is it independent of 1/5 and 2/5?

							Thanx, Paul

>  - Joel
> 
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  kernel/rcu/tree.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 9b9ae4db1c2d..64568f12641d 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2757,6 +2757,7 @@ static void kfree_rcu_work(struct work_struct *work)
> > >  	for (; head; head = next) {
> > >  		next = head->next;
> > >  		/* Could be possible to optimize with kfree_bulk in future */
> > > +		debug_rcu_head_unqueue(head);
> > >  		__rcu_reclaim(rcu_state.name, head);
> > >  		cond_resched_tasks_rcu_qs();
> > >  	}
> > > @@ -2868,6 +2869,13 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
> > >  		return kfree_call_rcu_nobatch(head, func);
> > >  
> > > +	if (debug_rcu_head_queue(head)) {
> > > +		/* Probable double kfree_rcu() */
> > > +		WARN_ONCE(1, "kfree_call_rcu(): Double-freed call. rcu_head %p\n",
> > > +			  head);
> > > +		return;
> > > +	}
> > > +
> > >  	head->func = func;
> > >  
> > >  	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
> > > -- 
> > > 2.23.0.187.g17f5b7556c-goog
> > > 
