Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794C9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A752067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOQmukPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfDYScp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:32:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42209 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfDYSco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:32:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id f23so391089otl.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvJO/2BdHJCODfQ2LeKMfPJDO1dVr2ZG8IxfZycQGxI=;
        b=HOQmukPkE5rZ4+NkJz2zMeX6v/up5c1bE88TwS+7QcKcAh5xZEo2b/504uFKAoBpT4
         wmro4N/hQCdu2TU0tiKbh83kmwLqn7Nq1b5jTPlAjAOUZneri0PP0ZrYMoYKS+KNC7y9
         Br1+n2bpPZYelX3FOWCLX/FSOsKCBR8JflOnS8LL+HwLV2WFaHD9i0rvMF+kkal2N9BD
         3RFiN5yQnxK+pFBKeiyfvhAZnW8NJqDvvW7e0DgC1KBxgF1HZT1TGXOx5Pl0MZWQ5yne
         YmWkw21nM56n2sb2KSwU0pIjfd/o7926Fg6Hpj8h4dFEd+8tSa9N9gJ7775oxA0IRdSh
         1rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvJO/2BdHJCODfQ2LeKMfPJDO1dVr2ZG8IxfZycQGxI=;
        b=Uw6g57IwTz9W6ViBFeQYEWzwE2b+vHLF3WFy3OsiXZjU2XdgQhEwTtwtU2SkZT8VMO
         Bl7ZhPZPkdhvc6LnDolA3eIuc2xSk1n7gDxxt4CZBQr5aQwZ8AlrHHqKB4lre2X+o0Mh
         fAgYh4tP0sEjXPq8HynRwmViZMECoOCTCVQr/7/V8u7GBz3OM/FzNtxZVQs8kJDKsy8M
         a1ngHTbBQ188q2mXjx851KyQ787Px+q05sVtN+PJNcv7dBB4yT6Y19DvKC3nbVHQ9eD6
         L0gdPRlMdTiU8edtcNBzrQQbKxnj9YrCUzAEqNriRbDPQ6QkC4Bs81e25mDTZJb3DAtd
         E/Yw==
X-Gm-Message-State: APjAAAUsmWp6DTVxPOSwTjdLs5h5HKsOjEQyiYxXl/iq8UxbqUcrHgWR
        hpeMHXtLO+I+4HyVKZJ+ee9oKniXAa1oHwyMyQE7ue0mUPzknw==
X-Google-Smtp-Source: APXvYqx4PgGe2U1MhC7pPBRWgQiJibrYu1+J0E9C1Kz8Xj5sTf7PaqKrcE6RXPXAki90WNbcfORk+TJ/tzBvoht62Uo=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr3779867oth.242.1556217163925;
 Thu, 25 Apr 2019 11:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190425161416.26600-1-dima@arista.com> <20190425161416.26600-16-dima@arista.com>
In-Reply-To: <20190425161416.26600-16-dima@arista.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 25 Apr 2019 20:32:17 +0200
Message-ID: <CAG48ez3nT_RtaHrjpKPRZDYTyzxX49QBZXJ+u2AZmFy5Wao4wQ@mail.gmail.com>
Subject: Re: [PATCHv3 15/27] x86/vdso: Allocate timens vdso
To:     Dmitry Safonov <dima@arista.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 6:14 PM Dmitry Safonov <dima@arista.com> wrote:
>
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
> It will add a penalty for everybody as branch predictor may mispredict
> the jump. Also there are instruction cache lines wasted on cmp/jmp.
>
> Those effects of introducing time namespace are very much unwanted
> having in mind how much work have been spent on micro-optimisation
> vdso code.
>
> The propose is to allocate a second vdso code with dynamically
> patched out (disabled by static_branch) timens code on boot time.
>
> Allocate another vdso and copy original code.
[...]
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 80cbb2167eba..6aae9c0d400d 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
[...]
>  static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
>                       struct vm_area_struct *vma, struct vm_fault *vmf)
>  {
>         const struct vdso_image *image = vma->vm_mm->context.vdso_image;
> +       unsigned long offset = vmf->pgoff << PAGE_SHIFT;
>
>         if (!image || (vmf->pgoff << PAGE_SHIFT) >= image->size)
>                 return VM_FAULT_SIGBUS;
>
> -       vmf->page = virt_to_page(image->text + (vmf->pgoff << PAGE_SHIFT));
> +       if (current_timens_offsets() && image->text_timens)

I'm pretty sure that accessing `current` in here is wrong. AFAIK this
fault handler can be invoked on remote processes, through interfaces
like /proc/$pid/mem and process_vm_readv(); in that case, the kernel
should install a page based on the time namespace of the target
process, not based on the time namespace of the caller.

> +               vmf->page = vmalloc_to_page(image->text_timens + offset);
> +       else
> +               vmf->page = virt_to_page(image->text + offset);
> +
>         get_page(vmf->page);
>         return 0;
>  }
[...]
