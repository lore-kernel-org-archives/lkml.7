Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A7C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6746721721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUpXWG1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJHRT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:19:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42547 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJHRT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:19:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so14693147otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7/gbm3RJTL0TVH1ZLjPUoytHiFwN21WJCo8ibqoeDQ=;
        b=ZUpXWG1bWoh4zFr+gjgNoVrWYx1WUaE/YcfQNPiJQXTXeEMYcYozKGDNdGtnoNDCRo
         UPuMBFlTM2u/2MWw3CoKyVSVb+y3VYSAu7m9Lv0hezzg8AqskYxrGn/BF0xCgRWRncW1
         TGwlt5psiYglK0e8ufKJ0wVFw8sUZFLFZiwkzMT7oUF1V/+qJqyXQAIdnQTobgXyWhZw
         YMiUpelGHmO0booe90K3vqqlymTrC6anV56DgKGR+rBDxxvpMPxyxmFA90yoWIrpO/cZ
         0vd0FBWozqrAcd/NrbhwwEi5zb/sv5OqByzBgDRvq4QA1OYZW4aiuR0kjet7rDMmTD0S
         aOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7/gbm3RJTL0TVH1ZLjPUoytHiFwN21WJCo8ibqoeDQ=;
        b=UADHq1XInk14O4m4qkhTGzkePrCgqDwFpmeDUMXnrs5XhJgSnBsYsHKqikai6f54uJ
         TL4mVxPQb+AyglGcvpzglVcyK4pQw17YkTAiq5ZxmyFwb5X2gg+CuJez+32EJOiV+XY4
         ND82qT+aERFoZ9A+lRWsYXAn7UtTsqOiNLVwWOdzOJSqYwxbd1sBpY657j+bnRoJDm21
         08DVpr+BpHNkZJtA6fLs1kXj937Ei82M1eAt6wkghAb3oN4ZWLbAxsIPQ6Bd69aMfzgX
         Oi12220YIHshrVLC3ugvVZNhAtEDo52YQwtTYJqzhGRiNOOiXP29h23wjyzr2Wr2Jq5X
         21hA==
X-Gm-Message-State: APjAAAWvACD5WzPEZrPVrIrcRaA6IKeM54BgR/gdWGJc6HfxaGTRmxxf
        OMvZNTj6LjqDMIs32nRo/su4AEERGe1NSnwBCuLVKA==
X-Google-Smtp-Source: APXvYqxwTOgEpp46kzNz9+9TPFWIuQF20yYh3lVzMc1t0DZiR6Ymsy1xmOwx46V6G8+czDEdX9APbmPM2+DmASKJFXI=
X-Received: by 2002:a9d:bcd:: with SMTP id 71mr27264570oth.35.1570555165072;
 Tue, 08 Oct 2019 10:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
 <20191008130159.10161-1-christian.brauner@ubuntu.com>
In-Reply-To: <20191008130159.10161-1-christian.brauner@ubuntu.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Tue, 8 Oct 2019 10:18:48 -0700
Message-ID: <CA+wgaPOfr+i-rNUTx+7PWWrZeRMsOUMYzk0ZKp5=C=cT-MSdpA@mail.gmail.com>
Subject: Re: [PATCH] binder: prevent UAF read in print_binder_transaction_log_entry()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     jannh@google.com,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@google.com>, Todd Kjos <tkjos@android.com>
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

Reviewed-by: Hridya Valsaraju <hridya@google.com>

Thank you for sending out this fix Christian!

Regards,
Hridya

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
