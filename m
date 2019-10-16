Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6129EFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8402168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571235283;
	bh=BCBnIdgzHwLTNLerkK+Tvksc5IOkOoEgqCnmgNRCt0s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=C/i2KuANvK0tXbCTfVwGJUHKepJDRLtEOhulfFionw+PclGltUAgEAZibiqpfvk6A
	 Uir//cJ1StTFDEYNFm681vzaJ3oef16CPeTE52wPVfz8SheANHsuYf4ZmloK6sWy0g
	 mLlIw4ofg5jngfh3bmrShEiHBXp3wyYMBsl8ocA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393874AbfJPOOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733190AbfJPOOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:14:41 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977BA207FF;
        Wed, 16 Oct 2019 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571235280;
        bh=BCBnIdgzHwLTNLerkK+Tvksc5IOkOoEgqCnmgNRCt0s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l4qvE68O5WrLhA97juhMjDTPl6SwZyvI7Z/ftUul+gs1n40w8IuG8in9+dl9D/KZv
         GPVt7UnWKkOOc9RXSsSL+DcxA6XcFwsUqTxNkr6FvFN5GKJZismP9Pyol3i/f/18fm
         bnUGLeJgsx0wfpcb2JRJRKeZP4r0hGLFyr72rdhY=
Date:   Wed, 16 Oct 2019 07:14:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 2/7] rcu: fix tracepoint string when RCU CPU kthread runs
Message-ID: <20191016141439.GA2588@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015102402.1978-1-laijs@linux.alibaba.com>
 <20191015102402.1978-3-laijs@linux.alibaba.com>
 <20191016033814.GX2689@paulmck-ThinkPad-P72>
 <c54063d6-c6d0-cd8c-40e3-5185258d71dd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c54063d6-c6d0-cd8c-40e3-5185258d71dd@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 12:24:09PM +0800, Lai Jiangshan wrote:
> 
> 
> On 2019/10/16 11:38 上午, Paul E. McKenney wrote:
> > On Tue, Oct 15, 2019 at 10:23:57AM +0000, Lai Jiangshan wrote:
> > > "rcu_wait" is incorrct here, use "rcu_run" instead.
> > > 
> > > Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > ---
> > >   kernel/rcu/tree.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 278798e58698..c351fc280945 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2485,7 +2485,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
> > >   	int spincnt;
> > >   	for (spincnt = 0; spincnt < 10; spincnt++) {
> > > -		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
> > > +		trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
> > >   		local_bh_disable();
> > >   		*statusp = RCU_KTHREAD_RUNNING;
> > >   		local_irq_disable();
> > > @@ -2496,7 +2496,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
> > >   			rcu_core();
> > >   		local_bh_enable();
> > >   		if (*workp == 0) {
> > > -			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
> > > +			trace_rcu_utilization(TPS("End CPU kthread@rcu_run"));
> > 
> > This one needs to stay as it was because this is where we wait when out
> > of work.
> 
> I don't fully understand those TPS marks.
> 
> If it is all about "where we wait when out of work", it ought to
> be "Start ... wait", rather than "End ... wait". The later one
> ("End ... wait") should be put before
> "for (spincnt = 0; spincnt < 10; spincnt++)" and remove
> the whole "rcu_run" as this patch suggested. To be honest,
> "rcu_run" is redundant since we already has TPS("Start RCU core").
> 
> Any ways, patch2&3 lose their relevance and should be dropped.
> Looking forward to your improved version.

Given that most of RCU's overhead is now in kthreads and in RCU_SOFTIRQ,
perhaps trace_rcu_utilization() has outlived its usefulness, especially
given the prospect of an RCU_SOFTIRQ-specific kthread.

							Thanx, Paul
