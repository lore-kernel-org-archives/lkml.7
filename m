Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DCFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78E22087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfCLO4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfCLO4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:56:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8E32083D;
        Tue, 12 Mar 2019 14:56:10 +0000 (UTC)
Date:   Tue, 12 Mar 2019 10:56:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Fix self wakeups for grace period kthread
Message-ID: <20190312105608.15994a1d@gandalf.local.home>
In-Reply-To: <20190312140923.GU13351@linux.ibm.com>
References: <1552038378-11166-1-git-send-email-neeraju@codeaurora.org>
        <20190311215027.2f3458a1@oasis.local.home>
        <579cd03a-17a7-5729-46b3-ffcc4afee0e5@codeaurora.org>
        <20190312140923.GU13351@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 07:09:23 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> On Tue, Mar 12, 2019 at 05:25:28PM +0530, Neeraj Upadhyay wrote:
> > On 3/12/19 7:20 AM, Steven Rostedt wrote:  
> > >On Fri,  8 Mar 2019 15:16:18 +0530
> > >Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
> > >  
> > >>Update the code to match the comment that self wakeup of
> > >>grace period kthread is allowed from interrupt handler, and
> > >>softirq handler, running in the grace period kthread's
> > >>context. Present code allows self wakeups from all
> > >>interrupt contexts - nmi, softirq and hardirq contexts.  
> > >
> > >That's not actually the issue. But it appears that we return if we
> > >simply have BH disabled, which I don't think we want, and we don't care
> > >about NMI as NMI should never call this code.
> > >
> > >I think your patch is correct, but the change log is not.  
> 
> How about this?
> 
> 	The current rcu_gp_kthread_wake() function uses in_interrupt()
> 	and thus does a self-wakeup from all interrupt contexts,
> 	including the pointless case where the GP kthread happens to be
> 	running with bottom halves disabled, along with the impossible
> 	case where the GP kthread is running within an NMI handler (you
> 	are not supposed to invoke rcu_gp_kthread_wake() from within an
> 	NMI handler.  This commit therefore replaces the in_interrupt()
> 	with in_irq(), so that the self-wakeups happen only from handlers
> 	for hardware interrupts and softirqs.  This also makes the code
> 	match the comment.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

> 
> 							Thanx, Paul
> 
> > >-- Steve
> > >  
> > 
> > Hi Steve, sorry, I don't understand fully, why we want to not return
> > in BH disabled case. From the commit logs and lkml discussion, there
> > is a case where GP kthread is interrupted in the wait event path and
> > rcu_gp_kthread_wake() is called in softirq handler (I am not sure
> > about interrupt handler case; how rcu_gp_kthread_wake() is called
> > from that path).

BH disabled case isn't a case where the kthread is preempted. It's just
that the kthread disabled BH, and thus we want to return.

-- Steve

