Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB662C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954DF2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfHBPWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:22:02 -0400
Received: from foss.arm.com ([217.140.110.172]:53960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbfHBPWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:22:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D0BB1596;
        Fri,  2 Aug 2019 08:22:01 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EEC43F575;
        Fri,  2 Aug 2019 08:22:00 -0700 (PDT)
Date:   Fri, 2 Aug 2019 16:21:58 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] Fix FIFO-99 abuse
Message-ID: <20190802152157.7fp775lg7tbm5rec@e107158-lin.cambridge.arm.com>
References: <20190801111348.530242235@infradead.org>
 <20190801131707.5rpyydznnhz474la@e107158-lin.cambridge.arm.com>
 <20190802093244.GF2332@hirez.programming.kicks-ass.net>
 <20190802102611.54sae3onftck5fye@e107158-lin.cambridge.arm.com>
 <20190802124151.GG2332@hirez.programming.kicks-ass.net>
 <20190802140854.ixq4cmo5nsfdaj24@e107158-lin.cambridge.arm.com>
 <20190802143324.GH2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802143324.GH2332@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/19 16:33, Peter Zijlstra wrote:
> > > Also also, RR-SMP is actually broken (and nobody has cared enough to
> > > bother fixing it).
> > 
> > If you can give me enough pointers to understand the problem I might be able to
> > bother with it :-)
> 
> So the push-pull balancer we have (designed for FIFO but also applied to
> RR) will only move a task if the destination CPU has a lower prio.  In
> the case where one CPU has 3 tasks and the other 1, and they're all the
> same prio, it does nothing.  For FIFO that is fine, for RR, not so much.
> 
> Because then the one CPU will RR between 3 tasks, giving each task
> 1/3rd, while the other will only run the one task.

Okay so what we need to do is keep a count of number of RR tasks on each CPU
(which we already do IIRC) and take that into account in
find_loweset_rq()/cpupri_find().

Let me see if I can create a test case then hack something.

Thanks

--
Qais Yousef
