Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BEBC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C9B21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUbmozDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfJHSwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:52:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39159 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJHSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:52:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so18737463ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ttC9Qk38rpEvRKxSWa+eMhwRul6btb0043polx//lc=;
        b=SUbmozDe2X2ao0PY/uZdB+ZQ4aJnY+MeTvsd7f+Tn0cwGFbO3kvj2x74oGnu2ZtVfl
         7C3/WscpU66LIwJnimGpX5FCDpu6KKyGbJfTZA5vkNAt+kHiAf26N0qviyHfzeEcHFUK
         wg3kskdJfC0AsDMju45spea05k8Xhm6YUxwrwuQUnBSqwZhwbD8zig6e4vO/mmLgdLTy
         WU5OR1qQXHV/m7LvN+RyTELTMG5YiWus1rCf7quFv5vd8WLZah2J8lIS/RDqraz0vYwv
         2/8/HA890PurFicnF/XVln9imVqjTu5aPmFQPPxVd9om5YFIH+bx+iKh73jQQS5AK4Q2
         xh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ttC9Qk38rpEvRKxSWa+eMhwRul6btb0043polx//lc=;
        b=P2ZFAWRjuIWzqOdcH4MGAgK+wtxtdvgEUZNbEjYepG5z636aGVZLS2NEoTpOTsdBir
         KaABR/AMmL/JPVJKQEiYAaO8xZk+Yg9aLYBQULxK76rDzx+JU62oDm1B5m/P6xTMuvQb
         qaaqVw7el9T95lRPS9dt/WmE2ef7VuN0AXigUmEI6TcoGpeitf1/835bQvS3hOjuziXx
         z6Slhx+1/4ApEJ5+Hh3uwNXgCaoWtP3CI59i2NdIGSeJGf+U48E6Fbe/mdIlq4JS/t55
         voUvmFxrEZWVaHckodwB4z0aVhVEf9NbUTME/kP8OmJO+lhaMn4u5lOutZ1KoBBtZPVa
         aeGw==
X-Gm-Message-State: APjAAAWmyTYN9ue/2uMWoYCiPmhV/PNazOXokpPt8B3gIFdsTz469+m0
        ZRDen1Qjrk3PB/NM6qwXba0r2XZnv0xx6qbZgPUCyw==
X-Google-Smtp-Source: APXvYqxCk2wL5SmvjWie8G/3HUzvf7LJ63re3Ebs0TK50UJmvniQje7a/3Inx/xfJB9wZGEbhBcSCpvTO3k5nCfL1tA=
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr23471467ljj.18.1570560752527;
 Tue, 08 Oct 2019 11:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
 <20191008130159.10161-1-christian.brauner@ubuntu.com>
In-Reply-To: <20191008130159.10161-1-christian.brauner@ubuntu.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 8 Oct 2019 11:52:18 -0700
Message-ID: <CAHRSSExHMx5Xd79yBnQGKzeJg6+ucy9reZF=7_e_UM0BGrNC-w@mail.gmail.com>
Subject: Re: [PATCH] binder: prevent UAF read in print_binder_transaction_log_entry()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jann Horn <jannh@google.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@android.com>,
        Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 6:02 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> When a binder transaction is initiated on a binder device coming from a
> binderfs instance, a pointer to the name of the binder device is stashed
> in the binder_transaction_log_entry's context_name member. Later on it
> is used to print the name in print_binder_transaction_log_entry(). By
> the time print_binder_transaction_log_entry() accesses context_name
> binderfs_evict_inode() might have already freed the associated memory
> thereby causing a UAF. Do the simple thing and prevent this by copying
> the name of the binder device instead of stashing a pointer to it.
>
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: 03e2e07e3814 ("binder: Make transaction_log available in binderfs")
> Link: https://lore.kernel.org/r/CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  drivers/android/binder.c          | 4 +++-
>  drivers/android/binder_internal.h | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c0a491277aca..5b9ac2122e89 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -57,6 +57,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/seq_file.h>
> +#include <linux/string.h>
>  #include <linux/uaccess.h>
>  #include <linux/pid_namespace.h>
>  #include <linux/security.h>
> @@ -66,6 +67,7 @@
>  #include <linux/task_work.h>
>
>  #include <uapi/linux/android/binder.h>
> +#include <uapi/linux/android/binderfs.h>
>
>  #include <asm/cacheflush.h>
>
> @@ -2876,7 +2878,7 @@ static void binder_transaction(struct binder_proc *proc,
>         e->target_handle = tr->target.handle;
>         e->data_size = tr->data_size;
>         e->offsets_size = tr->offsets_size;
> -       e->context_name = proc->context->name;
> +       strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
>
>         if (reply) {
>                 binder_inner_proc_lock(proc);
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index bd47f7f72075..ae991097d14d 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -130,7 +130,7 @@ struct binder_transaction_log_entry {
>         int return_error_line;
>         uint32_t return_error;
>         uint32_t return_error_param;
> -       const char *context_name;
> +       char context_name[BINDERFS_MAX_NAME + 1];
>  };
>
>  struct binder_transaction_log {
> --
> 2.23.0
>

Acked-by: Todd Kjos <tkjos@google.com>
