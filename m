Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE6CC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986702086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfHPQwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:52:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfHPQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:52:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GGpbCV058773;
        Fri, 16 Aug 2019 12:52:44 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udxshby7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 12:52:44 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7GGoSR5005137;
        Fri, 16 Aug 2019 16:52:43 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2u9nj7avk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 16:52:43 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GGqgUj54460688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 16:52:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C49BBB2065;
        Fri, 16 Aug 2019 16:52:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A83E9B2064;
        Fri, 16 Aug 2019 16:52:42 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 16:52:42 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7AC3B16C13A8; Fri, 16 Aug 2019 09:52:42 -0700 (PDT)
Date:   Fri, 16 Aug 2019 09:52:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in
 advance
Message-ID: <20190816165242.GS28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-3-joel@joelfernandes.org>
 <20190816162404.GB10481@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816162404.GB10481@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:24:04PM -0400, Joel Fernandes wrote:
> On Thu, Aug 15, 2019 at 10:53:11PM -0400, Joel Fernandes (Google) wrote:
> > I really cannot explain this patch, but without it, the "else if" block
> > just doesn't execute thus causing the tick's dep mask to not be set and
> > causes the tick to be turned off.
> > 
> > I tried various _ONCE() macros but the only thing that works is this
> > patch.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 856d3c9f1955..ac6bcf7614d7 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  	long incby = 2;
> > +	int dnn = rdp->dynticks_nmi_nesting;
> 
> I believe the accidental sign extension / conversion from long to int was
> giving me an illusion since things started working well. Changing the 'int
> dnn' to 'long dnn' gives similar behavior as without this patch! At least I
> know now. Please feel free to ignore this particular RFC patch while I debug
> this more (over the weekend or early next week). The first 2 patches are
> good, just ignore this one.

Ah, good point on the type!  So you were ending up with zero due to the
low-order 32 bits of DYNTICK_IRQ_NONIDLE being zero, correct?  If so,
the "!rdp->dynticks_nmi_nesting" instead needs to be something like
"rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE", which sounds like
it is actually worse then the earlier comparison against the constant 2.

Sounds like I should revert the -rcu commit 805a16eaefc3 ("rcu: Force
nohz_full tick on upon irq enter instead of exit").

Or would that once again cause RCU to fail to enable the tick?

								Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> >  
> >  	/* Complain about underflow. */
> >  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
> > @@ -826,7 +827,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >  
> >  		incby = 1;
> >  	} else if (tick_nohz_full_cpu(rdp->cpu) &&
> > -		   !rdp->dynticks_nmi_nesting &&
> > +		   !dnn &&
> >  		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> >  		rdp->rcu_forced_tick = true;
> >  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> > -- 
> > 2.23.0.rc1.153.gdeed80330f-goog
> > 
> 
