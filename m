Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA9C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC782133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfJIKkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:40:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57539 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIKkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:40:19 -0400
Received: from [79.140.115.128] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iI9O9-0003Mv-7o; Wed, 09 Oct 2019 10:40:13 +0000
Date:   Wed, 9 Oct 2019 12:40:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Todd Kjos <tkjos@android.com>
Cc:     jannh@google.com, arve@android.com, christian@brauner.io,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, maco@android.com, tkjos@google.com,
        Todd Kjos <tkjos@android.com>,
        Hridya Valsaraju <hridya@google.com>
Subject: Re: [PATCH] binder: prevent UAF read in
 print_binder_transaction_log_entry()
Message-ID: <20191009104011.rzfdvq7otkkj533m@wittgenstein>
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
 <20191008130159.10161-1-christian.brauner@ubuntu.com>
 <20191008180516.GB143258@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008180516.GB143258@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 02:05:16PM -0400, Joel Fernandes wrote:
> On Tue, Oct 08, 2019 at 03:01:59PM +0200, Christian Brauner wrote:
> > When a binder transaction is initiated on a binder device coming from a
> > binderfs instance, a pointer to the name of the binder device is stashed
> > in the binder_transaction_log_entry's context_name member. Later on it
> > is used to print the name in print_binder_transaction_log_entry(). By
> > the time print_binder_transaction_log_entry() accesses context_name
> > binderfs_evict_inode() might have already freed the associated memory
> > thereby causing a UAF. Do the simple thing and prevent this by copying
> > the name of the binder device instead of stashing a pointer to it.
> > 
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: 03e2e07e3814 ("binder: Make transaction_log available in binderfs")
> > Link: https://lore.kernel.org/r/CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Todd Kjos <tkjos@android.com>
> > Cc: Hridya Valsaraju <hridya@google.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  drivers/android/binder.c          | 4 +++-
> >  drivers/android/binder_internal.h | 2 +-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index c0a491277aca..5b9ac2122e89 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -57,6 +57,7 @@
> >  #include <linux/sched/signal.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/string.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/pid_namespace.h>
> >  #include <linux/security.h>
> > @@ -66,6 +67,7 @@
> >  #include <linux/task_work.h>
> >  
> >  #include <uapi/linux/android/binder.h>
> > +#include <uapi/linux/android/binderfs.h>
> >  
> >  #include <asm/cacheflush.h>
> >  
> > @@ -2876,7 +2878,7 @@ static void binder_transaction(struct binder_proc *proc,
> >  	e->target_handle = tr->target.handle;
> >  	e->data_size = tr->data_size;
> >  	e->offsets_size = tr->offsets_size;
> > -	e->context_name = proc->context->name;
> > +	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
> 
> Strictly speaking, proc-context->name can also be initialized for !BINDERFS
> so the BINDERFS in the MAX_NAME macro is misleading. So probably there should
> be a BINDER_MAX_NAME (and associated checks for whether non BINDERFS names
> fit within the MAX.

I know but I don't think it's worth special-casing non-binderfs devices.
First, non-binderfs devices can only be created through a KCONFIG option
determined at compile time. For stock Android the names are the same for
all vendors afaik.
Second, BINDERFS_MAX_NAME is set to the maximum path name component
length that nearly all filesystems support (256 chars). If you exceed
that then you run afoul of a bunch of other assumptions already and will
cause trouble.
Third, even if there is someone crazy and uses more than 256 chars for a
non-binderfs device at KCONFIG time strscpy will do the right thing and
truncate and you'd see a truncated binder device name. This doesn't seem
to be a big deal for a debugfs interface.
Fourth, the check for non-binderfs devices technically has nothing to do
with this patch. This patch should really just do the minimal thing and
fix the UAF. Which it does.
Fifth, I already tried to push for validation of non-binderfs binder
devices a while back when I wrote binderfs and was told that it's not
needed. Hrydia tried the same and we decided the same thing. So you get
to be the next person to send a patch. :)

> 
> >  	if (reply) {
> 
> >  		binder_inner_proc_lock(proc);
> > diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> > index bd47f7f72075..ae991097d14d 100644
> > --- a/drivers/android/binder_internal.h
> > +++ b/drivers/android/binder_internal.h
> > @@ -130,7 +130,7 @@ struct binder_transaction_log_entry {
> >  	int return_error_line;
> >  	uint32_t return_error;
> >  	uint32_t return_error_param;
> > -	const char *context_name;
> > +	char context_name[BINDERFS_MAX_NAME + 1];
> 
> Same comment here, context_name can be used for non-BINDERFS transactions as
> well such as default binder devices.

See above.

> 
> One more thought, this can be made dependent on CONFIG_BINDERFS since regular
> binder devices cannot be unregistered AFAICS and as Jann said, the problem is
> BINDERFS specific. That way we avoid the memcpy for _every_ transaction.
> These can be thundering when Android starts up.

Unless Todd sees this as a real performance problem I'm weary to
introduce additional checking and record a pointer for non-binderfs and
a memcpy() for binderfs devices. :)

> 
> (I secretly wish C strings could be refcounted to avoid exactly this issue,
> that should not be hard to develop but I am not sure if it is worth it for
> this problem :) - For one, it will avoid having to do the strcpy for _every_
> transaction).
> 
> Other than these nits, please add my tag on whichever is the final solution:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks for the review, Joel. :)
Christian
