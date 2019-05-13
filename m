Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5117CC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198B521019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUVTwg1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfEMLMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:12:07 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40218 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfEMLMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:12:07 -0400
Received: by mail-it1-f194.google.com with SMTP id g71so19575440ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysekORYhrqLrwz9iPHGQ0pQD77xRPHwED9M7O4Ddc2Q=;
        b=MUVTwg1AGpr0O/lydDpzMQ5NtkwHdoxyCLztovbsQS7Fn2MR3UnpVUtDfQMyJwW3cq
         +B0pJ9ECJT/seItP860ftaItKPBVtST2eT1cL3YWJzjBiYp3DidD2FocV1N5LhLbgDU1
         oib2M5FLR86W4xRfs/bZttmCeiES2nG7hY2qm/NnFqLfnA/90Q3kq0Z9etdwS7GGDPoN
         Mnnz8vNf9mH/vsFJxmNPu6iDsCPilUuL9P3mbShop+vpIv1hXzOs+mHXTbxP12YinmfZ
         n+8Nh0EcyTT27ADoPEevqAmIs6E90NgM0akYDWDyXDSxGWhzJMv2ced3KWq3ywbSfVcy
         kbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysekORYhrqLrwz9iPHGQ0pQD77xRPHwED9M7O4Ddc2Q=;
        b=oQDRGfPgqoNEEGsmZGz45z666+uWaLaFNEbHwjS6i7ftB1CaKt82thMAToY2UZLfJL
         HhVLetq1XMgiIs9K7LJYukjRSIE9Ltd/bVbKph1EONmpR6FT/ytsKs8lD/qfnK+G0rKM
         6+vFKVORhgD25ZwiN97kXffcCTcpjij2UplXIj2KEfR16+QIW8nR8LwDJLTJnUxav5/b
         i8EPAlcICWD8ithTVzbxqJ4jXUCkhbrlOW7nvuKStimfgexjHU/eQCM59L8cWboXQ3Rw
         4Z71LU685i5ViAUjF4U/gZDHgPYJZCdOyml62lfL06PfIzLuESQ1AKtse3itPVNUHXqt
         6OFQ==
X-Gm-Message-State: APjAAAXUv5Rhb7Q9mWjyWi0z9G6XO/cKRP95b4x+jk8sz4tMxdq4Wadx
        QtGCG2YuN1vVHiykPXyCWyeGUH4yXQRxMoBJN5zVrw==
X-Google-Smtp-Source: APXvYqzH+6ejBfcmpoK4OMOr+TvrPlPkmpgYjBF8RgHdJXKkuQZgi5M5Pgh98J56vSGJEYP2q4RDXSWudNkNRb/H+Iw=
X-Received: by 2002:a24:6cd5:: with SMTP id w204mr6918150itb.12.1557745925683;
 Mon, 13 May 2019 04:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 13 May 2019 13:11:53 +0200
Message-ID: <CACT4Y+ZADnPQm700PDxYiBKmWAAROyUCNKnPmG+tywZsLS-T4A@mail.gmail.com>
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Mon, May 13, 2019 at 1:04 PM
To: Andrew Morton
Cc: Ingo Molnar, Peter Zijlstra, Paul E. McKenney, Petr Mladek, Vitaly
Kuznetsov, Liu Chuansheng, Valdis Kletnieks,
<linux-kernel@vger.kernel.org>, Tetsuo Handa, Dmitry Vyukov

> syzbot's second top report is "no output from test machine" where the
> userspace process failed to spawn a new test process for 300 seconds
> for some reason. One of reasons which can result in this report is that
> an already spawned test process was unable to terminate (e.g. trapped at
> an unkillable retry loop due to some bug) after SIGKILL was sent to that
> process. Therefore, reporting when a thread is failing to terminate
> despite a fatal signal is pending would give us more useful information.
>
> This version shares existing sysctl settings (e.g. check interval,
> timeout, whether to panic) used for detecting TASK_UNINTERRUPTIBLE
> threads, for I don't know whether people want to use a new kernel
> config option and different sysctl settings for monitoring killed
> threads.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  include/linux/sched.h |  1 +
>  kernel/hung_task.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a2cd1585..d42bdd7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -850,6 +850,7 @@ struct task_struct {
>  #ifdef CONFIG_DETECT_HUNG_TASK
>         unsigned long                   last_switch_count;
>         unsigned long                   last_switch_time;
> +       unsigned long                   killed_time;
>  #endif
>         /* Filesystem information: */
>         struct fs_struct                *fs;
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index f108a95..34e7b84 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -141,6 +141,47 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>         touch_nmi_watchdog();
>  }
>
> +static void check_killed_task(struct task_struct *t, unsigned long timeout)
> +{
> +       unsigned long stamp = t->killed_time;
> +
> +       /*
> +        * Ensure the task is not frozen.
> +        * Also, skip vfork and any other user process that freezer should skip.
> +        */
> +       if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
> +               return;
> +       /*
> +        * Skip threads which are already inside do_exit(), for exit_mm() etc.
> +        * might take many seconds.
> +        */
> +       if (t->flags & PF_EXITING)
> +               return;
> +       if (!stamp) {
> +               stamp = jiffies;
> +               if (!stamp)
> +                       stamp++;
> +               t->killed_time = stamp;
> +               return;
> +       }
> +       if (time_is_after_jiffies(stamp + timeout * HZ))
> +               return;
> +       trace_sched_process_hang(t);
> +       if (sysctl_hung_task_panic) {
> +               console_verbose();
> +               hung_task_call_panic = true;
> +       }
> +       /*
> +        * This thread failed to terminate for more than
> +        * sysctl_hung_task_timeout_secs seconds, complain:
> +        */
> +       pr_err("INFO: task %s:%d can't die for more than %ld seconds.\n",
> +              t->comm, t->pid, (jiffies - stamp) / HZ);
> +       sched_show_task(t);
> +       hung_task_show_lock = true;
> +       touch_nmi_watchdog();
> +}
> +
>  /*
>   * To avoid extending the RCU grace period for an unbounded amount of time,
>   * periodically exit the critical section and enter a new one.
> @@ -192,6 +233,9 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>                                 goto unlock;
>                         last_break = jiffies;
>                 }
> +               /* Check threads which are about to terminate. */
> +               if (unlikely(fatal_signal_pending(t)))
> +                       check_killed_task(t, timeout);
>                 /* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
>                 if (t->state == TASK_UNINTERRUPTIBLE)
>                         check_hung_task(t, timeout);
> --
> 1.8.3.1


For background context:
syzkaller has found a number of cases with unkillable tasks ([1]),
but they were always poorly diagnosed by the kernel. In all cases
everything just hangs with no additional diagnosis and in all cases
it required manual work just to identify that there is an instance
of an unkillable task in the pile.
With syzbot all such bugs end up in the "no output from test machine" pile ([2])
with hundreds of thousands of crashes, which nobody usually looks at
(except for Tetsuo). Most likely we now have many more of these in the pile
so it would be very useful to make it possible to auto-diagnose and auto-bucket
these bugs.


[1] search for "unkillable" at
https://github.com/google/syzkaller/blob/master/docs/linux/found_bugs.md
[2] https://syzkaller.appspot.com/bug?id=0b210638616bb68109e9642158d4c0072770ae1c
