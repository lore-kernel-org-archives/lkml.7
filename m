Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2333DC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FE120715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw9M7Ngx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFUgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:36:02 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36640 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFUgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:36:01 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so6568302iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YOrBa0uMjT0oG8epharAahl9t8RPsj8FUffWAfL2YE=;
        b=Zw9M7NgxBvmnEMIbxvdU7XPJ+ar8q2O4GOjiND3M61UtWfOt5FA13MFkecu5mn6ijf
         6qDPs7fMPpNvMohozxydEI9cFeXhQgXiA7syr2aiSAkdQwTSqgfbMEa4Z1bnanddk9Iv
         KUiy9Lg6e6AcQfmDN5RWjahU6P5MivMJEkP0AqD9sjYEOlB3EGVA2HIziZYDFipM6OFc
         xHbzY2Y2AFGFOezs69Rx4VQ9SaevOjjRXv8dwV3lilB/xzZnlrK3GoKH8Gq8dNvEhQDY
         jv3bEbhYwr/V79ycwbr7GnsEEZlfMjP9kW1Kd48y/jaW/U/OjpkW0Izb1CRU89bm5ElN
         fQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YOrBa0uMjT0oG8epharAahl9t8RPsj8FUffWAfL2YE=;
        b=aeeJtSVXypMFfB0762Y+L9rTQeQgU+hwD25jQ/bGI+BGlhxuKN8k9bRZeDhgBQa0qf
         h3Xp4w2rZIn+GuFEYOSiHcgeMFpQBaBcz4osCWe9SGXzzwJqxLPvVNpegZea85dfWp4d
         5SwL7RCzylZDPr+rwQ/03FF4DnBBbIU/rBLVEtY+ytOIrr4FAFs5mrbelGk9szQ2QZvn
         OnzZ5XQQ9mVuMlBNIWBxHoyE5mFYSWA7sUgdQx1sOYXCtDYKb34+axweeEpBOlHVMwpO
         PIu0zF/d2Xs8cueYZy5tUIbg5lS9/+LGJEc01poChvqA8kDKroU51V9lSe7ny9Ax0TOj
         +8yg==
X-Gm-Message-State: APjAAAUndghDeipEzGkKu28GB/zmHXRz6EhIT+oufZVLejzlSYwexSAq
        hbCnGpX/LbROFJmVEe3qCoqJiSw2anCIVitCgW0=
X-Google-Smtp-Source: APXvYqw2b4JKjh4L9hPuLEG6/Y3soHXuIhEr3b7LFKH/qzdO0ewmtgKQpfQsZkJbi03YVWjTWt6dRU4BNJQ9aNppquU=
X-Received: by 2002:a6b:39d4:: with SMTP id g203mr61074742ioa.100.1578342960887;
 Mon, 06 Jan 2020 12:36:00 -0800 (PST)
