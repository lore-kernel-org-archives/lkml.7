Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832FCC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6067820863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfEWOT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:19:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbfEWOT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:19:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90E3680D;
        Thu, 23 May 2019 07:19:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBFA3F690;
        Thu, 23 May 2019 07:19:23 -0700 (PDT)
Date:   Thu, 23 May 2019 15:19:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] rcu: Make 'rcu_assign_pointer(p, v)' of type
 'typeof(p)'
Message-ID: <20190523141851.GA7523@lakrids.cambridge.arm.com>
References: <1558618340-17254-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190523135013.GL28207@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523135013.GL28207@linux.ibm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 06:50:13AM -0700, Paul E. McKenney wrote:
> On Thu, May 23, 2019 at 03:32:20PM +0200, Andrea Parri wrote:
> > The expression
> > 
> >   rcu_assign_pointer(p, typeof(p) v)
> > 
> > is reported to be of type 'typeof(p)' in the documentation (c.f., e.g.,
> > Documentation/RCU/whatisRCU.txt) but this is not the case: for example,
> > the following snippet
> > 
> >   int **y;
> >   int *x;
> >   int *r0;
> > 
> >   ...
> > 
> >   r0 = rcu_assign_pointer(*y, x);
> > 
> > can currently result in the compiler warning
> > 
> >   warning: assignment to ‘int *’ from ‘uintptr_t’ {aka ‘long unsigned int’} makes pointer from integer without a cast [-Wint-conversion]
> > 
> > Cast the uintptr_t value to a typeof(p) value.
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: rcu@vger.kernel.org
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > ---
> > NOTE:
> > 
> > TBH, I'm not sure this is 'the right patch' (hence the RFC...): in
> > fact, I'm currently missing the motivations for allowing assignments
> > such as the "r0 = ..." assignment above in generic code.  (BTW, it's
> > not currently possible to use such assignments in litmus tests...)
> 
> Given that a quick (and perhaps error-prone) search of the uses of
> rcu_assign_pointer() in v5.1 didn't find a single use of the return
> value, let's please instead change the documentation and implementation
> to eliminate the return value.

FWIW, I completely agree, and for similar reasons I'd say we should do
the same to WRITE_ONCE(), where this 'cool feature' has been inherited
from.

For WRITE_ONCE() there's at least one user that needs to be cleaned up
first (relying on non-portable implementation detaisl of atomic*_set()),
but I suspect rcu_assign_pointer() isn't used as much as a building
block for low-level macros.

Thanks,
Mark.
