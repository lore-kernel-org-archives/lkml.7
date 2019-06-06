Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C5C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BD5206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0s9DUtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfFFIDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:03:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60762 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QSKGyxx9Q9AJKtpqgKbGwuoacV8z0/sDEo2YsWMHixs=; b=m0s9DUtYOds2uc7WJfqzS3t14
        e1a5PkDuo5Rqai36yA9Mgw6v6lF3VcsB2M1Dv1lByAzNdVYKCEsWX1lnMSU5eLt6yiYW3hpUZFJgO
        bGS7gSojJwwHho6LqPC11dMXzwEIXW7rd+W6oMJYc6HRqY0tSOSgs7UXnvR/AwOBMCgvT+7jHBoeR
        w8jgEeCZ2z5aBB36HYzOVX9XfAzNK/7FNR2BWYi75RH/qQlbJd9XEl5rd2it+yiqx8zojxZMdHv+9
        6VIwFddYcsWycurAijzWZsa0Q1cyjYR2KETj/0RFrHuIywSo2o0RiwpPxgb3fbPD4Dsf48t2o48S5
        BVjmpnp0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYnMj-0006gX-Gc; Thu, 06 Jun 2019 08:03:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35B18203AA6FD; Thu,  6 Jun 2019 10:03:15 +0200 (CEST)
Date:   Thu, 6 Jun 2019 10:03:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>, dvyukov@google.com,
        glider@google.com, aryabinin@virtuozzo.com
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
Message-ID: <20190606080315.GE3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-16-longman@redhat.com>
 <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
 <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
 <20190604173853.GG3419@hirez.programming.kicks-ass.net>
 <f7f9b778-4f1a-7460-a7ae-1d4e3dd37181@redhat.com>
 <20190604181426.GH3419@hirez.programming.kicks-ass.net>
 <db89a086-3719-cea5-e24e-339085728c29@redhat.com>
 <46e44f43-87fd-251b-3b83-89a8bb3b407f@redhat.com>
 <20190605201901.GB3402@hirez.programming.kicks-ass.net>
 <CAHk-=wgqfXUeKkjT-TJRubxU5KNt9CLi88QSXhXT0H=3v4uF3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqfXUeKkjT-TJRubxU5KNt9CLi88QSXhXT0H=3v4uF3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 01:52:15PM -0700, Linus Torvalds wrote:
> On Wed, Jun 5, 2019 at 1:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Urgh, that's another things that's been on the TODO list for a long long
> > time, write code to verify the alignment of allocations :/ I'm
> > suspecting quite a lot of that goes wrong all over the place.
> 
> On x86, we only guarantee 8-byte alignment from things like kmalloc(), iirc.

Oh sure, and I'm not proposing to change that. I was more thinking of
having a GCC plugin that verifies, for every ptr assignment:

	ptr = foo;

that the actual alignment maches:

	assert(!(uintptr_t)ptr % __alignof(*ptr));

That would catch bugs like:

struct bar {
	int ponies;
	int peaches __smp_cacheline_aligned;
};

	struct bar *barp = kmalloc(sizeof(barp, GFP_KERNEL);

Blatantly violating alignment can't be right; either the alignment
constraints put on the data structures are not important and they should
be fixed, or we should respect them and fix the allocation, either way,
we should not silently violate things like we do today.


