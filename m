Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A17C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2759B24B36
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XGIvDcKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfFDJ4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:56:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40744 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfFDJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:56:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so10277289wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ZbLcJhbADzOCXOElQ4BPrniesq/GHeYDcXBdpu8YX0=;
        b=XGIvDcKDTGlVulUF/Qp2Ny2YLbHmCjYULB5q7v0ZOWxmJaDGhm54f27fBe0ZaOEKtI
         aLRR5sDenAGiUb3VMhShIIZLSKEg2ZXwsw1Knu5GfYRA0HNMIXbaCGFbEordr56Pg0eR
         c7s1prXvtpai1Rl9r/w1uiKOqxGab9MVZLDo7VCxlT4vgU7NtW3vFZgwCpNBZUFEsQtd
         i3I2eDIXaIQf/6fObZN86bAd3t+mY+GZ0Ucv0KwbcW8Wa9rmHEQLg9Xft/egx6qtCsrE
         8oK7PpXW3LxORrEUEgNYM+N1qLUgbUsybdWD+SXId+mIvgIqCN+zKjTQE4SAmiChpdhx
         p0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ZbLcJhbADzOCXOElQ4BPrniesq/GHeYDcXBdpu8YX0=;
        b=VuXHvJX1Ot7PIxCUV8Nk1COilVmSqhA7HvNST5bZznomI/mUx2d8vAmlwAIIv6AdXZ
         qdcOlZzbjxEwzZgHMFiXE/yr2dc9X0gpL31OW7yiF6on+7mRUOQBjs8zd4N3dd4DZ1m1
         wqx2Ezqk2IioSSrJ/lhoYOI9GNAi38gf3SbydSQjIU448T4xV8PdlMUhQB+SQlyRBdqV
         /t8izm0268J5Iz7WUBfRI//uB7I62/SywoEA/4hWs4FQiHhcq5i8bvw0oKLC9eQGk9rm
         3y/Ota9wT5Fe358jzLbkn9VUMBIMbRI4u373+5wstDbEk9YoqNmJAdaTBD/mUwDmiJic
         Mr7w==
X-Gm-Message-State: APjAAAXRL3AQtbXXrmI1+mWL10mTQGZYZj2ETqeygtO/uSd3ANgNkzO0
        9K5VCaaDiE4ASg3wbo7tzjU5mg==
X-Google-Smtp-Source: APXvYqzTcIFclDpx5BpmdTLFHU2RBH91jk3706KaCS4Z5VGJ0ycig9TDYbME7Msj15OvwxDmQcXd1Q==
X-Received: by 2002:a5d:5747:: with SMTP id q7mr18731165wrw.226.1559642195049;
        Tue, 04 Jun 2019 02:56:35 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id a62sm19187246wmf.19.2019.06.04.02.56.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 02:56:34 -0700 (PDT)
Date:   Tue, 4 Jun 2019 11:56:33 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        keescook@chromium.org, fweimer@redhat.com, oleg@redhat.com,
        arnd@arndb.de, Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fork: add clone3
Message-ID: <20190604095632.gsapgrmvup3mabga@brauner.io>
References: <20190603144331.16760-1-christian@brauner.io>
 <4020.1559640492@warthog.procyon.org.uk>
 <20190604094317.4wfelmbw4lgxzide@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604094317.4wfelmbw4lgxzide@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 11:43:17AM +0200, Christian Brauner wrote:
> On Tue, Jun 04, 2019 at 10:28:12AM +0100, David Howells wrote:
> > Christian Brauner <christian@brauner.io> wrote:
> > 
> > > +#include <linux/compiler_types.h>
> > 
> > I suspect you don't want to include that directly.
> > 
> > Also, to avoid bloating linux/sched/task.h yet further, maybe put this in
> > linux/sched/clone.h?
> 
> Yeah, not the worst idea.
> Though I'd leave the flags where they are and just add struct
> kernel_clone_args in there. But I assume that's what you meant anyway.

Actually, I would like to defer this to the cleanup patch too.
This way the patch stays small and clean and task.h is currently the
right place to put it.

> 
> > 
> > > -extern long _do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *, unsigned long);
> > > +extern long _do_fork(struct kernel_clone_args *kargs);
> > >  extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
> > 
> > Maybe these could move into linux/sched/clone.h too.
> 
> Meh, that could be a separate cleanup patch after clone3() has been
> merged.
> 
> > 
> > > +#define CLONE_MAX ~0U
> > 
> > Can you add a comment summarising the meaning?
> 
> Yes, can do.
> 
> > 
> > > +	u64 clone_flags = args->flags;
> > > +	int __user *child_tidptr = args->child_tid;
> > > +	unsigned long tls = args->tls;
> > > +	unsigned long stack_start = args->stack;
> > > +	unsigned long stack_size = args->stack_size;
> > 
> > Some of these are only used once, so it's probably not worth sticking them in
> > local variables.
> 
> [1]:
> Ok, will double check.
> This was just to minimize copy-paste erros for variables which were used
> multiple times.
> 
> > 
> > > -		if (clone_flags &
> > > -		    (CLONE_DETACHED | CLONE_PARENT_SETTID | CLONE_THREAD))
> > > -			return ERR_PTR(-EINVAL);
> > 
> > Did this error check get lost?  I can see part of it further on, but the check
> > on CLONE_PARENT_SETTID is absent.
> 
> No, it's only relevant for legacy clone() since it uses the
> parent_tidptr argument to return the pidfd. clone3() has a dedicated
> return argument for that in clone_args.
> The check for legacy clone() is now done in legacy clone() directly.
> copy_process() should only do generic checks for all version of
> clone(),fork(),vfork(), etc.
> 
> > 
> > > +	int __user *parent_tidptr = args->parent_tid;
> > 
> > There's only one usage remaining after this patch, so a local var doesn't gain
> > a lot.
> 
> Yes, that leads back to [1].
> 
> > 
> > >  pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
> > >  {
> > > -	return _do_fork(flags|CLONE_VM|CLONE_UNTRACED, (unsigned long)fn,
> > > -		(unsigned long)arg, NULL, NULL, 0);
> > > +	struct kernel_clone_args args = {
> > > +		.flags = ((flags | CLONE_VM | CLONE_UNTRACED) & ~CSIGNAL),
> > > +		.exit_signal = (flags & CSIGNAL),
> > 
> > Kernel threads can have exit signals?
> 
> Yes,
> 
> kernel/kthread.c:       pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
> kernel/umh.c:   pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
> 
> And even if they couldn't have. This is just to make sure that if they
> ever would we'd be prepared.
> 
> > 
> > > +static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> > > +				     struct clone_args __user *uargs,
> > > +				     size_t size)
> > 
> > I would make this "noinline".  If it gets inlined, local variable "args" may
> > still be on the stack when _do_fork() gets called.
> 
> Hm, can do.
> 
> Thanks!
> Christian
