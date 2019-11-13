Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84D9C4742F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46675233A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTZ3irPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKMPyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:54:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42078 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfKMPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:54:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so3128955ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 07:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzaxCU9q9z1LGi2aX0x3UARyQbOis5TAPoicbnH/6GI=;
        b=ZTZ3irPTvHiq3oCbBDUbbD9XD/s73seIp3GtBOlDaZU0YHv/XQjWAmUXVVDD7qQQPR
         0gsWzMVJunhqyjWB8I1AlD79yYu2dqlqgpXpZgQISfUz6h5ae0kvt1TpZJlvWMJ+Comf
         gF0R2d5jFeoAWlABzMuJG7g5Kw7nheyE985fUojj6aAeCXfxvbDMhb+ZqalMLkk7EPf3
         T1uF7g0aw8TGldwDJhrlbz91cc41N2ppLNpOfqgYvcrO4YytctRQdnGRWrVZxR422Y6Z
         YcCTos2NMU2S/kA2TVXLKzyW6Af9h+/P8twW1A20zVr0veZPNdN0G3Hm69prD4MxgKCs
         ThWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzaxCU9q9z1LGi2aX0x3UARyQbOis5TAPoicbnH/6GI=;
        b=BzKqskZAVNPKBVqo/2DfHx1wPDsGqGmO3kYkz/C6YMfruaWVMMgy6CuvsDvKzL/5Tw
         p8uiD4bnRqZIL0JYm/2arkng3UcJMNZE5psGp6PBCrqU+5m1PDWYvAod1M0SvlJhs3bN
         YyO4JI6vmvIqNTYpufHTtN+3A0T9p3YBC8tyAT8j5yyWO3YYQFKFfB/mnK6xB2jxjCvG
         DHszAarr7xps5UpB8HsO+gd6b3Kequ7qoNM1SPw7ug5tI66OKNW1UFZuDAlY6JEwPZy9
         NYuAMlCeDwlyqTv3Mf9ux6k9lRfdANXZZIFfQYVeXGek8iLncEg/ADTDGlLaXZPFHF4f
         CFDA==
X-Gm-Message-State: APjAAAU2/TIPECELP9oFi5+CwslThS3bnX74lsyb/CICBTbVuTxj1Vi/
        C8A1oxBc7mQ7yybZB2nZsgSTkeDrpvFrZ3NZbwU=
X-Google-Smtp-Source: APXvYqxjCHblaQ2q/rHynAtFsfDkEsZmifsqKl/aTu0GM9nvkBNV8Wug1C+MSPjVS3hOZ41xxvzmnvKe+DO9TF8H3Jg=
X-Received: by 2002:a2e:9947:: with SMTP id r7mr3176101ljj.104.1573660484386;
 Wed, 13 Nov 2019 07:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
 <20191014164110.GA58307@google.com> <CAMJBoFOqG8GYby-MLCgiYgsfntNP2hiX25WibxvUjpkLHvwsUQ@mail.gmail.com>
 <20191015200044.GA233697@google.com> <CAMJBoFM48tbay5B7VqvuNQrPkaXEvzG19n++Ke4p6cdSMCDQZw@mail.gmail.com>
 <20191030001054.GA175126@google.com>
In-Reply-To: <20191030001054.GA175126@google.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Wed, 13 Nov 2019 16:54:32 +0100
Message-ID: <CAMJBoFOLdoue3vvgBE2-t0nt4MX+Be6vE1APUNOeRKGoW=KUvA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow ZRAM to use any zpool-compatible backend
To:     Minchan Kim <minchan@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        "Theodore Ts'o" <tytso@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

On Wed, Oct 30, 2019 at 1:10 AM Minchan Kim <minchan@kernel.org> wrote:

