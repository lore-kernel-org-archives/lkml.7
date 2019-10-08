Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6822C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A4821721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gI2w8LEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfJHSFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:05:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38376 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfJHSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:05:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so11240473pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ELxAahh6Yu3vLwEO8PoffGoqAdx+X0u75FdVW3JY1Sg=;
        b=gI2w8LEiuJ8QiTz0qaKjrFj29ovgQqape9UrwF8PgqhKY5YLEnDL2d7vZ6bRaaDCMO
         ACwTwDvSBazaHtOHX/3gUREFksyAHhJMuT9PitspDDM9DWXZ7M4x8/d5Gwd2O3uZytRD
         eo9WymPXThG/wamCnCsvWSs8pwN+w6PUuy2n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ELxAahh6Yu3vLwEO8PoffGoqAdx+X0u75FdVW3JY1Sg=;
        b=c8xX1WQQfA8pSc5A37Nn4yZfHDWtTwUy01tpQzxbpHH0i/w52TD/ZsKCQDiSkX6cBn
         kZR0IiU1YWlTU1zPGTCiE29JQkwe5WCSBbs8ih1wNibJ3q3sP9HLcRAikVC2javIOIrU
         Fgd0I+Np3kDKluYbrEcc+5fB7LEhBC7swGtHfsOa38E1VONsnXKQabAr0TvyAwvkG7PU
         pPJXJNd9wKtCy6TDhKEuvNAZHi0czCLuRZCV/jtzfLvXPaPFrhEbHC5DAUUU2kYb3JN8
         SLcwqKGGGT5crTtFJcjLZgBchZg9bMfFZ70f5PPvHvtfuy/MOTmOPVUepn2NO6+jg8jE
         EMJQ==
X-Gm-Message-State: APjAAAXp44hrcFEmeMH6kIO+T6CMD7F+WuT3wzaPEzFWoODLookA2sYI
        jpczUhDKhmTK6X+ai4Ya+byx4A==
X-Google-Smtp-Source: APXvYqx9Yy4rF5ZGPbnFM8um+WCTgOQ2VEF8Ceziv6hXyFbR88Ad4Mvbu6bXH2//Ti5CUkovB742/g==
X-Received: by 2002:a17:90a:3d08:: with SMTP id h8mr7434521pjc.12.1570557917832;
        Tue, 08 Oct 2019 11:05:17 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h26sm18536212pgh.7.2019.10.08.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 11:05:17 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:05:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     jannh@google.com, arve@android.com, christian@brauner.io,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, maco@android.com, tkjos@google.com,
        Todd Kjos <tkjos@android.com>,
        Hridya Valsaraju <hridya@google.com>
Subject: Re: [PATCH] binder: prevent UAF read in
 print_binder_transaction_log_entry()
Message-ID: <20191008180516.GB143258@google.com>
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
 <20191008130159.10161-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008130159.10161-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:01:59PM +0200, Christian Brauner wrote:
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
>  	e->target_handle = tr->target.handle;
>  	e->data_size = tr->data_size;
>  	e->offsets_size = tr->offsets_size;
> -	e->context_name = proc->context->name;
> +	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);

Strictly speaking, proc-context->name can also be initialized for !BINDERFS
so the BINDERFS in the MAX_NAME macro is misleading. So probably there should
be a BINDER_MAX_NAME (and associated checks for whether non BINDERFS names
fit within the MAX.

>  	if (reply) {

>  		binder_inner_proc_lock(proc);
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index bd47f7f72075..ae991097d14d 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -130,7 +130,7 @@ struct binder_transaction_log_entry {
>  	int return_error_line;
>  	uint32_t return_error;
>  	uint32_t return_error_param;
> -	const char *context_name;
> +	char context_name[BINDERFS_MAX_NAME + 1];

Same comment here, context_name can be used for non-BINDERFS transactions as
well such as default binder devices.

One more thought, this can be made dependent on CONFIG_BINDERFS since regular
binder devices cannot be unregistered AFAICS and as Jann said, the problem is
BINDERFS specific. That way we avoid the memcpy for _every_ transaction.
These can be thundering when Android starts up.

(I secretly wish C strings could be refcounted to avoid exactly this issue,
that should not be hard to develop but I am not sure if it is worth it for
this problem :) - For one, it will avoid having to do the strcpy for _every_
transaction).

Other than these nits, please add my tag on whichever is the final solution:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>  };
>  
>  struct binder_transaction_log {
> -- 
> 2.23.0
> 
