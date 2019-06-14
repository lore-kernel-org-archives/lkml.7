Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6374BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfV3WUfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFNVY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 17:24:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36203 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 17:24:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so2152876pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2A4ly2dcH9ZC/oiZsEF8IXrnQBbAt0kcJ8C4LRUG9V4=;
        b=QfV3WUfs1QILx1Hg76mwH6v9g/+9dA7MqI+okQQpMpHT1jEXRYkvGxgbhK/Cpw4XNv
         HmN2vpYMI8vSc5sx+7b2xh0g3ibrle5JD44P6jStLr1jeru2SdnUC+xfOugB3SNtGJig
         XWPWJrnu9Ot70Y2+6PwFPvSV6h9GVD7iKCv2NMGuT4DkgtPTOOrIktz1DPOuHFCxjWX7
         5HWCX+Pyo1fYOxnsTXulwAFvnFMqvoXaZMkzNlQsKybcZ0ViszEtaK3tAOJSLYPnz4qS
         KCbo5jmoXR8IiJm8EKfUq6ec7lfjubZI/WN0IiGgJOVuYREpRyrxfqf7r1GBoS5BdNfZ
         +jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2A4ly2dcH9ZC/oiZsEF8IXrnQBbAt0kcJ8C4LRUG9V4=;
        b=rNWxcrhEtuT3S3Q3mcbpsRGtwCQcOpBAICpX/qfIWeLxB9x6QaT3Noesa0vtZaNYdO
         dgBTavXnIdoFAygr/ShsDwx8wC8ohn9OBltBZLi4xb+nYnfiQZ84xh8cRNe4bz2cA3Go
         DqxjIYQsVa6hv5+UJPx1NyPUN7B7j1OXVA7BdgdEFWZLHpjyMhetZZHNY6pZmbNc1zkc
         HfdZbwhGU2wtxe83XRbUldRfu0pMg8d9dIy214nmeo/BhOWgQuOnKn2KHzOyj7P3MlLH
         dimTFTwxFfQumm8Naa//4iVBYn3+yUWY6PAbqSjHM/U5vAJ3gDa/EMfkXdhA93OKIHay
         SAzA==
X-Gm-Message-State: APjAAAVK3o0x1ZlR0+JsPX+GyUfP6mqoAg5XQc8PQljcIEjE2BXZSHm9
        vdvoiY2v1yFivk+GE8Ypw2hQS2g9ZmnScBhxPg0GWQ==
X-Google-Smtp-Source: APXvYqx9GnpIDNQiXFYbRfX5Gn53jF/cFV4dnx6gklhkfhcISF3fk+MUizse71nuOBL8pOqrdDfLy4qaly5dqJAWnQs=
X-Received: by 2002:a62:2ec4:: with SMTP id u187mr99487707pfu.84.1560547465571;
 Fri, 14 Jun 2019 14:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190614181604.112297-1-nhuck@google.com>
In-Reply-To: <20190614181604.112297-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Jun 2019 14:24:14 -0700
Message-ID: <CAKwvOd=vZ=McsW5xe2mTPhgOmdkR0Z_LSPLhJtQ3Azv==ykoEA@mail.gmail.com>
Subject: Re: [PATCH] timer_list: Fix Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:16 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Clang produced the following warning when using allnoconfig
>
> kernel/time/timer_list.c:361:36: warning: unused variable
> 'timer_list_sops' [-Wunused-const-variable]
>    static const struct seq_operations timer_list_sops = {
>
> Code reliant on CONFIG_PROC_FS is not in ifdef guard.
> Created ifdef guard around proc_fs specific code.

Specifically, it sounds like proc_create_seq_private expands to an
empty GNU C statement expression (not sure why not a `static inline`
function returning `NULL` but ok), so in that case, this object full
of function pointer, and its pointed to static functions (whose sole
references are this object) all become dead code.

>
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/534
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Thanks for the patch, looks good!  Make sure to include reported by
tags when someone else has reported an issue that you fix, in this
case:

Reported-by: kbuild test robot <lkp@intel.com>
Link: https://groups.google.com/forum/#!topic/clang-built-linux/w27FQOTlb70
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  kernel/time/timer_list.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
> index 98ba50dcb1b2..acb326f5f50a 100644
> --- a/kernel/time/timer_list.c
> +++ b/kernel/time/timer_list.c
> @@ -282,23 +282,6 @@ static inline void timer_list_header(struct seq_file *m, u64 now)
>         SEQ_printf(m, "\n");
>  }
>
> -static int timer_list_show(struct seq_file *m, void *v)
> -{
> -       struct timer_list_iter *iter = v;
> -
> -       if (iter->cpu == -1 && !iter->second_pass)
> -               timer_list_header(m, iter->now);
> -       else if (!iter->second_pass)
> -               print_cpu(m, iter->cpu, iter->now);
> -#ifdef CONFIG_GENERIC_CLOCKEVENTS
> -       else if (iter->cpu == -1 && iter->second_pass)
> -               timer_list_show_tickdevices_header(m);
> -       else
> -               print_tickdevice(m, tick_get_device(iter->cpu), iter->cpu);
> -#endif
> -       return 0;
> -}
> -
>  void sysrq_timer_list_show(void)
>  {
>         u64 now = ktime_to_ns(ktime_get());
> @@ -317,6 +300,24 @@ void sysrq_timer_list_show(void)
>         return;
>  }
>
> +#ifdef CONFIG_PROC_FS
> +static int timer_list_show(struct seq_file *m, void *v)
> +{
> +       struct timer_list_iter *iter = v;
> +
> +       if (iter->cpu == -1 && !iter->second_pass)
> +               timer_list_header(m, iter->now);
> +       else if (!iter->second_pass)
> +               print_cpu(m, iter->cpu, iter->now);
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
> +       else if (iter->cpu == -1 && iter->second_pass)
> +               timer_list_show_tickdevices_header(m);
> +       else
> +               print_tickdevice(m, tick_get_device(iter->cpu), iter->cpu);
> +#endif
> +       return 0;
> +}
> +
>  static void *move_iter(struct timer_list_iter *iter, loff_t offset)
>  {
>         for (; offset; offset--) {
> @@ -376,3 +377,4 @@ static int __init init_timer_list_procfs(void)
>         return 0;
>  }
>  __initcall(init_timer_list_procfs);
> +#endif
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To post to this group, send email to clang-built-linux@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190614181604.112297-1-nhuck%40google.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Thanks,
~Nick Desaulniers
