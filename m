Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91835C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607862133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+eeuu9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfJFKAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:00:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45109 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfJFKAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:00:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so9923381qkb.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 03:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AJ8vN7NgW8GOge2fXRfaMsuXVib9gxqFttdl/8POdE=;
        b=g+eeuu9tszJJePOOvtXgKF4XEHohYk9Y9gekEYtA4mBkJ0IhDk8xIIaKETGWgxjbYW
         dpUWimg3mJoeqB/MaMIuk9RK/GiEtnvNGfQhuFpguqDQDr1VvNqCk7PcFMDxmZXP+tTM
         yj4Kzwrjau07ZAQnPp2k4CpNhuwQItUEsCq5EfucY8pFLMzRJgk44W0B1W6Iu5x8ksq7
         q1bPUfhPcrk17nlMQysUxcUCmHtWmDdeXYPWm777TTMDFqLqxofQb6IvgZuRAnujAJSR
         j/2CUBkG2zwyDIWhMADs/a608RO97cCXVnd0iy7ynCudPxZ8lk1smLN3GAcGi6R+0NFw
         HBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AJ8vN7NgW8GOge2fXRfaMsuXVib9gxqFttdl/8POdE=;
        b=siS7s5F9+Yl9tAQJcF3jkVvlWtHGVEyeSMtCbfE/9iGx577ReeIzZtJ5hYmUuzpKIT
         0LJ0CFMC8buPKAk5A+0RnPsZ4OIwYSIlyQFoPNdptGW5Ky3O57wDtykuc+w812c/l5bK
         lN3YKS41AZCNxfLHyGxviPur5QwvFHFvMMt0SLoUZNBt5gYUWlyb3RPcTAI/QA3K2Z1l
         Ra2ETNJ+tl2wjWx8102ZWE0NtJlKF2DVFfPj14BYp53TZaQUnEPZKPLnimToXLIPFWzh
         faQEBaum1qyFzgHlH1n9OYKSYRdpIgYqpjABrOzr1e7ekxA4fFDFAWg9WyUCfkVUk9qX
         nqBA==
X-Gm-Message-State: APjAAAUR7ehkVKupElT5YrTgOK0ndl4fY4lWSde56rQMOwgcFCHgcqMU
        RmvsOxC7BddPkMtgZ/UQ16uGqIZ9CmPXlgXj740eaw==
X-Google-Smtp-Source: APXvYqxg3feQqdK7RdWMCji44Xw2f6fQMU8nvIR88nM9T9K8OUzdjUYleutC6vRfGbphJhTzpDQmuOtyCwyYf3e15l4=
X-Received: by 2002:a37:d84:: with SMTP id 126mr17174005qkn.407.1570356043831;
 Sun, 06 Oct 2019 03:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009b403005942237bf@google.com> <20191005112806.13960-1-christian.brauner@ubuntu.com>
In-Reply-To: <20191005112806.13960-1-christian.brauner@ubuntu.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 6 Oct 2019 12:00:32 +0200
Message-ID: <CACT4Y+YiVE52xkADKgpfzRgofHbVxtRpcbKo_RU81jjOV_0TvA@mail.gmail.com>
Subject: Re: [PATCH] taskstats: fix data-race
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        bsingharora@gmail.com, Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 1:28 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> When assiging and testing taskstats in taskstats
> taskstats_exit() there's a race around writing and reading sig->stats.
>
> cpu0:
> task calls exit()
> do_exit()
>         -> taskstats_exit()
>                 -> taskstats_tgid_alloc()
> The task takes sighand lock and assigns new stats to sig->stats.
>
> cpu1:
> task catches signal
> do_exit()
>         -> taskstats_tgid_alloc()
>                 -> taskstats_exit()
> The tasks reads sig->stats __without__ holding sighand lock seeing
> garbage.
>
> Fix this by taking sighand lock when reading sig->stats.
>
> Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  kernel/taskstats.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index 13a0f2e6ebc2..58b145234c4a 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -553,26 +553,32 @@ static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>
>  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
>  {
> +       int empty;
> +       struct taskstats *stats_new, *stats = NULL;
>         struct signal_struct *sig = tsk->signal;
> -       struct taskstats *stats;
> -
> -       if (sig->stats || thread_group_empty(tsk))
> -               goto ret;
>
>         /* No problem if kmem_cache_zalloc() fails */
> -       stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> +       stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);

This seems to be over-pessimistic wrt performance b/c:
1. We always allocate the object and free it on every call, even if
the stats are already allocated, whereas currently we don't.
2. We always allocate the object and free it if thread_group_empty,
whereas currently we don't.
3. We do lock/unlock on every call.

I would suggest to fix the double-checked locking properly.
Locking is not the only correct way to synchronize things. Lock-free
synchronization is also possible. It's more tricky, but it can be
correct and it's supported by KCSAN/KTSAN. It just needs to be
properly implemented and expressed. For some cases we may decide to
switch to locking instead, but it needs to be an explicit decision.

We can fix the current code by doing READ_ONCE on sig->stats (which
implies smp_read_barrier_depends since 4.15), and storing to it with
smp_store_release.

> +       empty = thread_group_empty(tsk);
>
>         spin_lock_irq(&tsk->sighand->siglock);
> +       if (sig->stats || empty) {
> +               stats = sig->stats;
> +               spin_unlock_irq(&tsk->sighand->siglock);
> +               goto free_cache;
> +       }
> +
>         if (!sig->stats) {
> -               sig->stats = stats;
> -               stats = NULL;
> +               sig->stats = stats_new;
> +               spin_unlock_irq(&tsk->sighand->siglock);
> +               return stats_new;
>         }
>         spin_unlock_irq(&tsk->sighand->siglock);
>
> -       if (stats)
> -               kmem_cache_free(taskstats_cache, stats);
> -ret:
> -       return sig->stats;
> +free_cache:
> +       kmem_cache_free(taskstats_cache, stats_new);
> +       return stats;
>  }
>
>  /* Send pid data out on exit */
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20191005112806.13960-1-christian.brauner%40ubuntu.com.
