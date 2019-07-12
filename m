Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A240C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5BB20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfGLNBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:01:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727045AbfGLNBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:01:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CCxdgn137509;
        Fri, 12 Jul 2019 09:01:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tprnbdpt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 09:01:08 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6CD0Z73142609;
        Fri, 12 Jul 2019 09:01:08 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tprnbdpss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 09:01:08 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6CD0fqi021601;
        Fri, 12 Jul 2019 13:01:07 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 2tjk973q99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 13:01:07 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CD16PW46137692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 13:01:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DE60B207E;
        Fri, 12 Jul 2019 13:01:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15AC1B207D;
        Fri, 12 Jul 2019 13:01:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.195.235])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 13:01:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C989916C1A2F; Fri, 12 Jul 2019 06:01:05 -0700 (PDT)
Date:   Fri, 12 Jul 2019 06:01:05 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190712130105.GL26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711195839.GA163275@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> On Thu, Jul 11, 2019 at 12:48:18PM -0400, Joel Fernandes wrote:
> > On Thu, Jul 11, 2019 at 08:02:15AM -0700, Paul E. McKenney wrote:
> > > On Thu, Jul 11, 2019 at 09:08:49AM -0400, Joel Fernandes wrote:
> > > > On Thu, Jul 11, 2019 at 05:30:52AM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Jul 10, 2019 at 10:20:25AM +0900, Byungchul Park wrote:
> > > > > > On Tue, Jul 09, 2019 at 05:41:02AM -0700, Paul E. McKenney wrote:
> > > > > > > > Hi Paul,
> > > > > > > > 
> > > > > > > > IMHO, as much as we want to tune the time for fqs to be initiated, we
> > > > > > > > can also want to tune the time for the help from scheduler to start.
> > > > > > > > I thought only difference between them is a level of urgency. I might be
> > > > > > > > wrong. It would be appreciated if you let me know if I miss something.
> > > > > > > 
> > > > > > > Hello, Byungchul,
> > > > > > > 
> > > > > > > I understand that one hypothetically might want to tune this at runtime,
> > > > > > > but have you had need to tune this at runtime on a real production
> > > > > > > workload?  If so, what problem was happening that caused you to want to
> > > > > > > do this tuning?
> > > > > > 
> > > > > > Not actually.
> > > > > > 
> > > > > > > > And it's ok even if the patch is turned down based on your criteria. :)
> > > > > > > 
> > > > > > > If there is a real need, something needs to be provided to meet that
> > > > > > > need.  But in the absence of a real need, past experience has shown
> > > > > > > that speculative tuning knobs usually do more harm than good.  ;-)
> > > > > > 
> > > > > > It makes sense, "A speculative tuning knobs do more harm than good".
> > > > > > 
> > > > > > Then, it would be better to leave jiffies_till_{first,next}_fqs tunnable
> > > > > > but jiffies_till_sched_qs until we need it.
> > > > > > 
> > > > > > However,
> > > > > > 
> > > > > > (1) In case that jiffies_till_sched_qs is tunnable:
> > > > > > 
> > > > > > 	We might need all of jiffies_till_{first,next}_qs,
> > > > > > 	jiffies_till_sched_qs and jiffies_to_sched_qs because
> > > > > > 	jiffies_to_sched_qs can be affected by any of them. So we
> > > > > > 	should be able to read each value at any time.
> > > > > > 
> > > > > > (2) In case that jiffies_till_sched_qs is not tunnable:
> > > > > > 
> > > > > > 	I think we don't have to keep the jiffies_till_sched_qs any
> > > > > > 	longer since that's only for setting jiffies_to_sched_qs at
> > > > > > 	*booting time*, which can be done with jiffies_to_sched_qs too.
> > > > > > 	It's meaningless to keep all of tree variables.
> > > > > > 
> > > > > > The simpler and less knobs that we really need we have, the better.
> > > > > > 
> > > > > > what do you think about it?
> > > > > > 
> > > > > > In the following patch, I (1) removed jiffies_till_sched_qs and then
> > > > > > (2) renamed jiffies_*to*_sched_qs to jiffies_*till*_sched_qs because I
> > > > > > think jiffies_till_sched_qs is a much better name for the purpose. I
> > > > > > will resend it with a commit msg after knowing your opinion on it.
> > > > > 
> > > > > I will give you a definite "maybe".
> > > > > 
> > > > > Here are the two reasons for changing RCU's embarrassingly large array
> > > > > of tuning parameters:
> > > > > 
> > > > > 1.	They are causing a problem in production.  This would represent a
> > > > > 	bug that clearly must be fixed.  As you say, this change is not
> > > > > 	in this category.
> > > > > 
> > > > > 2.	The change simplifies either RCU's code or the process of tuning
> > > > > 	RCU, but without degrading RCU's ability to run everywhere and
> > > > > 	without removing debugging tools.
> > > > > 
> > > > > The change below clearly simplifies things by removing a few lines of
> > > > > code, and it does not change RCU's default self-configuration.  But are
> > > > > we sure about the debugging aspect?  (Please keep in mind that many more
> > > > > sites are willing to change boot parameters than are willing to patch
> > > > > their kernels.)
> > > > > 
> > > > > What do you think?
> > > > 
> > > > Just to add that independent of whether the runtime tunable make sense or
> > > > not, may be it is still worth correcting the 0444 to be 0644 to be a separate
> > > > patch?
> > > 
> > > You lost me on this one.  Doesn't changing from 0444 to 0644 make it be
> > > a runtime tunable?
> > 
> > I was going by our earlier discussion that the parameter is still writable at
> > boot time. You mentioned something like the following:
> > ---
> > In Byungchul's defense, the current module_param() permissions are
> > 0444, which really is read-only.  Although I do agree that they can
> > be written at boot, one could use this same line of reasoning to argue
> > that const variables can be written at compile time (or, for on-stack
> > const variables, at function-invocation time).  But we still call them
> > "const".
> > ---
> > 
> > Sorry if I got confused. You are right that we could leave it as read-only.
> > 
> > > > > Finally, I urge you to join with Joel Fernandes and go through these
> > > > > grace-period-duration tuning parameters.  Once you guys get your heads
> > > > > completely around all of them and how they interact across the different
> > > > > possible RCU configurations, I bet that the two of you will have excellent
> > > > > ideas for improvement.
> > > >
> > > > Yes, I am quite happy to join forces. Byungchul, let me know what about this
> > > > or other things you had in mind. I have some other RCU topics too I am trying
> > > > to get my head around and planning to work on more patches.
> > > >
> > > > Paul, in case you had any other specific tunables or experiments in mind, let
> > > > me know. I am quite happy to try out new experiments and learn something
> > > > based on tuning something.
> > >
> > > These would be the tunables controlling how quickly RCU takes its
> > > various actions to encourage the current grace period to end quickly.
> > > I would be happy to give you the exact list if you wish, but most of
> > > them have appeared in this thread.
> > >
> > > The experiments should be designed to work out whether the current
> > > default settings have configurations where they act badly.  This might
> > > also come up with advice for people attempting hand-tuning, or proposed
> > > parameter-checking code to avoid bad combinations.
> > >
> > > For one example, setting the RCU CPU stall timeout too low will definitely
> > > cause some unwanted splats.  (Yes, one could argue that other things in
> > > the kernel should change to allow this value to decrease, but things
> > > like latency tracer and friends are probably more useful and important.)
> > 
> > Ok, thank you for the hints. 
> 
> Hmm, speaking of grace period durations, it seems to me the maximum grace
> period ever is recorded in rcu_state.gp_max. However it is not read from
> anywhere.
> 
> Any idea why it was added but not used?

If I remember correclty, it used to be used in debugfs prints.  It is
useful for working out how low you can decrease rcutorture.stall_cpu to
without getting RCU CPU stall warnings.  A rather infrequent need,
given that the mainline default has been adjusted only once.

> I am interested in dumping this value just for fun, and seeing what I get.
> 
> I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> issues, or even expose it in sys/proc fs to see what worst case grace periods
> look like.

That might be worthwhile.

							Thanx, Paul
