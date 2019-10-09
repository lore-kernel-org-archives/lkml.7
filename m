Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DFAECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CF1218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfJIO3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:29:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34818 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbfJIO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:29:19 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iICxk-0003zb-4Q; Wed, 09 Oct 2019 14:29:12 +0000
Date:   Wed, 9 Oct 2019 16:29:11 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Todd Kjos <tkjos@android.com>, jannh@google.com, arve@android.com,
        christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        maco@android.com, tkjos@google.com,
        Hridya Valsaraju <hridya@google.com>
Subject: Re: [PATCH] binder: prevent UAF read in
 print_binder_transaction_log_entry()
Message-ID: <20191009142910.ggerxqxkft2ifhdn@wittgenstein>
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
 <20191008130159.10161-1-christian.brauner@ubuntu.com>
 <20191008180516.GB143258@google.com>
 <20191009104011.rzfdvq7otkkj533m@wittgenstein>
 <20191009142129.GD143258@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191009142129.GD143258@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:21:29AM -0400, Joel Fernandes wrote:
> On Wed, Oct 09, 2019 at 12:40:12PM +0200, Christian Brauner wrote:
> > On Tue, Oct 08, 2019 at 02:05:16PM -0400, Joel Fernandes wrote:
> > > On Tue, Oct 08, 2019 at 03:01:59PM +0200, Christian Brauner wrote:
> > > > When a binder transaction is initiated on a binder device coming from a
> > > > binderfs instance, a pointer to the name of the binder device is stashed
> > > > in the binder_transaction_log_entry's context_name member. Later on it
> > > > is used to print the name in print_binder_transaction_log_entry(). By
> > > > the time print_binder_transaction_log_entry() accesses context_name
> > > > binderfs_evict_inode() might have already freed the associated memory
> > > > thereby causing a UAF. Do the simple thing and prevent this by copying
> > > > the name of the binder device instead of stashing a pointer to it.
> > > > 
> > > > Reported-by: Jann Horn <jannh@google.com>
> > > > Fixes: 03e2e07e3814 ("binder: Make transaction_log available in binderfs")
> > > > Link: https://lore.kernel.org/r/CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Cc: Todd Kjos <tkjos@android.com>
> > > > Cc: Hridya Valsaraju <hridya@google.com>
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > ---
> > > >  drivers/android/binder.c          | 4 +++-
> > > >  drivers/android/binder_internal.h | 2 +-
> > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > index c0a491277aca..5b9ac2122e89 100644
> > > > --- a/drivers/android/binder.c
> > > > +++ b/drivers/android/binder.c
> > > > @@ -57,6 +57,7 @@
> > > >  #include <linux/sched/signal.h>
> > > >  #include <linux/sched/mm.h>
> > > >  #include <linux/seq_file.h>
> > > > +#include <linux/string.h>
> > > >  #include <linux/uaccess.h>
> > > >  #include <linux/pid_namespace.h>
> > > >  #include <linux/security.h>
> > > > @@ -66,6 +67,7 @@
> > > >  #include <linux/task_work.h>
> > > >  
> > > >  #include <uapi/linux/android/binder.h>
> > > > +#include <uapi/linux/android/binderfs.h>
> > > >  
> > > >  #include <asm/cacheflush.h>
> > > >  
> > > > @@ -2876,7 +2878,7 @@ static void binder_transaction(struct binder_proc *proc,
> > > >  	e->target_handle = tr->target.handle;
> > > >  	e->data_size = tr->data_size;
> > > >  	e->offsets_size = tr->offsets_size;
> > > > -	e->context_name = proc->context->name;
> > > > +	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
> > > 
> > > Strictly speaking, proc-context->name can also be initialized for !BINDERFS
> > > so the BINDERFS in the MAX_NAME macro is misleading. So probably there should
> > > be a BINDER_MAX_NAME (and associated checks for whether non BINDERFS names
> > > fit within the MAX.
> > 
> > I know but I don't think it's worth special-casing non-binderfs devices.
> > First, non-binderfs devices can only be created through a KCONFIG option
> > determined at compile time. For stock Android the names are the same for
> > all vendors afaik.
> 
> I am just talking about the name of weirdly named macro here.

You might miss context here: It's named that way because currently only
binderfs binder devices are bound to that limit. That's a point I made
further below in my previous mail. Non-binderfs devices are not subject
to that restriction and when we tried to make them subject to the same
it as rejected.

<snip>

> 
> > Fifth, I already tried to push for validation of non-binderfs binder
> > devices a while back when I wrote binderfs and was told that it's not
> > needed. Hrydia tried the same and we decided the same thing. So you get
> > to be the next person to send a patch. :)
> 
> I don't follow why we are talking about non-binderfs validation. I am just

Because above you said

> > > so the BINDERFS in the MAX_NAME macro is misleading. So probably there should
> > > be a BINDER_MAX_NAME (and associated checks for whether non BINDERFS names
> > > fit within the MAX.

which to me reads like you want generic checks for _all_ binder devices
not just for the ones from binderfs.

(Btw, I didn't read your comments as pointing it out the patch is buggy.
I mostly wanted to provide context why we ended up with the
binderfs-specific restriction. Maybe the list sounded like a complaint
but it wasn't meant to. :))

Thanks!
Christian
