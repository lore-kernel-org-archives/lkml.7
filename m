Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED1FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB52D20854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEv1382i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfDJNkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:40:07 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41604 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfDJNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:40:05 -0400
Received: by mail-vk1-f195.google.com with SMTP id d15so559992vka.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sn5HKSW/EV0nlOWbnLpY+Fd+1g+qo5O/g3DXMlwf0kM=;
        b=YEv1382inFweWm+G1U0lRVzwb0YoC4DLOxCoav3toO/5oYQ+/OdjsPWvH+lO+f0mzR
         0LKLYPNvrhAdHoGz+CpEpBJ8fFbhiXlmAiKK1bxCud9pmcGrrf995TgpBNME2CKv9OeV
         mUf2EIkGDWYlo1obEiwz5d+DlAnJprrahYWfTdbEvc2yuuwLL8t9+fMw7fkzPMSuW8AU
         zc+NfUBtGwWu0H1SCDOisEUj2RJyYZDef4iOf84SA8kbMbgT3lfZTc7gnH4lMagXVZo2
         lohi1J/fcYI4aSWJdn2gqiMT4u+9qmUI/Hj7Zlhp58DJY2DBm+5eA99+BhSmaNnDds5T
         5d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sn5HKSW/EV0nlOWbnLpY+Fd+1g+qo5O/g3DXMlwf0kM=;
        b=EM0eoQ3xRku7iFpGDdYAkqcOqcO8mMbQ/MFvv6GGi9FFaBTpCIdmfg19aDPHiI4tuZ
         g/rLlTCrkAv4OklPZAYJoaGO0mhWZig4TmG6dalP4HrDt9uBrC+qX09h3hgV4aQZzAOX
         aYPoEE5JhK/zBx997L9weEQSRgEKPNCvDSN7pQ1yVGZVgBOGdDgBAiqvGHiLffb8kdmo
         aBZIY5+O1LhSauvQvWQnFbZgFOIQpjz0kHLDR65vJFSj2bwGxhRlsyCgXIIRpUXYsgQ/
         zTBvJeY1fdkUS7gYqblJF9baXLfY9eoQa5+pmjrVtBCNzZZmltfQSiHyl96iGm3+k+t+
         IXog==
X-Gm-Message-State: APjAAAWfvTMzt+yLF25KCa/2cEqArn6YjOJJi3pnzQ3zIWza8842A4aK
        GpWJX7KyvcYGgEpXT2N1viOoiGi4ZyfivCfVozG5sw==
X-Google-Smtp-Source: APXvYqwKYXTlLzULVgtEN6lJ98Uu8rjpyuD00ssrtJFjSDAEv1GKhxUHHjfyUyg8SjDkahgooR5BHqcfTCJ7+ycFbDY=
X-Received: by 2002:a1f:aa93:: with SMTP id t141mr22915246vke.64.1554903603791;
 Wed, 10 Apr 2019 06:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190410102754.387743324@linutronix.de> <20190410103645.315084160@linutronix.de>
