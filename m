Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119E6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30A42075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDCPMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:12:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCPMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:12:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F87320265;
        Wed,  3 Apr 2019 15:12:00 +0000 (UTC)
Received: from treble (ovpn-123-180.rdu2.redhat.com [10.10.123.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE6F2608A5;
        Wed,  3 Apr 2019 15:11:59 +0000 (UTC)
Date:   Wed, 3 Apr 2019 10:11:57 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
Message-ID: <20190403151157.dcjmunsl7mna4ore@treble>
References: <20190331214020.836098943@linutronix.de>
 <20190331215136.039902969@linutronix.de>
 <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de>
 <20190402154329.scp7i7uqevubgwrz@treble>
 <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
 <20190402155149.c23ivzzc5hyykokl@treble>
 <20190403080828.GN12232@hirez.programming.kicks-ass.net>
 <20190403081041.GB14281@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403081041.GB14281@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 03 Apr 2019 15:12:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:10:41AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 03, 2019 at 10:08:28AM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 02, 2019 at 10:51:49AM -0500, Josh Poimboeuf wrote:
> > > On Tue, Apr 02, 2019 at 05:48:56PM +0200, Thomas Gleixner wrote:
> > > > > With the above "(stk <= begin || stk >= end)" check, removing the loop
> > > > > becomes not all that important since exception stack dumps are quite
> > > > > rare and not performance sensitive.  With all the macros this code
> > > > > becomes a little more obtuse, so I'm not sure whether removal of the
> > > > > loop is a net positive.
> > > > 
> > > > What about perf? It's NMI context and probably starts from there. Peter?
> > > 
> > > I believe perf unwinds starting from the regs from the context which was
> > > interrupted by the NMI.
> > 
> > Aah, indeed. So then we only see exception stacks when the NMI lands in
> > an exception, which is, as you say, quite rare.
> 
> Aah, ftrace OTOH might still trigger this lots. When you do function
> tracer with stacktrace enabled it'll do unwinds _everywhere_.

Even then, ftrace stacktrace will be really slow regardless, and this
loop removal would be a tiny performance improvement for a tiny fraction
of those stack traces.  Unless the improvement is measurable I would
personally rather err on the side of code readability.

-- 
Josh
