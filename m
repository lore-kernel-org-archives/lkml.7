Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF1CC73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009F821537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfGIMnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:43:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbfGIMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:43:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69Ch3v6098974
        for <linux-kernel@vger.kernel.org>; Tue, 9 Jul 2019 08:43:40 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmu64810a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 08:43:39 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 9 Jul 2019 13:43:38 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Jul 2019 13:43:35 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x69ChYrK48759238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jul 2019 12:43:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89FD6B2066;
        Tue,  9 Jul 2019 12:43:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CCBDB2064;
        Tue,  9 Jul 2019 12:43:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 12:43:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 61B0916C29D7; Tue,  9 Jul 2019 05:43:35 -0700 (PDT)
Date:   Tue, 9 Jul 2019 05:43:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Reply-To: paulmck@linux.ibm.com
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190708131942.GH26519@linux.ibm.com>
 <20190709060558.GB19459@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709060558.GB19459@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070912-0072-0000-0000-00000446236D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011400; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01229684; UDB=6.00647637; IPR=6.01010943;
 MB=3.00027649; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-09 12:43:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070912-0073-0000-0000-00004CB665D8
Message-Id: <20190709124335.GS26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 03:05:58PM +0900, Byungchul Park wrote:
> On Mon, Jul 08, 2019 at 06:19:42AM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 08, 2019 at 09:03:59AM -0400, Joel Fernandes wrote:
> > > Good morning!
> > > 
> > > On Mon, Jul 08, 2019 at 05:50:13AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Jul 08, 2019 at 03:00:09PM +0900, Byungchul Park wrote:
> > > > > jiffies_till_sched_qs is useless if it's readonly as it is used to set
> > > > > jiffies_to_sched_qs with its value regardless of first/next fqs jiffies.
> > > > > And it should be applied immediately on change through sysfs.
> > > 
> > > It is interesting it can be setup at boot time, but not at runtime. I think
> > > this can be mentioned in the change log that it is not really "read-only",
> > > because it is something that can be dynamically changed as a kernel boot
> > > parameter.
> > 
> > In Byungchul's defense, the current module_param() permissions are
> > 0444, which really is read-only.  Although I do agree that they can
> > be written at boot, one could use this same line of reasoning to argue
> > that const variables can be written at compile time (or, for on-stack
> > const variables, at function-invocation time).  But we still call them
> > "const".
> 
> ;-)
> 
> > > > Actually, the intent was to only allow this to be changed at boot time.
> > > > Of course, if there is now a good reason to adjust it, it needs
> > > > to be adjustable.  So what situation is making you want to change
> > > > jiffies_till_sched_qs at runtime?  To what values is it proving useful
> > > > to adjust it?  What (if any) relationships between this timeout and the
> > > > various other RCU timeouts need to be maintained?  What changes to
> > > > rcutorture should be applied in order to test the ability to change
> > > > this at runtime?
> > > 
> > > I am also interested in the context, are you changing it at runtime for
> > > experimentation? I recently was doing some performance experiments and it is
> > > quite interesting how reducing this value can shorten grace period times :)
> > 
> > If you -really- want to reduce grace-period latencies, you can always
> > boot with rcupdate.rcu_expedited=1.  ;-)
> 
> It's a quite different mechanism at the moment though... :(

Quite true, but a rather effective mechanism for reducing grace-period
latency, give or take the needs of aggressive real-time workloads.

> > If you want to reduce grace-period latencies, but without all the IPIs
> > that expedited grace periods give you, the rcutree.jiffies_till_first_fqs
> > and rcutree.jiffies_till_next_fqs kernel boot parameters might be better
> > places to start than rcutree.jiffies_till_sched_qs.  For one thing,
> > adjusting these two affects the value of jiffies_till_sched_qs.
> 
> Do you mean:
> 
> adjusting these two affects the value of *jiffies_to_sched_qs* (instead
> of jiffies_till_sched_qs).
> 
> Right?

Yes, and apologies for my confusion!

							Thaxn, Paul

> Thanks,
> Byungchul
> 
> > 
> > 							Thanx, Paul
> > 
> > > Joel
> > > 
> > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > The function for setting jiffies_to_sched_qs,
> > > > > adjust_jiffies_till_sched_qs() will be called only if
> > > > > the value from sysfs != ULONG_MAX. And the value won't be adjusted
> > > > > unlike first/next fqs jiffies.
> > > > > 
> > > > > While at it, changed the positions of two module_param()s downward.
> > > > > 
> > > > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 22 ++++++++++++++++++++--
> > > > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index a2f8ba2..a28e2fe 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -422,9 +422,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > > > >   * quiescent-state help from rcu_note_context_switch().
> > > > >   */
> > > > >  static ulong jiffies_till_sched_qs = ULONG_MAX;
> > > > > -module_param(jiffies_till_sched_qs, ulong, 0444);
> > > > >  static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
> > > > > -module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > > > >  
> > > > >  /*
> > > > >   * Make sure that we give the grace-period kthread time to detect any
> > > > > @@ -450,6 +448,18 @@ static void adjust_jiffies_till_sched_qs(void)
> > > > >  	WRITE_ONCE(jiffies_to_sched_qs, j);
> > > > >  }
> > > > >  
> > > > > +static int param_set_sched_qs_jiffies(const char *val, const struct kernel_param *kp)
> > > > > +{
> > > > > +	ulong j;
> > > > > +	int ret = kstrtoul(val, 0, &j);
> > > > > +
> > > > > +	if (!ret && j != ULONG_MAX) {
> > > > > +		WRITE_ONCE(*(ulong *)kp->arg, j);
> > > > > +		adjust_jiffies_till_sched_qs();
> > > > > +	}
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > >  static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> > > > >  {
> > > > >  	ulong j;
> > > > > @@ -474,6 +484,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > +static struct kernel_param_ops sched_qs_jiffies_ops = {
> > > > > +	.set = param_set_sched_qs_jiffies,
> > > > > +	.get = param_get_ulong,
> > > > > +};
> > > > > +
> > > > >  static struct kernel_param_ops first_fqs_jiffies_ops = {
> > > > >  	.set = param_set_first_fqs_jiffies,
> > > > >  	.get = param_get_ulong,
> > > > > @@ -484,8 +499,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> > > > >  	.get = param_get_ulong,
> > > > >  };
> > > > >  
> > > > > +module_param_cb(jiffies_till_sched_qs, &sched_qs_jiffies_ops, &jiffies_till_sched_qs, 0644);
> > > > >  module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
> > > > >  module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
> > > > > +
> > > > > +module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > > > >  module_param(rcu_kick_kthreads, bool, 0644);
> > > > >  
> > > > >  static void force_qs_rnp(int (*f)(struct rcu_data *rdp));
> > > > > -- 
> > > > > 1.9.1
> > > > > 
> > > > 
> > > 
> 

