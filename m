Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9741FC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D836216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e9qnk018"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfG2Okj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:40:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2Oki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FYNwer5O4SIKv9en8AjVTkT4U2QOeVJ1BOl6QlGXUIw=; b=e9qnk018gQZbcpCtHTD/UzOlI
        UgHjs7V5dJQqfd650YEyLfq0RphEwCrZDJ0szt/NiNGUlLPzq+bfNoFCkkiOaDHp32w1kSnUEZ0Mr
        S3gPHjwv5PCnLRRBicTOg8kfobIYYq/ENXnUpzJMlIS4n85tWkT0UotMQjM6udXYU3Skr7C9QmSCV
        hYPJQzGZ9pFXoq2F6yQ33GdADAerY898aBxWI1kd+rS3xoupPd9bT9x3OxCa8uKGK9fpBoCT5ThWA
        LXbLDP+CfLyMeuvTsxlwW+eHXqxi76eQP/mPNmv9SfvtTNaAg52YyD4wa8qehVKLq6VqiYZq8ihp1
        oO5slJG9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6p9-0002sm-4f; Mon, 29 Jul 2019 14:40:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43D3F20AF2C00; Mon, 29 Jul 2019 16:40:25 +0200 (CEST)
Date:   Mon, 29 Jul 2019 16:40:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 04/13] sched/{rt,deadline}: Fix set_next_task vs
 pick_next_task
Message-ID: <20190729144025.GD31381@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.579899041@infradead.org>
 <20190729092519.GR25636@localhost.localdomain>
 <20190729111510.GD31398@hirez.programming.kicks-ass.net>
 <20190729112702.GA8927@localhost.localdomain>
 <20190729130438.GE31398@hirez.programming.kicks-ass.net>
 <20190729131701.GB8927@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729131701.GB8927@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 03:17:01PM +0200, Juri Lelli wrote:
> On 29/07/19 15:04, Peter Zijlstra wrote:

> > Now, looking at it, this also doesn't do push balancing when we
> > re-select the same task, even though we really should be doing it. So I
> > suppose not adding the condition, and always doing the push balance,
> > while wasteful, is not wrong.
> 
> Right, also because deadline_queue_push_tasks() already checks if there
> are tasks to potentially push around before queuing the balance
> callback.

Yes, but in the overloaded case, where there is always a task to push,
but nowhere to push it to, we can waste a 'lot' of time looking for
naught in case of extra pushes.

So in that regard the check you reference is not sufficient.

Anyway, let me change this for now.
