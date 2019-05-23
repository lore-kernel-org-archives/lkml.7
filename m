Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C040C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0891621019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfEWGG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:06:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40662 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfEWGG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:06:56 -0400
Received: by mail-io1-f68.google.com with SMTP id s20so3895204ioj.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 23:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNUktpedBrxulRohJ67/ZQIyhajUGPsEgfYnIkyhhQ8=;
        b=jBIXPnNOLN6ICqPLo//7D+bnnf0d6ctnvI3cVOKSHzxyDFEmkdKfuiVkL5GcuMP136
         svfCg3PPy2ASVMHpuHFVCPr3ScGM5t9MfA65Ey//hT3SpQ9wBY0GJ/ilMZJ8ybpS7axJ
         X1BXaQtxp30c8XvGknkh6FePLYKhui3611+HHVJzg87O3aH2EKjU0woohGKjDCYuBI88
         wPcKI/F5/aoRfM9JHO0Q3Mf5/9BYCfZ194z3i0WAGSlPcDWcymhndQAA7KkMCh3A06tM
         37G8zCqlW7/Ade3UGNo1ZZ+jbkx9h1uKva7t0RHMas1mHZ1Sj4SmK0CV/SDYL7Pmv2WX
         EYrQ==
X-Gm-Message-State: APjAAAV29tv9c12TC38qu23nTErO+fvbg3PzoTSykT6wdQQNpsPQBoVR
        M1xtCZpgWvc6FzhXez+5o/QYvGjKAqQf6qld4hph5L1voCrOAw==
X-Google-Smtp-Source: APXvYqwL+rTJ8coX0NZseJHhduGDusNE2IYZsftgMszlpkAqf1otdDBkRNtA+47vpccRttGr3CjHVW1lepULvMCFt/g=
X-Received: by 2002:a6b:7d0d:: with SMTP id c13mr10557094ioq.249.1558591616008;
 Wed, 22 May 2019 23:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190523053429.3567376-1-songliubraving@fb.com>
In-Reply-To: <20190523053429.3567376-1-songliubraving@fb.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 23 May 2019 14:06:44 +0800
Message-ID: <CACPcB9cXUEhn1a14mq_axJfkR13dna4OfgDZ=YEr=LVKn8K5tg@mail.gmail.com>
Subject: Re: [PATCH v2] perf/x86: always include regs->ip in callchain
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 1:34 PM Song Liu <songliubraving@fb.com> wrote:
>
> Commit d15d356887e7 removes regs->ip for !perf_hw_regs(regs) case. This
> patch adds regs->ip back.
>
> Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> Cc: Kairui Song <kasong@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  arch/x86/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index f315425d8468..7b8a9eb4d5fd 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2402,9 +2402,9 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>                 return;
>         }
>
> +       if (perf_callchain_store(entry, regs->ip))
> +               return;
>         if (perf_hw_regs(regs)) {
> -               if (perf_callchain_store(entry, regs->ip))
> -                       return;
>                 unwind_start(&state, current, regs, NULL);
>         } else {
>                 unwind_start(&state, current, NULL, (void *)regs->sp);
> --
> 2.17.1
>

Hi, this will make !perf_hw_regs(regs) case print a double first level
stack trace, which is wrong. And the actual problem that unwinder give
empty calltrace in bpf is still not fixed.

-- 
Best Regards,
Kairui Song
