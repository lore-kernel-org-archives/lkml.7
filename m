Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180CFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F6C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfHSQoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:44:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbfHSQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:44:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JGhmrs130085;
        Mon, 19 Aug 2019 12:44:17 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufwdy5yqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 12:44:17 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7JGYSeQ002650;
        Mon, 19 Aug 2019 16:44:16 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 2ue975snkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 16:44:16 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JGiG5g34144596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 16:44:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 274C5B2068;
        Mon, 19 Aug 2019 16:44:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC8F7B2065;
        Mon, 19 Aug 2019 16:44:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 16:44:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1D30B16C2F18; Mon, 19 Aug 2019 09:44:20 -0700 (PDT)
Date:   Mon, 19 Aug 2019 09:44:20 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu dev 1/3] rcu/tree: tick_dep_set/clear_cpu should
 accept bits instead of masks
Message-ID: <20190819164420.GA28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190819123837.GC27088@lenoir>
 <20190819144632.GW28441@linux.ibm.com>
 <20190819163226.GE27088@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819163226.GE27088@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 06:32:27PM +0200, Frederic Weisbecker wrote:
> On Mon, Aug 19, 2019 at 07:46:32AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 19, 2019 at 02:38:38PM +0200, Frederic Weisbecker wrote:
> > > On Thu, Aug 15, 2019 at 10:53:09PM -0400, Joel Fernandes (Google) wrote:
> > > > This commit fixes the issue.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 29 +++++++++++++++++------------
> > > >  1 file changed, 17 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 0512de9ead20..322b1b57967c 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -829,7 +829,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > > >  		   !rdp->dynticks_nmi_nesting &&
> > > >  		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > > >  		rdp->rcu_forced_tick = true;
> > > > -		tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > > > +		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> > > 
> > > Did I suggest you to use the _MASK_ value? That was a bit mean.
> > > Sorry for all that lost debugging time :-(
> > 
> > At some point, I should have looked at the other calls to these
> > functions.  :-/
> > 
> > But would the following patch make sense?  This would not help for (say)
> > use of TICK_MASK_BIT_POSIX_TIMER instead of TICK_DEP_BIT_POSIX_TIMER, but
> > would help for any new values that might be added later on.  And currently
> > for TICK_DEP_MASK_CLOCK_UNSTABLE and TICK_DEP_MASK_RCU.
> 
> I'd rather make the TICK_DEP_MASK_* values private to kernel/time/tick-sched.c but
> that means I need to re-arrange a bit include/trace/events/timer.h

That would be even better!  For one thing, it would detect misuse of
-all- of the _MASK_ values.  ;-)

> I'm looking into it. Meanwhile, your below patch that checks for the max value is
> still valuable.

If I were to push it, it would be v5.5 before it showed up.  My guess
is therefore that I should keep it for my own internal use in the near
term, but not push it.  If you would like to take it, feel free to use
my Signed-off-by.

							Thanx, Paul

> Thanks.
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index 39eb44564058..4ed788ce5762 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -111,6 +111,7 @@ enum tick_dep_bits {
> >  	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
> >  	TICK_DEP_BIT_RCU		= 4
> >  };
> > +#define TICK_DEP_BIT_MAX TICK_DEP_BIT_RCU
> >  
> >  #define TICK_DEP_MASK_NONE		0
> >  #define TICK_DEP_MASK_POSIX_TIMER	(1 << TICK_DEP_BIT_POSIX_TIMER)
> > @@ -215,24 +216,28 @@ extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
> >   */
> >  static inline void tick_dep_set(enum tick_dep_bits bit)
> >  {
> > +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
> >  	if (tick_nohz_full_enabled())
> >  		tick_nohz_dep_set(bit);
> >  }
> >  
> >  static inline void tick_dep_clear(enum tick_dep_bits bit)
> >  {
> > +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
> >  	if (tick_nohz_full_enabled())
> >  		tick_nohz_dep_clear(bit);
> >  }
> >  
> >  static inline void tick_dep_set_cpu(int cpu, enum tick_dep_bits bit)
> >  {
> > +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
> >  	if (tick_nohz_full_cpu(cpu))
> >  		tick_nohz_dep_set_cpu(cpu, bit);
> >  }
> >  
> >  static inline void tick_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
> >  {
> > +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
> >  	if (tick_nohz_full_cpu(cpu))
> >  		tick_nohz_dep_clear_cpu(cpu, bit);
> >  }
> > @@ -240,24 +245,28 @@ static inline void tick_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
> >  static inline void tick_dep_set_task(struct task_struct *tsk,
> >  				     enum tick_dep_bits bit)
> >  {
> > +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
> >  	if (tick_nohz_full_enabled())
> >  		tick_nohz_dep_set_task(tsk, bit);
> >  }
> >  static inline void tick_dep_clear_task(struct task_struct *tsk,
> >  				       enum tick_dep_bits bit)
> >  {
> > +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
> >  	if (tick_nohz_full_enabled())
> >  		tick_nohz_dep_clear_task(tsk, bit);
> >  }
> >  static inline void tick_dep_set_signal(struct signal_struct *signal,
> >  				       enum tick_dep_bits bit)
> >  {
> > +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
> >  	if (tick_nohz_full_enabled())
> >  		tick_nohz_dep_set_signal(signal, bit);
> >  }
> >  static inline void tick_dep_clear_signal(struct signal_struct *signal,
> >  					 enum tick_dep_bits bit)
> >  {
> > +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
> >  	if (tick_nohz_full_enabled())
> >  		tick_nohz_dep_clear_signal(signal, bit);
> >  }
> 
