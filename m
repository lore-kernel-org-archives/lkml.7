Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7288C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F94D20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfGSNPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:15:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41484 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfGSNPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:15:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so30793515qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptGDwCDpu9YnHGwrKzTO0V91FxCe9oG3xvjTeoByl+k=;
        b=KrbgCCt0/UgMjjVthWk9fQ6YuPvU2oy9IlL2IDSxsgI6bOYme2n5LFOejs0bexk7Yw
         M1pFebhxHwpQbN0LEbtBN6myru1lfs8bLEfnZmQK7GdeYi3HO7igthPHe/cI8ZsCCgdD
         9Ce1IB6SOf12HSuFIC09gfGO7EW4/XgP2+OMS2TDblOf7bp5302+W/Rti3vtD2A2jbIO
         0pxtJMCz/+5jrfdUYXJvS/RTiwT4mJP0++TFgj+vXehaA9rygXUQUri4KOv234rhGAUc
         JV4PZEp5z+YRpLRWEBKtOizpOsfUfcF9BLTSDZA4Z8i5NPTJLR4g84Yhn+UeWOyfwGr3
         iEfA==
X-Gm-Message-State: APjAAAUwYVvE2AFiidG2oV/sH/RalZeWHHvaiIOAfL540yhrQ/SA50s9
        gRSLd3VSkU0QYnMUCcIXzncGJHLiX9Q2F9W9rBk=
X-Google-Smtp-Source: APXvYqzY13nirnasX8ZIoxFUjkrIIuouACjPWbI3iJWRVQ0C6F/h405AUZKMhgvUgCBy9ly7Jon4UyGpUM0aoharp34=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr36183443qtd.18.1563542109745;
 Fri, 19 Jul 2019 06:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190719113139.4005262-1-arnd@arndb.de> <20190719121336.GB28960@lst.de>
In-Reply-To: <20190719121336.GB28960@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Jul 2019 15:14:52 +0200
Message-ID: <CAK8P3a09YuLbQrfC61VMg_v3h+pA-QZBnW7i45AG6asPgMuoGg@mail.gmail.com>
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

On Fri, Jul 19, 2019 at 2:13 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +/*
> > + * The basic unit of block I/O is a sector. It is used in a number of contexts
> > + * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
> > + * bytes. Variables of type sector_t represent an offset or size that is a
> > + * multiple of 512 bytes. Hence these two constants.
> > + */
> > +#ifndef SECTOR_SHIFT
> > +#define SECTOR_SHIFT 9
> > +#endif
> > +#ifndef SECTOR_SIZE
> > +#define SECTOR_SIZE (1 << SECTOR_SHIFT)
> > +#endif
>
> While we're at it we really should drop the ifndefs.

Good idea. Needs some more build testing then.

> Otherwise looks good.
>
> In fact given that sector_t is in linux/types.h I wonder if these
> should just move there.

Less sure about that, we don't really have other constants in that
file, just typedefs and a few common structures.

    ARnd
