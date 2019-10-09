Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5876C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8080920B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="STZuVvgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfJIOVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:21:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33337 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfJIOVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:21:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so1748540pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DmUxhazUy7VP9f4USa8aSKP02spUxp65a86AeoMf0gQ=;
        b=STZuVvggKL55zLM9vCBJ+A2pfA7as9WNdrmpGbK3WnzSxjC/cF+rYR4+iN1xvo1GlC
         STsgQUY4G6+vZmw371freyyNJqFnRQcmN/m+f4E46bzSzHZpXU3Nhk/97eUI6l8wV5pL
         ovf7GJ80HIVPdZYmZaLydX0tSlgTVxXbcoHCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DmUxhazUy7VP9f4USa8aSKP02spUxp65a86AeoMf0gQ=;
        b=OL2xPs1CWyIDG7h9khKTcAJM9iinTCupPWVXkDgeVzYUZQGYq1vmfo93444INVWZ91
         8KLQ3pkzFgBXsUo7jnDX/pQYn5dMOcZkJ0tb++1LgBzd7Q2VowiAJQ+4wx3RWsidPZlS
         MwtOLk1QWU8TY1FpNh1uyIXnJ8VJFURsCmOTRWuUBl4nkgaq5QYUhxfMo/WUO3vIv7gm
         GX3vx23fSBk2hYPNPDAswujQIoLkSSKIDhv6xHdq0VuAwYhZ8xCg0HxRUVWcv26Rt+xt
         esXslw0gfubkAF11orIDhxnumcW8yEa/0l8f5qpLzPYFf4boCo4N95NflMbkNMYqSIED
         U3yg==
X-Gm-Message-State: APjAAAWsHycjnZef2i8IimCHUqasqGSfZnh/vq326sxv6mgkgWiqLpzy
        eSIYuAz9AQTcGrowBnDYXOHpIw==
X-Google-Smtp-Source: APXvYqw77zW9Asq12JCLJ75JsyifGbzBz5mJqgDeKYP8fCzNXqlPP+xWxreUUqKJMtKtic9hp0dZIw==
X-Received: by 2002:a63:1050:: with SMTP id 16mr4552328pgq.295.1570630891701;
        Wed, 09 Oct 2019 07:21:31 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s97sm2289836pjc.4.2019.10.09.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:21:30 -0700 (PDT)
Date:   Wed, 9 Oct 2019 10:21:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Todd Kjos <tkjos@android.com>, jannh@google.com, arve@android.com,
        christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        maco@android.com, tkjos@google.com,
        Hridya Valsaraju <hridya@google.com>
Subject: Re: [PATCH] binder: prevent UAF read in
 print_binder_transaction_log_entry()
Message-ID: <20191009142129.GD143258@google.com>
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
 <20191008130159.10161-1-christian.brauner@ubuntu.com>
 <20191008180516.GB143258@google.com>
 <20191009104011.rzfdvq7otkkj533m@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009104011.rzfdvq7otkkj533m@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:40:12PM +0200, Christian Brauner wrote:
