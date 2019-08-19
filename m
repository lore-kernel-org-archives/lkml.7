Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013BDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0412086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566219552;
	bh=Sh3TbivVvIcuc2WU4oim5kaxlQu+I/qgCqID/+7+3hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DDzVrKafsaPN95kxzzr1aDk76Gih47ttL+XKfwdZKEjNSa5PSg9lYvaiQMYVU4UvN
	 DCo8smsSasPInYuirm/jzulIZu91za5uUyxOv7rV6P0E3mcpbz1hYTXkmfdOSOPqmk
	 qxuh/rWwSVofVarvNPEINIEf1bq+OOHE7/vvCOZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfHSM7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfHSM7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:59:11 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D77205C9;
        Mon, 19 Aug 2019 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566219550;
        bh=Sh3TbivVvIcuc2WU4oim5kaxlQu+I/qgCqID/+7+3hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4p8ugCETs7favaQpvlGpiSd+m/7kISZJrc0vUQ7oFESvYbRbkP//FpHJR8wpgOho
         x+R17XbgRQUJw7vNcV6mG1XwrT7VlQ88BqRmza+dlReIgycUY9eg/SRqPJHkkPIXem
         Pu7wcbkm8A3R6lYcKcM4LQLFhkkk4j5KzQt2ffWs=
Date:   Mon, 19 Aug 2019 14:59:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in
 advance
Message-ID: <20190819125907.GD27088@lenoir>
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-3-joel@joelfernandes.org>
 <20190816162404.GB10481@google.com>
 <20190816165242.GS28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816165242.GS28441@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 09:52:42AM -0700, Paul E. McKenney wrote:
> On Fri, Aug 16, 2019 at 12:24:04PM -0400, Joel Fernandes wrote:
> > On Thu, Aug 15, 2019 at 10:53:11PM -0400, Joel Fernandes (Google) wrote:
> > > I really cannot explain this patch, but without it, the "else if" block
> > > just doesn't execute thus causing the tick's dep mask to not be set and
> > > causes the tick to be turned off.
> > > 
> > > I tried various _ONCE() macros but the only thing that works is this
> > > patch.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 856d3c9f1955..ac6bcf7614d7 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > >  {
> > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > >  	long incby = 2;
> > > +	int dnn = rdp->dynticks_nmi_nesting;
> > 
> > I believe the accidental sign extension / conversion from long to int was
> > giving me an illusion since things started working well. Changing the 'int
> > dnn' to 'long dnn' gives similar behavior as without this patch! At least I
> > know now. Please feel free to ignore this particular RFC patch while I debug
> > this more (over the weekend or early next week). The first 2 patches are
> > good, just ignore this one.
> 
> Ah, good point on the type!  So you were ending up with zero due to the
> low-order 32 bits of DYNTICK_IRQ_NONIDLE being zero, correct?  If so,
> the "!rdp->dynticks_nmi_nesting" instead needs to be something like
> "rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE", which sounds like
> it is actually worse then the earlier comparison against the constant 2.
> 
> Sounds like I should revert the -rcu commit 805a16eaefc3 ("rcu: Force
> nohz_full tick on upon irq enter instead of exit").

I can't find that patch so all I can say so far is that its title doesn't
inspire me much. Do you still need that change for some reason?

Thanks.
