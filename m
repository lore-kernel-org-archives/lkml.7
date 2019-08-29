Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD15C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD482073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ESaJoc8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfH2AEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 20:04:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42757 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfH2AEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 20:04:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id j7so1624337ota.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9V1I2O+TivEgbBfrL+sbjQm1nhJ9MH50acKxm7Jxy80=;
        b=ESaJoc8uAcMghQKXnUGzQAUXuyljQbXi8D9tnbGffCiBjVzZuOXCax8X2qwURhna8D
         ZCii/AXaKhwWr4hlRiHLcZ2NkaEVT4y9nfs/aJf8phUBTO5AwR8KTXRZurFFafCjLRhd
         OY1VXkibH9HabUYOOfTgCyiw8cBHoj6YGzW1YRj33glxC4a0hjLp6bsL2Q74qKKC1DM4
         hGhKheWRBV0QQd9KYQXbvrdnWI7S30xJ8O484RMAId2aedVlxTJHFFgkevMGBuf5JDwI
         s88SmUnmj6LY0LPGMVexZlcan5Vud1uQzml64dgeu8YJZO+YkEohexOj5GRTXIpu3dam
         wc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9V1I2O+TivEgbBfrL+sbjQm1nhJ9MH50acKxm7Jxy80=;
        b=rcy/GG8C6ZvlTh9JYWMyX+/i9YzKIRkSMVlDxXDZWeYoHVaZfqLGt5a6br3PFc/VPD
         F6OPHBK1VkSw/u6H54CBODZH77zT6vFfsyEnL4gTrVBl4HDlZNyZC4mOlHegMsF66Yeg
         W5K+ALIC0arDli8smDAdBiew6wWXxDBit3FqtWMhSHO5oSSfLRjxBpx6aDYvLMMih0dM
         s9HZMgmlsDX2p/7YuwPoe6AHSbNNbVChTc8O2syEgBRjD4u/qVlnAzacp2L0rzNQlHqA
         yBWT0ql/WJHND6Vv9vESk5i3AdFLDL/fq1y0WpSUJof7bJkIXJ7yoE8n8epdj4Il6adf
         NTdg==
X-Gm-Message-State: APjAAAWVLGwPH5u7vV9T8XgUmrluK64oQDR2GABJgvGeOsPh3ysfq7aO
        eQnwJHUiOtdZsjD2XrP46D7fGCXSbnIkBc+q9tPaeQ==
X-Google-Smtp-Source: APXvYqw9NltuXUDjLqBgr7ARTZxSXB64T52L8qLE03K+SnICANvhCQNurFmsvJfjCF782hyug4nnoI73YcgZgqRJ+Zo=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr5658299otq.363.1567037063279;
 Wed, 28 Aug 2019 17:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org> <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org> <20190828175843.GB912@redhat.com> <20190828225322.GA7777@dread.disaster.area>
In-Reply-To: <20190828225322.GA7777@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 28 Aug 2019 17:04:11 -0700
Message-ID: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Dave Chinner <david@fromorbit.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 3:53 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Aug 28, 2019 at 01:58:43PM -0400, Vivek Goyal wrote:
> > On Tue, Aug 27, 2019 at 11:58:09PM -0700, Christoph Hellwig wrote:
> > > On Tue, Aug 27, 2019 at 12:38:28PM -0400, Vivek Goyal wrote:
> > > > > For bdev_dax_pgoff
> > > > > I'd much rather have the partition offset if there is on in the daxdev
> > > > > somehow so that we can get rid of the block device entirely.
> > > >
> > > > IIUC, there is one block_device per partition while there is only one
> > > > dax_device for the whole disk. So we can't directly move bdev logical
> > > > offset into dax_device.
> > >
> > > Well, then we need to find a way to get partitions for dax devices,
> > > as we really should not expect a block device hiding behind a dax
> > > dev.  That is just a weird legacy assumption - block device need to
> > > layer on top of the dax device optionally.
> > >
> > > >
> > > > We probably could put this in "iomap" and leave it to filesystems to
> > > > report offset into dax_dev in iomap that way dax generic code does not
> > > > have to deal with it. But that probably will be a bigger change.
> > >
> > > And where would the file system get that information from?
> >
> > File system knows about block device, can it just call get_start_sect()
> > while filling iomap->addr. And this means we don't have to have
> > parition information in dax device. Will something like following work?
> > (Just a proof of concept patch).
> >
> >
> > ---
> >  drivers/dax/super.c |   11 +++++++++++
> >  fs/dax.c            |    6 +++---
> >  fs/ext4/inode.c     |    6 +++++-
> >  include/linux/dax.h |    1 +
> >  4 files changed, 20 insertions(+), 4 deletions(-)
> >
> > Index: rhvgoyal-linux/fs/ext4/inode.c
> > ===================================================================
> > --- rhvgoyal-linux.orig/fs/ext4/inode.c       2019-08-28 13:51:16.051937204 -0400
> > +++ rhvgoyal-linux/fs/ext4/inode.c    2019-08-28 13:51:44.453937204 -0400
> > @@ -3589,7 +3589,11 @@ retry:
> >                       WARN_ON_ONCE(1);
> >                       return -EIO;
> >               }
> > -             iomap->addr = (u64)map.m_pblk << blkbits;
> > +             if (IS_DAX(inode))
> > +                     iomap->addr = ((u64)map.m_pblk << blkbits) +
> > +                                   (get_start_sect(iomap->bdev) * 512);
> > +             else
> > +                     iomap->addr = (u64)map.m_pblk << blkbits;
>
> I'm not a fan of returning a physical device sector address from an
> interface where ever other user/caller expects this address to be a
> logical block address into the block device. It creates a landmine
> in the iomap API that callers may not be aware of and that's going
> to cause bugs. We're trying really hard to keep special case hacks
> like this out of the iomap infrastructure, so on those grounds alone
> I'd suggest this is a dead end approach.
>
> Hence I think that if the dax device needs a physical offset from
> the start of the block device the filesystem sits on, it should be
> set up at dax device instantiation time and so the filesystem/bdev
> never needs to be queried again for this information.
>

Agree. In retrospect it was my laziness in the dax-device
implementation to expect the block-device to be available.

It looks like fs_dax_get_by_bdev() is an intercept point where a
dax_device could be dynamically created to represent the subset range
indicated by the block-device partition. That would open up more
cleanup opportunities.
