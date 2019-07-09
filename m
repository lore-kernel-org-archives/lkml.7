Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247B9C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E322166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfGIF7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:59:12 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:49028 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfGIF7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:59:12 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 9 Jul 2019 14:59:09 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.121 with ESMTP; 9 Jul 2019 14:59:09 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 9 Jul 2019 14:58:16 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190709055815.GA19459@X58A-UD3R>
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708130359.GA42888@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 09:03:59AM -0400, Joel Fernandes wrote:
> > Actually, the intent was to only allow this to be changed at boot time.
> > Of course, if there is now a good reason to adjust it, it needs
> > to be adjustable.  So what situation is making you want to change
> > jiffies_till_sched_qs at runtime?  To what values is it proving useful
> > to adjust it?  What (if any) relationships between this timeout and the
> > various other RCU timeouts need to be maintained?  What changes to
> > rcutorture should be applied in order to test the ability to change
> > this at runtime?
> 
> I am also interested in the context, are you changing it at runtime for
> experimentation? I recently was doing some performance experiments and it is
> quite interesting how reducing this value can shorten grace period times :)

Hi Joel,

I've read a thread talking about your experiment to see how the grace
periods change depending on the tunnable variables which was interesting
to me. While reading it, I found out jiffies_till_sched_qs is not
tunnable at runtime unlike jiffies_till_{first,next}_fqs which looks
like non-sense to me that's why I tried this patch. :)

Hi Paul,

IMHO, as much as we want to tune the time for fqs to be initiated, we
can also want to tune the time for the help from scheduler to start.
I thought only difference between them is a level of urgency. I might be
wrong. It would be appreciated if you let me know if I miss something.

And it's ok even if the patch is turned down based on your criteria. :)

Thanks,
Byungchul

> Joel
> 
> 
> > 							Thanx, Paul
> > 
> > > The function for setting jiffies_to_sched_qs,
> > > adjust_jiffies_till_sched_qs() will be called only if
> > > the value from sysfs != ULONG_MAX. And the value won't be adjusted
> > > unlike first/next fqs jiffies.
> > > 
> > > While at it, changed the positions of two module_param()s downward.
> > > 
> > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > ---
> > >  kernel/rcu/tree.c | 22 ++++++++++++++++++++--
> > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index a2f8ba2..a28e2fe 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -422,9 +422,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > >   * quiescent-state help from rcu_note_context_switch().
> > >   */
> > >  static ulong jiffies_till_sched_qs = ULONG_MAX;
> > > -module_param(jiffies_till_sched_qs, ulong, 0444);
> > >  static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
> > > -module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > >  
> > >  /*
> > >   * Make sure that we give the grace-period kthread time to detect any
> > > @@ -450,6 +448,18 @@ static void adjust_jiffies_till_sched_qs(void)
> > >  	WRITE_ONCE(jiffies_to_sched_qs, j);
> > >  }
> > >  
> > > +static int param_set_sched_qs_jiffies(const char *val, const struct kernel_param *kp)
> > > +{
> > > +	ulong j;
> > > +	int ret = kstrtoul(val, 0, &j);
> > > +
> > > +	if (!ret && j != ULONG_MAX) {
> > > +		WRITE_ONCE(*(ulong *)kp->arg, j);
> > > +		adjust_jiffies_till_sched_qs();
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > >  static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> > >  {
> > >  	ulong j;
> > > @@ -474,6 +484,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> > >  	return ret;
> > >  }
> > >  
> > > +static struct kernel_param_ops sched_qs_jiffies_ops = {
> > > +	.set = param_set_sched_qs_jiffies,
> > > +	.get = param_get_ulong,
> > > +};
> > > +
> > >  static struct kernel_param_ops first_fqs_jiffies_ops = {
> > >  	.set = param_set_first_fqs_jiffies,
> > >  	.get = param_get_ulong,
> > > @@ -484,8 +499,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
> > >  	.get = param_get_ulong,
> > >  };
> > >  
> > > +module_param_cb(jiffies_till_sched_qs, &sched_qs_jiffies_ops, &jiffies_till_sched_qs, 0644);
> > >  module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
> > >  module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
> > > +
> > > +module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > >  module_param(rcu_kick_kthreads, bool, 0644);
> > >  
> > >  static void force_qs_rnp(int (*f)(struct rcu_data *rdp));
> > > -- 
> > > 1.9.1
> > > 
> > 
