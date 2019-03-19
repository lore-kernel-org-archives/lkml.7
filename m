Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FC2C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B982085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCSNnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:43:17 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41429 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSNnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:43:17 -0400
Received: by mail-vs1-f68.google.com with SMTP id z25so10389141vsk.8;
        Tue, 19 Mar 2019 06:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0qw5YUJ7LbTxni2Vy4OEUg4MuVlWm9B+Bk1yzt1Ilk=;
        b=s3mYjFFh9B/V4WlHf5QUQO57iM107MgwwMjkmCXz0qLU4voLC3J59te1dY6N2Ml/vA
         xl+qTOytav/pDDDxiwQnFzn50HwzJg3zOJtJMAhTXovi/7FVyCStWKyREPu+kpkJT9iu
         H3Oc6qcAisrwPiAvsk1kvoeXuQEc4RkNUP9/JdMwHCVvxEebzPubCBQHxReeF3bZ8inf
         Vlcna7bN2bKottoHMVDr8/Ylw8Spi9XiG9nW02ErIoqhMeCwRtHAMTbtlETughj/gUF2
         vlwnLcmvxPmXwDdb1VdNLWAqFZngAFa23ufVTPbGLDoLh9WqwLwQBePMnUg20SiBGOrL
         PZrg==
X-Gm-Message-State: APjAAAUIhAVLyw/wUOfE97BIAYbLiDNDOWZgu0OOmVyjfNThkLaKp+/j
        YVLn61M0+sknfOZHrlN5dMVn1dQLOIauXL3W7YM=
X-Google-Smtp-Source: APXvYqxWIGWdTORc+McrYSmGlCSMV2HFlT6oo+gW2PGtlfEoG5tyH6rkB3XqMHKO5hIN/q6ND3qsTUzZVVQGD8yH60A=
X-Received: by 2002:a67:f843:: with SMTP id b3mr1343623vsp.152.1553002995707;
 Tue, 19 Mar 2019 06:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190314074607.28041-1-kjlu@umn.edu>
In-Reply-To: <20190314074607.28041-1-kjlu@umn.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Mar 2019 14:43:04 +0100
Message-ID: <CAMuHMdX0ShS8d11kYDYoce=yaqphMvWdyqocsZczF8+EkSSkuw@mail.gmail.com>
Subject: Re: [PATCH] fs: affs: fix a NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, David Sterba <dsterba@suse.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

On Thu, Mar 14, 2019 at 8:47 AM Kangjie Lu <kjlu@umn.edu> wrote:
> If affs_bread fails, do not use ext_bh to avoid NULL pointer
>  dereference
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Thanks for your patch!

> --- a/fs/affs/file.c
> +++ b/fs/affs/file.c
> @@ -835,7 +835,7 @@ void
>  affs_truncate(struct inode *inode)
>  {
>         struct super_block *sb = inode->i_sb;
> -       u32 ext, ext_key;
> +       u32 ext, ext_key, ext_bk;

Why adding an intermediate variable (without __be32 tag)?

>         u32 last_blk, blkcnt, blk;
>         u32 size;
>         struct buffer_head *ext_bh;
> @@ -941,8 +941,12 @@ affs_truncate(struct inode *inode)
>                 size = AFFS_SB(sb)->s_hashsize;
>                 if (size > blkcnt - blk)
>                         size = blkcnt - blk;
> -               for (i = 0; i < size; i++, blk++)
> -                       affs_free_block(sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, i)));
> +               if (ext_bh) {
> +                       for (i = 0; i < size; i++, blk++) {
> +                               ext_bk = AFFS_BLOCK(sb, ext_bh, i);
> +                               affs_free_block(sb, be32_to_cpu(ext_bk));
> +                       }

Now this ignores all errors, silently.
What about handling actual errors, and propagating them up?

> +               }
>                 affs_free_block(sb, ext_key);
>                 ext_key = be32_to_cpu(AFFS_TAIL(sb, ext_bh)->extension);
>                 affs_brelse(ext_bh);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
