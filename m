Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E545C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2719A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nvjWYQ3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfFLQQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:16:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46416 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfFLQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:16:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so9929970lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Wj8tFDiZvzxFDGQ8FFfl+cfAEOeLDLTEH6503XcxMY=;
        b=nvjWYQ3OHJDjWYibj/YNX20SWR28Rhln3Pwh8JIoMOB8OYo9eG07U/4EJIi9NQXKU8
         FZ1/5iwJpMxE0klA5AmIIGuutxZJIxHeS6K+KXebsBLnYuO+t+KuX6kINQe7hjeoBDY3
         0ZfXnRIiSqhRxTtwkbs5aoGhxHXWBwCKDHX5XpKeAaUVYQxyx/l5jNJiU2aLHbu2Sa7R
         feNRdnrd20kbNrAFb52qXZK/9aKx48QdfVrgI34RuxVxGpsKru21y4gadhgZb7yfkdSE
         iY1BePwQcyrF3ELgUklGxp9Ps2OI0ImZrPOFTAp1gGh5B2aZrBli2mw63UIYcMm86r88
         RviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Wj8tFDiZvzxFDGQ8FFfl+cfAEOeLDLTEH6503XcxMY=;
        b=WKi/Xfg4qsSyGuwhUIqRTDlKzR16O8HUaZsfsB3yKSwKppg/iEOyUbPpks3knLsRvP
         8T2dY/hgkn7JKo5Dd706o/gt8i6kFzTG4P3FHt40OUehA8gFO7v9kFQfp0DiSTFkWNeC
         uQJ7ZigUkAyYN7cyWViulEvid2nviAD7RjAPrzzlKQ1tmh/mMTeylyvoGjoWkSLtisaL
         9MlrHGxSpFahNjKY5m9Gu+pROL6VjUw9DexHnz/+k9TTClIJ4GVrHVrN7NhYwtAodYYG
         2UQ3Vo/FBTX7/KxBrNSDmWG//gkedN1otiV6zbleifpEWJrxJ7IvKXXiDLV//0/6dlPZ
         Oulg==
X-Gm-Message-State: APjAAAX+wWUE9XsO7xj1wjy7ZqK3wl4Lmmqb82uub8RPkVP2IJrCYUkp
        8t5U/UyTNhDnZ19ireaOyo2/h6jCBVEsBaqRi1ds
X-Google-Smtp-Source: APXvYqyI+wg+yow3qnp80fWW70DXTb4mtKkSJHSPj2mCVDEByCZl0pS3Ep6ghGCpZO/mj3aj2z0K6vWb/l6vy7tU9HE=
X-Received: by 2002:a19:7716:: with SMTP id s22mr24362250lfc.64.1560356202660;
 Wed, 12 Jun 2019 09:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190612132821.GA3816@zhanggen-UX430UQ>
In-Reply-To: <20190612132821.GA3816@zhanggen-UX430UQ>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jun 2019 12:16:31 -0400
Message-ID: <CAHC9VhTVpTMBHDWtXVBcW94-Rt2jzW0-+D_krgyj6o3TotodwQ@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: fix a missing-check bug in
 selinux_add_mnt_opt( )
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 9:28 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_add_mnt_opt(), 'val' is allocated by kmemdup_nul(). It returns
> NULL when fails. So 'val' should be checked. And 'mnt_opts' should be
> freed when error.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Fixes: 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()")
> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..b4b888e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1052,15 +1052,24 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
>         if (token == Opt_error)
>                 return -EINVAL;
>
> -       if (token != Opt_seclabel)
> -               val = kmemdup_nul(val, len, GFP_KERNEL);
> +       if (token != Opt_seclabel) {
> +                       val = kmemdup_nul(val, len, GFP_KERNEL);
> +                       if (!val) {
> +                               rc = -ENOMEM;
> +                               goto free_opt;
> +                       }

This block has an extra indent, but I'll go ahead and fix that during
the merge.  I have to mention that had you run this patch through
./scripts/checkpatch.pl it would have caught the mistake :)

Regardless, thanks for the patch, I've merged it into the
selinux/stable-5.2 branch and I'll be testing it shortly.

> +       }
>         rc = selinux_add_opt(token, val, mnt_opts);
>         if (unlikely(rc)) {
>                 kfree(val);
> -               if (*mnt_opts) {
> -                       selinux_free_mnt_opts(*mnt_opts);
> -                       *mnt_opts = NULL;
> -               }
> +               goto free_opt;
> +       }
> +       return rc;
> +
> +free_opt:
> +       if (*mnt_opts) {
> +               selinux_free_mnt_opts(*mnt_opts);
> +               *mnt_opts = NULL;
>         }
>         return rc;
>  }

-- 
paul moore
www.paul-moore.com
