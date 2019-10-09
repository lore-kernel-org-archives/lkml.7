Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18F0ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC1121848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CJAd+CcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfJIPhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:37:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46565 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbfJIPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:37:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id b8so1627752pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ZGdcOkmNChI8GwI1qcidl2FDH4Bb9peSC073dz7RNI=;
        b=CJAd+CcAELyW05E819LLecs1+gJPqyY2RarShACD41RGixMe/lGk9gk+HKPTR0iujG
         9xuBZ/ZnoAXPZrSkM7jSeVMUUrHV/wbM3iX0EF/wFkliAQ97f6hs8Ygj7ZVpsUUk69wb
         KAINJ+IZp/QNxiqEXUtoUAgd/uU6Pgo5IT+O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ZGdcOkmNChI8GwI1qcidl2FDH4Bb9peSC073dz7RNI=;
        b=hwecIYmiwZcmSOGPu0t3NFcVIu/HxH5Jw0barGu0V7qxG5GG6zKXgiQSiwiOIsVaaZ
         sOx48zLGdi2Nco6IB62f59BtPtWWh7kGlgVt9wQbGX8FFXMBx2rG7ir0G73m89TQV8Py
         LwWBOoVOeSKO8FUT3jTBUkav3Sxhf8Zpu1SAAfOFOzHdcr6Gu524hHO6JkxoIiMpeNWu
         9T+xVWuxGOh6qEdnbxR9j/b/OJan1hcAsM77iWT2zr246fkUM2oFL0x5lfJxM1P9Vo5f
         uFXQKFw5f5ess7wEcZWHSAYerfij+KofIM/GoKBEXlcaUIMhfIoLzYj8qarUkOcNNvD8
         uZQg==
X-Gm-Message-State: APjAAAXs0PaWmuk8Y02W5VD0k2sUmWBKXZNVM36GZczxcBTXIi38ti0c
        9PfaPXsZU1Rfi50pSEmyeKtm/w==
X-Google-Smtp-Source: APXvYqwYRXAeX7S2oT8FjXdl9BCAH/zKp7xscFhn8VCIxBtgH911ZQui6ZAkGOu1jgRdabCyxN4ztg==
X-Received: by 2002:a17:90b:313:: with SMTP id ay19mr4821052pjb.25.1570635431802;
        Wed, 09 Oct 2019 08:37:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k5sm2222328pgo.45.2019.10.09.08.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:37:11 -0700 (PDT)
Date:   Wed, 9 Oct 2019 11:37:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Todd Kjos <tkjos@android.com>, jannh@google.com, arve@android.com,
        christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        maco@android.com, tkjos@google.com,
        Hridya Valsaraju <hridya@google.com>
Subject: Re: [PATCH] binder: prevent UAF read in
 print_binder_transaction_log_entry()
Message-ID: <20191009153710.GC13654@google.com>
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
 <20191008130159.10161-1-christian.brauner@ubuntu.com>
 <20191008180516.GB143258@google.com>
 <20191009104011.rzfdvq7otkkj533m@wittgenstein>
 <20191009142129.GD143258@google.com>
 <20191009142910.ggerxqxkft2ifhdn@wittgenstein>
 <20191009145558.GA96813@google.com>
 <20191009151044.t2jo3mo4acjtyhez@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009151044.t2jo3mo4acjtyhez@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 05:10:45PM +0200, Christian Brauner wrote:
