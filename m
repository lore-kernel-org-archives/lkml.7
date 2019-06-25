Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0492C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B06E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PSt1cdfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfFYHe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:34:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54252 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfFYHe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EfE9b6iC+ztQ2vj5wKDIVg9bT9RfKnT+aDZ7Xh8JmQE=; b=PSt1cdfG8jH5IrxOFwBR1B7iF
        JopUIkQmRjHxy5FprH9Y9CT7pNwP2YVqEqKo8zs1R7JVlb0XlkpvWvDzyT/iV0M726xXDDr5LAztO
        +clzTA2iC4AVb5yD2D0yaHL8M1nGCoVcywSlRINOe6I6HWIOVZORlh/9C5BAk+4Pe6zgbun+JUf/e
        slVVCpJLcSsz0tYF3bVjdB9286lk2vtmB7eBZ0K+d/xiufG0TuVMCQs6wQOQY+JfJGHnxgNb+T7bF
        KTIygfAloBmKQn/5WzScPCwqIV95gzFkI96M7ypN2EJxsIVWZG4UVAZ6OUoZ0KszrzoN8t3rFlXUh
        34boJnm5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hffxx-0002XT-5n; Tue, 25 Jun 2019 07:34:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDA9E209FFF54; Tue, 25 Jun 2019 09:34:07 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:34:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH RFC v2] Convert struct pid count to refcount_t
Message-ID: <20190625073407.GP3436@hirez.programming.kicks-ass.net>
References: <20190624184534.209896-1-joel@joelfernandes.org>
 <20190624185214.GA211230@google.com>
 <CAG48ez3maGsRbN3qr8YVb6ZCw0FDq-7GqqiTiA4yEa1mebkubw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3maGsRbN3qr8YVb6ZCw0FDq-7GqqiTiA4yEa1mebkubw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 09:10:15PM +0200, Jann Horn wrote:
> That part of the documentation only talks about cases where you have a
> control dependency on the return value of the refcount operation. But
> refcount_inc() does not return a value, so this isn't relevant for
> refcount_inc().
> 
> Also, AFAIU, the control dependency mentioned in the documentation has
> to exist *in the caller* - it's just pointing out that if you write
> code like the following, you have a control dependency between the
> refcount operation and the write:
> 
>     if (refcount_inc_not_zero(&obj->refcount)) {
>       WRITE_ONCE(obj->x, y);
>     }
> 
> For more information on the details of this stuff, try reading the
> section "CONTROL DEPENDENCIES" of Documentation/memory-barriers.txt.

IIRC the argument went as follows:

 - if you use refcount_inc(), you've already got a stable object and
   have ACQUIRED it otherwise, typically through locking.

 - if you use refcount_inc_not_zero(), you have a semi stable object
   (RCU), but you still need to ensure any changes to the object happen
   after acquiring a reference, and this is where the control dependency
   comes in as Jann already explained.

Specifically, it would be bad to allow STOREs to happen before we know
the refcount isn't 0, as that would be a UaF.

Also see the comment in lib/refcount.c.

