Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48800C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2236220828
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk084PCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfGYGLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:11:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35194 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGYGLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:11:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so43519924wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PrghChsOVRMfwpij53eGz1Wi4A+tfqIRi6hI1nWFnrs=;
        b=lk084PCHVWG0QmdJFBK7xJ5eyDsEkncFxo9Oq+bv+IOWm50mH1ZzmeoVYcb/NNqY1R
         y/djFuTEdHL/KpOaB94EtFeGAO1aYvy5F/2UCuF6ihERVvJ2GMhh7I21lSu1uT5vlfR7
         T7Z/I6IgYmzDT6TaMoHi/TsXXyOEwHP0jsfEG3TipjgxY4+I5qtvOKt5Tl8PBFGgVJPV
         EOI7gAF63fXN8L1FCFGuu1t5OS+kawjXBZWVqb4sLbASIrr8jhXYQbSGVEdd1aOWoVDw
         AtSU/XCwNdjmOQuf4hDhvli60+FtOhGKT+JqbfknmS0tkx6T2iZoS+C053e22yTRmGwg
         nwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PrghChsOVRMfwpij53eGz1Wi4A+tfqIRi6hI1nWFnrs=;
        b=ESeUP/wJjkpb99Ws7uf3OkDLxKcryq0bYgH75oCU7b0JmXtRaxVd2XKcaLIlUhHqJR
         5xk0DQephrBARBVenSlJDnLR/B84dXjBcxVjJQObaUKmUF4K+c8j4d/f93RJiyL9Vwc8
         7pY1ahsOO2QDWk3yXM29kKwnm607DyWUvEfZPSwJbsWn7ZRjraaIhJMQs36fe/AsbKYl
         thvLf7SwWweW8APSofBMPL33GDWGkgA8JrU6nSO5fBavPHifRayIxbzOPKc7k4gQIUzC
         0+086eoXD+9xCcTI7MwPIfFWqUMbOjKNX2sIVGkCBQfaz3H1+/3V0RoB+X0GSDND97eL
         fjCw==
X-Gm-Message-State: APjAAAWl7txfwAtUYeskWlVBbphbTt1HjUCi+z66aCz0r//YJdZmJ2H0
        iJKZW6+PWYI4h38Sd59gzwM3iLlFWyj0cLuXjWw=
X-Google-Smtp-Source: APXvYqzZwwybCGBYVG5TI+PriV3WnuQHbWVWVfMcrMJWzo7fSM2WdyrPby63rMixcgtJ1oxuCf+jYx0k7QLBLzKVMQA=
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr81600428wmm.81.1564035060177;
 Wed, 24 Jul 2019 23:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564007838.git.jpoimboe@redhat.com> <523b910e41a5cf856ee338b78ee36941034be142.1564007838.git.jpoimboe@redhat.com>
In-Reply-To: <523b910e41a5cf856ee338b78ee36941034be142.1564007838.git.jpoimboe@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 25 Jul 2019 08:10:49 +0200
Message-ID: <CA+icZUUb0XVhYq6Y590UyKxEyvzP7_LWU6WZW6bi7tEu6=RzuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:48 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Objtool reports:
>
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable
>
> __copy_from_user() already does both STAC and CLAC, so the
> user_access_end() in its error path adds an extra unnecessary CLAC.
>
> Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/617
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Just for the records and ensuing ages:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

> ---
>  .../gpu/drm/i915/gem/i915_gem_execbuffer.c    | 20 +++++++++----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index 5fae0e50aad0..41dab9ea33cd 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -1628,6 +1628,7 @@ static int check_relocations(const struct drm_i915_gem_exec_object2 *entry)
>
>  static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  {
> +       struct drm_i915_gem_relocation_entry *relocs;
>         const unsigned int count = eb->buffer_count;
>         unsigned int i;
>         int err;
> @@ -1635,7 +1636,6 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>         for (i = 0; i < count; i++) {
>                 const unsigned int nreloc = eb->exec[i].relocation_count;
>                 struct drm_i915_gem_relocation_entry __user *urelocs;
> -               struct drm_i915_gem_relocation_entry *relocs;
>                 unsigned long size;
>                 unsigned long copied;
>
> @@ -1663,14 +1663,8 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>
>                         if (__copy_from_user((char *)relocs + copied,
>                                              (char __user *)urelocs + copied,
> -                                            len)) {
> -end_user:
> -                               user_access_end();
> -end:
> -                               kvfree(relocs);
> -                               err = -EFAULT;
> -                               goto err;
> -                       }
> +                                            len))
> +                               goto end;
>
>                         copied += len;
>                 } while (copied < size);
> @@ -1699,10 +1693,14 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>
>         return 0;
>
> +end_user:
> +       user_access_end();
> +end:
> +       kvfree(relocs);
> +       err = -EFAULT;
>  err:
>         while (i--) {
> -               struct drm_i915_gem_relocation_entry *relocs =
> -                       u64_to_ptr(typeof(*relocs), eb->exec[i].relocs_ptr);
> +               relocs = u64_to_ptr(typeof(*relocs), eb->exec[i].relocs_ptr);
>                 if (eb->exec[i].relocation_count)
>                         kvfree(relocs);
>         }
> --
> 2.20.1
>
