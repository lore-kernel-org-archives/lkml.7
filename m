Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0CFC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85FE21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VstX66QS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfJIO4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:56:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38557 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfJIO4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:56:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so1789134pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aOgn8mw5G0zCorohTbiBhErE9Htr2eH0PTcfAgZzeCI=;
        b=VstX66QSqpiEh6mLaTLvPTUKIxieH1clx0lHan9qg0sh7wSLa9o1SAHAsDn45Y1LEX
         VnvHVqpzptArvIVOzmNnYmTvkQoS8/kmuZZoq6M0C8NPelxANZI7SXzH1WJ+NCXymblC
         8P4YVNu/EppaFy48zVDd4SMI+oGovUArNlnRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aOgn8mw5G0zCorohTbiBhErE9Htr2eH0PTcfAgZzeCI=;
        b=VnSS77fUdLXhAjU5nnev6vgwFPmSBuhSpDGpxvPhAKsARWdsoC0wBR8AsSce7YxX/J
         dQ//ZZhbCfMGQD8VzrU3gQO1krH8ZgLVvVqZBn7i0dNwVHG/ma/c8f7W3x9UeSGJ/xY3
         9DFR7BBKGjCMStmp3sAVvzxMD40PCYHhxucGlSf5lHZSzirlWsuEH8F0GygNWFRKWF7Q
         9fAFtES8Pqgl07aMchorwIPoqwFgPUuE2n4nIBkiazjG2LvH+0ukPtswDFImu7y64mPZ
         y5Fpw7IDOYpvy9Zd1WrH1yB+qOibymVOcHxFnXtFCX7e+zQ814HiZH8omW4q4Jzbv3Qb
         PN0Q==
X-Gm-Message-State: APjAAAVSqP5BWgetdpfCznWfRzsdSZJSfJhZcGs4H7oaJCDNESsCE14M
        4k7RxsPMMy52C6koibPLrW1JnA==
X-Google-Smtp-Source: APXvYqxG4MfEe0DJOggwz01Le1Ib2Ew4XpzR9Ciw+7fCKsEz4kX7uyIeV9AIXk2h68uhE2I+UsKqfg==
X-Received: by 2002:a63:287:: with SMTP id 129mr4814068pgc.190.1570632960950;
        Wed, 09 Oct 2019 07:56:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v9sm2866264pfe.1.2019.10.09.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:56:00 -0700 (PDT)
Date:   Wed, 9 Oct 2019 10:55:58 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Todd Kjos <tkjos@android.com>, jannh@google.com, arve@android.com,
        christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        maco@android.com, tkjos@google.com,
        Hridya Valsaraju <hridya@google.com>
Subject: Re: [PATCH] binder: prevent UAF read in
 print_binder_transaction_log_entry()
Message-ID: <20191009145558.GA96813@google.com>
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
 <20191008130159.10161-1-christian.brauner@ubuntu.com>
 <20191008180516.GB143258@google.com>
 <20191009104011.rzfdvq7otkkj533m@wittgenstein>
 <20191009142129.GD143258@google.com>
 <20191009142910.ggerxqxkft2ifhdn@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009142910.ggerxqxkft2ifhdn@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 04:29:11PM +0200, Christian Brauner wrote:
