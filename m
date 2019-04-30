Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46932C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D01D21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bOQnutm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfD3Pfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:35:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38748 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3Pfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xkHmQ5VtLPFk5RCj2nSWg30TnIw2SSbj0nkad1c7W7E=; b=bOQnutm+bB+XMxG3zduAv4jW7
        znSbbl+5BGbPorr8/ibz5INOWoVxj3R8KryAVGOpi+MvZjoflt9dvB3sz2LtLacGEKb7VtLESUYeG
        xpJ5vyaOz8NWx3yGMQMdOABuahAZPhGd5TJMOVEBKO4soCdERdpqkwty7T7uxHDcLtbBMWTk3QeeJ
        QvQ4dUboMm24ewnqZjK93nB95uy6P8M8rllYuaqBYVq5CnZcPUNnt2FPsVgfFQnNLE+26Xk+pTTtM
        Zc4hm+xLMyGpzZ8gG3yzVNNXYwS2ntqc0mWbUdUvaoxJzwWyfa0MOAXUfmr8rxaipa3GCioOpDJR5
        8Y+W9uNHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLUn3-0001zI-Lf; Tue, 30 Apr 2019 15:35:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22100236F9E80; Tue, 30 Apr 2019 17:35:28 +0200 (CEST)
Date:   Tue, 30 Apr 2019 17:35:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 24/28] locking/lockdep: Remove !dir in lock irq usage
 check
Message-ID: <20190430153528.GA2650@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-25-duyuyang@gmail.com>
 <20190425200336.GY12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425200336.GY12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:03:36PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 24, 2019 at 06:19:30PM +0800, Yuyang Du wrote:
> > In mark_lock_irq(), the following checks are performed:
> > 
> >    ----------------------------------
> >   |   ->      | unsafe | read unsafe |
> >   |----------------------------------|
> >   | safe      |  F  B  |    F* B*    |
> >   |----------------------------------|
> >   | read safe |  F? B* |      -      |
> >    ----------------------------------
> > 
> > Where:
> > F: check_usage_forwards
> > B: check_usage_backwards
> > *: check enabled by STRICT_READ_CHECKS
> > ?: check enabled by the !dir condition
> > 
> > From checking point of view, the special F? case does not make sense,
> > whereas it perhaps is made for peroformance concern. As later patch will
> > address this issue, remove this exception, which makes the checks
> > consistent later.
> > 
> > With STRICT_READ_CHECKS = 1 which is default, there is no functional
> > change.
> 
> Oh man.. thinking required and it is way late.. anyway this whole read
> stuff made me remember we had a patch set on readlocks last year.
> 
>   https://lkml.kernel.org/r/20180411135110.9217-1-boqun.feng@gmail.com
> 
> I remember reviewing that a few times and then it dropped on the floor,
> probably because Spectre crap or something sucked up all my time again :/

So if we look at Boqun's patches (as posted, I haven't looked at his
github, but I'm assuming this hasn't changed with the 'Shared' state),
we'll find he'll only does either 1 backward or 1 foward search (which
is already an improvement over the current state).

His mark_lock_irq() looks like:

static int
mark_lock_irq(struct task_struct *curr, struct *held_lock *this,
		enum lock_usage_bit new_bit)
{
	int excl_bit = exclusive_bit(new_bit);

+       if (new_bit & 2) {
+               /*
+                * mark ENABLED has to look backwards -- to ensure no dependee
+                * has USED_IN state, which, again, would allow recursion
+                * deadlocks.
+                */
+               if (!check_usage_backwards(curr, this, new_bit, excl_bit))
			return 0;
+       } else {
+               /*
+                * mark USED_IN has to look forwards -- to ensure no dependency
+                * has ENABLED state, which would allow recursion deadlocks.
+                */
+               if (!check_usage_forwards(curr, this, new_bit, excl_bit))
			return 0;
	}

	return 1;
}

Where '& 2' would read '& LOCK_USAGE_DIR_MASK' in the current code.

Now, I'm thinking you're proposing to replace the backward search for
USED_IN/safe with your reachable-safe state, which, if done on his
'strong' links, should still work.

That is; I _think_ the two patch-sets are not in conceptual conflict.

Of course; I could have missed something; I've just read both patchsets
again, and it's a bit much :-)
