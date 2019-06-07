Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A0C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD4E208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfFGIl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:41:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36974 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfFGIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:41:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id r10so1140968otd.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhRDnyMcoVrM+CY+5h3V1Bjl6TjB4Im0OP5MymJVl50=;
        b=Fo9P7aL37E6v5EqdxXFJCYBazZb+ixL3KHX89nSoRCTmi98LoQan8nm30sIS9QtxBp
         DLQ4PgEdiyq9uHDnvspqaDhiPxiLLwM31bKr/5UGhkCwyC6jFfbt5y6MRmKYl3WGzcJQ
         kRvNQAKrG/sLeFDFMGtQWhfWwbkbAOd4wpa0oiDwVcBL8HwtU5bH5JIo/dt2SE62wQhl
         qkc9OEaj4ffx9F7E47CpbmX6CDHH1vQ07yfSdwvmdoYYhI4IddEgfWvXNhRQg4+9htxx
         xTdXXadsAn0cE7AcM+6t2puZUKEgbLFMnhgai1tq+yo2v7M9SqdrGrVZe0wOOYvmhulX
         mtYw==
X-Gm-Message-State: APjAAAVqx5qAbhGzNzVwB46GXC/TzthXvT9kfF4kUbjK5EyPTpj2t2Nx
        WRhAnhfCDhpW/SEtc7RIzaF3p/08AfTbjRIbk4bHrg==
X-Google-Smtp-Source: APXvYqyoX9qXSFNPUKcdHor6FViid7pqKSfIHRCEiLoUUUULC30ITm19dvd+a4TZbZbKNzpafhkZJtRsq8aszvlkpjo=
X-Received: by 2002:a9d:73cd:: with SMTP id m13mr8285912otk.43.1559896887528;
 Fri, 07 Jun 2019 01:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190606085524.GA21119@zhanggen-UX430UQ>
In-Reply-To: <20190606085524.GA21119@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 7 Jun 2019 10:41:17 +0200
Message-ID: <CAFqZXNvM94T2reUsn6Mwuz6GNGNCR=wUNBE8w4tcjNuhJ6rCeQ@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: lsm: fix a missing-check bug in
 selinux_sb_eat_lsm_o pts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 10:55 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> should be freed when error.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")

My comments about the subject and an empty line before label apply
here as well, but Paul can fix both easily when applying, so:

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..13479cd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2616,10 +2616,11 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>         char *from = options;
>         char *to = options;
>         bool first = true;
> +       int rc;
>
>         while (1) {
>                 int len = opt_len(from);
> -               int token, rc;
> +               int token;
>                 char *arg = NULL;
>
>                 token = match_opt_prefix(from, len, &arg);
> @@ -2635,15 +2636,15 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg) {
> +                                       rc = -ENOMEM;
> +                                       goto free_opt;
> +                               }
>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {
>                                 kfree(arg);
> -                               if (*mnt_opts) {
> -                                       selinux_free_mnt_opts(*mnt_opts);
> -                                       *mnt_opts = NULL;
> -                               }
> -                               return rc;
> +                               goto free_opt;
>                         }
>                 } else {
>                         if (!first) {   // copy with preceding comma
> @@ -2661,6 +2662,12 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>         }
>         *to = '\0';
>         return 0;
> +free_opt:
> +       if (*mnt_opts) {
> +               selinux_free_mnt_opts(*mnt_opts);
> +               *mnt_opts = NULL;
> +       }
> +       return rc;
>  }
>
>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
