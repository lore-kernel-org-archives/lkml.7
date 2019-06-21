Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B9AC48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2979208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561140129;
	bh=g79cNV6mf95ZmNPYnM1FB01DX5LPgZqiGUD7akF6G6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HbPATZKDAvsFfXaIMlkxM8+M1yttXXjDGCWI5jRzzG4O0mcbl5hRBQV9StCyreYTm
	 GxGwX7TAVVGz4nE8foMjw2ddmS8uSP0zTaZvov3auCVrr5GKe9ayMzpH2mB3Go/CtI
	 qR7kHbLqyutkWo4IW2g7Ht3UYRh3qUB2UvMF77zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFUSCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUSCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:02:08 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BA22070B;
        Fri, 21 Jun 2019 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561140126;
        bh=g79cNV6mf95ZmNPYnM1FB01DX5LPgZqiGUD7akF6G6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ox4m1w+PS7vUV8r9TxOITAt1Szi7NPEgyksJHkf2lyp999RYb4j+gqL+htr6gvvTW
         QazJsF8LbXmELHinQXJOlt0BjQSv+FOidYA2eimQ2cMJWFn7R/Qa6tTaSNx+f4o0tA
         wDn4Za7mziYVpYox27i7qI7VGqf3WHjWxwylpif8=
Date:   Fri, 21 Jun 2019 11:02:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chao Yu <yuchao0@huawei.com>, Qiuyang Sun <sunqiuyang@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] f2fs: Use div_u64*() for 64-bit divisions
Message-ID: <20190621180206.GD79502@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190620143800.20640-1-geert@linux-m68k.org>
 <dd980fec-d507-6969-cd86-971bafb401c2@huawei.com>
 <CAMuHMdUHi3z5xmLyut2XqOPf9XFMF3AJiTnkwOAL-GQ6Ck_1ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUHi3z5xmLyut2XqOPf9XFMF3AJiTnkwOAL-GQ6Ck_1ow@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21, Geert Uytterhoeven wrote:
> Hi Chao,
> 
> On Fri, Jun 21, 2019 at 11:54 AM Chao Yu <yuchao0@huawei.com> wrote:
> > Since the original patch hasn't been merged to upstream, I think we can merge
> > this into original patch, how do you think?
> 
> Thanks, that's fine for me.

Merged the fix.
Thank you so much.

> 
> > On 2019/6/20 22:38, Geert Uytterhoeven wrote:
> > > On 32-bit (e.g. m68k):
> > >
> > >     fs/f2fs/gc.o: In function `f2fs_resize_fs':
> > >     gc.c:(.text+0x3056): undefined reference to `__umoddi3'
> > >     gc.c:(.text+0x30c4): undefined reference to `__udivdi3'
> > >
> > > Fix this by using div_u64_rem() and div_u64() for 64-by-32 modulo resp.
> > > division operations.
> > >
> > > Reported-by: noreply@ellerman.id.au
> > > Fixes: d2ae7494d043bfaf ("f2fs: ioctl for removing a range from F2FS")
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > ---
> > > This assumes BLKS_PER_SEC(sbi) is 32-bit.
> > >
> > >     #define BLKS_PER_SEC(sbi)                                       \
> > >           ((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
> > >
> > > Notes:
> > >   1. f2fs_sb_info.segs_per_sec and f2fs_sb_info.blocks_per_seg are both
> > >      unsigned int,
> > >   2. The multiplication is done in 32-bit arithmetic, hence the result
> > >      is of type unsigned int.
> > >   3. Is it guaranteed that the result will always fit in 32-bit, or can
> > >      this overflow?
> > >   4. fs/f2fs/debug.c:update_sit_info() assigns BLKS_PER_SEC(sbi) to
> > >      unsigned long long blks_per_sec, anticipating a 64-bit value.
> > > ---
> > >  fs/f2fs/gc.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index 5b1076505ade9f84..c65f87f11de029f4 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -1438,13 +1438,15 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> > >       unsigned int secs;
> > >       int gc_mode, gc_type;
> > >       int err = 0;
> > > +     __u32 rem;
> > >
> > >       old_block_count = le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count);
> > >       if (block_count > old_block_count)
> > >               return -EINVAL;
> > >
> > >       /* new fs size should align to section size */
> > > -     if (block_count % BLKS_PER_SEC(sbi))
> > > +     div_u64_rem(block_count, BLKS_PER_SEC(sbi), &rem);
> > > +     if (rem)
> > >               return -EINVAL;
> > >
> > >       if (block_count == old_block_count)
> > > @@ -1463,7 +1465,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> > >       freeze_bdev(sbi->sb->s_bdev);
> > >
> > >       shrunk_blocks = old_block_count - block_count;
> > > -     secs = shrunk_blocks / BLKS_PER_SEC(sbi);
> > > +     secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
> > >       spin_lock(&sbi->stat_lock);
> > >       if (shrunk_blocks + valid_user_blocks(sbi) +
> > >               sbi->current_reserved_blocks + sbi->unusable_block_count +
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