> On Wed, Oct 09, 2019 at 10:21:29AM -0400, Joel Fernandes wrote:
> > On Wed, Oct 09, 2019 at 12:40:12PM +0200, Christian Brauner wrote:
> > > On Tue, Oct 08, 2019 at 02:05:16PM -0400, Joel Fernandes wrote:
> > > > On Tue, Oct 08, 2019 at 03:01:59PM +0200, Christian Brauner wrote:
> > > > > When a binder transaction is initiated on a binder device coming from a
> > > > > binderfs instance, a pointer to the name of the binder device is stashed
> > > > > in the binder_transaction_log_entry's context_name member. Later on it
> > > > > is used to print the name in print_binder_transaction_log_entry(). By
> > > > > the time print_binder_transaction_log_entry() accesses context_name
> > > > > binderfs_evict_inode() might have already freed the associated memory
> > > > > thereby causing a UAF. Do the simple thing and prevent this by copying
> > > > > the name of the binder device instead of stashing a pointer to it.
> > > > > 
> > > > > Reported-by: Jann Horn <jannh@google.com>
> > > > > Fixes: 03e2e07e3814 ("binder: Make transaction_log available in binderfs")
> > > > > Link: https://lore.kernel.org/r/CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com
> > > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > > Cc: Todd Kjos <tkjos@android.com>
> > > > > Cc: Hridya Valsaraju <hridya@google.com>
> > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > ---
> > > > >  drivers/android/binder.c          | 4 +++-
> > > > >  drivers/android/binder_internal.h | 2 +-
> > > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > index c0a491277aca..5b9ac2122e89 100644
> > > > > --- a/drivers/android/binder.c
> > > > > +++ b/drivers/android/binder.c
> > > > > @@ -57,6 +57,7 @@
> > > > >  #include <linux/sched/signal.h>
> > > > >  #include <linux/sched/mm.h>
> > > > >  #include <linux/seq_file.h>
> > > > > +#include <linux/string.h>
> > > > >  #include <linux/uaccess.h>
> > > > >  #include <linux/pid_namespace.h>
> > > > >  #include <linux/security.h>
> > > > > @@ -66,6 +67,7 @@
> > > > >  #include <linux/task_work.h>
> > > > >  
> > > > >  #include <uapi/linux/android/binder.h>
> > > > > +#include <uapi/linux/android/binderfs.h>
> > > > >  
> > > > >  #include <asm/cacheflush.h>
> > > > >  
> > > > > @@ -2876,7 +2878,7 @@ static void binder_transaction(struct binder_proc *proc,
> > > > >  	e->target_handle = tr->target.handle;
> > > > >  	e->data_size = tr->data_size;
> > > > >  	e->offsets_size = tr->offsets_size;
> > > > > -	e->context_name = proc->context->name;
> > > > > +	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
> > > > 
> > > > Strictly speaking, proc-context->name can also be initialized for !BINDERFS
> > > > so the BINDERFS in the MAX_NAME macro is misleading. So probably there should
> > > > be a BINDER_MAX_NAME (and associated checks for whether non BINDERFS names
> > > > fit within the MAX.
> > > 
> > > I know but I don't think it's worth special-casing non-binderfs devices.
> > > First, non-binderfs devices can only be created through a KCONFIG option
> > > determined at compile time. For stock Android the names are the same for
> > > all vendors afaik.
> > 
> > I am just talking about the name of weirdly named macro here.
> 
> You might miss context here: It's named that way because currently only
> binderfs binder devices are bound to that limit. That's a point I made
> further below in my previous mail. Non-binderfs devices are not subject
> to that restriction and when we tried to make them subject to the same
> it as rejected.

I know that. I am saying the memcpy is happening for regular binder devices
as well but the macro has BINDERFS in the name. That's all. It is not a
significant eye sore. But is a bit odd.

> <snip>
> 
> > 
> > > Fifth, I already tried to push for validation of non-binderfs binder
> > > devices a while back when I wrote binderfs and was told that it's not
> > > needed. Hrydia tried the same and we decided the same thing. So you get
> > > to be the next person to send a patch. :)
> > 
> > I don't follow why we are talking about non-binderfs validation. I am just
> 
> Because above you said
> 
> > > > so the BINDERFS in the MAX_NAME macro is misleading. So probably there should
> > > > be a BINDER_MAX_NAME (and associated checks for whether non BINDERFS names
> > > > fit within the MAX.
> 
> which to me reads like you want generic checks for _all_ binder devices
> not just for the ones from binderfs.

No I am not talking about the checks at all, I am talking about the unwanted
mem copy you are doing for regular binder devices now. Before binderfs this
would not have happened, but now for regular binder devices we have to do the
extra mem copies which were avoided before. That was what I was talking about.

But this discussing is getting to bike shedding at this point, and since the
overhead is likely small, I am Ok with the change (though I don't like very
much the additional memcpy and the associated space wastage in the
transaction buffer for regular binder devices).

thanks!

 - Joel

> 
> (Btw, I didn't read your comments as pointing it out the patch is buggy.
> I mostly wanted to provide context why we ended up with the
> binderfs-specific restriction. Maybe the list sounded like a complaint
> but it wasn't meant to. :))
> 
> Thanks!
> Christian
