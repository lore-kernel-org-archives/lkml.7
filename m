Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC80C072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FF220883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfE0R56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:57:58 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:49093 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbfE0R56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:57:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C7F7C100E86C3;
        Mon, 27 May 2019 17:57:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: can07_7f3a0e0e0e616
X-Filterd-Recvd-Size: 3205
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 May 2019 17:57:54 +0000 (UTC)
Message-ID: <475b18e78ba7e04363fe002315f75d2ce35496f9.camel@perches.com>
Subject: Re: [PATCH v2] rcu: Don't return a value from rcu_assign_pointer()
From:   Joe Perches <joe@perches.com>
To:     paulmck@linux.ibm.com
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>, apw@canonical.com
Date:   Mon, 27 May 2019 10:57:52 -0700
In-Reply-To: <20190527174901.GL28207@linux.ibm.com>
References: <1558946997-25559-1-git-send-email-andrea.parri@amarulasolutions.com>
         <20190527161050.GK28207@linux.ibm.com>
         <810a0dae47c90c39015903c413303fcee89ab5eb.camel@perches.com>
         <20190527174901.GL28207@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-27 at 10:49 -0700, Paul E. McKenney wrote:
> On Mon, May 27, 2019 at 10:21:22AM -0700, Joe Perches wrote:
> > On Mon, 2019-05-27 at 09:10 -0700, Paul E. McKenney wrote:
> > > On Mon, May 27, 2019 at 10:49:57AM +0200, Andrea Parri wrote:
> > > > Quoting Paul [1]:
> > > > 
> > > >   "Given that a quick (and perhaps error-prone) search of the uses
> > > >    of rcu_assign_pointer() in v5.1 didn't find a single use of the
> > > >    return value, let's please instead change the documentation and
> > > >    implementation to eliminate the return value."
> > > > 
> > > > [1] https://lkml.kernel.org/r/20190523135013.GL28207@linux.ibm.com
> > > 
> > > Queued, thank you!
> > > 
> > > Adding the checkpatch maintainers on CC as well.  The "do { } while
> > > (0)" prevents the return value from being used, by design.  Given the
> > > checkpatch complaint, is there some better way to achieve this?
> > 
> > Not sure what the checkpatch complaint is here.
> 
> Checkpatch seems to want at least two statements in each
> "do { } while (0)" macro definition:
> 
> WARNING: Single statement macros should not use a do {} while (0) loop
> 
> > Reading the link above, there seems to be a compiler warning.
> 
> The compiler warning is a theoretical issue that is being fixed by this
> patch, and the patch is giving the checkpatch warning.
> 
> > Perhaps a statement expression macro with no return value?
> > 
> > #define rcu_assign_pointer(p, v)	({ (p) = (v); ; })
> 
> This is at best an acquired taste for me...

Another ugly possibility could be:

#define rcu_assign_pointer(p, v) do {if (1) (p) = (v); } while (0)

Possibly the best option would be to ignore checkpatch here
and just add a comment above the use.



