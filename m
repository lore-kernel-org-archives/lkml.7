Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B7AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A77205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nGMtr/6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbfDJOoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:44:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732818AbfDJOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4YVFWr0gIfVgCxc2G9GPVRtvsl+Z3HYriqsv+oJBi2Y=; b=nGMtr/6Lf/IR9Ua0DLDUmyza3
        7CSTYI3OtFo7xRxuqjJCRo3o0EDp6ppzaSXxEd6p8JbNrRaRIoFjTFn8v+CY8akDzwBUD+zUJ4FI9
        KTeYYuTMXSnFzYsGHTnEi/2TWcROZWLfx7b8pECNGHidH4lm7CVm+Jw1XxMTIFGUWiIl7F3GZo5ac
        Hg7Wqbu/e1Yr5fJiXkImH9/XuL1TLdG07eosNKyR0OCRr+6bK0fd2ZFCdDwSEZPZWN8arcNqfJo/g
        4C+jj4FOuPNSIblKOuujgJeBABSSJt5fzqFt91HBlsPd/q8UU0tjsFbStXKo4nnu2ZGTpJxilTE6q
        cQ7co6SHw==;
Received: from [89.200.33.100] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEESK-0002kg-GD; Wed, 10 Apr 2019 14:44:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46A18984F06; Wed, 10 Apr 2019 16:44:18 +0200 (CEST)
Date:   Wed, 10 Apr 2019 16:44:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190410144418.GH2490@worktop.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
 <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
 <20190405145530.GA453@aaronlu>
 <460ce6fb-6a40-4a72-47e8-cf9c7c409bef@linux.intel.com>
 <20190410043633.GA67532@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410043633.GA67532@aaronlu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:36:33PM +0800, Aaron Lu wrote:
> On Tue, Apr 09, 2019 at 11:09:45AM -0700, Tim Chen wrote:
> > Now that we have accumulated quite a number of different fixes to your orginal
> > posted patches.  Would you like to post a v2 of the core scheduler with the fixes?
> 
> One more question I'm not sure: should a task with cookie=0, i.e. tasks
> that are untagged, be allowed to scheduled on the the same core with
> another tagged task?

That was not meant to be possible.

> The current patch seems to disagree on this, e.g. in pick_task(),
> if max is already chosen but max->core_cookie == 0, then we didn't care
> about cookie and simply use class_pick for the other cpu. This means we
> could schedule two tasks with different cookies(one is zero and the
> other can be tagged).

When core_cookie==0 we shouldn't schedule the other siblings at all.

> But then sched_core_find() only allow idle task to match with any tagged
> tasks(we didn't place untagged tasks to the core tree of course :-).
> 
> Thoughts? Do I understand this correctly? If so, I think we probably
> want to make this clear before v2. I personally feel, we shouldn't allow
> untagged tasks(like kernel threads) to match with tagged tasks.

Agreed, cookie should always match or idle.
