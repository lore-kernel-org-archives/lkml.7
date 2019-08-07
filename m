Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE0DC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB32229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388821AbfHGQVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387922AbfHGQVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:21:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDF28641DA;
        Wed,  7 Aug 2019 16:21:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8A2B160852;
        Wed,  7 Aug 2019 16:21:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Aug 2019 18:21:15 +0200 (CEST)
Date:   Wed, 7 Aug 2019 18:21:12 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190807162112.GF24112@redhat.com>
References: <20190806191551.22192-1-areber@redhat.com>
 <20190807154828.GD24112@redhat.com>
 <b57e809d-e5fa-bda2-ee81-e86116bb2856@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b57e809d-e5fa-bda2-ee81-e86116bb2856@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 07 Aug 2019 16:21:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07, Dmitry Safonov wrote:
> 
> On 8/7/19 4:48 PM, Oleg Nesterov wrote:
> > On 08/06, Adrian Reber wrote:
> >>
> >> @@ -2530,12 +2530,14 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> >>  					      struct clone_args __user *uargs,
> >>  					      size_t size)
> >>  {
> >> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
> >>  	struct clone_args args;
> >>  
> >>  	if (unlikely(size > PAGE_SIZE))
> >>  		return -E2BIG;
> >>  
> >> -	if (unlikely(size < sizeof(struct clone_args)))
> >> +	/* The struct needs to be at least the size of the original struct. */
> >> +	if (size < (sizeof(struct clone_args) - sizeof(__aligned_u64)))
> >>  		return -EINVAL;
> > 
> > slightly off-topic, but with or without this patch I do not understand
> > -EINVAL. Can't we replace this check with
> > 
> > 	if (size < sizeof(struct clone_args))
> > 		memset((void*)&args + size, sizeof(struct clone_args) - size, 0);
> > 
> > ?
> > 
> > this way we can new members at the end of clone_args and this matches
> > the "if (size > sizeof(struct clone_args))" block below which promises
> > that whatever we add into clone_args a zero value should work.
>
> What if the size is lesser than offsetof(struct clone_args, stack_size)?
> Probably, there should be still a check that it's not lesser than what's
> the required minimum..

Not sure I understand... I mean, this doesn't differ from the case when
size == sizeof(clone_args) but uargs->stack == NULL ?

> Also note, that (kargs) and (args) are a bit different beasts in this
> context..
> kargs lies on the stack and might want to be with zero-initializer
> :	struct kernel_clone_args kargs = {};

I don't think so. Lets consider this patch which adds the new set_tid
into clone_args and kernel_clone_args. copy_clone_args_from_user() does

	*kargs = (struct kernel_clone_args){
		.flags		= args.flags,
		.pidfd		= u64_to_user_ptr(args.pidfd),
		.child_tid	= u64_to_user_ptr(args.child_tid),
		.parent_tid	= u64_to_user_ptr(args.parent_tid),
		.exit_signal	= args.exit_signal,
		.stack		= args.stack,
		.stack_size	= args.stack_size,
		.tls		= args.tls,
	};

so this patch should simply add

		.set_tid	= args.set_tid;

at the end. No?

Oleg.

