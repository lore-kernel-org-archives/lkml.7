Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF15C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2438521473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfEVPO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:14:26 -0400
Received: from foss.arm.com ([217.140.101.70]:53466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbfEVPO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:14:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CBA880D;
        Wed, 22 May 2019 08:14:25 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24ED33F718;
        Wed, 22 May 2019 08:14:24 -0700 (PDT)
Date:   Wed, 22 May 2019 16:14:23 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp,cpumask: Don't call functions on offline CPUs
Message-ID: <20190522151422.GD8268@e119886-lin.cambridge.arm.com>
References: <20190522111537.27815-1-andrew.murray@arm.com>
 <20190522140921.GD16275@worktop.programming.kicks-ass.net>
 <20190522143711.GC8268@e119886-lin.cambridge.arm.com>
 <20190522144918.GH16275@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522144918.GH16275@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 04:49:18PM +0200, Peter Zijlstra wrote:
> On Wed, May 22, 2019 at 03:37:11PM +0100, Andrew Murray wrote:
> > > Is perhaps the problem that on_each_cpu_cond() uses cpu_onlne_mask
> > > without protection?
> > 
> > Does this prevent racing with a CPU going offline? I guess this prevents
> > the warning at the expense of a lock - but is only beneficial in the
> > unlikely path. (In the likely path this prevents new CPUs going offline
> > but we don't care because we don't WARN if they aren't they when we
> > attempt to call functions).
> > 
> > At least this is my limited understanding.
> 
> Hmm.. I don't think it could matter, we only use the mask when
> preempt_disable(), which would already block offline, due to it using
> stop_machine().

OK, so as long as all arches use stop_machine to bring down a CPU then
preeempt_disable will stop racing with CPUs going offline (I don't know
if they all do or not).

> 
> So the patch is a no-op.
> 
> What's the WARN you see? TLB invalidation should pass mm_cpumask(),
> which similarly should not contain offline CPUs I'm thinking.

So the only remaining issue is if callers pass offline CPUs to the
function (I guess there is still the chance of a race between calling
on_each_cpu_cond_mask and entering the preempt disabled'd bit). As you
suggest they probably don't.

Given the above, should we add a " @mask: The mask of cpus it can run on."
to on_each_cpu_cond_mask? (Which is different to the wording of other
functions in the same file that mask it with online CPUs, e.g.
" @mask: The set of cpus to run on (only runs on online subset).".

(I haven't seen any WARN, but from looking at the code thought that it
was possible.)

Thanks,

Andrew Murray
