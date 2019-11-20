Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94F0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D79C2088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cFv2Z33Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfKTS5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:57:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40865 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfKTS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:57:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so312560ljg.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOSs8GWh4nvdHvITwvOT+7DGX4JWzvhey5FOjHknUSw=;
        b=cFv2Z33QNS8FpfuHutXCBQyQhPSIGwX+LfOwGlTR9vLXVSoIDDnfRthMyiahTGOfjw
         chxSXEuCrJqyhTSt7qt57KAxvGZjWprcx5G5hWWzVEXyEoSM3S7xUECA5GQrbjqImzbS
         1z/i9s/QZ4KTGxDmOI5d8yt2FH4zlKyIs6KYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOSs8GWh4nvdHvITwvOT+7DGX4JWzvhey5FOjHknUSw=;
        b=cQleTkIpOSJYDHAlkR5T/MbF04PTw6DCMDJouc8VoVOYG/w/1ATR/2ewEzcVfyfJqH
         xKIGUdQ4ygNoG3a7lSaw99wk55ARmFsnIYQzQBPzQ+uxLqmNpubuQnHiT+jdN2eTfYV8
         erYwUD4LN5VzouTisGWOloZ8cqA8hEYz8Q4LqlGjoRXkyU0n6oX25fZzz7c5i1ElhEYU
         +l52CxWMYAhxK6PiUpAavgYiZnrdkNYcLW6WxOP/NeDAdqur42S4Xn+irmoSG1rWHcZd
         1gHbZyDyZ0X/H1+9/mbtTlbNs7+JoOAe2JeBmHixctY3JaXTklrZJZfhYyHwkCRvpdDT
         CRiQ==
X-Gm-Message-State: APjAAAWkmOX8wPVhLjA8h5JgzhEHgEc4kmDoSf1lgn1n2KU4R1gg0UoZ
        d4U/Tv4DtNNlk3SL+fedh+/hhYcikNM=
X-Google-Smtp-Source: APXvYqx3HzjaMZ4lnIszSAHd0uWE5mXuG9AyLnIqbPuQEpKFXTmCLkZ087X1hB0bcgg2I+OgOtookA==
X-Received: by 2002:a2e:7607:: with SMTP id r7mr4229245ljc.37.1574276228108;
        Wed, 20 Nov 2019 10:57:08 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 28sm13232182lfy.38.2019.11.20.10.57.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 10:57:07 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id b20so421369lfp.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:57:06 -0800 (PST)
X-Received: by 2002:ac2:5597:: with SMTP id v23mr1072977lfg.79.1574276226377;
 Wed, 20 Nov 2019 10:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20191114235008.185111-1-evgreen@chromium.org> <20191114154903.v7.2.I4d476bddbf41a61422ad51502f4361e237d60ad4@changeid>
 <20191120022518.GU6235@magnolia>
In-Reply-To: <20191120022518.GU6235@magnolia>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 20 Nov 2019 10:56:30 -0800
X-Gmail-Original-Message-ID: <CAE=gft4mjKc4QKFKxp2FX9G2rUMuE3_eDuW_3Oq7NqTYBQwEjg@mail.gmail.com>
Message-ID: <CAE=gft4mjKc4QKFKxp2FX9G2rUMuE3_eDuW_3Oq7NqTYBQwEjg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] loop: Better discard support for block devices
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 6:25 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Nov 14, 2019 at 03:50:08PM -0800, Evan Green wrote:
> > If the backing device for a loop device is itself a block device,
> > then mirror the "write zeroes" capabilities of the underlying
> > block device into the loop device. Copy this capability into both
> > max_write_zeroes_sectors and max_discard_sectors of the loop device.
> >
> > The reason for this is that REQ_OP_DISCARD on a loop device translates
> > into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> > presents a consistent interface for loop devices (that discarded data
> > is zeroed), regardless of the backing device type of the loop device.
> > There should be no behavior change for loop devices backed by regular
> > files.
> >
> > This change fixes blktest block/003, and removes an extraneous
> > error print in block/013 when testing on a loop device backed
> > by a block device that does not support discard.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > ---
> >
> > Changes in v7:
> > - Rebase on top of Darrick's patch
> > - Tweak opening line of commit description (Darrick)
> >
> > Changes in v6: None
> > Changes in v5:
> > - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> >
> > Changes in v4:
> > - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> >
> > Changes in v3:
> > - Updated commit description
> >
> > Changes in v2: None
> >
> >  drivers/block/loop.c | 40 +++++++++++++++++++++++++++++-----------
> >  1 file changed, 29 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 6a9fe1f9fe84..e8f23e4b78f7 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -427,11 +427,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> >        * information.
> >        */
> >       struct file *file = lo->lo_backing_file;
> > +     struct request_queue *q = lo->lo_queue;
> >       int ret;
> >
> >       mode |= FALLOC_FL_KEEP_SIZE;
> >
> > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > +     if (!blk_queue_discard(q)) {
> >               ret = -EOPNOTSUPP;
> >               goto out;
> >       }
> > @@ -862,6 +863,21 @@ static void loop_config_discard(struct loop_device *lo)
> >       struct file *file = lo->lo_backing_file;
> >       struct inode *inode = file->f_mapping->host;
> >       struct request_queue *q = lo->lo_queue;
> > +     struct request_queue *backingq;
> > +
> > +     /*
> > +      * If the backing device is a block device, mirror its zeroing
> > +      * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> > +      * by block devices to keep consistent behavior with file-backed loop
> > +      * devices.
> > +      */
> > +     if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> > +             backingq = bdev_get_queue(inode->i_bdev);
> > +             blk_queue_max_discard_sectors(q,
> > +                     backingq->limits.max_write_zeroes_sectors);
>
> max_discard_sectors?

I didn't plumb max_discard_sectors because for my scenario it never
ends up hitting the block device that way.

The loop device either uses FL_ZERO_RANGE or FL_PUNCH_HOLE. When
backed by a block device, that ends up in blkdev_fallocate(), which
always translates both of those into blkdev_issue_zeroout(), not
blkdev_issue_discard(). So it's really the zeroing capabilities of the
block device that matters, even for loop discard operations. It seems
weird, but I think this is the right thing because it presents a
consistent interface to loop device users whether backed by a file
system file, or directly by a block device. That is, a previously
discarded range will read back as zeroes.

-Evan
