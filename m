Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D35C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D51620859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ADSwSfiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE0KwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:52:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfE0KwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7y/ZIAVRFGv3U2Fb/JXw1uaz+a1Vf4aQoe4TK3E1YMI=; b=ADSwSfiGnpgpd477tSoPRL4e+
        Z9BciYq0/ZaV1YiFsg5IhewUOpD9eZtIgIuHiaH/QPxCrrWMAQKFq1Mll1y4tP4BGjNCWSKzqjm91
        4aEq4+XxqsnGBtYGWBOCmTeg++fOn/RRjw+n6F5itY6l/SkM8x+eSIRolLSWoML9T7Ob8zLUNNAOq
        fS/FNuLDOUgGG8fcUIBlu8RnK38Gg1ommxgK9hajSZyfGJGjn/ltyjB1nv7KpfG8ycddtRMrJPkQF
        /Skv3C8a/L+fYFL5+YAzsGgmT9E5giHqAsWcdET+EwyW86hh/wH2SNpRgnjgM6v2TbAnOd52vI6qO
        I7xDwYy7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVDEb-0000ec-0y; Mon, 27 May 2019 10:52:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB5912027F766; Mon, 27 May 2019 12:52:02 +0200 (CEST)
Date:   Mon, 27 May 2019 12:52:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp,cpumask: Don't call functions on offline CPUs
Message-ID: <20190527105202.GY2623@hirez.programming.kicks-ass.net>
References: <20190522111537.27815-1-andrew.murray@arm.com>
 <20190522140921.GD16275@worktop.programming.kicks-ass.net>
 <20190522143711.GC8268@e119886-lin.cambridge.arm.com>
 <20190522144918.GH16275@worktop.programming.kicks-ass.net>
 <20190522151422.GD8268@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522151422.GD8268@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 04:14:23PM +0100, Andrew Murray wrote:
> On Wed, May 22, 2019 at 04:49:18PM +0200, Peter Zijlstra wrote:
> > On Wed, May 22, 2019 at 03:37:11PM +0100, Andrew Murray wrote:
> > > > Is perhaps the problem that on_each_cpu_cond() uses cpu_onlne_mask
> > > > without protection?
> > > 
> > > Does this prevent racing with a CPU going offline? I guess this prevents
> > > the warning at the expense of a lock - but is only beneficial in the
> > > unlikely path. (In the likely path this prevents new CPUs going offline
> > > but we don't care because we don't WARN if they aren't they when we
> > > attempt to call functions).
> > > 
> > > At least this is my limited understanding.
> > 
> > Hmm.. I don't think it could matter, we only use the mask when
> > preempt_disable(), which would already block offline, due to it using
> > stop_machine().
> 
> OK, so as long as all arches use stop_machine to bring down a CPU then
> preeempt_disable will stop racing with CPUs going offline (I don't know
> if they all do or not).

kernel/cpu.c:takedown_cpu() is generic code :-)

> > So the patch is a no-op.
> > 
> > What's the WARN you see? TLB invalidation should pass mm_cpumask(),
> > which similarly should not contain offline CPUs I'm thinking.
> 
> So the only remaining issue is if callers pass offline CPUs to the
> function (I guess there is still the chance of a race between calling
> on_each_cpu_cond_mask and entering the preempt disabled'd bit). As you
> suggest they probably don't.

Yes, it is possible to construct fail that way.
