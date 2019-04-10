Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6371EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2867B20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3gdf1SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDJWwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:52:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37974 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfDJWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:52:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id f36so2298713plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgu9rCUlCUyRg9pTWOOFz0QLkS3psF0id2QKUuVnVNU=;
        b=H3gdf1SCfcoUCCXHTroS7uP9CcD5D65nMUz7Fh7Mw2sAhS5Qq+jSkCOdMV6YcYCZy2
         cxLhWFA3JvVmMoWX6tNXrM1vZDPcul0o7S0F2cT1AYp8dzNdaffpc968qOEkGObRAWPl
         d5drsQGh/4GJw4wBy0AaIEZ4eqyHu84xLEwFvW6BvHV1kmvJ6CnnV/IkO/Nmx3jpiM0y
         74UpmuVJ0DdNsT1iBomnl6Ce3IOz7WVnZhMP5SaVQTJ7L8Z+KNU08PbeihaEl40BjHlN
         pYjp24oFI0v7fk8elxvH/8LDd7R3Pe5OVfjESx4msWw/AJirZS7ka4X/Iix5RL2CuP5A
         8h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgu9rCUlCUyRg9pTWOOFz0QLkS3psF0id2QKUuVnVNU=;
        b=QQn4oGO9HF+0cszUHU1fNHVT4SYgeniAR3jwMnkF7jnFBCzbnGzmgXfEXY5w50H6gu
         vOww8eff2EEapi800pvtoTbwLvkyQn+KhA8RIl0zZSKoi8Rp/SfiVbNXP+WTQM8GGXrw
         eeT6CFbZbq3BUMK1WO8q+DR/41W7W5/HwwyS2AarQMCEwZin4gup+ri2aoBNwj0S5XlJ
         vTPVQByh4Y8IVuEs1Tz9SRV0Hz7MO5Knls7VoHzgEo9mNOf6irb8Eqm72eG4P46EsDEv
         /WLC4vUAywf/Ok/KTIXNi5ro3ox0LMID9Jo3OG6I/70l3QKfV4efucN/P4HmS6HanpIz
         7pLQ==
X-Gm-Message-State: APjAAAWsjPT/7Ldu+ALpu+Vu5VYMvjV7EuTA+DFiiJJDh/NZ7vpTUG/w
        q1Z2Yfj4EQFErX5t21cVdPp23wEyWVFnZ5vsdqTJSA==
X-Google-Smtp-Source: APXvYqxxqPUGTT8rZ7GD11BnTnQW7BO8syDgqJnfUUfUUjWlzJQmDU4+N8F4h+0VvYbBzgF4BLmTYo9CkpIa5ojeOfc=
X-Received: by 2002:a17:902:8a8b:: with SMTP id p11mr46550449plo.227.1554936756671;
 Wed, 10 Apr 2019 15:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190410220301.2332-1-louis@kragniz.eu> <20190410224124.6901-1-louis@kragniz.eu>
In-Reply-To: <20190410224124.6901-1-louis@kragniz.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Apr 2019 15:52:25 -0700
Message-ID: <CAKwvOdmCHfRZ8miaCie=f2Fd_2QoJAnhS7TC8T0NYyQdcop9zA@mail.gmail.com>
Subject: Re: [PATCH v2] afs: use correct format characters
To:     Louis Taylor <louis@kragniz.eu>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 3:41 PM Louis Taylor <louis@kragniz.eu> wrote:
>
> When compiling with -Wformat, clang warns:
>
> fs/afs/flock.c:632:29: warning: format specifies type 'short' but the argument has type
>       'unsigned char' [-Wformat]
>         _leave(" = %d [%hd]", ret, fl->fl_type);
>                        ~~~         ^~~~~~~~~~~
>
> fs/afs/dir.c:138:11: warning: format specifies type 'unsigned short' but
> the argument has type 'int' [-Wformat]
>        ntohs(dbuf->blocks[tmp].hdr.magic));
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> fl_type is declared as an unsigned char unconditionally in
> include/linux/fs.h, so use the correct format characters.

Thanks for the v2, probably should include a note about ntohs.  That
case in particular looks more complicated, due to the definition of
ntohs (which uses __swab16).

If you keep the previous flag of %04hx, but add an explicit cast to
u16, does the warning go away? If so, that might be a better fix.

- ntohs(dbuf->blocks[tmp].hdr.magic));
+ (u16)ntohs(dbuf->blocks[tmp].hdr.magic));

?

Particularly, I'm curious about the return type of GNU C statement
expressions, in the definition of __swab16 if __HAVE_BUILTIN_BSWAP16__
is not defined.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  fs/afs/dir.c   | 2 +-
>  fs/afs/flock.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 8a2562e3a316..4ceaec94e9c5 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -133,7 +133,7 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
>         dbuf = kmap(page);
>         for (tmp = 0; tmp < qty; tmp++) {
>                 if (dbuf->blocks[tmp].hdr.magic != AFS_DIR_MAGIC) {
> -                       printk("kAFS: %s(%lx): bad magic %d/%d is %04hx\n",
> +                       printk("kAFS: %s(%lx): bad magic %d/%d is %04x\n",
>                                __func__, dvnode->vfs_inode.i_ino, tmp, qty,
>                                ntohs(dbuf->blocks[tmp].hdr.magic));
>                         trace_afs_dir_check_failed(dvnode, off, i_size);
> diff --git a/fs/afs/flock.c b/fs/afs/flock.c
> index 6a0174258382..be4c3f6a3178 100644
> --- a/fs/afs/flock.c
> +++ b/fs/afs/flock.c
> @@ -629,7 +629,7 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
>
>         ret = 0;
>  error:
> -       _leave(" = %d [%hd]", ret, fl->fl_type);
> +       _leave(" = %d [%hhu]", ret, fl->fl_type);
>         return ret;
>  }

-
Thanks,
~Nick Desaulniers
