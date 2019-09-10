Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C910C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B394206CD
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfIJN1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:27:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38929 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfIJN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:27:05 -0400
Received: from [148.69.85.38] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i7gAh-0005Io-08; Tue, 10 Sep 2019 13:27:03 +0000
Date:   Tue, 10 Sep 2019 15:27:02 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] fork: fail on non-zero higher 32 bits of args.exit_signal
Message-ID: <20190910132701.s5o5nidewyo5zl7h@wittgenstein>
References: <20190910115711.GA3755@asgard.redhat.com>
 <20190910124440.GA25647@redhat.com>
 <20190910130935.jxqxbt7wop3ostob@wittgenstein>
 <20190910131048.e7xr52az2zej4p4v@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190910131048.e7xr52az2zej4p4v@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 03:10:48PM +0200, Christian Brauner wrote:
> On Tue, Sep 10, 2019 at 03:09:35PM +0200, Christian Brauner wrote:
> > On Tue, Sep 10, 2019 at 02:44:41PM +0200, Oleg Nesterov wrote:
> > > On 09/10, Eugene Syromiatnikov wrote:
> > > >
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -2562,6 +2562,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> > > >  	if (copy_from_user(&args, uargs, size))
> > > >  		return -EFAULT;
> > > >  
> > > > +	if (unlikely(((unsigned int)args.exit_signal) != args.exit_signal))
> > > > +		return -EINVAL;
> > > 
> > > Hmm. Unless I am totally confused you found a serious bug...
> > > 
> > > Without CLONE_THREAD/CLONE_PARENT copy_process() blindly does
> > > 
> > > 	p->exit_signal = args->exit_signal;
> > > 
> > > the valid_signal(sig) check in do_notify_parent() mostly saves us, but we
> > > must not allow child->exit_signal < 0, if nothing else this breaks
> > > thread_group_leader().
> > > 
> > > And afaics this patch doesn't fix this? I think we need the valid_signal()
> > > check...
> > 
> > Thanks for sending this patch so quickly after our conversation
> > yesterday, Eugene!
> > We definitely want valid_signal() to verify the signal is ok.

So we could do your check in copy_clone_args_from_user(), and then we do
another valid_signal() check in clone3_args_valid()? We could do the
latter in copy_clone_args_from_user() too but it's nicer to do it along
the other checks in clone3_args_valid().

Christian
