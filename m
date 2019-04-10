Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31ADC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4452082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RWCcaS+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfDJPHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:07:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732830AbfDJPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Dn2JbVhnhjXRkDyjKbZgpcJeD9yYMXMOg6VKmD5Y37E=; b=RWCcaS+G9SH+VjJPy2QZN9WGx
        pM3odcMZEW+irj54ciHNk/AADDQTqg8YPRXq7hBJFIwVjlVCy0GmJ308djV2rLROaD3mEKkv2gLDa
        O8Q2WheSDTgO9xCwbXbZTqM73oqU7tWc+csfZ+hUK4m4dkdnrlF9l7EE04gk7FKGwN2UYAOIB+zHh
        Lb5qu+227wAN4E7WDrhImpSR1s3wGqdMCJOwQ9cWl2nwzqVusJXDWlI6XzstV02H3xX82vSQdDsmL
        CTaDTEtv3jl58nkHzbjiVMUBB7wqDkn7XigFczXhERwfmyX7d4BhwK0UbTBGuId2Fu2eT5JLU9SrR
        bWjFOfH3Q==;
Received: from [89.200.33.100] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEEon-0004Yq-UP; Wed, 10 Apr 2019 15:07:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5737D984F06; Wed, 10 Apr 2019 17:07:14 +0200 (CEST)
Date:   Wed, 10 Apr 2019 17:07:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v2 02/12] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190410150714.GK7905@worktop.programming.kicks-ass.net>
References: <20190405192115.17416-1-longman@redhat.com>
 <20190405192115.17416-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405192115.17416-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 03:21:05PM -0400, Waiman Long wrote:
> Because of writer lock stealing, it is possible that a constant
> stream of incoming writers will cause a waiting writer or reader to
> wait indefinitely leading to lock starvation.
> 
> The mutex code has a lock handoff mechanism to prevent lock starvation.
> This patch implements a similar lock handoff mechanism to disable
> lock stealing and force lock handoff to the first waiter in the queue
> after at least a 5ms waiting period. The waiting period is used to
> avoid discouraging lock stealing too much to affect performance.

So the mutex code doesn't have that timeout, it foces the handoff if the
top waiter fails to acquire.

I don't find the above sufficiently justifies the additional complexity.
What were the numbers with the simple scheme vs this etc..
