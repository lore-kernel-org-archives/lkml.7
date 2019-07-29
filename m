Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE89AC7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD738217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e8QOlcrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbfG2PDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:03:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387425AbfG2PDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/ETHf94MjVCsWoGJmgma/XCP9Q3AJ/2BeOPSWh2RAN0=; b=e8QOlcrR5gXbft+ShFMb4+YS4
        rBL0ALsF9M+9MNxs0Ya0+3kn28QWVH01B+T5M8QN9a4XxGOK4RtCQVjhEeVv/q2NUltmBov90qUlo
        SjXcHbwNkXLoDw/iBM5riNlGFNlsG2T/bHGkbD0ULfU6asner3o9yiBuA7R6bdKq6XhPw0heiEiuT
        6NkZ6uF9uU3e2E9eQQdCtyVCM6/BWmaCf6IdpECaYLr/0WshUQ3I2hYU1lGWaDvsdrASxE9CxDIVL
        1RqFDZwbdslIqQ6VdLf4h4o8N7tvACdOnaSJPmWMXAjn646Mq0/V+uJfRbGwcNxwfZKaAj6iz4CfO
        Uz3JqkB/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs7Bc-00052G-Ff; Mon, 29 Jul 2019 15:03:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E260F20AF2C00; Mon, 29 Jul 2019 17:03:38 +0200 (CEST)
Date:   Mon, 29 Jul 2019 17:03:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190729150338.GF31398@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729085235.GT31381@hirez.programming.kicks-ass.net>
 <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:51:51AM -0400, Waiman Long wrote:
> On 7/29/19 4:52 AM, Peter Zijlstra wrote:
> > On Sat, Jul 27, 2019 at 01:10:47PM -0400, Waiman Long wrote:
> >> It was found that a dying mm_struct where the owning task has exited
> >> can stay on as active_mm of kernel threads as long as no other user
> >> tasks run on those CPUs that use it as active_mm. This prolongs the
> >> life time of dying mm holding up memory and other resources like swap
> >> space that cannot be freed.
> > Sure, but this has been so 'forever', why is it a problem now?
> 
> I ran into this probem when running a test program that keeps on
> allocating and touch memory and it eventually fails as the swap space is
> full. After the failure, I could not rerun the test program again
> because the swap space remained full. I finally track it down to the
> fact that the mm stayed on as active_mm of kernel threads. I have to
> make sure that all the idle cpus get a user task to run to bump the
> dying mm off the active_mm of those cpus, but this is just a workaround,
> not a solution to this problem.

The 'sad' part is that x86 already switches to init_mm on idle and we
only keep the active_mm around for 'stupid'.

Rik and Andy were working on getting that 'fixed' a while ago, not sure
where that went.
