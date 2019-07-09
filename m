Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F39C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAFE21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfGIMli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:41:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbfGIMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:41:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69Cbjlh018060;
        Tue, 9 Jul 2019 08:41:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmtq2159n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 08:41:04 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x69CbrTw018658;
        Tue, 9 Jul 2019 08:41:03 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmtq2158r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 08:41:03 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x69CdPgv010183;
        Tue, 9 Jul 2019 12:41:02 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 2tjk96my6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 12:41:02 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x69Cf1iL43974960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jul 2019 12:41:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B9FCB2071;
        Tue,  9 Jul 2019 12:41:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CF93B2064;
        Tue,  9 Jul 2019 12:41:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 12:41:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2EAD216C29D7; Tue,  9 Jul 2019 05:41:02 -0700 (PDT)
Date:   Tue, 9 Jul 2019 05:41:02 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190709124102.GR26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709055815.GA19459@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 02:58:16PM +0900, Byungchul Park wrote:
> On Mon, Jul 08, 2019 at 09:03:59AM -0400, Joel Fernandes wrote:
> > > Actually, the intent was to only allow this to be changed at boot time.
> > > Of course, if there is now a good reason to adjust it, it needs
> > > to be adjustable.  So what situation is making you want to change
> > > jiffies_till_sched_qs at runtime?  To what values is it proving useful
> > > to adjust it?  What (if any) relationships between this timeout and the
> > > various other RCU timeouts need to be maintained?  What changes to
> > > rcutorture should be applied in order to test the ability to change
> > > this at runtime?
> > 
> > I am also interested in the context, are you changing it at runtime for
> > experimentation? I recently was doing some performance experiments and it is
> > quite interesting how reducing this value can shorten grace period times :)
> 
> Hi Joel,
> 
> I've read a thread talking about your experiment to see how the grace
> periods change depending on the tunnable variables which was interesting
> to me. While reading it, I found out jiffies_till_sched_qs is not
> tunnable at runtime unlike jiffies_till_{first,next}_fqs which looks
> like non-sense to me that's why I tried this patch. :)
> 
> Hi Paul,
> 
> IMHO, as much as we want to tune the time for fqs to be initiated, we
> can also want to tune the time for the help from scheduler to start.
> I thought only difference between them is a level of urgency. I might be
> wrong. It would be appreciated if you let me know if I miss something.

Hello, Byungchul,

I understand that one hypothetically might want to tune this at runtime,
but have you had need to tune this at runtime on a real production
workload?  If so, what problem was happening that caused you to want to
do this tuning?

> And it's ok even if the patch is turned down based on your criteria. :)

If there is a real need, something needs to be provided to meet that
need.  But in the absence of a real need, past experience has shown
that speculative tuning knobs usually do more harm than good.  ;-)

Hence my question to you about a real need.

							Thanx, Paul

> Thanks,
> Byungchul
> 
> > Joel
> > 
> > 
> > > 							Thanx, Paul
> > > 
> > > > The function for setting jiffies_to_sched_qs,
> > > > adjust_jiffies_till_sched_qs() will be called only if
> > > > the value from sysfs != ULONG_MAX. And the value won't be adjusted
> > > > unlike first/next fqs jiffies.
> > > > 
> > > > While at it, changed the positions of two module_param()s downward.
> > > > 
> > > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > > ---
> > > >  kernel/rcu/tree.c | 22 ++++++++++++++++++++--
> > > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index a2f8ba2..a28e2fe 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -422,9 +422,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > > >   * quiescent-state help from rcu_note_context_switch().
> > > >   */
> > > >  static ulong jiffies_till_sched_qs = ULONG_MAX;
> > > > -module_param(jiffies_till_sched_qs, ulong, 0444);
> > > >  static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
> > > > -module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > > >  
> > > >  /*
> > > >   * Make sure that we give the grace-period kthread time to detect any
> > > > @@ -450,6 +448,18 @@ static void adjust_jiffies_till_sched_qs(void)
> > > >  	WRITE_ONCE(jiffies_to_sched_qs, j);
> > > >  }
> > > >  
> > > > +static int param_set_sched_qs_jiffies(const char *val, const struct kernel_param *kp)
> > > > +{
> > > > +	ulong j;
> > > > +	int ret = kstrtoul(val, 0, &j);
> > > > +
> > > > +	if (!ret && j != ULONG_MAX) {
> > > > +		WRITE_ONCE(*(ulong *)kp->arg, j);
> > > > +		adjust_jiffies_till_sched_qs();
> > > > +	}
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> > > >  {
> > > >  	ulong j;
> > > > @@ -474,6 +484,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static struct kernel_param_ops sched_qs_jiffies_ops = {
> > > > +	.set = param_set_sched_qs_jiffies,
> > > > +	.get = param_get_ulong,
> > > > +};
> > > > +
> > > >  static struct kernel_param_ops first_fqs_jiffies_ops = {
> > > >  	.set = param_set_first_fqs_jiffies,
> > > >  	.get = param_get_ulong,
> > > > @@ -484,8 +499,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> > > >  	.get = param_get_ulong,
> > > >  };
> > > >  
> > > > +module_param_cb(jiffies_till_sched_qs, &sched_qs_jiffies_ops, &jiffies_till_sched_qs, 0644);
> > > >  module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
> > > >  module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
> > > > +
> > > > +module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > > >  module_param(rcu_kick_kthreads, bool, 0644);
> > > >  
> > > >  static void force_qs_rnp(int (*f)(struct rcu_data *rdp));
> > > > -- 
> > > > 1.9.1
> > > > 
> > > 
> 
