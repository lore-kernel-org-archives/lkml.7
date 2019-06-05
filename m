Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E72C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4E22075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZuyN59KQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFEHW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:22:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEHW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tbIQe82KRWXfpj+AU7ijiA93IgD+ePBUN61009rIGNs=; b=ZuyN59KQFzxjL7oWCjg0GpmXv
        +lpdH2TaYGNV/c9WX6uV507J13v+WuIJfu8Cxnahf7vEBdqvOoYu7sfDT5nr71ZkOh9Xhzd4u3ivC
        3eFW5Rwr53aRQ7/RTItN6g33vv+d5Fihe46bSy/EOIpQjUIOZcPdKIa1EKRms40OjA3vyPsSJi5v8
        GSB2Ixef9VSzk2ZyhA/Jpdf/gfsnWEI1GP75s4uqUsv2+EWi2o07toI1ftj2cSeg8Fca+S/Ds94U7
        N+oILRkjEXsMFKpFDR/YKaJIkWnM+sQDbRMJ/Se4pebfFmOJmQB4q4rCnY+o0Sb5rIYpyR1yk92BE
        qbry4b0pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYQFh-0007oa-Qb; Wed, 05 Jun 2019 07:22:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F197207A17DB; Wed,  5 Jun 2019 09:22:27 +0200 (CEST)
Date:   Wed, 5 Jun 2019 09:22:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 0/6] sched: Add new tracepoints required for EAS
 testing
Message-ID: <20190605072227.GI3419@hirez.programming.kicks-ass.net>
References: <20190604111459.2862-1-qais.yousef@arm.com>
 <20190605061748.GA20661@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605061748.GA20661@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 11:17:48PM -0700, Christoph Hellwig wrote:
> > The following patches add the bare minimum tracepoints required to perform EAS
> > testing in Lisa[1].
> 
> What is EAS?  Whhy is "Lisa" not part of the patch submission?
> submission.
> 
> > It is done in this way because adding new TRACE_EVENTS() is no longer accepted
> > AFAIU.
> 
> Huh?  We keep adding trace events all the time.  And they actually
> are useful because they are testable.

They also form an implicit API/ABI with userspace, and I've been bitten
by that crap before. No more tracepoints. IIRC viro is also not having
tracepoints in the vfs.

> This series on the other hand adds exports not used in tree, which is
> a big no-go.

I much prefer a few unused exports that expose data in a controlled
fashion than commit to an implicit ABI through tracepoints. By keeping
it all in kernel, we're punting to the no-in-kernel-ABI rule.

Basically nobody gives a crap if we break (out-of-tree) modules, but the
moment we break something userspace we're fscked.

