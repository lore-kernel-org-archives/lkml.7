Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4133FC7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F23821901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfGVNSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:18:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38380 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfGVNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:18:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so40183495oth.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46nBGTq9+Y+lM2ciGt7IuascVvvL7sVLuW7aSWfz9iM=;
        b=kmwdMXNvsyePYe8Ule5Z2C84VL9wPq/251jcWEwpniq3zkdFstVx1f+M9mmS0HTkC9
         GyvJY98n7jAvmXZlxiMVXzkdOlmWBAcYETk0SYofjIrz9Hsc20BdYVLJXMbfkEVXQfwS
         x/B8TZ5b+SncgFb1gQbxixKgtUGVqVxTwRWbfAycOfOLH0AOWpyf2taD+eMKhupcxO5j
         jM1h7Enl8o8+l7aTBLqt0puj5t6OgYbF71j98+DfHG4+LqIwTm3mPzLunj8Xp9Bn61du
         jfZZ/HPhOE0A+bgJ1cboizKW4BFCqhQ3UXL0ycKzmyjiwfN4BAiADZSxAfjymB0OjIRY
         ltSQ==
X-Gm-Message-State: APjAAAX+shOJsQUw3aJb60vmvmKgCMh3GYfW3WjFtFjK2ZNzN+/O5nlQ
        ZRvuiL6gXJXw4mL9F8Jqv6bn8s3+b+N0Lh0Tnn4bow==
X-Google-Smtp-Source: APXvYqzRZs+3+1ucKSe3yuFeprYfsp9QaDCtvH5/kJtEexcbwdxJf8ovuT4RA2eMigFLBlO8RDkEYxRd3eoVi7kF/P8=
X-Received: by 2002:a9d:4c17:: with SMTP id l23mr7097454otf.367.1563801488453;
 Mon, 22 Jul 2019 06:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190722113151.1584-1-nitin.r.gote@intel.com>
In-Reply-To: <20190722113151.1584-1-nitin.r.gote@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 22 Jul 2019 15:17:57 +0200
Message-ID: <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
To:     NitinGote <nitin.r.gote@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 1:35 PM NitinGote <nitin.r.gote@intel.com> wrote:
> refcount_t type and corresponding API should be
> used instead of atomic_t when the variable is used as
> a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free
> situations.
>
> Signed-off-by: NitinGote <nitin.r.gote@intel.com>

Nack.

The 'count' variable is not used as a reference counter here. It
tracks the number of entries in sidtab, which is a very specific
lookup table that can only grow (the count never decreases). I only
made it atomic because the variable is read outside of the sidtab's
spin lock and thus the reads and writes to it need to be guaranteed to
be atomic. The counter is only updated under the spin lock, so
insertions do not race with each other.

Your patch, however, lead me to realize that I forgot to guard against
overflow above SIDTAB_MAX when a new entry is being inserted. It is
extremely unlikely to happen in practice, but should be fixed anyway.
I'll send a patch shortly.

> ---
>  security/selinux/ss/sidtab.c | 16 ++++++++--------
>  security/selinux/ss/sidtab.h |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index e63a90ff2728..20fe235c6c71 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -29,7 +29,7 @@ int sidtab_init(struct sidtab *s)
>         for (i = 0; i < SECINITSID_NUM; i++)
>                 s->isids[i].set = 0;
>
> -       atomic_set(&s->count, 0);
> +       refcount_set(&s->count, 0);
>
>         s->convert = NULL;
>
> @@ -130,7 +130,7 @@ static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
>
>  static struct context *sidtab_lookup(struct sidtab *s, u32 index)
>  {
> -       u32 count = (u32)atomic_read(&s->count);
> +       u32 count = refcount_read(&s->count);
>
>         if (index >= count)
>                 return NULL;
> @@ -245,7 +245,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>                                  u32 *index)
>  {
>         unsigned long flags;
> -       u32 count = (u32)atomic_read(&s->count);
> +       u32 count = (u32)refcount_read(&s->count);
>         u32 count_locked, level, pos;
>         struct sidtab_convert_params *convert;
>         struct context *dst, *dst_convert;
> @@ -272,7 +272,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>         spin_lock_irqsave(&s->lock, flags);
>
>         convert = s->convert;
> -       count_locked = (u32)atomic_read(&s->count);
> +       count_locked = (u32)refcount_read(&s->count);
>         level = sidtab_level_from_count(count_locked);
>
>         /* if count has changed before we acquired the lock, then catch up */
> @@ -315,7 +315,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>                 }
>
>                 /* at this point we know the insert won't fail */
> -               atomic_set(&convert->target->count, count + 1);
> +               refcount_set(&convert->target->count, count + 1);
>         }
>
>         if (context->len)
> @@ -328,7 +328,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>         /* write entries before writing new count */
>         smp_wmb();
>
> -       atomic_set(&s->count, count + 1);
> +       refcount_set(&s->count, count + 1);
>
>         rc = 0;
>  out_unlock:
> @@ -418,7 +418,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
>                 return -EBUSY;
>         }
>
> -       count = (u32)atomic_read(&s->count);
> +       count = (u32)refcount_read(&s->count);
>         level = sidtab_level_from_count(count);
>
>         /* allocate last leaf in the new sidtab (to avoid race with
> @@ -431,7 +431,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
>         }
>
>         /* set count in case no new entries are added during conversion */
> -       atomic_set(&params->target->count, count);
> +       refcount_set(&params->target->count, count);
>
>         /* enable live convert of new entries */
>         s->convert = params;
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index bbd5c0d1f3bd..68dd96a5beba 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -70,7 +70,7 @@ struct sidtab_convert_params {
>
>  struct sidtab {
>         union sidtab_entry_inner roots[SIDTAB_MAX_LEVEL + 1];
> -       atomic_t count;
> +       refcount_t count;
>         struct sidtab_convert_params *convert;
>         spinlock_t lock;
>
> --
> 2.17.1
>

Thanks,

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