MIME-Version: 1.0
References: <157830736034.8148.7070851958306750616.stgit@buzz>
In-Reply-To: <157830736034.8148.7070851958306750616.stgit@buzz>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Mon, 6 Jan 2020 23:35:50 +0300
Message-ID: <CALYGNiMUQ2=OjF4G3jQYZMXja5mGinXB8M1YRCe8kctCzQoWHw@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: fix reusing mergeable anon_vma as parent when fork
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 1:42 PM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> This fixes couple misconceptions in commit 4e4a9eb92133 ("mm/rmap.c: reuse
> mergeable anon_vma as parent when fork").
>
> First problem caused by initialization order in dup_mmap(): vma->vm_prev
> is set after calling anon_vma_fork(). Thus in anon_vma_fork() it points to
> previous VMA in parent mm. This is fixed by rearrangement in dup_mmap().
>
> If in parent VMAs: SRC1 SRC2 .. SRCn share anon-vma ANON0, then after fork
> before all patches in child process related VMAs: DST1 DST2 .. DSTn will
> use different anon-vmas: ANON1 ANON2 .. ANONn. Before this patch only DST1
> will fork new ANON1 and following DST2 .. DSTn will share parent's ANON0.
> With this patch DST1 will create new ANON1 and DST2 .. DSTn will share it.
>
> Also this patch moves sharing logic out of anon_vma_clone() into more
> specific anon_vma_fork() because this supposed to work only at fork().
> Function anon_vma_clone() is more generic is also used at splitting VMAs.
>
> Second problem is hidden behind first one: assumption "Parent has vm_prev,
> which implies we have vm_prev" is wrong if first VMA in parent mm has set
> flag VM_DONTCOPY. Luckily prev->anon_vma doesn't dereference NULL pointer
> because in current code 'prev' actually is same as 'pprev'. To avoid that
> this patch just checks pointer and compares vm_start to verify relation
> between previous VMAs in parent and child.
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 4e4a9eb92133 ("mm/rmap.c: reuse mergeable anon_vma as parent when fork")

Oops, I've forgot to mention that Li Xinhai <lixinhai.lxh@gmail.com>
found and reported this suspicious code. Sorry.

Reported-by: Li Xinhai <lixinhai.lxh@gmail.com>
Link: https://lore.kernel.org/linux-mm/CALYGNiNzz+dxHX0g5-gNypUQc3B=8_Scp53-NTOh=zWsdUuHAw@mail.gmail.com/T/#t

> ---
>  kernel/fork.c |    4 ++--
>  mm/rmap.c     |   25 ++++++++++++-------------
>  2 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2508a4f238a3..04ee5e243f65 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -548,6 +548,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>                 if (retval)
>                         goto fail_nomem_policy;
>                 tmp->vm_mm = mm;
> +               tmp->vm_prev = prev;    /* anon_vma_fork use this */
> +               tmp->vm_next = NULL;
>                 retval = dup_userfaultfd(tmp, &uf);
>                 if (retval)
>                         goto fail_nomem_anon_vma_fork;
> @@ -559,7 +561,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>                 } else if (anon_vma_fork(tmp, mpnt))
>                         goto fail_nomem_anon_vma_fork;
>                 tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
> -               tmp->vm_next = tmp->vm_prev = NULL;
>                 file = tmp->vm_file;
>                 if (file) {
>                         struct inode *inode = file_inode(file);
> @@ -592,7 +593,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>                  */
>                 *pprev = tmp;
>                 pprev = &tmp->vm_next;
> -               tmp->vm_prev = prev;
>                 prev = tmp;
>
>                 __vma_link_rb(mm, tmp, rb_link, rb_parent);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b3e381919835..77b3aa38d5c2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -269,19 +269,6 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>  {
>         struct anon_vma_chain *avc, *pavc;
>         struct anon_vma *root = NULL;
> -       struct vm_area_struct *prev = dst->vm_prev, *pprev = src->vm_prev;
> -
> -       /*
> -        * If parent share anon_vma with its vm_prev, keep this sharing in in
> -        * child.
> -        *
> -        * 1. Parent has vm_prev, which implies we have vm_prev.
> -        * 2. Parent and its vm_prev have the same anon_vma.
> -        */
> -       if (!dst->anon_vma && src->anon_vma &&
> -           pprev && pprev->anon_vma == src->anon_vma)
> -               dst->anon_vma = prev->anon_vma;
> -
>
>         list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
>                 struct anon_vma *anon_vma;
> @@ -334,6 +321,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>   */
>  int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
>  {
> +       struct vm_area_struct *prev = vma->vm_prev, *pprev = pvma->vm_prev;
>         struct anon_vma_chain *avc;
>         struct anon_vma *anon_vma;
>         int error;
> @@ -345,6 +333,17 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
>         /* Drop inherited anon_vma, we'll reuse existing or allocate new. */
>         vma->anon_vma = NULL;
>
> +       /*
> +        * If parent shares anon_vma with its vm_prev, keep this sharing.
> +        *
> +        * Previous VMA could be missing or not match previuos in parent
> +        * if VM_DONTCOPY is set: compare vm_start to avoid this case.
> +        */
> +       if (pvma->anon_vma && pprev && prev &&
> +           pprev->anon_vma == pvma->anon_vma &&
> +           pprev->vm_start == prev->vm_start)
> +               vma->anon_vma = prev->anon_vma;
> +
>         /*
>          * First, attach the new VMA to the parent VMA's anon_vmas,
>          * so rmap can find non-COWed pages in child processes.
>
>
