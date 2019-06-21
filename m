Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C0C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F17420665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFUJ4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:56:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33512 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:56:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id x2so6330468qtr.0;
        Fri, 21 Jun 2019 02:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoSCQQgDyqdNTKrY/BA7yRe6rgMh4ABI0Zse4HOFW8I=;
        b=iGbUzHSUsXKE4Mhdgla4u6B7/wCG8Wbmf5kDEQ4BN4k1tQ8eg8CQayXAinNe5wTRGl
         RgZb3XHyc3YUpW/i6jHAP2Slc280FCqKj4v1pyc3XxorwWYgJ9iHTb3QF2zwUZuUT/fB
         RVFxSEKbmMSV8JQPOW68FxPyBLivkZCncf9tp4NEz/ZV8fRl8ykLK+pjeyJSfF38jqXP
         fZ/ntGqcFdrzhmJSLFKtHne4UkS5Eca6PdGXe4CgH4tx2t6iI6BUU5qzbt4HSsqu9fdx
         8QeL7UYNipQ2zOZjrEfWxkurPIbyI4/KAK3wyWO30U6rxA8itr/IkMri5NUHlFDujyDV
         SESw==
X-Gm-Message-State: APjAAAVriE4RiYeS1vHfGyvxgGyYEdIomySOqmqhCFsE87bF3ZM05ExW
        xUv5sqP0emizTYgZgFatYR7PYimq627vK1UvQCs=
X-Google-Smtp-Source: APXvYqxw7aZjDgZ7ucZwG6IV1T0CZcfI+f0WlXd3bEKJ5eJl95/WgLNK/53xguy0PsbHRE0STqxRzd1MrkBr3wNBVjI=
X-Received: by 2002:ac8:2379:: with SMTP id b54mr56769954qtb.168.1561110967884;
 Fri, 21 Jun 2019 02:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190620143800.20640-1-geert@linux-m68k.org> <dd980fec-d507-6969-cd86-971bafb401c2@huawei.com>
In-Reply-To: <dd980fec-d507-6969-cd86-971bafb401c2@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jun 2019 11:55:56 +0200
Message-ID: <CAMuHMdUHi3z5xmLyut2XqOPf9XFMF3AJiTnkwOAL-GQ6Ck_1ow@mail.gmail.com>
Subject: Re: [PATCH -next] f2fs: Use div_u64*() for 64-bit divisions
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Qiuyang Sun <sunqiuyang@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Fri, Jun 21, 2019 at 11:54 AM Chao Yu <yuchao0@huawei.com> wrote:
> Since the original patch hasn't been merged to upstream, I think we can merge
> this into original patch, how do you think?

Thanks, that's fine for me.

> On 2019/6/20 22:38, Geert Uytterhoeven wrote:
> > On 32-bit (e.g. m68k):
> >
> >     fs/f2fs/gc.o: In function `f2fs_resize_fs':
> >     gc.c:(.text+0x3056): undefined reference to `__umoddi3'
> >     gc.c:(.text+0x30c4): undefined reference to `__udivdi3'
> >
> > Fix this by using div_u64_rem() and div_u64() for 64-by-32 modulo resp.
> > division operations.
> >
> > Reported-by: noreply@ellerman.id.au
> > Fixes: d2ae7494d043bfaf ("f2fs: ioctl for removing a range from F2FS")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > This assumes BLKS_PER_SEC(sbi) is 32-bit.
> >
> >     #define BLKS_PER_SEC(sbi)                                       \
> >           ((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
> >
> > Notes:
> >   1. f2fs_sb_info.segs_per_sec and f2fs_sb_info.blocks_per_seg are both
> >      unsigned int,
> >   2. The multiplication is done in 32-bit arithmetic, hence the result
> >      is of type unsigned int.
> >   3. Is it guaranteed that the result will always fit in 32-bit, or can
> >      this overflow?
> >   4. fs/f2fs/debug.c:update_sit_info() assigns BLKS_PER_SEC(sbi) to
> >      unsigned long long blks_per_sec, anticipating a 64-bit value.
> > ---
> >  fs/f2fs/gc.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 5b1076505ade9f84..c65f87f11de029f4 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1438,13 +1438,15 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> >       unsigned int secs;
> >       int gc_mode, gc_type;
> >       int err = 0;
> > +     __u32 rem;
> >
> >       old_block_count = le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count);
> >       if (block_count > old_block_count)
> >               return -EINVAL;
> >
> >       /* new fs size should align to section size */
> > -     if (block_count % BLKS_PER_SEC(sbi))
> > +     div_u64_rem(block_count, BLKS_PER_SEC(sbi), &rem);
> > +     if (rem)
> >               return -EINVAL;
> >
> >       if (block_count == old_block_count)
> > @@ -1463,7 +1465,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> >       freeze_bdev(sbi->sb->s_bdev);
> >
> >       shrunk_blocks = old_block_count - block_count;
> > -     secs = shrunk_blocks / BLKS_PER_SEC(sbi);
> > +     secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
> >       spin_lock(&sbi->stat_lock);
> >       if (shrunk_blocks + valid_user_blocks(sbi) +
> >               sbi->current_reserved_blocks + sbi->unusable_block_count +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
