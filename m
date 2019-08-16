Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3773C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2B42086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfHPRai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:30:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727347AbfHPRai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:30:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GHQXxa179836;
        Fri, 16 Aug 2019 13:30:35 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2udx197d5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 13:30:34 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7GHUHdO004704;
        Fri, 16 Aug 2019 17:30:34 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2u9nj7cn14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 17:30:34 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GHUXmp54853970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 17:30:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36F29B2067;
        Fri, 16 Aug 2019 17:30:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AA9EB2065;
        Fri, 16 Aug 2019 17:30:33 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 17:30:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DC98816C28A9; Fri, 16 Aug 2019 10:30:32 -0700 (PDT)
Date:   Fri, 16 Aug 2019 10:30:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in
 advance
Message-ID: <20190816173032.GV28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-3-joel@joelfernandes.org>
 <20190816162404.GB10481@google.com>
 <20190816165242.GS28441@linux.ibm.com>
 <20190816170700.GC10481@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816170700.GC10481@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:07:00PM -0400, Joel Fernandes wrote:
> On Fri, Aug 16, 2019 at 09:52:42AM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 16, 2019 at 12:24:04PM -0400, Joel Fernandes wrote:
> > > On Thu, Aug 15, 2019 at 10:53:11PM -0400, Joel Fernandes (Google) wrote:
> > > > I really cannot explain this patch, but without it, the "else if" block
> > > > just doesn't execute thus causing the tick's dep mask to not be set and
> > > > causes the tick to be turned off.
> > > > 
> > > > I tried various _ONCE() macros but the only thing that works is this
> > > > patch.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 856d3c9f1955..ac6bcf7614d7 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > > >  {
> > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >  	long incby = 2;
> > > > +	int dnn = rdp->dynticks_nmi_nesting;
> > > 
> > > I believe the accidental sign extension / conversion from long to int was
> > > giving me an illusion since things started working well. Changing the 'int
> > > dnn' to 'long dnn' gives similar behavior as without this patch! At least I
> > > know now. Please feel free to ignore this particular RFC patch while I debug
> > > this more (over the weekend or early next week). The first 2 patches are
> > > good, just ignore this one.
> > 
> > Ah, good point on the type!  So you were ending up with zero due to the
> > low-order 32 bits of DYNTICK_IRQ_NONIDLE being zero, correct?  If so,
> > the "!rdp->dynticks_nmi_nesting" instead needs to be something like
> > "rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE", which sounds like
> > it is actually worse then the earlier comparison against the constant 2.
> > 
> > Sounds like I should revert the -rcu commit 805a16eaefc3 ("rcu: Force
> > nohz_full tick on upon irq enter instead of exit").
> 
> I think just using doing " == DYNTICK_IRQ_NONIDLE" as you mentioned should
> make it work. I'll test that soon, thanks!

My first step is indeed to add "== DYNTICK_IRQ_NONIDLE".

> I would prefer not to revert that commit, and just make the above change.
> Just because I feel this is safer. Since the tick is turned off in the IRQ
> exit path, I am a bit worried about timing (does the tick turn off before RCU
> sees the IRQ exit, or after it?). Either way, doing it on IRQ entry makes the
> question irrelevant and immune to future changes in the timing.

Well, comparing to 0x2 is probably cheaper than comparing to
0x4000000000000000 on most architectures.  Probably not a really big
deal, but this is after all the interrupt-entry fastpath.  Or is the
compiler trickier than I am giving it credit for?  (Still, seems like
comparing to 0x2 is one small instruction and to 0x4000000000000000 is
one big instruction at the very least, and probably several instructions
on many architectures.)

But to your point, if it is absolutely necessary to turn on the tick
at interrupt entry, then the larger comparison cannot be avoided.

> Would you think the check for the nesting variable is more expensive to do on
> IRQ entry than exit? If so, we could discuss doing it in the exit path,
> otherwise we could doing on entry with just the above change in the equality
> condition.

Yes, but let's see what is possible.  ;-)

							Thanx, Paul
