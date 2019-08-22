Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182CAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E398322CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arq4xCxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfHVAR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:17:27 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38583 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfHVAR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:17:26 -0400
Received: by mail-yw1-f66.google.com with SMTP id f187so1681672ywa.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulFbNzA9b5vRVN6/SZzhpTQBctv6NDxyo6JV6dAYMZI=;
        b=arq4xCxeNbVzw1mj9oaCKvl7JTiIF99/NsrNSN+AnMEyM0a/Xfg9vhQv0BvOqpWpe/
         v3tA64zDckl5lhF90Woh7EfD80UCUDCUEkwHgJdQ+pgFlUTEMuywha9octggJ/sq9T5Y
         BW0hphWaaZLycOGI8NXBkBcqchnfncBPqVisO4hct/IOUJeJzhUN+rFzeKfW8Pz+ppmK
         PFAFiA/jizlGE0vBh8SKextDcb6FTDqYsYmTawuXiPYSyxmEOMOlGVhwsUcKMPM2e4/A
         DQA9FatJIVjx3ZWptpeZUDKwSqY/MY/d2t3JV0ySCIdBuqC1sXmOflg4USbr6TCSBC8P
         m/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulFbNzA9b5vRVN6/SZzhpTQBctv6NDxyo6JV6dAYMZI=;
        b=TFmZIyU7ygcdVzJBQ54CHoi54DZZmAbDF4dlbd4bsspZE4Qz7Sdue6B4hsLJ8v3bbM
         wEBJIyA7Byg2vu6NlxyWoSdfDxWPvmZLJ1E4K2IB0x0oKCbtGQ3Jj3Pw71y1eFOq3O07
         xFHw2xN7naMkPp1Ppe1ng5aFAkAasF4ZF0/tzzf07VIcMsU/MkPTyOFxJSlC/MBWo1dx
         LsxlFxXWjflHUPg+ZDF4mjhMrTsiY8qQNttTVC2b5f09xhiZl4+8KGY2bFVZ+N4vBk+D
         yyQqrScD5xs1st6prpvmHcMJ9ggfLbvz8XHiRTLbY1eMHp2yCz1WKZyugh1myYxuSHnI
         ZEoA==
X-Gm-Message-State: APjAAAVhQMjv+45pPHxRILi/stMLL9Hbb6vdmdhxL+tA45p90WVG0YcO
        bzHVegeISBVr9Uuu5WsflXrrmhS5UuxgnpOwyKrqvaVDGA8=
X-Google-Smtp-Source: APXvYqxx4Ps49Zdl5TE5I7hU6AIZpEVV3CyqprwPfgkXjdI6SdjvtAetbjni64AXIBGuff4VhHRJBdFvRBwd2sZ2ER0=
X-Received: by 2002:a81:a448:: with SMTP id b69mr25417748ywh.4.1566433045475;
 Wed, 21 Aug 2019 17:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190822000933.180870-1-khazhy@google.com>
In-Reply-To: <20190822000933.180870-1-khazhy@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 21 Aug 2019 17:17:14 -0700
Message-ID: <CALvZod44CHWEUxa4Mi7nRLfgyCnGgNAxso8SLA5xVoR=DdQiWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: on 64-bit store time in d_fsdata directly
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     miklos@szeredi.hu, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 5:09 PM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> Implements the optimization noted in f75fdf22b0a8 ("fuse: don't use
> ->d_time"), as the additional memory can be significant. (In particular,
> on SLAB configurations this 8-byte alloc becomes 32 bytes). Per-dentry,
> this can consume significant memory.
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Actually we are seeing this in production where a job creating a lot
of fuse files cause a lot of extra system level overhead.

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  fs/fuse/dir.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index dd0f64f7bc06..f9c59a296568 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -24,6 +24,18 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
>         set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
>  }
>
> +#if BITS_PER_LONG >= 64
> +static inline void fuse_dentry_settime(struct dentry *entry, u64 time)
> +{
> +       entry->d_fsdata = (void *) time;
> +}
> +
> +static inline u64 fuse_dentry_time(struct dentry *entry)
> +{
> +       return (u64)entry->d_fsdata;
> +}
> +
> +#else
>  union fuse_dentry {
>         u64 time;
>         struct rcu_head rcu;
> @@ -38,6 +50,7 @@ static inline u64 fuse_dentry_time(struct dentry *entry)
>  {
>         return ((union fuse_dentry *) entry->d_fsdata)->time;
>  }
> +#endif
>
>  /*
>   * FUSE caches dentries and attributes with separate timeout.  The
> @@ -242,6 +255,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>         goto out;
>  }
>
> +#if BITS_PER_LONG < 64
>  static int fuse_dentry_init(struct dentry *dentry)
>  {
>         dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
> @@ -254,16 +268,21 @@ static void fuse_dentry_release(struct dentry *dentry)
>
>         kfree_rcu(fd, rcu);
>  }
> +#endif
>
>  const struct dentry_operations fuse_dentry_operations = {
>         .d_revalidate   = fuse_dentry_revalidate,
> +#if BITS_PER_LONG < 64
>         .d_init         = fuse_dentry_init,
>         .d_release      = fuse_dentry_release,
> +#endif
>  };
>
>  const struct dentry_operations fuse_root_dentry_operations = {
> +#if BITS_PER_LONG < 64
>         .d_init         = fuse_dentry_init,
>         .d_release      = fuse_dentry_release,
> +#endif
>  };
>
>  int fuse_valid_type(int m)
> --
> 2.23.0.187.g17f5b7556c-goog
>