> On Wed, Oct 09, 2019 at 10:55:58AM -0400, Joel Fernandes wrote:
> > On Wed, Oct 09, 2019 at 04:29:11PM +0200, Christian Brauner wrote:
> > > On Wed, Oct 09, 2019 at 10:21:29AM -0400, Joel Fernandes wrote:
> > > > On Wed, Oct 09, 2019 at 12:40:12PM +0200, Christian Brauner wrote:
> > > > > On Tue, Oct 08, 2019 at 02:05:16PM -0400, Joel Fernandes wrote:
> > > > > > On Tue, Oct 08, 2019 at 03:01:59PM +0200, Christian Brauner wrote:
> > > > > > > When a binder transaction is initiated on a binder device coming from a
> > > > > > > binderfs instance, a pointer to the name of the binder device is stashed
> > > > > > > in the binder_transaction_log_entry's context_name member. Later on it
> > > > > > > is used to print the name in print_binder_transaction_log_entry(). By
> > > > > > > the time print_binder_transaction_log_entry() accesses context_name
> > > > > > > binderfs_evict_inode() might have already freed the associated memory
> > > > > > > thereby causing a UAF. Do the simple thing and prevent this by copying
> > > > > > > the name of the binder device instead of stashing a pointer to it.
> > > > > > > 
> > > > > > > Reported-by: Jann Horn <jannh@google.com>
> > > > > > > Fixes: 03e2e07e3814 ("binder: Make transaction_log available in binderfs")
> > > > > > > Link: https://lore.kernel.org/r/CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com
> > > > > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > > > > Cc: Todd Kjos <tkjos@android.com>
> > > > > > > Cc: Hridya Valsaraju <hridya@google.com>
> > > > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > > > ---
> > > > > > >  drivers/android/binder.c          | 4 +++-
> > > > > > >  drivers/android/binder_internal.h | 2 +-
> > > > > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > > > index c0a491277aca..5b9ac2122e89 100644
> > > > > > > --- a/drivers/android/binder.c
> > > > > > > +++ b/drivers/android/binder.c
> > > > > > > @@ -57,6 +57,7 @@
> > > > > > >  #include <linux/sched/signal.h>
> > > > > > >  #include <linux/sched/mm.h>
> > > > > > >  #include <linux/seq_file.h>
> > > > > > > +#include <linux/string.h>
> > > > > > >  #include <linux/uaccess.h>
> > > > > > >  #include <linux/pid_namespace.h>
> > > > > > >  #include <linux/security.h>
> > > > > > > @@ -66,6 +67,7 @@
> > > > > > >  #include <linux/task_work.h>
> > > > > > >  
> > > > > > >  #include <uapi/linux/android/binder.h>
> > > > > > > +#include <uapi/linux/android/binderfs.h>
> > > > > > >  
> > > > > > >  #include <asm/cacheflush.h>
> > > > > > >  
> > > > > > > @@ -2876,7 +2878,7 @@ static void binder_transaction(struct binder_proc *proc,
> > > > > > >  	e->target_handle = tr->target.handle;
> > > > > > >  	e->data_size = tr->data_size;
> > > > > > >  	e->offsets_size = tr->offsets_size;
> > > > > > > -	e->context_name = proc->context->name;
> > > > > > > +	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
> > > > > > 
> > > > > > Strictly speaking, proc-context->name can also be initialized for !BINDERFS
> > > > > > so the BINDERFS in the MAX_NAME macro is misleading. So probably there should
> > > > > > be a BINDER_MAX_NAME (and associated checks for whether non BINDERFS names
> > > > > > fit within the MAX.
> > > > > 
> > > > > I know but I don't think it's worth special-casing non-binderfs devices.
> > > > > First, non-binderfs devices can only be created through a KCONFIG option
> > > > > determined at compile time. For stock Android the names are the same for
> > > > > all vendors afaik.
> > > > 
> > > > I am just talking about the name of weirdly named macro here.
> > > 
> > > You might miss context here: It's named that way because currently only
> > > binderfs binder devices are bound to that limit. That's a point I made
> > > further below in my previous mail. Non-binderfs devices are not subject
> > > to that restriction and when we tried to make them subject to the same
> > > it as rejected.
> > 
> > I know that. I am saying the memcpy is happening for regular binder devices
> > as well but the macro has BINDERFS in the name. That's all. It is not a
> > significant eye sore. But is a bit odd.
> 
> Right, and I told you that we _can't_ rename it to BINDER_MAX because
> that check only happens for binderfs devices since you were suggesting
> this. If you want to rename to get rid of the this being somehow
> apparently odd then you need to introduce that check for non-binderfs
> devices too. Or just rename the macro in a follow-up patch. I don't care.

Here in this patch we are doing mem copy for regular binder device name using
a BINDERFS macro name.

> > 
> > > <snip>
> > > 
> > > > 
> > > > > Fifth, I already tried to push for validation of non-binderfs binder
> > > > > devices a while back when I wrote binderfs and was told that it's not
> > > > > needed. Hrydia tried the same and we decided the same thing. So you get
> > > > > to be the next person to send a patch. :)
> > > > 
> > > > I don't follow why we are talking about non-binderfs validation. I am just
> > > 
> > > Because above you said
> > > 
> > > > > > so the BINDERFS in the MAX_NAME macro is misleading. So probably there should
> > > > > > be a BINDER_MAX_NAME (and associated checks for whether non BINDERFS names
> > > > > > fit within the MAX.
> > > 
> > > which to me reads like you want generic checks for _all_ binder devices
> > > not just for the ones from binderfs.
> > 
> > No I am not talking about the checks at all, I am talking about the unwanted
> > mem copy you are doing for regular binder devices now. Before binderfs this
> > would not have happened, but now for regular binder devices we have to do the
> > extra mem copies which were avoided before. That was what I was talking about.
> 
> I'm sorry but I did not get this at all from:
> "So probably there should be a BINDER_MAX_NAME (and associated checks
> for whether non BINDERFS names fit within the MAX." 

Sorry for the misleading statement. That means I have to improve my
communication game, sorry it is my fault.

> > 
> > But this discussing is getting to bike shedding at this point, and since the
> > overhead is likely small, I am Ok with the change (though I don't like very
> > much the additional memcpy and the associated space wastage in the
> > transaction buffer for regular binder devices).
> 
> Feel free to send a follow-up patch handling both separately.

Ok will do once I get a chance. Thanks for working on the fix!

-  Joel

