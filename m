Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C28C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C932189D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567127391;
	bh=6jMjUtmP0H2iW36XFHXCCd3HFSbOytUyoLjhhlrmBdE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YKQRDFgG0EZXx2ZGsEk7zaNmTumYouEZTaqAwh/B8bU7Waq3ywQzdjy3lzhD8zRz4
	 zPocDSI0FcN3E8RTz82/GbT5Jp8j2ZUcDTpTu2SoWeQgGU5/WOLpgyR+OE4LilVMJY
	 Hyu/DRxC9oRMfQIFnlndBV24rL5jHCFgLvvG+EGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfH3BJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:09:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbfH3BJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:09:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7U1848w053567;
        Thu, 29 Aug 2019 21:09:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upn48rqwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 21:09:08 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7U18LLo054562;
        Thu, 29 Aug 2019 21:09:07 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upn48rqvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 21:09:07 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7U17OIK005553;
        Fri, 30 Aug 2019 01:09:06 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 2ujvv7fu62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 01:09:06 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7U195pS11797236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 01:09:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82DCCB2067;
        Fri, 30 Aug 2019 01:09:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58A6CB2075;
        Fri, 30 Aug 2019 01:09:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.201.94])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 01:09:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F128C16C0963; Thu, 29 Aug 2019 17:47:56 -0700 (PDT)
Date:   Thu, 29 Aug 2019 17:47:56 -0700
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
Message-ID: <20190830004756.GW4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190828214241.GD75931@google.com>
 <20190828220108.GC26530@linux.ibm.com>
 <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com>
 <20190829015155.GB100789@google.com>
 <20190829034336.GD4125@linux.ibm.com>
 <20190829144355.GE63638@google.com>
 <20190829151325.GF63638@google.com>
 <20190829161301.GQ4125@linux.ibm.com>
 <20190829171454.GA115245@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829171454.GA115245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 01:14:54PM -0400, Joel Fernandes wrote:
> On Thu, Aug 29, 2019 at 09:13:01AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 29, 2019 at 11:13:25AM -0400, Joel Fernandes wrote:
> > > On Thu, Aug 29, 2019 at 10:43:55AM -0400, Joel Fernandes wrote:
> > > > On Wed, Aug 28, 2019 at 08:43:36PM -0700, Paul E. McKenney wrote:
> > > > [snip]
> > > > > > > > > This change is not fixing a bug, so there is no need for an emergency fix,
> > > > > > > > > and thus no point in additional churn.  I understand that it is a bit
> > > > > > > > > annoying to code and test something and have your friendly maintainer say
> > > > > > > > > "sorry, wrong rocks", and the reason that I understand this is that I do
> > > > > > > > > that to myself rather often.
> > > > > > > > 
> > > > > > > > The motivation for me for this change is to avoid future bugs such as with
> > > > > > > > the following patch where "== 2" did not take the force write of
> > > > > > > > DYNTICK_IRQ_NONIDLE into account:
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=13c4b07593977d9288e5d0c21c89d9ba27e2ea1f
> > > > > > > 
> > > > > > > Yes, the current code does need some simplification.
> > > > > > > 
> > > > > > > > I still don't see it as pointless churn, it is also a maintenance cost in its
> > > > > > > > current form and the simplification is worth it IMHO both from a readability,
> > > > > > > > and maintenance stand point.
> > > > > > > > 
> > > > > > > > I still don't see what's technically wrong with the patch. I could perhaps
> > > > > > > > add the above "== 2" point in the patch?
> > > > > > > 
> > > > > > > I don't know of a crash or splat your patch would cause, if that is
> > > > > > > your question.  But that is also true of the current code, so the point
> > > > > > > is simplification, not bug fixing.  And from what I can see, there is an
> > > > > > > opportunity to simplify quite a bit further.  And with something like
> > > > > > > RCU, further simplification is worth -serious- consideration.
> > > > > > > 
> > > > > > > > We could also discuss f2f at LPC to see if we can agree about it?
> > > > > > > 
> > > > > > > That might make a lot of sense.
> > > > > > 
> > > > > > Sure. I am up for a further redesign / simplification. I will think more
> > > > > > about your suggestions and can also further discuss at LPC.
> > > > > 
> > > > > One question that might (or might not) help:  Given the compound counter,
> > > > > where the low-order hex digit indicates whether the corresponding CPU
> > > > > is running in a non-idle kernel task and the rest of the hex digits
> > > > > indicate the NMI-style nesting counter shifted up by four bits, what
> > > > > could rcu_is_cpu_rrupt_from_idle() be reduced to?
> > > > > 
> > > > > > And this patch is on LKML archives and is not going anywhere so there's no
> > > > > > rush I guess ;-)
> > > > > 
> > > > > True enough!  ;-)
> > > > 
> > > > Paul, do we also nuke rcu_eqs_special_set()?  Currently I don't see anyone
> > > > using it. And also remove the bottom most bit of dynticks?
> > > > 
> > > > Also what happens if a TLB flush broadcast is needed? Do we IPI nohz or idle
> > > > CPUs are the moment?
> > > > 
> > > > All of this was introduced in:
> > > > b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
> > > 
> > > 
> > > Paul, also what what happens in the following scenario:
> > > 
> > > CPU0                                                 CPU1
> > > 
> > > A syscall causes rcu_eqs_exit()
> > > rcu_read_lock();
> > >                                                      ---> FQS loop waiting on
> > > 						           dyntick_snap
> > > usermode-upcall  entry -->causes rcu_eqs_enter();
> > > 
> > > usermode-upcall  exit  -->causes rcu_eqs_exit();
> > > 
> > >                                                      ---> FQS loop sees
> > > 						          dyntick snap
> > > 							  increment and
> > > 							  declares CPU0 is
> > > 							  in a QS state
> > > 							  before the
> > > 							  rcu_read_unlock!
> > > 
> > > rcu_read_unlock();
> > > ---
> > > 
> > > Does the context tracking not call rcu_user_enter() in this case, or did I
> > > really miss something?
> > 
> > Holding rcu_read_lock() across usermode execution (in this case,
> > the usermode upcall) is a bad idea.  Why is CPU 0 doing that?
> 
> Oh, ok. I was just hypothesizing that since usermode upcalls from
> something as heavy as interrupts, it could also mean we had the same from
> some path that held an rcu_read_lock() as well. It was just a theoretical
> concern, if it is not an issue, no problem.

Are there the usual lockdep checks in the upcall code?  Holding a spinlock
across them would seem to be at least as bad as holding an rcu_read_lock()
across them.

> The other question I had was, in which cases would dyntick_nesting in current
> RCU code be > 1 (after removing the lower bit and any crowbarring) ? In the
> scenarios I worked out on paper, I can only see this as 1 or 0. But the
> wording of it is 'dynticks_nesting'. May be I am missing a nesting scenario?
> We can exit RCU-idleness into process context only once (either exiting idle
> mode or user mode). Both cases would imply a value of 1.

Interrrupt -> NMI -> certain types of tracing.  I believe that can get
it to 5.  There might be even more elaborate sequences of events.

							Thanx, Paul
