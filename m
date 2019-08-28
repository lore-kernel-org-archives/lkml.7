Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809F0C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D942339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567027179;
	bh=XjxB11eHI7IkLFo16zN1tnfl5noViw+MqDSW0zxAxVc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=oCPKZn2yBgmkwTvhr3F7ZWOscR40DLaKLSFvaIzvAV8Vc2qA2qGZuE+XVCohv2Uea
	 kuqBS5d02RXtA0IqTkplXfAT8Vw7juegXVoVAsHHIUQYGkSxXwd/879PLxMT9OIMXX
	 tHjTYFexYAnnTO72dJ6R9xOvS+S7Og1MlRPhvFSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfH1VTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:19:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbfH1VTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:19:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SL8CRI118716;
        Wed, 28 Aug 2019 17:19:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unycmbyy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:19:04 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SL9cgk123731;
        Wed, 28 Aug 2019 17:19:04 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unycmbyxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:19:04 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SL4sW4027009;
        Wed, 28 Aug 2019 21:19:03 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 2ujvv78a3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 21:19:03 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SLJ2W747120800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 21:19:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5C42B205F;
        Wed, 28 Aug 2019 21:19:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 875C1B2064;
        Wed, 28 Aug 2019 21:19:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 21:19:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 57B7F16C65C1; Wed, 28 Aug 2019 14:19:04 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:19:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
Message-ID: <20190828211904.GX26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d648897.1c69fb81.5e60a.fc70@mx.google.com>
 <20190828202330.GS26530@linux.ibm.com>
 <20190828210525.GB75931@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828210525.GB75931@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:05:25PM -0400, Joel Fernandes wrote:
> On Wed, Aug 28, 2019 at 01:23:30PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 26, 2019 at 09:33:54PM -0400, Joel Fernandes (Google) wrote:
> > > The dynticks_nmi_nesting counter serves 4 purposes:
> > > 
> > >       (a) rcu_is_cpu_rrupt_from_idle() needs to be able to detect first
> > >           interrupt nesting level.
> > > 
> > >       (b) We need to detect half-interrupts till we are sure they're not an
> > >           issue. However, change the comparison to DYNTICK_IRQ_NONIDLE with 0.
> > > 
> > >       (c) When a quiescent state report is needed from a nohz_full CPU.
> > >           The nesting counter detects we are a first level interrupt.
> > > 
> > > For (a) we can just use dyntick_nesting == 1 to determine this. Only the
> > > outermost interrupt that interrupted an RCU-idle state can set it to 1.
> > > 
> > > For (b), this warning condition has not occurred for several kernel
> > > releases.  But we still keep the warning but change it to use
> > > in_interrupt() instead of the nesting counter. In a later year, we can
> > > remove the warning.
> > > 
> > > For (c), the nest check is not really necessary since forced_tick would
> > > have been set to true in the outermost interrupt, so the nested/NMI
> > > interrupts will check forced_tick anyway, and bail.
> > 
> > Skipping the commit log and documentation for this pass.
> [snip] 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 255cd6835526..1465a3e406f8 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -81,7 +81,6 @@
> > >  
> > >  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> > >  	.dynticks_nesting = 1,
> > > -	.dynticks_nmi_nesting = 0,
> > 
> > This should be in the previous patch, give or take naming.
> 
> Done.
> 
> > >  	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> > >  };
> > >  struct rcu_state rcu_state = {
> > > @@ -392,15 +391,9 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > >  	/* Check for counter underflows */
> > >  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> > >  			 "RCU dynticks_nesting counter underflow!");
> > > -	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> > > -			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> > >  
> > > -	/* Are we at first interrupt nesting level? */
> > > -	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> > > -		return false;
> > > -
> > > -	/* Does CPU appear to be idle from an RCU standpoint? */
> > > -	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
> > > +	/* Are we the outermost interrupt that arrived when RCU was idle? */
> > > +	return __this_cpu_read(rcu_data.dynticks_nesting) == 1;
> > >  }
> > >  
> > >  #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch ... */
> > > @@ -564,11 +557,10 @@ static void rcu_eqs_enter(bool user)
> > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > >  
> > >  	/* Entering usermode/idle from interrupt is not handled. These would
> > > -	 * mean usermode upcalls or idle entry happened from interrupts. But,
> > > -	 * reset the counter if we warn.
> > > +	 * mean usermode upcalls or idle exit happened from interrupts. Remove
> > > +	 * the warning by 2020.
> > >  	 */
> > > -	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
> > > -		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> > > +	WARN_ON_ONCE(in_interrupt());
> > 
> > And this is a red flag.  Bad things happen should some common code
> > that disables BH be invoked from the idle loop.  This might not be
> > happening now, but we need to avoid this sort of constraint.
> > How about instead merging ->dyntick_nesting into the low-order bits
> > of ->dyntick_nmi_nesting?
> > 
> > Yes, this assumes that we don't enter process level twice, but it should
> > be easy to add a WARN_ON() to test for that.  Except that we don't have
> > to because there is already this near the end of rcu_eqs_exit():
> > 
> > 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> > 
> > So the low-order bit of the combined counter could indicate process-level
> > non-idle, the next three bits could be unused to make interpretation
> > of hex printouts easier, and then the rest of the bits could be used in
> > the same way as currently.
> > 
> > This would allow a single read to see the full state, so that 0x1 means
> > at process level in the kernel, 0x11 is interrupt (or NMI) from process
> > level, 0x10 is interrupt/NMI from idle/user, and so on.
> > 
> > What am I missing here?  Why wouldn't this work, and without adding yet
> > another RCU-imposed constraint on some other subsystem?
> 
> What about replacing the warning with a WARN_ON_ONCE(in_irq()), would that
> address your concern?
> 
> Also, considering this warning condition is most likely never occurring as we
> know it, and we are considering deleting it soon enough, is it really worth
> reimplementing the whole mechanism with a complex bit-sharing scheme just
> because of the BH-disable condition you mentioned, which likely doesn't
> happen today? In my implementation, this is just a simple counter. I feel
> combining bits in the same counter will just introduce more complexity that
> this patch tries to address/avoid.
> 
> OTOH, I also don't mind with just deleting the warning altogether if you are
> Ok with that.

The big advantage of combining the counters is that all of the state is
explicit and visible in one place.  Plus it can be accessed atomically.
And it avoids setting a time bomb for some poor guys just trying to get
their idle-loop jobs done some time in the dim distant future.

Besides, this pair of patches already makes a large change from a
conceptual viewpoint.  If we are going to make a large change, let's
get our money's worth out of that change!

							Thanx, Paul
