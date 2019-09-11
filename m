Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C4C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E381920863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfIKNrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:47:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56788 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfIKNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:47:48 -0400
Received: from [148.69.85.38] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i82yH-0005OE-Bv; Wed, 11 Sep 2019 13:47:45 +0000
Date:   Wed, 11 Sep 2019 15:47:44 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2] fork: check exit_signal passed in clone3() call
Message-ID: <20190911134742.fuktu2wmwavfc3go@wittgenstein>
References: <20190910175852.GA15572@asgard.redhat.com>
 <20190911133119.GA17580@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190911133119.GA17580@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 03:31:20PM +0200, Oleg Nesterov wrote:
> On 09/10, Eugene Syromiatnikov wrote:
> >
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2338,6 +2338,8 @@ struct mm_struct *copy_init_mm(void)
> >   *
> >   * It copies the process, and if successful kick-starts
> >   * it and waits for it to finish using the VM if required.
> > + *
> > + * args->exit_signal is expected to be checked for sanity by the caller.
> 
> not sure this comment is really useful but it doesn't hurt
> 
> >  long _do_fork(struct kernel_clone_args *args)
> >  {
> > @@ -2562,6 +2564,16 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> >  	if (copy_from_user(&args, uargs, size))
> >  		return -EFAULT;
> >  
> > +	/*
> > +	 * exit_signal is confined to CSIGNAL mask in legacy syscalls,
> > +	 * so it is used unchecked deeper in syscall handling routines;
> > +	 * moreover, copying to struct kernel_clone_args.exit_signals
> > +	 * trims higher 32 bits, so it is has to be checked that they
> > +	 * are zero.
> > +	 */
> > +	if (unlikely(args.exit_signal & ~((u64)CSIGNAL)))
> > +		return -EINVAL;
> 
> OK, agreed. As you pointed out, this doesn't guarantee valid_signal(exit_signal).
> But we do no really care as long as it is non-negative, it acts as exit_signal==0.
> 
> I have no idea if we want to deny exit_signal >= _NSIG in clone3(), this was always
> allowed...
> 
> I think this needs the "CC: stable" tag.

No, I don't think so. clone3() is not in any released kernel. It'll be
released with 5.3. So we should just try and have this picked up this
week before the release.  I'm going to send a pr for this today
hopefully.
(Sorry for the delay, conferencing makes it harder to reply to mail.)

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
