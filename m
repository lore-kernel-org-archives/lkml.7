Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790BC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F63520840
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwmzPjwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfGXR3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:29:03 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46182 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfGXR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:29:03 -0400
Received: by mail-vk1-f196.google.com with SMTP id b64so9529136vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g65bq2BEnljTH4aMgkIZ1B8Lg7IURCua+lyIxVKScJY=;
        b=mwmzPjwajv1rjeaemLgLYc6PD1sFmLLO4Ve4HcQyRYSilUH4mZsBwCj9zmXiWW8jYr
         U3wrKe3fhthhsKceOl+umeVUJV/G3fx95HHOs8Pa6DLScXiUJslK2X3vPArtcdOkVJMF
         NRFd6Eoz2oSUXQyq363SzO6MAqDnOeDJ5UjeTGqSFK5L3U48daxTkIrvtkS4cbFVIt8+
         gz5RCNtEHmZJk1il+DiLfRp/74XAaEacQW7axxY+FzxUSwFOHogEwCyAOhiFR7POEKlV
         1OTP5YAsiE5uNmDgkbnXUcK5wBOfdxmyFbQBRrPmQJHlL7tCHBQZoigb/lPQ3xWfYypA
         RVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g65bq2BEnljTH4aMgkIZ1B8Lg7IURCua+lyIxVKScJY=;
        b=HK8ETI1ySPOs8Rlfy9KkDEZCVP6+9wlpwI6OE9K0asUH0eFkCLlah0hpQoL8vaqqJ1
         Xo80FZItGrvOufhe1tPVkVyX8zjpLLZu/2ptRUDdnBYqUBr5du7d14LJeXBxFztD/L7O
         fAEhF5djEfbIsnx+mQgkVUHhyY4R2KOHpewwVH0emMGCfw/9M/6ArWODx9uTFxT00y52
         VsaK1fqL+H+syoHNxYBA4mDfMBh1k81Ptn60BXCQNbtT7GIjFbDvw0wyou2Q+Us6DEDz
         L91TQ6l7RBapFowEaEJclDfyT9WMhf8QCFDSt9HuKd2RgTyxCmKkWpZUPdFAzUD8LR/E
         GpZA==
X-Gm-Message-State: APjAAAUG3h7QC+2s5qCcnxOn6SDX4KLDuTPfhXPvFbE3N1+F3V5Am+ND
        1k2lriN+DQhJdFre1RliJIIbwzqeUMNvJdMGIwTyy3s2cGI19g==
X-Google-Smtp-Source: APXvYqzxA0IP/qNwL5bynk/l6uhKSN1KZDOfp9tIFoIp/NfO0yMWR/am+9x96oa7CYc5GD4ul7N04F6fmu25moniLc8=
X-Received: by 2002:a63:60a:: with SMTP id 10mr51141254pgg.381.1563988984995;
 Wed, 24 Jul 2019 10:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de> <20190724023946.yxsz5im22fz4zxrn@treble>
In-Reply-To: <20190724023946.yxsz5im22fz4zxrn@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jul 2019 10:22:53 -0700
Message-ID: <CAKwvOdk7d2UupG66Zt0zN_NB0xQOaCWBvMMWY_N_-uejw69-BQ@mail.gmail.com>
Subject: Re: x86 - clang / objtool status
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 7:43 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Jul 18, 2019 at 10:40:09PM +0200, Thomas Gleixner wrote:
>
> >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x86: redundant UACCESS disable
>
> Looking at this one, I think I agree with objtool.
>
> PeterZ, Linus, I know y'all discussed this code a few months ago.
>
> __copy_from_user() already does a CLAC in its error path.  So isn't the
> user_access_end() redundant for the __copy_from_user() error path?
>
> Untested fix:
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

Thanks for this patch.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/617
Fixes: 2889caa92321 ("drm/i915: Eliminate lots of iterations over the
execobjects array")

-- 
Thanks,
~Nick Desaulniers
