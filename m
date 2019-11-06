Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF4C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8024820717
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlMbyGMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfKFENf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 23:13:35 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42045 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKFENf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:13:35 -0500
Received: by mail-yb1-f196.google.com with SMTP id 4so10370984ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 20:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwFCUxppEaNk2oIdxdIvyDyCNPn0jEdjjgUSJ84+xNQ=;
        b=AlMbyGMa7MWuq5/EpRqZgfCyPBkPCExaX+zZoQkJdTN/lF7YD73QC5yL1+omzJM7yC
         DMlShiA4F34d2KeYyuK9I1/N/t8UW9qAOLtG0SXMGSk0WKfgH9/P8Z8UMEHBlXvUxK0Y
         gJfa637hIOFw5UR8fDHlcvP+aeIevWaL0R0G0Uo1AGUGKCuIbYgANj+zvZqL1s9ZBHNd
         dYbIWIQ0Rt0Z9+Q43NbJhVAoNa9z8XCXn5ZXr9oQ9SNPUmrnmF8uaRRe0P0dFTqosJrf
         Ha94d5+RSx4UcigOCx9oEe9vxQ5CJ1bSkNoTjFKyf8gGL9yEHz30TWTxPhboKHgoSTSe
         53pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwFCUxppEaNk2oIdxdIvyDyCNPn0jEdjjgUSJ84+xNQ=;
        b=o6hWnJHxCoi8Tf82GNqpQXVMPmj/qUwYb5piXdyOd6wokduKkbR/kQTQLi0pnXB68o
         Ag3sCmWyL84yAPaYbohxSGUKt1XJMvyELcZD0PbCMLX03w9lqiQl2dzO2+ttkQq7F2Ij
         CK/9SHdf3LMjF4vZ3XVGg2HLsqqc6B6uF2km2EHUN6Px6rfPuAm/szaV8cBhgQwQfmuM
         cDUeW0Dyl1TQS3WkreSZbC0sVzgws4TY4/4ym/GmJ478gIoWgC6UgVXMeR8pmlcJpGAN
         JdywKzSvA1SbpemEe7BKEWw3FidHuXsyE9FJySeVmhcQ6CAjZNrqz9aQ5L9E41pZv8RX
         gF1Q==
X-Gm-Message-State: APjAAAXfCm1vjQQulkK5KXnb8x1DzA+W57SmNe4fJJJBrbe3VgEKJusN
        nrQganh8d7/mdFvXcB8qywG884IEpuyNPNNLfr4=
X-Google-Smtp-Source: APXvYqxnWqKBQH/WgOTOh+up/B1GJKC4sYZVvsEXYvu2jZjvE4ZuVW38m1dUhYfYXvngfBFi0KCVCzqC/Tp+cm++nDg=
X-Received: by 2002:a25:df81:: with SMTP id w123mr566146ybg.286.1573013614155;
 Tue, 05 Nov 2019 20:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20191106030542.868541-1-dima@arista.com> <20191106030542.868541-44-dima@arista.com>
In-Reply-To: <20191106030542.868541-44-dima@arista.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 5 Nov 2019 20:13:22 -0800
Message-ID: <CAMo8Bf+q0j81VZeUQdvCkXt131uzSBfJ0N7RTe7+NpjRkVpzdA@mail.gmail.com>
Subject: Re: [PATCH 43/50] xtensa: Add show_stack_loglvl()
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Nov 5, 2019 at 7:08 PM Dmitry Safonov <dima@arista.com> wrote:
>
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
>
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
>
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
>
> Introduce show_stack_loglvl(), that eventually will substitute
> show_stack().
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/xtensa/kernel/traps.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
> index cbc0d673f542..ba6c150095c6 100644
> --- a/arch/xtensa/kernel/traps.c
> +++ b/arch/xtensa/kernel/traps.c
> @@ -502,7 +502,8 @@ static void show_trace(struct task_struct *task, unsigned long *sp,
>
>  static int kstack_depth_to_print = 24;
>
> -void show_stack(struct task_struct *task, unsigned long *sp)
> +void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
> +                      const char *loglvl)
>  {
>         int i = 0;
>         unsigned long *stack;
> @@ -511,16 +512,21 @@ void show_stack(struct task_struct *task, unsigned long *sp)
>                 sp = stack_pointer(task);
>         stack = sp;
>
> -       pr_info("Stack:\n");
> +       printk("%sStack:\n", loglvl);
>
>         for (i = 0; i < kstack_depth_to_print; i++) {
>                 if (kstack_end(sp))
>                         break;
> -               pr_cont(" %08lx", *sp++);
> +               printk("%s %08lx", loglvl, *sp++);
>                 if (i % 8 == 7)
> -                       pr_cont("\n");
> +                       printk("%s\n", loglvl);
>         }
> -       show_trace(task, stack, KERN_INFO);
> +       show_trace(task, stack, loglvl);
> +}
> +
> +void show_stack(struct task_struct *task, unsigned long *sp)
> +{
> +       show_stack_loglvl(task, sp, KERN_INFO);
>  }
>
>  DEFINE_SPINLOCK(die_lock);
> --
> 2.23.0

This change doesn't work well with printk timestamps, it changes
the following output on xtensa architecture

[    3.404675] Stack:
[    3.404861]  a05773e2 00000018 bb03dc34 bb03dc30 a0008640 bb03dc70
ba9ba410 37c3f000
[    3.405414]  37c3f000 d7c3f000 00000800 bb03dc50 a02b97ed bb03dc90
ba9ba400 ba9ba410
[    3.405969]  a05fc1bc bbff28dc 00000000 bb03dc70 a02b7fb9 bb03dce0
ba9ba410 a0579044

into this:
[    3.056825] Stack:
[    3.056963]  a04ebb20
[    3.056995]  bb03dc10
[    3.057138]  00000001
[    3.057277]  bb03dc10
[    3.057815]  a00083ca
[    3.057965]  bb03dc50
[    3.058107]  ba9ba410
[    3.058247]  37c3f000
[    3.058387]
[    3.058584]  a05773e2
[    3.058614]  00000001
[    3.058755]  a05ca0bc
[    3.058896]  bb03dc30
[    3.059035]  a000865c
[    3.059180]  bb03dc70
[    3.059319]  ba9ba410
[    3.059459]  37c3f000
[    3.059598]
[    3.059795]  37c3f000
[    3.059824]  d7c3f000
[    3.059964]  00000800
[    3.060103]  bb03dc50
[    3.060241]  a02b9809
[    3.060379]  bb03dc90
[    3.060519]  ba9ba400
[    3.060658]  ba9ba410
[    3.060796]

-- 
Thanks.
-- Max