<snip>
>
>
> I ran fio on x86 with various compression sizes.
>
> left is zsmalloc. right is z3fold
>
> The operation order is
>         seq-write
>         rand-write
>         seq-read
>         rand-read
>         mixed-seq
>         mixed-rand
>         trim
>         mem_used - byte unit
>
> Last column mem_used is to indicate how many allocator used the memory
> to store compressed page
>
> 1) compression ratio 75
>
>      WRITE     2535          WRITE     1928
>      WRITE     2425          WRITE     1886
>       READ     6211           READ     5731
>       READ     6339           READ     6182
>       READ     1791           READ     1592
>      WRITE     1790          WRITE     1591
>       READ     1704           READ     1493
>      WRITE     1699          WRITE     1489
>      WRITE      984          WRITE      974
>       TRIM      984           TRIM      974
>   mem_used 29986816       mem_used 61239296
>
> For every operation, zsmalloc is faster than z3fold.
> Even, it used the 1/2 memory compared to z3fold.
>
> 2) compression ratio 66
>
>      WRITE     2125          WRITE     1258
>      WRITE     2107          WRITE     1233
>       READ     5714           READ     5793
>       READ     5948           READ     6065
>       READ     1667           READ     1248
>      WRITE     1666          WRITE     1247
>       READ     1521           READ     1218
>      WRITE     1517          WRITE     1215
>      WRITE      943          WRITE      870
>       TRIM      943           TRIM      870
>   mem_used 38158336       mem_used 76779520
>
> For only read operation, z3fold is a bit faster than zsmalloc about 2%.
> However, look at other operations which zsmalloc is much faster.
> Even, look at used memory.
>
> 3) compression ratio 50
>
>      WRITE     2051          WRITE     1109
>      WRITE     2029          WRITE     1087
>       READ     5366           READ     6364
>       READ     5575           READ     5785
>       READ     1497           READ     1121
>      WRITE     1496          WRITE     1121
>       READ     1432           READ     1065
>      WRITE     1428          WRITE     1062
>      WRITE      930          WRITE      838
>       TRIM      930           TRIM      838
>   mem_used 59932672       mem_used 104873984
>
> sequential read on z3fold is faster about 15%. However, look at other
> operations and used memory. zsmalloc is better.

There are two things to this: the measurements you've taken as such
and how they are relevant to this discussion.
I'd be happy to discuss these measurements in a separate thread if you
specified more precisely what kind of x86 the measurements were taken
on.

However, my point was that there are rather common cases when people
want to use z3fold as a zRAM memory allocation backend. The fact that
there are other cases when people wouldn't want that is pretty natural
and doesn't need a proof.
That's why I propose to use ZRAM over zpool API for the sake of
flexibility. That would benefit various users of ZRAM and, at the end
of the day, the Linux kernel ecosystem.

<snip>
> Thanks for the testing. I also tried to test zbud with zram but failed because fio
> submit incompressible pages to zram even though it specifiy compress ratio 100%
> However, zbud doesn't support 4K page allocation so zram couldn't work on it
> at this moment. I tried various fio versions as well as old but everything failed.
>
> How did you test it successfully? Let me know your fio version.
> I want to investigate what's the performance bottleneck beside page copy
> so that I will optimize it.

You're very welcome. :) The patch to make zbud accept PAGE_SIZE pages
has been posted a while ago [1] and it was a part of our previous
(pre-z3fold) discussion on the same subject but you probably haven't
read it then.

> >
> > Now to the fun part.
> > zsmalloc:
> >   0 .text         00002908  0000000000000000  0000000000000000  00000040  2**2
> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> > zbud:
> >   0 .text         0000072c  0000000000000000  0000000000000000  00000040  2**2
> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> >
> > And this does not cover dynamic memory allocation overhead which is
> > higher for zsmalloc. So once again, given that the compression ratio
> > is low (e. g. a simple HW accelerator is used), what would most
> > unbiased people prefer to use in this case?
>
> Zsmalloc has more features than zbud. That's why you see the code size
> difference. It was intentional because at that time most of users were
> mobile phones, TV and other smart devices. They needed those features.
>
> We could make those feature turned off at build time, which will improve
> performance and reduce code size a lot. It would be no problem if the
> user wanted to use zbud which is alredy lacking of those features.

I do support this idea and would like to help as much as I can, but
why should the people who want to use ZRAM/zbud combo be left stranded
while we're working on reducing the zsmalloc code size by 4x?

With that said, let me also re-iterate that there may be more
allocators coming, and in some cases zsmalloc won't be a good
fit/alternative while there will be still a need for a compressed RAM
device. I hope you understand.

Best regards,
   Vitaly

[1] https://lore.kernel.org/patchwork/patch/598210/
