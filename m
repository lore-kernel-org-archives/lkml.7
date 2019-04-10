Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D4C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAF22083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvqm/Ik4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfDJLdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:33:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55525 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfDJLdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:33:41 -0400
Received: by mail-it1-f195.google.com with SMTP id y134so2775943itc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjsaQPbNShbvkpeAw80k99dKqAmZ5aA0r05zKVOr+cY=;
        b=hvqm/Ik4KxAHtz43m6VcZ5ZJb2oTQcRYl5Wa6EFlDWWtQIi0309hOCfGWPlvYW5CVu
         GZHhxum7cn1LWR0Gn5hQAkUnGo2RnPYUnA+BEEdXJzWjNEILyLzzmsNitTrupttoKTLu
         Su3SEScp55+gHgArWw1x0UIoInY4PebKVgMZmKE3KkUWVMXpHYWWbPioc6d2Yd309vPj
         3qgKEWXpxQRMisGZUqn86Cy97q2MH6J9E9cF4I+qLRPFRyT6sIfIrdr1cvB+yu1RxVNE
         fkcGJVfCp3wZrD5fqsP5thPPZQFAHbawJwusIqzSk5/QKRHof2aMYBr+BjAqbIrPIHvc
         xOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjsaQPbNShbvkpeAw80k99dKqAmZ5aA0r05zKVOr+cY=;
        b=JaKXCLIdCseD9Vbc19X+eQNAVtk1z0lP4d62c6EXb3ITbm20SmRpCw4s5ZOMnR2n06
         Umpk81ymMYuv4h2DjmFMzsK52jv59MByBOjOz6TaSNPF8FR7tF9vT1RUsiUFAqRSl+Yd
         JNxaG1MrZjdtlmfCMXutMhl2g4PgaLEH6qRWGF02uLJZ5CqoWO7/BVVqJXpkmhsbcmjS
         Nqb+WSLRew9u0Y8m8Mvb8a8W6hLLb+leUkM+3Il1i4c7hnyfbCVdIKt2g0sebwytkVEz
         vGGn9D62aLJNn/rhjNQhMjdN3NkPx/FlmteZ9kGJw7WCTcHDj05n/lkamV+mlch0cIRD
         iyEg==
X-Gm-Message-State: APjAAAVd1r2woa09bvgn1MhI4P0zddnKd1iRbkMPDe9ATLE5+VCSmw9g
        rNHBWbMetBXp2/qs9bKhdMvFY9JfrPMSw6kO01k6Cy5qWx5BOQ==
X-Google-Smtp-Source: APXvYqzT8uWFTmOVFg+lawKasWyQAVi5QIe9VZzcU7UqZE3f+PI2gxUaNo6UcjcJ8i56WEL9XlBPLD7tIGbalaBanow=
X-Received: by 2002:a24:2f49:: with SMTP id j70mr2774640itj.122.1554896020630;
 Wed, 10 Apr 2019 04:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190410102754.387743324@linutronix.de> <20190410103645.862294081@linutronix.de>
In-Reply-To: <20190410103645.862294081@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Apr 2019 13:33:29 +0200
Message-ID: <CACT4Y+YBvhbBLfrCvJ0t21ZQ_Pd-ZTR9UnzOYGUyyvdJD+0M2A@mail.gmail.com>
Subject: Re: [RFC patch 25/41] mm/kasan: Simplify stacktrace handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 1:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Replace the indirection through struct stack_trace by using the storage
> array based interfaces.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-mm@kvack.org
> ---
>  mm/kasan/common.c |   30 ++++++++++++------------------
>  mm/kasan/report.c |    7 ++++---
>  2 files changed, 16 insertions(+), 21 deletions(-)
>
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -48,34 +48,28 @@ static inline int in_irqentry_text(unsig
>                  ptr < (unsigned long)&__softirqentry_text_end);
>  }
>
> -static inline void filter_irq_stacks(struct stack_trace *trace)
> +static inline unsigned int filter_irq_stacks(unsigned long *entries,
> +                                            unsigned int nr_entries)
>  {
> -       int i;
> +       unsigned int i;
>
> -       if (!trace->nr_entries)
> -               return;
> -       for (i = 0; i < trace->nr_entries; i++)
> -               if (in_irqentry_text(trace->entries[i])) {
> +       for (i = 0; i < nr_entries; i++) {
> +               if (in_irqentry_text(entries[i])) {
>                         /* Include the irqentry function into the stack. */
> -                       trace->nr_entries = i + 1;
> -                       break;
> +                       return i + 1;
>                 }
> +       }
> +       return nr_entries;
>  }
>
>  static inline depot_stack_handle_t save_stack(gfp_t flags)
>  {
>         unsigned long entries[KASAN_STACK_DEPTH];
> -       struct stack_trace trace = {
> -               .nr_entries = 0,
> -               .entries = entries,
> -               .max_entries = KASAN_STACK_DEPTH,
> -               .skip = 0
> -       };
> +       unsigned int nent;
>
> -       save_stack_trace(&trace);
> -       filter_irq_stacks(&trace);
> -
> -       return depot_save_stack(&trace, flags);
> +       nent = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> +       nent = filter_irq_stacks(entries, nent);
> +       return stack_depot_save(entries, nent, flags);
>  }
>
>  static inline void set_track(struct kasan_track *track, gfp_t flags)
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -100,10 +100,11 @@ static void print_track(struct kasan_tra
>  {
>         pr_err("%s by task %u:\n", prefix, track->pid);
>         if (track->stack) {
> -               struct stack_trace trace;
> +               unsigned long *entries;
> +               unsigned int nent;
>
> -               depot_fetch_stack(track->stack, &trace);
> -               print_stack_trace(&trace, 0);
> +               nent = stack_depot_fetch(track->stack, &entries);
> +               stack_trace_print(entries, nent, 0);
>         } else {
>                 pr_err("(stack is not available)\n");
>         }


Acked-by: Dmitry Vyukov <dvyukov@google.com>
