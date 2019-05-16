Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15554C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457720833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNqI2/n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEPQ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:26:03 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38575 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfEPQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:26:02 -0400
Received: by mail-vs1-f65.google.com with SMTP id x184so1688344vsb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aF7z4HMLUnakhny7k0GasKk7IF4REIlPL6fyWISpTgk=;
        b=tNqI2/n1/KRWaJC+/CpSW6dpIqwdsMYCdLezQXGYWXVbirGLs2g6o5eFI8o7yn3+fy
         zoP1qOF3qa/Ft/+eb6VML5ISPaIJxdHsZahgMeuB3cDrPgk5NlWNVi7VcgXobHzL37vA
         VYT4v1aRcr5tm9LBwLpSLP/+yE6YIGXDhlwaQiUexHLdFnVcVGcGZ6nZTw/5Mo+yHzcc
         HPFl2Juc+RnIB0MPzP0JfxkaEtrwWJK/Bnsv08I8r221StpqU1iDcSBXMUP/xw7YAinb
         T5+IC4xAPzZyHwQmvh11vFQWFg1Tz8fszmCRdto1rJaDjf1gPy1nHNTLHjuSoImf4/si
         jdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aF7z4HMLUnakhny7k0GasKk7IF4REIlPL6fyWISpTgk=;
        b=G4itPURbCFfoZR1SKfivRh3kfpMztw/q6z2GVaSyIhjbQ7AoXgE2fwHCdJOvJYmUdD
         8wKA5UWdbqYpBXCs6vD/OnowBWW/o+LOFmhL0iJfZHMnGUaMBV+UAh1KeN9wq7x2EyAe
         7MC8cyE9NNznJAgyKoSNz/AKM7VjMhXb4UkZsECsIdY4DoBq6i7WloSZFpX0zKclgFGx
         3vRiXIBUn0WPea945gfZlzISLRYCjfFuaKab4ip7WDE/pwMRCCrf2ybuQ/o1XUs4x3J+
         OjgaXgt+3h2cWgBGkRpAAXSYxp0H7RjiX0xF39EMqrkPZFfkLk1z6SrLyNpNedyhi7+5
         HQCA==
X-Gm-Message-State: APjAAAXoFi8qpIWj5+rL/ug4n1RG3h/U5wpv3KbBBzN+JT/sjbq7+513
        +uxS+tPlKTNYqig3/w2fyiFXw0QnY9FkAZiB74o=
X-Google-Smtp-Source: APXvYqx/cc7lJi9PCpEFthV94uIkRRjAs7sIeQj5KsGC3UjX5CEfXwDS+OwvGnUgD0g4EfbKAsvbZknBvShClFQYgak=
X-Received: by 2002:a67:f6c4:: with SMTP id v4mr144463vso.182.1558023960664;
 Thu, 16 May 2019 09:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 16 May 2019 09:25:49 -0700
Message-ID: <CANaxB-zxz5oSeNS2cK-3m6_d9x_kw2pkwWibgOEgr+uOP6YhOA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for pre-faults
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 7:32 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> When get_user_pages*() is called with pages = NULL, the processing of
> VM_FAULT_RETRY terminates early without actually retrying to fault-in all
> the pages.
>
> If the pages in the requested range belong to a VMA that has userfaultfd
> registered, handle_userfault() returns VM_FAULT_RETRY *after* user space
> has populated the page, but for the gup pre-fault case there's no actual
> retry and the caller will get no pages although they are present.
>
> This issue was uncovered when running post-copy memory restore in CRIU
> after commit d9c9ce34ed5c ("x86/fpu: Fault-in user stack if
> copy_fpstate_to_sigframe() fails").
>
> After this change, the copying of FPU state to the sigframe switched from
> copy_to_user() variants which caused a real page fault to get_user_pages()
> with pages parameter set to NULL.
>
> In post-copy mode of CRIU, the destination memory is managed with
> userfaultfd and lack of the retry for pre-fault case in get_user_pages()
> causes a crash of the restored process.
>
> Making the pre-fault behavior of get_user_pages() the same as the "normal"
> one fixes the issue.
>

Tested-by: Andrei Vagin <avagin@gmail.com>

https://travis-ci.org/avagin/linux/builds/533184940

> Fixes: d9c9ce34ed5c ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/gup.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 91819b8..c32ae5a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -936,10 +936,6 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>                         BUG_ON(ret >= nr_pages);
>                 }
>
> -               if (!pages)
> -                       /* If it's a prefault don't insist harder */
> -                       return ret;
> -
>                 if (ret > 0) {
>                         nr_pages -= ret;
>                         pages_done += ret;
> @@ -955,8 +951,12 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>                                 pages_done = ret;
>                         break;
>                 }
> -               /* VM_FAULT_RETRY triggered, so seek to the faulting offset */
> -               pages += ret;
> +               /*
> +                * VM_FAULT_RETRY triggered, so seek to the faulting offset.
> +                * For the prefault case (!pages) we only update counts.
> +                */
> +               if (likely(pages))
> +                       pages += ret;
>                 start += ret << PAGE_SHIFT;
>
>                 /*
> @@ -979,7 +979,8 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>                 pages_done++;
>                 if (!nr_pages)
>                         break;
> -               pages++;
> +               if (likely(pages))
> +                       pages++;
>                 start += PAGE_SIZE;
>         }
>         if (lock_dropped && *locked) {
> --
> 2.7.4
>
