Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F9C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEDA20828
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567133196;
	bh=FxE7xlat60kmVXb5PHtPX6Pm0K+r6JFeLP+3EhKc5ME=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=BepEzgLhCEgIdgj5LE5bUWHI4qGm2pDIwHpsTZrAzjblhSxgy/K5AtY3yh7JaquRg
	 4KssrGE5B9Ak521Db7el1VlbXk6mGbSpuHFljYKu+xavx8tQIhwV5iH5enFNGTqygf
	 8CTZSounEjhsmei+IBikap4sP0Eoc3f6FsdEndRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfH3Cqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:46:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbfH3Cqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:46:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7U2fliL024217;
        Thu, 29 Aug 2019 22:45:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uppvcfjnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 22:45:59 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7U2fwJn024344;
        Thu, 29 Aug 2019 22:45:59 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uppvcfjmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 22:45:59 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7U2iZpW009104;
        Fri, 30 Aug 2019 02:45:58 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 2ujvv709n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 02:45:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7U2jvcR48496946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 02:45:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B89AB2065;
        Fri, 30 Aug 2019 02:45:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 557BBB205F;
        Fri, 30 Aug 2019 02:45:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.159.7])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 02:45:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EF33C16C1D7F; Thu, 29 Aug 2019 19:45:56 -0700 (PDT)
Date:   Thu, 29 Aug 2019 19:45:56 -0700
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
Message-ID: <20190830024556.GZ4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com>
 <20190829015155.GB100789@google.com>
 <20190829034336.GD4125@linux.ibm.com>
 <20190829144355.GE63638@google.com>
 <20190829151325.GF63638@google.com>
 <20190829161301.GQ4125@linux.ibm.com>
 <20190829171454.GA115245@google.com>
 <20190830004756.GW4125@linux.ibm.com>
 <20190830012036.GA184995@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830012036.GA184995@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:20:36PM -0400, Joel Fernandes wrote:
> On Thu, Aug 29, 2019 at 05:47:56PM -0700, Paul E. McKenney wrote:
> [snip]
> > > > > Paul, also what what happens in the following scenario:
> > > > > 
> > > > > CPU0                                                 CPU1
> > > > > 
> > > > > A syscall causes rcu_eqs_exit()
> > > > > rcu_read_lock();
> > > > >                                                      ---> FQS loop waiting on
> > > > > 						           dyntick_snap
> > > > > usermode-upcall  entry -->causes rcu_eqs_enter();
> > > > > 
> > > > > usermode-upcall  exit  -->causes rcu_eqs_exit();
> > > > > 
> > > > >                                                      ---> FQS loop sees
> > > > > 						          dyntick snap
> > > > > 							  increment and
> > > > > 							  declares CPU0 is
> > > > > 							  in a QS state
> > > > > 							  before the
> > > > > 							  rcu_read_unlock!
> > > > > 
> > > > > rcu_read_unlock();
> > > > > ---
> > > > > 
> > > > > Does the context tracking not call rcu_user_enter() in this case, or did I
> > > > > really miss something?
> > > > 
> > > > Holding rcu_read_lock() across usermode execution (in this case,
> > > > the usermode upcall) is a bad idea.  Why is CPU 0 doing that?
> > > 
> > > Oh, ok. I was just hypothesizing that since usermode upcalls from
> > > something as heavy as interrupts, it could also mean we had the same from
> > > some path that held an rcu_read_lock() as well. It was just a theoretical
> > > concern, if it is not an issue, no problem.
> > 
> > Are there the usual lockdep checks in the upcall code?  Holding a spinlock
> > across them would seem to be at least as bad as holding an rcu_read_lock()
> > across them.
> 
> Great point, I'll take a look.
> 
> > > The other question I had was, in which cases would dyntick_nesting in current
> > > RCU code be > 1 (after removing the lower bit and any crowbarring) ? In the
> > > scenarios I worked out on paper, I can only see this as 1 or 0. But the
> > > wording of it is 'dynticks_nesting'. May be I am missing a nesting scenario?
> > > We can exit RCU-idleness into process context only once (either exiting idle
> > > mode or user mode). Both cases would imply a value of 1.
> > 
> > Interrrupt -> NMI -> certain types of tracing.  I believe that can get
> > it to 5.  There might be even more elaborate sequences of events.
> 
> I am only talking about dynticks_nesting, not dynticks_nmi_nesting. In
> current mainline, I see this only 0 or 1. I am running the below patch
> overnight on all RCU configurations to see if it is ever any other value.

Ah!  Then yes, we never enter non-idle/non-user process-level mode
twice without having exited it.  There would have been a splat,
I believe.

> And, please feel free to ignore my emails as you mentioned you are supposed
> to be out next 2 days! Thanks for the replies though!

Actually this day and next.  ;-)

							Thanx, Paul

> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 68ebf0eb64c8..8c8ddb6457d5 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -571,6 +571,9 @@ static void rcu_eqs_enter(bool user)
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>  		     rdp->dynticks_nesting == 0);
> +
> +	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
> +
>  	if (rdp->dynticks_nesting != 1) {
>  		rdp->dynticks_nesting--;
>  		return;
> @@ -736,6 +739,9 @@ static void rcu_eqs_exit(bool user)
>  	lockdep_assert_irqs_disabled();
>  	rdp = this_cpu_ptr(&rcu_data);
>  	oldval = rdp->dynticks_nesting;
> +
> +	WARN_ON_ONCE(rdp->dynticks_nesting != 0);
> +
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
>  	if (oldval) {
>  		rdp->dynticks_nesting++;
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
