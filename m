Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E6AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF12522522
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lAn6FgwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgACSMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:12:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46784 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgACSMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:12:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id p67so14714653oib.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3brJhWTSesWIRxDSnHgjF8nIZbts1Wu314rZzjXn1M=;
        b=lAn6FgwQQMYzkHNrvN1rRFNYVp+0/0fgWehxuV9jdkjbcq9UCjg/LWklrQMinMlTD+
         rjYhtgI2mNvRwWUnxAh3hV7ai1xjTahx4eD0I1E9IdQ4AWpZK0J6emaWKMy8TPy41pKP
         h63PGVQD/FEUvYx/yJwAhI8+3ooXUTbsu+MiCIAAHl1x2cxQqUlcp3d01qkIiWnF0sdv
         N2jvz2p8Z951aXN0UyUCkTU2WzwTU9HH0ZeLgyQzMMEl2rsW74FOlfswuDQP5Pw2wqYc
         ECOLx9irUQlfTHxACK2Lo5WiAl8FxMN5h06QpbaSb3r19c6QAS8YIyYY0iE0yDWNxke9
         SqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3brJhWTSesWIRxDSnHgjF8nIZbts1Wu314rZzjXn1M=;
        b=L6r9LLLcHLZt6YhAbu9EzKBWDsqYa7FyRD39gmqwmIeq/epSjvIrS7B3u7GtXOMAsT
         pMR9RDKqrDtW3CoOQZa4hp0Mn8Q38BsmBfPzIsR7AGIGx+yglDVJXNrPi9+pOELixC5L
         DpYnLfsNoZnO+dU1PCNtEkAmgsOieWLa53M2NxWHgsAa82/F96uG8xMVJiXkjl/cWONI
         PtLP4kZYJ1vGpIzgZ8qkmEzPK/F/7WzLTdHAeQGoPMec2mak9SytkGcEspzOLKWAZfBK
         u4PO9A0k9WI6HsNDRSPTVZZ1IS+v8Bav8aMkiVLBRLYm9rmORL6nhAanFr7O6bEVtLiV
         j8eA==
X-Gm-Message-State: APjAAAVOUIWQ4iWJK0Cjq3QEFIHm5lQT3Ng9vKZSmjq7DRcMYCQvlZnR
        aM1k+IODk3t+hBq6m11//eZTNPXQs96TYQYhS9cjsw==
X-Google-Smtp-Source: APXvYqxNvahWxntDLEIKUszdbRJxBKjKuUGiDqlTVmO0biL4kYnJB9fAtU7+SaWNBxJZ6Rlsg/jaWbQJSirwoQgnbaI=
X-Received: by 2002:aca:3b44:: with SMTP id i65mr4303906oia.70.1578075140713;
 Fri, 03 Jan 2020 10:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org> <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com> <20200103141235.GA13350@redhat.com>
In-Reply-To: <20200103141235.GA13350@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Jan 2020 10:12:09 -0800
Message-ID: <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 6:12 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Aug 26, 2019 at 04:58:29PM -0400, Vivek Goyal wrote:
> > On Mon, Aug 26, 2019 at 04:33:26PM -0400, Vivek Goyal wrote:
> > > On Mon, Aug 26, 2019 at 04:53:16AM -0700, Christoph Hellwig wrote:
> > > > On Wed, Aug 21, 2019 at 01:57:03PM -0400, Vivek Goyal wrote:
> > > > > Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
> > > > > is searched from that bdev name.
> > > > >
> > > > > virtio-fs does not have a bdev. So pass in dax_dev also to
> > > > > dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
> > > > > used otherwise dax_dev is searched using bdev.
> > > >
> > > > Please just pass in only the dax_device and get rid of the block device.
> > > > The callers should have one at hand easily, e.g. for XFS just call
> > > > xfs_find_daxdev_for_inode instead of xfs_find_bdev_for_inode.
> > >
> > > Sure. Here is the updated patch.
> > >
> > > This patch can probably go upstream independently. If you are fine with
> > > the patch, I can post it separately for inclusion.
> >
> > Forgot to update function declaration in case of !CONFIG_FS_DAX. Here is
> > the updated patch.
> >
> > Subject: dax: Pass dax_dev instead of bdev to dax_writeback_mapping_range()
> >
> > As of now dax_writeback_mapping_range() takes "struct block_device" as a
> > parameter and dax_dev is searched from bdev name. This also involves taking
> > a fresh reference on dax_dev and putting that reference at the end of
> > function.
> >
> > We are developing a new filesystem virtio-fs and using dax to access host
> > page cache directly. But there is no block device. IOW, we want to make
> > use of dax but want to get rid of this assumption that there is always
> > a block device associated with dax_dev.
> >
> > So pass in "struct dax_device" as parameter instead of bdev.
> >
> > ext2/ext4/xfs are current users and they already have a reference on
> > dax_device. So there is no need to take reference and drop reference to
> > dax_device on each call of this function.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>
> Hi Dan,
>
> Ping for this patch. I see christoph and Jan acked it. Can we take it. Not
> sure how to get ack from ext4 developers.

Jan counts for ext4, I just missed this. Now merged.
