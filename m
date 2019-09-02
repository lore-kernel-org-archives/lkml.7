Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5E0C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939D62168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qyt5M2sH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfIBMbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:31:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44178 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfIBMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lBLD1ncc2hG4ju0AyE3DjcGoR5OZ27h6EU0DPKLq93w=; b=qyt5M2sHlu4gjAY1O6NgGLy91
        EoYi9ltTA+5ZM4d+xmzo3toUP8JrlqXyvIg7/gY7maGaaa0oXQkxWjAYSPgAvwuDtgy5v01S8EqVE
        EkMXrFGlwX4KfojVcf/s6F7p/lQ63rvMXTZ6qmwZMq8YTc9LntWlJcEO8lLd6+qLotRcLGqwhYBYD
        aO95Xgw7qL6pegat+9HipWcBnb35mwdNl74YPSaOV76g6CwI1cMmT5wnltcbWGEBXnBSKe1R405iw
        5Fg2MdPWYenEncekJj0F5WIVCNU5jwzhbBl55sZmK1l8N3TJeKriw1p0FOKz15Cx5aikYFVr/K4X1
        Xe/0z1C4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lUE-00080K-Ua; Mon, 02 Sep 2019 12:31:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A0E5430116F;
        Mon,  2 Sep 2019 14:30:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 539C029B2A005; Mon,  2 Sep 2019 14:31:06 +0200 (CEST)
Date:   Mon, 2 Sep 2019 14:31:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alessio Balsini <balsini@android.com>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org,
        kernel-team@android.com
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190902123106.GS2386@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
 <20190802172104.GA134279@google.com>
 <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
 <20190822122949.GA245353@google.com>
 <20190822165125.GW2369@hirez.programming.kicks-ass.net>
 <20190831144117.GA133727@google.com>
 <20190902091623.GQ2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902091623.GQ2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 11:16:23AM +0200, Peter Zijlstra wrote:
> On Sat, Aug 31, 2019 at 03:41:17PM +0100, Alessio Balsini wrote:
> > Right!
> > 
> > Verified that sysctl_sched_dl_period_max and sysctl_sched_dl_period_min values
> > are now always consistent.
> > 
> > I spent some time in trying to figure out if not having any mutex in
> > __checkparam_dl() is safe. There can surely happen that "max < min", e.g.:

> > Sharing my thoughts, a "BUG_ON(max < min)" in __checkparam_dl() is then a
> > guaranteed source of explosions, but the good news is that "if (period < min ||
> > period > max" in __checkparam_dl() surely fails if "max < min".  Also the fact
> > that, when we are writing the new sysctl_sched_dl_* values, only one is
> > actually changed at a time, that surely helps to preserve the consistency.
> > 
> > But is that enough?
> 
> Strictly speaking, no, I suppose it is not. We can have two changes in
> between the two READ_ONCE()s and then we'd be able to observe a
> violation.
> 
> The easy way to fix that is do something like:
> 
> +	synchronize_rcu();
> 	mutex_unlock(&mutex);
> 
> in sched_dl_period_handler(). And do:
> 
> +	preempt_disable();
> 	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
> 	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
> +	preempt_enable();
> 
> in __checkparam_dl().
> 
> That would prohibit we see two changes, and seeing only the single
> change is safe.

I pushed out a new version; and added patch to sched_rt_handler() on
top.

Please have a look at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip-deadline

I'll move these two patches to sched/core if everything looks good.
