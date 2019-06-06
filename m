Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB20C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117C3206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tbQnnJcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfFFIL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:11:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60888 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e6bLkJJ04QCBl6qx9TwevQz+PD7l230SF5u4ffzcwfE=; b=tbQnnJcCiL15+sVyBFtYTuc6J
        7Ao7Ud2ZOVJ5uYDqHR8tsj9CgNiImS2ee5cuM5aG3CqHQpJaO9i6Td1MFa8V/C1RhDcDD7zCDgOS8
        1NDsKd3IL+aTNIYsNRsLqGmHORI7bWrKZJy4/uvgFZZgXCqDasofv1ybASwMlhkqXZ6kB5BSFP9yd
        +7GCRB4zM9K1mixmga6/ruLGEUhYXRjqKZGiUofLb0mVFxkFKnfaIFYoGRAR+gkIDKgb9mTy72Gzp
        4/qoGCUIKjFS3xtMJ6I9JNqlt6jDyNQBoMZPkMpgqDNW4BP18k1wIW0sGSU7ShCnOwJdompirJ88T
        MVCX9f0EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYnUs-0006kT-OB; Thu, 06 Jun 2019 08:11:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 881CD203AA6FD; Thu,  6 Jun 2019 10:11:41 +0200 (CEST)
Date:   Thu, 6 Jun 2019 10:11:41 +0200
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
Message-ID: <20190606081141.GC3463@hirez.programming.kicks-ass.net>
References: <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
 <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
 <20190604173853.GG3419@hirez.programming.kicks-ass.net>
 <f7f9b778-4f1a-7460-a7ae-1d4e3dd37181@redhat.com>
 <20190604181426.GH3419@hirez.programming.kicks-ass.net>
 <db89a086-3719-cea5-e24e-339085728c29@redhat.com>
 <46e44f43-87fd-251b-3b83-89a8bb3b407f@redhat.com>
 <20190605201901.GB3402@hirez.programming.kicks-ass.net>
 <CAHk-=wgqfXUeKkjT-TJRubxU5KNt9CLi88QSXhXT0H=3v4uF3g@mail.gmail.com>
 <20190606080315.GE3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606080315.GE3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:03:15AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 05, 2019 at 01:52:15PM -0700, Linus Torvalds wrote:
> > On Wed, Jun 5, 2019 at 1:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Urgh, that's another things that's been on the TODO list for a long long
> > > time, write code to verify the alignment of allocations :/ I'm
> > > suspecting quite a lot of that goes wrong all over the place.
> > 
> > On x86, we only guarantee 8-byte alignment from things like kmalloc(), iirc.
> 
> Oh sure, and I'm not proposing to change that. I was more thinking of
> having a GCC plugin that verifies, for every ptr assignment:
> 
> 	ptr = foo;

To better qualify: 'for every ptr assignment that includes a type cast',
and since allocators return 'void *' and (typically/eventually) assign
to a typed pointer, that would be the place to check.

This avoids having to instrument every single pointer assignment.

> that the actual alignment maches:
> 
> 	assert(!(uintptr_t)ptr % __alignof(*ptr));
> 
> That would catch bugs like:
> 
> struct bar {
> 	int ponies;
> 	int peaches __smp_cacheline_aligned;
> };
> 
> 	struct bar *barp = kmalloc(sizeof(barp, GFP_KERNEL);
> 
> Blatantly violating alignment can't be right; either the alignment
> constraints put on the data structures are not important and they should
> be fixed, or we should respect them and fix the allocation, either way,
> we should not silently violate things like we do today.
> 
> 
