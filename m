Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FE3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046AC2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWm7+vuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFDSdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:33:19 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42291 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:33:19 -0400
Received: by mail-ua1-f67.google.com with SMTP id e9so8173179uar.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxIk9skfL10h++xFzeC1ExctfO9RGW2vbzK+6HmIbys=;
        b=UWm7+vuqyfxHrQcdqAb2ZCmFmzV5z3xDzutiPJa/oHikBKy4EeGo8QZXgLuXoFCL0E
         jnW/hiLpxr9r7ka7jxc2PnUFhenSel2a0KZhamHNt5zHFMDOnVTMMuIy+dG1VTNWnHlj
         Bz3h9uyTr3HL3YMO5k/Ep7bE2NfcIDQfo8ZsjGu8NC2ssF+laZswqzGTeCXvgA/uUtHM
         nH/R3d8Ba2pcaPk3Sh6fHmefCJtVrOH1HThe6DaXpfaItYOoNx/MndrgrnM+UkEH00a3
         AtewB/+L5MwcVnVF2GljbisSpyUcF64vk7jfNxvxGNRo130gUtxwEd8ewuo2250Mr9Dk
         tezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxIk9skfL10h++xFzeC1ExctfO9RGW2vbzK+6HmIbys=;
        b=UWGAmBROMGWb1widFvTSNnC4kB7xAgIp4yv85TxUh6byPxFNXA4tuMZ3Mj0PxqifIm
         +DIjGPHOtSLd/UOhOYtumVejd890EsHWUNxv6s+G+mVYjPmm3Eqqn/dGUwjE+OJq+3tY
         lKwMzR1FJ6jCAJ+/1LVTbEOSqmfkY5tWNOVpX9WAcbifrNAnrhj7aQSbU/dBIhhLlmi3
         IkYXUKLDftUnzNC4McjMJoin1xYIfxLbT3hTfqiJrVQgjpLc+oP7SUCwg3AVUChyF0IK
         CC3m23ZU/5pWVmZOVkH9BdarlmP6v3PtvzWLbeD9GZG+k++5XlkExEJWTCHDsdF51GpS
         OAbA==
X-Gm-Message-State: APjAAAWrVMLSLaA07Is5pOX9nk3sJM4l0AgzPsjCltk55bSYtW7nYuT1
        VpMoM7RQkfLYC2eQ4C/9moa/L/2m1xabId1M3Ks=
X-Google-Smtp-Source: APXvYqwUdo4RP9hMFVAuO+fECAymIr8XcvJkU/3BOcuLsYNwNGgrozJrugJo7NBDWBLG7Dm34zj9f1SHRNk4288s4w0=
X-Received: by 2002:ab0:5a88:: with SMTP id w8mr4749403uae.50.1559673197560;
 Tue, 04 Jun 2019 11:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000410d500588adf637@google.com> <87woia5vq3.fsf@xmission.com>
 <20190528124746.ac703cd668ca9409bb79100b@linux-foundation.org> <87pno23vim.fsf_-_@xmission.com>
In-Reply-To: <87pno23vim.fsf_-_@xmission.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 4 Jun 2019 11:33:06 -0700
Message-ID: <CANaxB-ztx3-3cfsbK4rTnGAAcODJmgKHyhHF_0oBe+qqyf5Leg@mail.gmail.com>
Subject: Re: [PATCH] signal/ptrace: Don't leak unitialized kernel memory with PTRACE_PEEK_SIGINFO
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        deepa.kernel@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        syzbot <syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 6:22 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> Recently syzbot in conjunction with KMSAN reported that
> ptrace_peek_siginfo can copy an uninitialized siginfo to userspace.
> Inspecting ptrace_peek_siginfo confirms this.
>
> The problem is that off when initialized from args.off can be
> initialized to a negaive value.  At which point the "if (off >= 0)"
> test to see if off became negative fails because off started off
> negative.
>
> Prevent the core problem by adding a variable found that is only true
> if a siginfo is found and copied to a temporary in preparation for
> being copied to userspace.
>
> Prevent args.off from being truncated when being assigned to off by
> testing that off is <= the maximum possible value of off.  Convert off
> to an unsigned long so that we should not have to truncate args.off,
> we have well defined overflow behavior so if we add another check we
> won't risk fighting undefined compiler behavior, and so that we have a
> type whose maximum value is easy to test for.
>

Hello Eric,

Thank you for fixing this issue. Sorry for the late response.
I thought it was fixed a few month ago, I remembered that we discussed it:
https://lkml.org/lkml/2018/10/10/251

Here are two inline comments.


> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com
> Fixes: 84c751bd4aeb ("ptrace: add ability to retrieve signals without removing from a queue (v4)")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>
> Comments?
> Concerns?
>
> Otherwise I will queue this up and send it to Linus.
>
>  kernel/ptrace.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 6f357f4fc859..4c2b24a885d3 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -704,6 +704,10 @@ static int ptrace_peek_siginfo(struct task_struct *child,
>         if (arg.nr < 0)
>                 return -EINVAL;
>
> +       /* Ensure arg.off fits in an unsigned */
> +       if (arg.off > ULONG_MAX)

if (arg.off > ULONG_MAX - arg.nr)

> +               return 0;

maybe we should return EINVAL in this case

> +
>         if (arg.flags & PTRACE_PEEKSIGINFO_SHARED)
>                 pending = &child->signal->shared_pending;
>         else
> @@ -711,18 +715,20 @@ static int ptrace_peek_siginfo(struct task_struct *child,
>
>         for (i = 0; i < arg.nr; ) {
>                 kernel_siginfo_t info;
> -               s32 off = arg.off + i;
> +               unsigned long off = arg.off + i;
> +               bool found = false;
>
>                 spin_lock_irq(&child->sighand->siglock);
>                 list_for_each_entry(q, &pending->list, list) {
>                         if (!off--) {
> +                               found = true;
>                                 copy_siginfo(&info, &q->info);
>                                 break;
>                         }
>                 }
>                 spin_unlock_irq(&child->sighand->siglock);
>
> -               if (off >= 0) /* beyond the end of the list */
> +               if (!found) /* beyond the end of the list */
>                         break;
>
>  #ifdef CONFIG_COMPAT
> --
> 2.21.0.dirty
>