In-Reply-To: <20190410103645.315084160@linutronix.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 10 Apr 2019 15:39:52 +0200
Message-ID: <CAG_fn=U5vWCCRbCTABCa5GqBrkeT0gQyyUnUgSQ5wJhSuNw94A@mail.gmail.com>
Subject: Re: [RFC patch 19/41] lib/stackdepot: Provide functions which operate
 on plain storage arrays
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 1:05 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The struct stack_trace indirection in the stack depot functions is a trul=
y
> pointless excercise which requires horrible code at the callsites.
>
> Provide interfaces based on plain storage arrays.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alexander Potapenko <glider@google.com>
> ---
>  include/linux/stackdepot.h |    4 ++
>  lib/stackdepot.c           |   66 ++++++++++++++++++++++++++++++++------=
-------
>  2 files changed, 51 insertions(+), 19 deletions(-)
>
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -26,7 +26,11 @@ typedef u32 depot_stack_handle_t;
>  struct stack_trace;
>
>  depot_stack_handle_t depot_save_stack(struct stack_trace *trace, gfp_t f=
lags);
> +depot_stack_handle_t stack_depot_save(unsigned long *entries,
> +                                     unsigned int nr_entries, gfp_t gfp_=
flags);
>
>  void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *=
trace);
> +unsigned int stack_depot_fetch(depot_stack_handle_t handle,
> +                              unsigned long **entries);
>
>  #endif
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -194,40 +194,56 @@ static inline struct stack_record *find_
>         return NULL;
>  }
>
> -void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *=
trace)
> +/**
> + * stack_depot_fetch - Fetch stack entries from a depot
> + *
> + * @entries:           Pointer to store the entries address
> + */
> +unsigned int stack_depot_fetch(depot_stack_handle_t handle,
> +                              unsigned long **entries)
>  {
>         union handle_parts parts =3D { .handle =3D handle };
>         void *slab =3D stack_slabs[parts.slabindex];
>         size_t offset =3D parts.offset << STACK_ALLOC_ALIGN;
>         struct stack_record *stack =3D slab + offset;
>
> -       trace->nr_entries =3D trace->max_entries =3D stack->size;
> -       trace->entries =3D stack->entries;
> -       trace->skip =3D 0;
> +       *entries =3D stack->entries;
> +       return stack->size;
> +}
> +EXPORT_SYMBOL_GPL(stack_depot_fetch);
> +
> +void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *=
trace)
> +{
> +       unsigned int nent =3D stack_depot_fetch(handle, &trace->entries);
> +
> +       trace->max_entries =3D trace->nr_entries =3D nent;
>  }
>  EXPORT_SYMBOL_GPL(depot_fetch_stack);
>
>  /**
> - * depot_save_stack - save stack in a stack depot.
> - * @trace - the stacktrace to save.
> - * @alloc_flags - flags for allocating additional memory if required.
> + * stack_depot_save - Save a stack trace from an array
>   *
> - * Returns the handle of the stack struct stored in depot.
> + * @entries:           Pointer to storage array
> + * @nr_entries:                Size of the storage array
> + * @alloc_flags:       Allocation gfp flags
> + *
> + * Returns the handle of the stack struct stored in depot
>   */
> -depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
> -                                   gfp_t alloc_flags)
> +depot_stack_handle_t stack_depot_save(unsigned long *entries,
> +                                     unsigned int nr_entries,
> +                                     gfp_t alloc_flags)
>  {
> -       u32 hash;
> -       depot_stack_handle_t retval =3D 0;
>         struct stack_record *found =3D NULL, **bucket;
> -       unsigned long flags;
> +       depot_stack_handle_t retval =3D 0;
>         struct page *page =3D NULL;
>         void *prealloc =3D NULL;
> +       unsigned long flags;
> +       u32 hash;
>
> -       if (unlikely(trace->nr_entries =3D=3D 0))
> +       if (unlikely(nr_entries =3D=3D 0))
>                 goto fast_exit;
>
> -       hash =3D hash_stack(trace->entries, trace->nr_entries);
> +       hash =3D hash_stack(entries, nr_entries);
>         bucket =3D &stack_table[hash & STACK_HASH_MASK];
>
>         /*
> @@ -235,8 +251,8 @@ depot_stack_handle_t depot_save_stack(st
>          * The smp_load_acquire() here pairs with smp_store_release() to
>          * |bucket| below.
>          */
> -       found =3D find_stack(smp_load_acquire(bucket), trace->entries,
> -                          trace->nr_entries, hash);
> +       found =3D find_stack(smp_load_acquire(bucket), entries,
> +                          nr_entries, hash);
>         if (found)
>                 goto exit;
>
> @@ -264,10 +280,10 @@ depot_stack_handle_t depot_save_stack(st
>
>         spin_lock_irqsave(&depot_lock, flags);
>
> -       found =3D find_stack(*bucket, trace->entries, trace->nr_entries, =
hash);
> +       found =3D find_stack(*bucket, entries, nr_entries, hash);
>         if (!found) {
>                 struct stack_record *new =3D
> -                       depot_alloc_stack(trace->entries, trace->nr_entri=
es,
> +                       depot_alloc_stack(entries, nr_entries,
>                                           hash, &prealloc, alloc_flags);
>                 if (new) {
>                         new->next =3D *bucket;
> @@ -297,4 +313,16 @@ depot_stack_handle_t depot_save_stack(st
>  fast_exit:
>         return retval;
>  }
> +EXPORT_SYMBOL_GPL(stack_depot_save);
> +
> +/**
> + * depot_save_stack - save stack in a stack depot.
> + * @trace - the stacktrace to save.
> + * @alloc_flags - flags for allocating additional memory if required.
> + */
> +depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
> +                                     gfp_t alloc_flags)
> +{
> +       return stack_depot_save(trace->entries, trace->nr_entries, alloc_=
flags);
> +}
>  EXPORT_SYMBOL_GPL(depot_save_stack);
>
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
