Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998D7C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348521655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576877208;
	bh=GB0uH5v3CIKNR642grWZ0+CyMiDRyZ1gPbwQP4C+Aw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HegtjdkjXYkRbWfGfL5WMLd9hgI9+sRt4qMTNia+JaERpllVSE/ana6PxlkUZSRDP
	 xHEAVmRhP68x3PbcLQtaABA2qveCT1AH/89+T7Z9/JdF1Y8/8hnFGpePmTRbkEXKMj
	 HcIQxqhx09lcZrWjxVFo3BRv4F2LhdAoISrR0GV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLTV0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:26:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfLTV0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:26:47 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82FDE206DA;
        Fri, 20 Dec 2019 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576877206;
        bh=GB0uH5v3CIKNR642grWZ0+CyMiDRyZ1gPbwQP4C+Aw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnD/cqIsY2DEGGEQjd5GSK4d6ltKJg8qF/7HVUf0RdCncfWQz6dCALsQSlUt4WWO5
         GQjczmmQeTpmisqGhWEcfBC3ePvP11TPVHCEOxmgXyYC8Kd+cni1wpwfewiyQapBan
         bbci6tmLpqU1uq5xNWdo1u7EofBgHvoVgC/xCiTQ=
Date:   Fri, 20 Dec 2019 13:26:45 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>,
        Linux-Next <linux-next@vger.kernel.org>
Subject: Re: [RFC PATCH v5] f2fs: support data compression
Message-ID: <20191220212645.GA14042@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <CAMuHMdUDURUQJjJU+2QQgY1hXN8ndJ6dwc-PF1CWc-HAio0sKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUDURUQJjJU+2QQgY1hXN8ndJ6dwc-PF1CWc-HAio0sKA@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19, Geert Uytterhoeven wrote:
> Hi,
> 
> On Mon, Dec 16, 2019 at 7:29 AM Chao Yu <yuchao0@huawei.com> wrote:
> >
> > This patch tries to support compression in f2fs.
> 
> 
> 
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> 
> > @@ -667,6 +719,24 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
> >         return err;
> >  }
> >
> > +int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
> > +{
> > +       u64 free_from = from;
> > +
> > +       /*
> > +        * for compressed file, only support cluster size
> > +        * aligned truncation.
> > +        */
> > +       if (f2fs_compressed_file(inode)) {
> > +               size_t cluster_size = PAGE_SIZE <<
> > +                                       F2FS_I(inode)->i_log_cluster_size;
> > +
> > +               free_from = roundup(from, cluster_size);
> 
> This is a 64-by-32 or 64-by-64 division, causing a link failure on
> 32-bit platforms:
> 
>     fs/f2fs/file.o: In function `f2fs_truncate_blocks':
>     file.c:(.text+0x1db4): undefined reference to `__udivdi3'
> 
> Please use DIV_ROUND_UP_ULL() instead.

Thanks, I applied it in:
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev

> 
> Reported-by: <noreply@ellerman.id.au>
> 
> > +       }
> > +
> > +       return do_truncate_blocks(inode, free_from, lock);
> > +}
> 
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