> On Tue, Oct 08, 2019 at 02:05:16PM -0400, Joel Fernandes wrote:
> > On Tue, Oct 08, 2019 at 03:01:59PM +0200, Christian Brauner wrote:
> > > When a binder transaction is initiated on a binder device coming from a
> > > binderfs instance, a pointer to the name of the binder device is stashed
> > > in the binder_transaction_log_entry's context_name member. Later on it
> > > is used to print the name in print_binder_transaction_log_entry(). By
> > > the time print_binder_transaction_log_entry() accesses context_name
> > > binderfs_evict_inode() might have already freed the associated memory
> > > thereby causing a UAF. Do the simple thing and prevent this by copying
> > > the name of the binder device instead of stashing a pointer to it.
> > > 
> > > Reported-by: Jann Horn <jannh@google.com>
> > > Fixes: 03e2e07e3814 ("binder: Make transaction_log available in binderfs")
> > > Link: https://lore.kernel.org/r/CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Todd Kjos <tkjos@android.com>
> > > Cc: Hridya Valsaraju <hridya@google.com>
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > ---
> > >  drivers/android/binder.c          | 4 +++-
> > >  drivers/android/binder_internal.h | 2 +-
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index c0a491277aca..5b9ac2122e89 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -57,6 +57,7 @@
> > >  #include <linux/sched/signal.h>
> > >  #include <linux/sched/mm.h>
> > >  #include <linux/seq_file.h>
> > > +#include <linux/string.h>
> > >  #include <linux/uaccess.h>
> > >  #include <linux/pid_namespace.h>
> > >  #include <linux/security.h>
> > > @@ -66,6 +67,7 @@
> > >  #include <linux/task_work.h>
> > >  
> > >  #include <uapi/linux/android/binder.h>
> > > +#include <uapi/linux/android/binderfs.h>
> > >  
> > >  #include <asm/cacheflush.h>
> > >  
> > > @@ -2876,7 +2878,7 @@ static void binder_transaction(struct binder_proc *proc,
> > >  	e->target_handle = tr->target.handle;
> > >  	e->data_size = tr->data_size;
> > >  	e->offsets_size = tr->offsets_size;
> > > -	e->context_name = proc->context->name;
> > > +	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
> > 
> > Strictly speaking, proc-context->name can also be initialized for !BINDERFS
> > so the BINDERFS in the MAX_NAME macro is misleading. So probably there should
> > be a BINDER_MAX_NAME (and associated checks for whether non BINDERFS names
> > fit within the MAX.
> 
> I know but I don't think it's worth special-casing non-binderfs devices.
> First, non-binderfs devices can only be created through a KCONFIG option
> determined at compile time. For stock Android the names are the same for
> all vendors afaik.

I am just talking about the name of weirdly named macro here.

> Second, BINDERFS_MAX_NAME is set to the maximum path name component
> length that nearly all filesystems support (256 chars). If you exceed
> that then you run afoul of a bunch of other assumptions already and will
> cause trouble.

Again, just talking about the name.

> Third, even if there is someone crazy and uses more than 256 chars for a
> non-binderfs device at KCONFIG time strscpy will do the right thing and
> truncate and you'd see a truncated binder device name. This doesn't seem
> to be a big deal for a debugfs interface.

Sure I never said the patch has a bug.

> Fourth, the check for non-binderfs devices technically has nothing to do
> with this patch. This patch should really just do the minimal thing and
> fix the UAF. Which it does.

Again, never said the patch is buggy.

> Fifth, I already tried to push for validation of non-binderfs binder
> devices a while back when I wrote binderfs and was told that it's not
> needed. Hrydia tried the same and we decided the same thing. So you get
> to be the next person to send a patch. :)

I don't follow why we are talking about non-binderfs validation. I am just
saying a memcpy of the name could have been avoided for regular binder
devices. But since Todd Acked it, I wont stand in the way..

> > One more thought, this can be made dependent on CONFIG_BINDERFS since regular
> > binder devices cannot be unregistered AFAICS and as Jann said, the problem is
> > BINDERFS specific. That way we avoid the memcpy for _every_ transaction.
> > These can be thundering when Android starts up.
> 
> Unless Todd sees this as a real performance problem I'm weary to
> introduce additional checking and record a pointer for non-binderfs and
> a memcpy() for binderfs devices. :)

Ok.

> > (I secretly wish C strings could be refcounted to avoid exactly this issue,
> > that should not be hard to develop but I am not sure if it is worth it for
> > this problem :) - For one, it will avoid having to do the strcpy for _every_
> > transaction).
> > 
> > Other than these nits, please add my tag on whichever is the final solution:
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Thanks for the review, Joel. :)

My duty!! ;-)

thanks,

 - Joel

