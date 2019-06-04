Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD3CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4039F20848
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559681470;
	bh=WoHldgKkngmxQsKjM+ZXSy/iOD+GzqZEW5s3/Clv9gM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G9pYUcdqNrPfh1QxuO9bxNoUED+Web9EOqDVobX0Of9P/TBtpL9pI+sPzm3Fql8Dn
	 UPr+3ktkOe95JCatP5yKSnVl7ecX61Oe+niodiw14695QJgkN3cuDykw/edBkyoFAO
	 5DOXPZ3+ZV6jq9qwD6pB3RqCwSAu4UR3dOzP2dD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFDUvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:51:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41285 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFDUvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:51:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id 107so15080481otj.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 13:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzJhGKhzrzdwswjZmo+oYPOFFA3OkVX4vMWQxKITSco=;
        b=W7HGaO0fnOLgvhIhRQmZUjbJlgWqFwiwmKiTlO+QB6b39yXf0HkBXsf/UcG6S6y+ns
         aAr7Z0Mqo1fxgPqirNnW622bbqJeICs4+1k4Bi0q/zbiXyfeiAuEAgekgWhXQ5djgKV5
         QP3tfiLClm7n0GiV9LYiczuKgRn9ewIqtPiVkOiTplcuOqZVG+fH0CVzw1xnz/gVVogd
         IaMTb4wjP1REbBJ6JH5WW1q/AYL06+2yCLKC4SLOdr77kF/BtAlQkhmexoejoF3OBIvn
         b2QKHK4kqHA2ibW84a4c21tdwhoU2OU7D/aVi2YOTXPHWitAbDGBjfSd9v5CytufxzZ7
         +UXw==
X-Gm-Message-State: APjAAAUfl0SB0Kzg+HAtwbQJaRlbxXPKMyV8GdTCrUeX00jmtMXA0FLA
        pMtOXnKMsnaj0A5yTb2cPpMUS65TSxvz3OwiS6vs9A==
X-Google-Smtp-Source: APXvYqw6aV66KCDU4wYhdXF/YwYlfF8jogyhDJ2Tb5qeXvYAYMxi5dQVzM1epv/bsdX0FEIRXWIJOOfFlUDKyaAzOqI=
X-Received: by 2002:a9d:7393:: with SMTP id j19mr6354384otk.118.1559681468447;
 Tue, 04 Jun 2019 13:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190604174412.13324-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190604174412.13324-1-yamada.masahiro@socionext.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jun 2019 22:50:54 +0200
Message-ID: <CAJZ5v0jXKNr3_W9B_raetj42UOdphA3GEE_Qh7nBSwDzwXfA1Q@mail.gmail.com>
Subject: Re: [PATCH] kobject: return -ENOSPC when add_uevent_var() fails
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 8:00 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This function never attempts to allocate memory, so returning -ENOMEM
> looks weird to me.

And why is the "looks weird to me" a good enough reason for making
changes like this?

The existing behavior is known and documented AFAICS and is it really
so confusing?

> The reason of the failure is there is no more space
> in the given kobj_uevent_env structure.
>
> No caller of this function relies on this functing returning a specific
> error code, so just change it to return -ENOSPC. The intended change,
> if any, is the error number displayed in log messages.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  lib/kobject_uevent.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7998affa45d4..5ffd44bf4aad 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -647,7 +647,7 @@ EXPORT_SYMBOL_GPL(kobject_uevent);
>   * @env: environment buffer structure
>   * @format: printf format for the key=value pair
>   *
> - * Returns 0 if environment variable was added successfully or -ENOMEM
> + * Returns 0 if environment variable was added successfully or -ENOSPC
>   * if no space was available.
>   */
>  int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
> @@ -657,7 +657,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
>
>         if (env->envp_idx >= ARRAY_SIZE(env->envp)) {
>                 WARN(1, KERN_ERR "add_uevent_var: too many keys\n");
> -               return -ENOMEM;
> +               return -ENOSPC;
>         }
>
>         va_start(args, format);
> @@ -668,7 +668,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
>
>         if (len >= (sizeof(env->buf) - env->buflen)) {
>                 WARN(1, KERN_ERR "add_uevent_var: buffer size too small\n");
> -               return -ENOMEM;
> +               return -ENOSPC;
>         }
>
>         env->envp[env->envp_idx++] = &env->buf[env->buflen];
> --
> 2.17.1
>
