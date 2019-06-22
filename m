Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA8C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7980720665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561226590;
	bh=rS+QDUEv9Kv011x6Xcxx8PCZ+1Rhhfc8kGOfdal28LI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CuFpl0pNQj8YO4oFEtYdP9jrlQgz4hsVrOIXvvF9rE31VgVYrKwWwEwZpClqUkeIT
	 1JXVOETTMGiKMmMyfQqav0ShV0212+biWG5E8JZxOvDADsClI/64SOjVfISb+dNZKr
	 HmgTY4np5sAlwO4A69dHqmpLj9kRy6K8TIZredus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFVSDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 14:03:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32982 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVSDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 14:03:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so7228417lfe.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTVQwNdpEANBFFxnKdTYMSvJa37ECLsEqk9sL0w2aCY=;
        b=NHX+A4Hn+9k1GJ8KSdLWDJGit6XGMQmGE4DEU3fZsyRFWfBpw3wMmna3jspZ8npHAG
         uKBQSW6kfbmK1saH4HAnCB+CK4PhAc0azGjSfqk5NUcxI70V/w92Nb9Dpol9ZFldVFig
         uzoE3MUGDKRzt4OKUC0byx12pDyJL1JGvGwcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTVQwNdpEANBFFxnKdTYMSvJa37ECLsEqk9sL0w2aCY=;
        b=LI1g+YoWyb//1IpmmT6GQpydyFNKnNvwelUHZUYUAWKt5p1aLzLE5flErxEgwcKdWZ
         d56aHgSQ4NUcxAu3WjTyig7Unu5YKaiD+VojCoeMckBKQnSxPsgeu7oOeltXawdwTdfp
         pmIkjlBZ35wd51kV9fWIDGPs3RxgjYx/IesmOIzLpi5YC7JkVRcBFOmvAJ1xUOnzLcUp
         Xn1ac8SxiRg4bf7bR7GyQEuayaGHqjutlEKDne9hRWGBTn6egVFcfGOQxWLlKnBWcJeO
         inWQ6a1PH1lJOkexD73p1t5iWbYsj2aI41wHclXSxrYZx7DqE1KgKlvfAz/suJ8N6A3K
         CWDg==
X-Gm-Message-State: APjAAAVOq/X2swiLAEu2SQKIshRbtJGqHcKiuFPRDqajo1jMGuW+NjmV
        36HcbvNzcPKoHw7/pk/5zm1yZ3/+T3U=
X-Google-Smtp-Source: APXvYqw81qrlJ7pnlTs7j/TWLu1+me7ekxUkOqXByVQm7DUfDAeFFgp5bIDW5rLN2v1SXEGd5yDuYg==
X-Received: by 2002:a19:7607:: with SMTP id c7mr23415847lff.28.1561226585587;
        Sat, 22 Jun 2019 11:03:05 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id p5sm935792ljb.91.2019.06.22.11.03.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 11:03:04 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i21so8820765ljj.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 11:03:04 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr30871577ljj.165.1561226584112;
 Sat, 22 Jun 2019 11:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190620022008.19172-1-peterx@redhat.com> <20190620022008.19172-3-peterx@redhat.com>
In-Reply-To: <20190620022008.19172-3-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Jun 2019 11:02:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGphH2UL+To5rASyFoCk6=9bROUkGDWSa_rMu9Kgb0yw@mail.gmail.com>
Message-ID: <CAHk-=wiGphH2UL+To5rASyFoCk6=9bROUkGDWSa_rMu9Kgb0yw@mail.gmail.com>
Subject: Re: [PATCH v5 02/25] mm: userfault: return VM_FAULT_RETRY on signals
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I still think this all *may* ok, but at a minimum some of the
comments are misleading, and we need more docs on what happens with
normal signals.

I'm picking on just the first one I noticed, but I think there were
other architectures with this too:

On Wed, Jun 19, 2019 at 7:20 PM Peter Xu <peterx@redhat.com> wrote:
>
> diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
> index 6836095251ed..3517820aea07 100644
> --- a/arch/arc/mm/fault.c
> +++ b/arch/arc/mm/fault.c
> @@ -139,17 +139,14 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>          */
>         fault = handle_mm_fault(vma, address, flags);
>
> -       if (fatal_signal_pending(current)) {
> -
> +       if (unlikely((fault & VM_FAULT_RETRY) && signal_pending(current))) {
> +               if (fatal_signal_pending(current) && !user_mode(regs))
> +                       goto no_context;
>                 /*
>                  * if fault retry, mmap_sem already relinquished by core mm
>                  * so OK to return to user mode (with signal handled first)
>                  */
> -               if (fault & VM_FAULT_RETRY) {
> -                       if (!user_mode(regs))
> -                               goto no_context;
> -                       return;
> -               }
> +               return;
>         }

So note how the end result of this is:

 (a) if a fatal signal is pending, and we're returning to kernel mode,
we do the exception handling

 (b) otherwise, if *any* signal is pending, we'll just return and
retry the page fault

I have nothing against (a), and (b) is likely also ok, but it's worth
noting that (b) happens for kernel returns too. But the comment talks
about returning to user mode.

Is it ok to return to kernel mode when signals are pending? The signal
won't be handled, and we'll just retry the access.

Will we possibly keep retrying forever? When we take the fault again,
we'll set the FAULT_FLAG_ALLOW_RETRY again, so any fault handler that
says "if it allows retry, and signals are pending, just return" would
keep never making any progress, and we'd be stuck taking page faults
in kernel mode forever.

So I think the x86 code sequence is the much safer and more correct
one, because it will actually retry once, and set FAULT_FLAG_TRIED
(and it will clear the "FAULT_FLAG_ALLOW_RETRY" flag - but you'll
remove that clearing later in the series).

> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 46df4c6aae46..dcd7c1393be3 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1463,16 +1463,20 @@ void do_user_addr_fault(struct pt_regs *regs,
>          * that we made any progress. Handle this case first.
>          */
>         if (unlikely(fault & VM_FAULT_RETRY)) {
> +               bool is_user = flags & FAULT_FLAG_USER;
> +
>                 /* Retry at most once */
>                 if (flags & FAULT_FLAG_ALLOW_RETRY) {
>                         flags &= ~FAULT_FLAG_ALLOW_RETRY;
>                         flags |= FAULT_FLAG_TRIED;
> +                       if (is_user && signal_pending(tsk))
> +                               return;
>                         if (!fatal_signal_pending(tsk))
>                                 goto retry;
>                 }
>
>                 /* User mode? Just return to handle the fatal exception */
> -               if (flags & FAULT_FLAG_USER)
> +               if (is_user)
>                         return;
>
>                 /* Not returning to user mode? Handle exceptions or die: */

However, I think the real issue is that it just needs documentation
that a fault handler must not react to signal_pending() as part of the
fault handling itself (ie the VM_FAULT_RETRY can not be *because* of a
non-fatal signal), and there needs to be some guarantee of forward
progress.

At that point the "infinite page faults in kernel mode due to pending
signals" issue goes away. But it's not obvious in this patch, at
least.

               Linus
