Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29927C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4002077C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfGSN20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:28:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39523 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfGSN20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:28:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so30881790qtu.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nnlqw3Kv3CZrLr1tsvetYOC12fuM5jTa5rjogKHkRHk=;
        b=CdCOn4eN95qYaAAXTVaS0hetaAGhQkvC6+5We5TY07HJL5cKq03ExoFsoe6i/BCmBX
         cWwmR8Cphhu1eU4fk5W4H6ji9gq2RDhayD4GLgpeFvVfr6yFlk44M70mf8tRae4sIXxh
         jLBa5iBtVy09f3R/VEaL6A+9IZhvm6zTt3/wIZpLFweCurfwJh+Qlas9dv0ssYH5v4UM
         8WYkms5QIqcERKqQ5McK0MKsQb54TD3nxGrYCWksj//ApCSTOiCrygVe3tlP6tUuIVj+
         d6CCzNNlu3uXT3amQAVBmBir54aO4+IOSRYS089X/DZT3t8YQBf+oTAW2NKHUV7+oZY/
         kccw==
X-Gm-Message-State: APjAAAV+9/CuqjZTbGQx9K+zGFLeSBvxxszGbse6hihF1bz6sNChfAvd
        /TeAtOhuma++593tZOn+MUeAeyf4nUwmSBwe0j95/b8AXmQ=
X-Google-Smtp-Source: APXvYqzIwTHiEwMwhv1NzYtpQLA08KLiR7lPaTytc76htDKB/elNqRfFHnkfCtdEriDcN13yVJr6Gnq/O6CD1t2BIR4=
X-Received: by 2002:a0c:e952:: with SMTP id n18mr35962248qvo.63.1563542905500;
 Fri, 19 Jul 2019 06:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190719113139.4005262-1-arnd@arndb.de> <20190719121336.GB28960@lst.de>
 <CAK8P3a09YuLbQrfC61VMg_v3h+pA-QZBnW7i45AG6asPgMuoGg@mail.gmail.com>
In-Reply-To: <CAK8P3a09YuLbQrfC61VMg_v3h+pA-QZBnW7i45AG6asPgMuoGg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Jul 2019 15:28:09 +0200
Message-ID: <CAK8P3a3j0opg-1yUt4sAU+fxCvk0bKBoJKc16jyPUPmyHEr0hg@mail.gmail.com>
Subject: Re: [PATCH] [v2] blkdev: always export SECTOR_SHIFT
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 3:14 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 19, 2019 at 2:13 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > > +/*
> > > + * The basic unit of block I/O is a sector. It is used in a number of contexts
> > > + * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
> > > + * bytes. Variables of type sector_t represent an offset or size that is a
> > > + * multiple of 512 bytes. Hence these two constants.
> > > + */
> > > +#ifndef SECTOR_SHIFT
> > > +#define SECTOR_SHIFT 9
> > > +#endif
> > > +#ifndef SECTOR_SIZE
> > > +#define SECTOR_SIZE (1 << SECTOR_SHIFT)
> > > +#endif
> >
> > While we're at it we really should drop the ifndefs.
>
> Good idea. Needs some more build testing then.

Did not take long:

In file included from block/partitions/msdos.c:24:
In file included from block/partitions/check.h:3:
include/linux/blkdev.h:15:9: error: 'SECTOR_SIZE' macro redefined
[-Werror,-Wmacro-redefined]
#define SECTOR_SIZE (1 << SECTOR_SHIFT)
        ^
include/uapi/linux/msdos_fs.h:14:9: note: previous definition is here
#define SECTOR_SIZE     512             /* sector size (bytes) */
        ^

This could clearly be fixed as well, but I suspect we're better off not touching
it any further than necessary.

       Arnd
