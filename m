Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA77CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A88220811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VjW+JUp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfC1Txr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:53:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45384 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfC1Txr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:53:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so18743989ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYGWnhIks4l2MvbVr4OOzOvA1DR9kZHEkMjqKsutwJM=;
        b=VjW+JUp5Ow5m9ugk5lKNG7c/n8KEWjzx0UMl+kEyhgEl7A3xmAvyRKOSGjILTj4+87
         UE7mUw3gu9Z2gKO7K/ltJa/GA1xsUJSXm4ZD6DdtxBrtls9bKKCfKFOEyT1llNgDNgVQ
         0SRSECwP4XyBRt0ngrU3t/ySAuGyHYVxiN6gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYGWnhIks4l2MvbVr4OOzOvA1DR9kZHEkMjqKsutwJM=;
        b=IKk+mhbB1CIlqlM+1eiyOCdtTaS9bNLrlf8WIWv9TqvMmmdvY5tx4X8vBvmnYyu7KO
         MHIOglOIA6tC65Ak1Jem/lpd2QQF7g2iYHlnPf3k4sIqbKRolfnBCP16Bc3Q+MC4wK7n
         PQNq/hvIcHxTqJgb/ij2i/eRjDVTlYPxiwBfYcsI+Kxd4XLNkStgz7UGAGcioZ2b8M/J
         Mtlj+w8Viu+9MkKLBte6LTV+75m2vLAHxzcsk9FgBIPKvTSr/TVdlJAuHBGfEzXfNLKr
         7ox1FCNbbJ69HxOOfKBo7jW8X56CXhIEsCurfCkl55A8pZKbdV6QIqNrjmJU2J5vTXey
         mxTw==
X-Gm-Message-State: APjAAAVg/UCDa1+gmjd/35ScxGQl41MvUZIuhL5NYVP8+Dt1MuqENQFM
        U1t0Zx6u9qJPouPS1d+rvjA69MuWQK8=
X-Google-Smtp-Source: APXvYqxei1rkl5vOLHVtjhFR/ql7Xoqb+cFpjDEDbuN8UvJTrVyqWV+RaEBvTbqdIFtfSTbP/bG7Ig==
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr15456330lji.94.1553802824809;
        Thu, 28 Mar 2019 12:53:44 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x6sm5177793lfe.67.2019.03.28.12.53.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:53:43 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h21so176430ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:53:43 -0700 (PDT)
X-Received: by 2002:a2e:6507:: with SMTP id z7mr10807300ljb.147.1553802823297;
 Thu, 28 Mar 2019 12:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190327222841.38650-1-evgreen@chromium.org> <20190327222841.38650-3-evgreen@chromium.org>
 <20190328023650.GD19708@ming.t460p>
In-Reply-To: <20190328023650.GD19708@ming.t460p>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 28 Mar 2019 12:53:06 -0700
X-Gmail-Original-Message-ID: <CAE=gft7AXQ1t_oeJRpytD26A=hAPp3G-g5SY0MvxzZAGYJGaSA@mail.gmail.com>
Message-ID: <CAE=gft7AXQ1t_oeJRpytD26A=hAPp3G-g5SY0MvxzZAGYJGaSA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] loop: Better discard support for block devices
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 7:37 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, Mar 27, 2019 at 03:28:41PM -0700, Evan Green wrote:
...
> > @@ -854,6 +854,25 @@ static void loop_config_discard(struct loop_device *lo)
> >       struct file *file = lo->lo_backing_file;
> >       struct inode *inode = file->f_mapping->host;
> >       struct request_queue *q = lo->lo_queue;
> > +     struct request_queue *backingq;
> > +
> > +     /*
> > +      * If the backing device is a block device, mirror its discard
> > +      * capabilities.
> > +      */
> > +     if (S_ISBLK(inode->i_mode)) {
> > +             backingq = bdev_get_queue(inode->i_bdev);
> > +             blk_queue_max_discard_sectors(q,
> > +                     backingq->limits.max_discard_sectors);
> > +
> > +             blk_queue_max_write_zeroes_sectors(q,
> > +                     backingq->limits.max_write_zeroes_sectors);
> > +
> > +             q->limits.discard_granularity =
> > +                     backingq->limits.discard_granularity;
> > +
> > +             q->limits.discard_alignment =
> > +                     backingq->limits.discard_alignment;
>
> Loop usually doesn't mirror backing queue's limits, and I believe
> it isn't necessary for this case too, just wondering why the
> following simple setting can't work?
>
>         if (S_ISBLK(inode->i_mode)) {
>                 backingq = bdev_get_queue(inode->i_bdev);
>
>                 q->limits.discard_alignment = 0;
>                 if (!blk_queue_discard(backingq)) {
>                         q->limits.discard_granularity = 0;
>                         blk_queue_max_discard_sectors(q, 0);
>                         blk_queue_max_write_zeroes_sectors(q, 0);
>                         blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
>                 } else {
>                         q->limits.discard_granularity = inode->i_sb->s_blocksize;
>                         blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
>                         blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
>                         blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
>                 }
>         } else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
>                 ...
>         }
>
> I remembered you mentioned the above code doesn't work in some of your
> tests, but never explain the reason. However, it is supposed to work
> given bio splitting does handle/respect the discard limits. Or is there
> bug in bio splitting on discard IO?

I've done some more digging, and I think I have an answer for you,
with some proposed changes to the patch.

My original answer was going to be that REQ_OP_DISCARD and
REQ_OP_WRITE_ZEROES are different. So I have an NVMe device that does
support discard, but does not support write_zeroes, and should mirror
those capabilities individually to most accurately reflect the
underlying block device. But then I noticed that this device still
prints the error log I was trying to get rid of when doing mkfs.ext4,
so my fix is incomplete.

The reason is that I have the following translation between REQ_OP_*
and FALLOC_FL_*:
REQ_OP_DISCARD ==> FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE
REQ_OP_WRITE_ZEROES ==> FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE

This makes sense for loop devices backed by regular files, and I think
is the right mapping. But for loop devices backed by block devices,
blkdev_fallocate() translates both of these sets of flags into
blkdev_issue_zeroout(), rather than blkdev_issue_discard() for
REQ_OP_DISCARD (since I wasn't setting FALLOC_FL_NO_HIDE_STALE).

I think this set of flags still makes sense for block devices, since
it keeps a consistent behavior for loop devices backed by files and
block devices (namely, that the discarded space is always zeroed).
However it means that for my NVMe that supports discard (never used)
but not write_zeroes (always tried), loop devices backed directly by
this NVMe should not set the discard flag.

So I think what I should actually have is this:

if (S_ISBLK(inode->i_mode)) {
        backingq = bdev_get_queue(inode->i_bdev);
        blk_queue_max_discard_sectors(q,
                backingq->limits.max_write_zeroes_sectors);  /// Note
the difference here.

        blk_queue_max_write_zeroes_sectors(q,
                backingq->limits.max_write_zeroes_sectors);
} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) { ... }
...
if (q->limits.max_write_zeroes_sectors)
        blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
else
        blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);

I can confirm that this fixes the errors for my NVMe as well.

What do you think?
-Evan
