Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D785DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17B021E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389270AbfHGSUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:20:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59615 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbfHGSUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:20:38 -0400
Received: from c-67-180-61-213.hsd1.ca.comcast.net ([67.180.61.213] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hvQY1-0000pd-Hq; Wed, 07 Aug 2019 18:20:30 +0000
Date:   Wed, 7 Aug 2019 20:20:24 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190807182023.ut6dg4pfdcaw7m6k@wittgenstein>
References: <20190806191551.22192-1-areber@redhat.com>
 <20190807154828.GD24112@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190807154828.GD24112@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:48:29PM +0200, Oleg Nesterov wrote:
> On 08/06, Adrian Reber wrote:
> >
> > @@ -2530,12 +2530,14 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> >  					      struct clone_args __user *uargs,
> >  					      size_t size)
> >  {
> > +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
> >  	struct clone_args args;
> >  
> >  	if (unlikely(size > PAGE_SIZE))
> >  		return -E2BIG;
> >  
> > -	if (unlikely(size < sizeof(struct clone_args)))
> > +	/* The struct needs to be at least the size of the original struct. */
> > +	if (size < (sizeof(struct clone_args) - sizeof(__aligned_u64)))
> >  		return -EINVAL;
> 
> slightly off-topic, but with or without this patch I do not understand
> -EINVAL. Can't we replace this check with
> 
> 	if (size < sizeof(struct clone_args))
> 		memset((void*)&args + size, sizeof(struct clone_args) - size, 0);
> 
> ?
> 
> this way we can new members at the end of clone_args and this matches
> the "if (size > sizeof(struct clone_args))" block below which promises
> that whatever we add into clone_args a zero value should work.

Hm, I actually think we should define:

#define CLONE3_ARGS_SIZE_V0 64
#define CLONE3_ARGS_SIZE_V1 ...
and then later on for future extensions
#define CLONE3_ARGS_SIZE_V2 ...

then do
if (size < CLONE3_ARGS_SIZE_V0)
	return -EINVAL;

then do what you suggested:

if (size < sizeof(struct clone_args))
	memset((void*)&args + size, sizeof(struct clone_args) - size, 0);

> 
> 
> And if we do this
> 
> > +	if (size == sizeof(struct clone_args)) {
> > +		/* Only check permissions if set_tid is actually set. */
> > +		if (args.set_tid &&
> > +			!ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> > +			return -EPERM;
> > +		kargs->set_tid = args.set_tid;
> > +	}
> 
> we can move this check into clone3_args_valid() or even copy_process()
> 
> 	if (kargs->set_tid) {
> 		if (!ns_capable(...))
> 			return -EPERM;
> 	}
> 
> 
> Either way,
> 
> > @@ -2585,6 +2595,10 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
> >  	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
> >  		return false;
> >
> > +	/* Fail if set_tid is invalid */
> > +	if (kargs->set_tid < 0)
> > +		return false;
> 
> I think it would be more clean to do this along with ns_capable() check,
> or along with the "set_tid >= pid_max" check in alloc_pid().
> 
> I won't insist, but I do not really like the fact we check set_tid 3 times
> in copy_clone_args_from_user(), clone3_args_valid(), and alloc_pid().

Agreed on that part.
