Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74762ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED1621848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571103698;
	bh=5iWOZBJ7tL/nEuf6H4tASq4VsXCd6yb10enkldFVl1U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XPU5JNbXd4iiWonPam6lLu/uTKQRyYxP6RT+F9WZe2FphEhiBVxZekE4RClEiPxYL
	 ymXY04JGEdy9jMNzHweQKkb1Gfl7FbAG13otpZUbNQDsSFWPhMTFeiNN2zumwKQTda
	 KsYuX5Iz4hxpwBfKsVZUkWK7Tii8tdRgzjzBjnsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfJOBlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 21:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfJOBlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 21:41:36 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9777021835;
        Tue, 15 Oct 2019 01:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571103696;
        bh=5iWOZBJ7tL/nEuf6H4tASq4VsXCd6yb10enkldFVl1U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YJcmaFkNm4JKFST4g8tFdTZcO4hBVtsdHBDblalh8fnHIxFiA1zOsjuz3EYMnJOhI
         yAUTHOsOrr0X1/+RqwohUWlHsr7PjpibAWidPwT2BaHLP2R8OCajYwNsqiVQbKadQ9
         YT52k5D/ugTbcea3zJC9PPnk8fOt+oHx/d2A9UWI=
Date:   Mon, 14 Oct 2019 18:41:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: add declarations of undeclared items
Message-ID: <20191015014133.GK2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191011170824.30228-1-ben.dooks@codethink.co.uk>
 <20191012044430.GG2689@paulmck-ThinkPad-P72>
 <20191014175123.GC105106@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014175123.GC105106@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 01:51:23PM -0400, Joel Fernandes wrote:
> On Fri, Oct 11, 2019 at 09:44:30PM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 11, 2019 at 06:08:24PM +0100, Ben Dooks wrote:
> > > The rcu_state, rcu_rnp_online_cpus and rcu_dynticks_curr_cpu_in_eqs
> > > do not have declarations in a header. Add these to remove the
> > > following sparse warnings:
> > > 
> > > kernel/rcu/tree.c:87:18: warning: symbol 'rcu_state' was not declared. Should it be static?
> > > kernel/rcu/tree.c:191:15: warning: symbol 'rcu_rnp_online_cpus' was not declared. Should it be static?
> > > kernel/rcu/tree.c:297:6: warning: symbol 'rcu_dynticks_curr_cpu_in_eqs' was not declared. Should it be static?
> > > 
> > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > 
> > Good catch!
> > 
> > However, these guys (plus one more) are actually used only in the
> > kernel/rcu/tree.o translation unit, so they can be marked static.
> > I made this change as shown below with your Reported-by.
> > 
> > Seem reasonable?
> > 
> 
> LGTM.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 02995691aa76f3e52599d4f9d9d1ab23c3574f32
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri Oct 11 21:40:09 2019 -0700
> > 
> >     rcu: Mark non-global functions and variables as static
> >     
> >     Each of rcu_state, rcu_rnp_online_cpus(), rcu_dynticks_curr_cpu_in_eqs(),
> >     and rcu_dynticks_snap() are used only in the kernel/rcu/tree.o translation
> >     unit, and may thus be marked static.  This commit therefore makes this
> >     change.
> >     
> >     Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b18fa3d..278798e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -85,7 +85,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> >  	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
> >  	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> >  };
> > -struct rcu_state rcu_state = {
> > +static struct rcu_state rcu_state = {
> >  	.level = { &rcu_state.node[0] },
> >  	.gp_state = RCU_GP_IDLE,
> >  	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
> > @@ -189,7 +189,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
> >   * held, but the bit corresponding to the current CPU will be stable
> >   * in most contexts.
> >   */
> > -unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
> > +static unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
> >  {
> >  	return READ_ONCE(rnp->qsmaskinitnext);
> >  }
> > @@ -295,7 +295,7 @@ static void rcu_dynticks_eqs_online(void)
> >   *
> >   * No ordering, as we are sampling CPU-local information.
> >   */
> > -bool rcu_dynticks_curr_cpu_in_eqs(void)
> > +static bool rcu_dynticks_curr_cpu_in_eqs(void)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > @@ -306,7 +306,7 @@ bool rcu_dynticks_curr_cpu_in_eqs(void)
> >   * Snapshot the ->dynticks counter with full ordering so as to allow
> >   * stable comparison of this counter with past and future snapshots.
> >   */
> > -int rcu_dynticks_snap(struct rcu_data *rdp)
> > +static int rcu_dynticks_snap(struct rcu_data *rdp)
> >  {
> >  	int snap = atomic_add_return(0, &rdp->dynticks);
> >  
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 1540542..f8e6c70 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -402,8 +402,6 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
> >  #define RCU_NAME rcu_name
> >  #endif /* #else #ifdef CONFIG_TRACING */
> >  
> > -int rcu_dynticks_snap(struct rcu_data *rdp);
> > -
> >  /* Forward declarations for tree_plugin.h */
> >  static void rcu_bootup_announce(void);
> >  static void rcu_qs(void);
