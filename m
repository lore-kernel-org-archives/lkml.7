Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A8EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7352075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVqHteOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfECXQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:16:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37537 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfECXQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:16:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id 143so5691179oii.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD9g6xa183TbZYK1E/4xXKXs/8wgAjfsXWJnecCynzU=;
        b=NVqHteOYCFtgeDOD5N4eWEnJlIc/XHTqfuOCqOXYgbDTo/r8RjZMol/FGqptscAoQ7
         4UGDi158ypVfQgCDU+QHVPfXt/RYe4QXLLMRcgRkm1mMM/VEc4bGilI43ZBXc4ulGViL
         MB1gdSQvRwTubfHr+TiAphsE7BOHesuiNqjOc2BE0sL5yBeTavWgmTkfErWB1DhWV/S+
         G3kBairuev/7VFZ7muSit9fjAHzb0/aYQXSBxhSefvIi4ZEd3OXZxklR4NPZDVpOA1Fb
         GemnlNusa0dUnnNaCnXRgrhBCz8bVVQ/WU5fEUY+UCPFB3WgaymEH/qhgjlHcLorpsbK
         JqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD9g6xa183TbZYK1E/4xXKXs/8wgAjfsXWJnecCynzU=;
        b=NqR7dxkLfAmU2hAANdNcjmIn2MHxnc2cEE01FgJcvbI9RLkSD5OrpwbhmmGjA418fM
         NxWs3kiZExIDL2iaQP6BGz3w4ck2PSynLzNNyzITIVpVxM3KVxoBw7LGrbyvQLMpkuei
         2eiz5qK8D+1DMIs0BfTS0PKzBO/3hQP8gp1lXUSCxLeJDYiG4XqpU1tPlWAp3w3O7fTo
         XId6i7qsomInn/R7bLIqjr071P/HvVvIA9jqavxtIQW6vAEKaXqFUX1kJyK4uOgfz3wh
         h7TzBldsHmhRr2oMmevDwnLSPjf4mkBk8lLfh3rhtyifPPYNePuzCMZ4phzdoPBjzYaf
         TWGw==
X-Gm-Message-State: APjAAAVJVGqkG43P1O63U9+hlCDJBXxpoA0tOS5d4u86JOmw+yBQDPip
        uhS2KGVMBNYRZzfWxi1U4EpEGWnbiGQrWFN7DhnLFg==
X-Google-Smtp-Source: APXvYqwpWBIsVexMTCATxRPaUYCnp/FPkT3o0dnVawXtZefaMTKLjPRVBvUCZPfdQa/kA7EgJDjoRrC7xdyyz3GeTTs=
X-Received: by 2002:aca:b8d5:: with SMTP id i204mr806671oif.175.1556925384298;
 Fri, 03 May 2019 16:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <1556907021-29730-1-git-send-email-jsavitz@redhat.com> <1556907021-29730-2-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1556907021-29730-2-git-send-email-jsavitz@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 3 May 2019 19:15:58 -0400
Message-ID: <CAG48ez2CCQ02KYcjZVZYtcVjKN4WH111rdKHPEcYziM9tzmyiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kernel/sys: add PR_GET_TASK_SIZE option to prctl(2)
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 2:12 PM Joel Savitz <jsavitz@redhat.com> wrote:
> When PR_GET_TASK_SIZE is passed to prctl, the kernel will attempt to
> copy the value of TASK_SIZE to the userspace address in arg2.

A commit message shouldn't just describe what you're doing, but also
why you're doing it. Is this intended for processes that are running
on X86-64 and want to determine whether the system supports 5-level
paging, or something like that?

> +static int prctl_get_tasksize(void __user *uaddr)
> +{
> +       unsigned long current_task_size, current_word_size;
> +
> +       current_task_size = TASK_SIZE;
> +       current_word_size = sizeof(unsigned long);
> +
> +#ifdef CONFIG_64BIT
> +       /* On 64-bit architecture, we must check whether the current thread
> +        * is running in 32-bit compat mode. If it is, we can simply cut
> +        * the size in half. This avoids corruption of the userspace stack.
> +        */
> +       if (test_thread_flag(TIF_ADDR32))
> +               current_word_size >>= 1;
> +#endif
> +
> +       return copy_to_user(uaddr, &current_task_size, current_word_size) ? -EFAULT : 0;
> +}

This function looks completely wrong; in particular, you're assuming
that the architecture is little-endian.
Make the value a u64, and you won't have these problems:

static int prctl_get_tasksize(u64 __user *uaddr)
{
        return put_user(TASK_SIZE, uaddr) ? -EFAULT : 0;
}

A bunch of other new pieces of userspace API already use "u64" to
store userspace pointers and lengths to avoid compat issues.

> @@ -2486,6 +2506,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>                         return -EINVAL;
>                 error = PAC_RESET_KEYS(me, arg2);
>                 break;
> +       case PR_GET_TASK_SIZE:
> +               error = prctl_get_tasksize((void *)arg2);

s/void */void __user */
