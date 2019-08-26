Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B297C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532B92186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KB19yNqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfHZVdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:33:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36356 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfHZVdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:33:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so16686722otr.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=addQr9bC2wmMaOpWzp5KHixoxZuk44VTTnG3FHz50ro=;
        b=KB19yNqe2JAyNdzPN93BH99s0SUUx4ly84Dg+4BhMZSnUtjRsgn1CtyZkk45Rg9IZz
         Rch9ySnRAVAkgyrrsg2oJuq3zJPuBF0wbnoZXojIoOPlK7GJjU78phO75hePgy99qNJJ
         4W7h+BXdL23ATAaiL+3u0fS6tnTdMb6hQq+IexH5BwTUvRW8ADRES45cItBkNr3sxEco
         lxcLEukToOMG1qoky8nHKT8gqgrMJhfkGoEVqWjxcEQtqrw9BICZ1xZ6ze+048v+vHFn
         5dGXWwcjEp9ea1R0z4blVj6VALBMF6hVCLufXjBS0+9Gm1gvp/C21pOA6gU2EArJ5AXi
         H9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=addQr9bC2wmMaOpWzp5KHixoxZuk44VTTnG3FHz50ro=;
        b=iJHpQa5MpKwC4DPCj2glBiG5wAsHMBjgZYUmkdxG0QvpLptGPKVkI1t/Xw3JdASAsR
         IkX+In9x4Tsi57H1IYoAXYHT4DunSfS3OEgoDn58g1C8nUTOW3X1wbvQ+ae1kbcIdD6x
         CgSRLTaptKXVXgR3l6Xh7khJ4or2jp+BmNaM5ImIY2aRmKoczQdCax7E9WACoNkv6Ad5
         usW7nDTh0tRoueuVH8CUi/TFZ3rTQ1LtUE9cOJZoHvAGZluRAR2vkgkSNuyLFkeg7yKV
         4vFL2F+UISRWp9TdwS1RFhlJx7YA8Tf3sd19e/qAyXuEroYujSacQxSPjygS5sqrZw1n
         f4aQ==
X-Gm-Message-State: APjAAAUD6/1Zym8zDJozlSOCSpZkXwUykHBwUmrgRJz8mr1XP5/kkFBF
        lUGE6OI1RcnahrwMu7Jypv27hCK2a/fr5A0MKRGY0YTX
X-Google-Smtp-Source: APXvYqzdmrCxPsLGkwxNLbv0nCYfX5WN2PH0oFBVdK2D57wEJrFA0ck2wwQinKWCopRImeLq6iaGhc0qX19J1KqtxKY=
X-Received: by 2002:a05:6830:1e05:: with SMTP id s5mr16213861otr.247.1566855197160;
 Mon, 26 Aug 2019 14:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org> <20190826203326.GB13860@redhat.com> <20190826205829.GC13860@redhat.com>
In-Reply-To: <20190826205829.GC13860@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Aug 2019 14:33:04 -0700
Message-ID: <CAPcyv4htarWQysXZh8JDh3mMBNM4WtVs7yL70LGOZ1mQg5bEFA@mail.gmail.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Jan ]

On Mon, Aug 26, 2019 at 1:58 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Aug 26, 2019 at 04:33:26PM -0400, Vivek Goyal wrote:
> > On Mon, Aug 26, 2019 at 04:53:16AM -0700, Christoph Hellwig wrote:
> > > On Wed, Aug 21, 2019 at 01:57:03PM -0400, Vivek Goyal wrote:
> > > > Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
> > > > is searched from that bdev name.
> > > >
> > > > virtio-fs does not have a bdev. So pass in dax_dev also to
> > > > dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
> > > > used otherwise dax_dev is searched using bdev.
> > >
> > > Please just pass in only the dax_device and get rid of the block device.
> > > The callers should have one at hand easily, e.g. for XFS just call
> > > xfs_find_daxdev_for_inode instead of xfs_find_bdev_for_inode.
> >
> > Sure. Here is the updated patch.
> >
> > This patch can probably go upstream independently. If you are fine with
> > the patch, I can post it separately for inclusion.
>
> Forgot to update function declaration in case of !CONFIG_FS_DAX. Here is
> the updated patch.
>
> Subject: dax: Pass dax_dev instead of bdev to dax_writeback_mapping_range()
>
> As of now dax_writeback_mapping_range() takes "struct block_device" as a
> parameter and dax_dev is searched from bdev name. This also involves taking
> a fresh reference on dax_dev and putting that reference at the end of
> function.
>
> We are developing a new filesystem virtio-fs and using dax to access host
> page cache directly. But there is no block device. IOW, we want to make
> use of dax but want to get rid of this assumption that there is always
> a block device associated with dax_dev.
>
> So pass in "struct dax_device" as parameter instead of bdev.
>
> ext2/ext4/xfs are current users and they already have a reference on
> dax_device. So there is no need to take reference and drop reference to
> dax_device on each call of this function.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c            |    8 +-------
>  fs/ext2/inode.c     |    5 +++--
>  fs/ext4/inode.c     |    2 +-
>  fs/xfs/xfs_aops.c   |    2 +-
>  include/linux/dax.h |    4 ++--

Looks good to me. Would be nice to get some ext4 and xfs acks then
I'll take it through the dax tree for v5.4.

>  5 files changed, 8 insertions(+), 13 deletions(-)
>
> Index: rhvgoyal-linux-fuse/fs/dax.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/dax.c   2019-08-26 16:45:26.093710196 -0400
> +++ rhvgoyal-linux-fuse/fs/dax.c        2019-08-26 16:45:29.462710196 -0400
> @@ -936,12 +936,11 @@ static int dax_writeback_one(struct xa_s
>   * on persistent storage prior to completion of the operation.
>   */
>  int dax_writeback_mapping_range(struct address_space *mapping,
> -               struct block_device *bdev, struct writeback_control *wbc)
> +               struct dax_device *dax_dev, struct writeback_control *wbc)
>  {
>         XA_STATE(xas, &mapping->i_pages, wbc->range_start >> PAGE_SHIFT);
>         struct inode *inode = mapping->host;
>         pgoff_t end_index = wbc->range_end >> PAGE_SHIFT;
> -       struct dax_device *dax_dev;
>         void *entry;
>         int ret = 0;
>         unsigned int scanned = 0;
> @@ -952,10 +951,6 @@ int dax_writeback_mapping_range(struct a
>         if (!mapping->nrexceptional || wbc->sync_mode != WB_SYNC_ALL)
>                 return 0;
>
> -       dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
> -       if (!dax_dev)
> -               return -EIO;
> -
>         trace_dax_writeback_range(inode, xas.xa_index, end_index);
>
>         tag_pages_for_writeback(mapping, xas.xa_index, end_index);
> @@ -976,7 +971,6 @@ int dax_writeback_mapping_range(struct a
>                 xas_lock_irq(&xas);
>         }
>         xas_unlock_irq(&xas);
> -       put_dax(dax_dev);
>         trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
>         return ret;
>  }
> Index: rhvgoyal-linux-fuse/include/linux/dax.h
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/include/linux/dax.h        2019-08-26 16:45:26.094710196 -0400
> +++ rhvgoyal-linux-fuse/include/linux/dax.h     2019-08-26 16:46:08.101710196 -0400
> @@ -141,7 +141,7 @@ static inline void fs_put_dax(struct dax
>
>  struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
>  int dax_writeback_mapping_range(struct address_space *mapping,
> -               struct block_device *bdev, struct writeback_control *wbc);
> +               struct dax_device *dax_dev, struct writeback_control *wbc);
>
>  struct page *dax_layout_busy_page(struct address_space *mapping);
>  dax_entry_t dax_lock_page(struct page *page);
> @@ -180,7 +180,7 @@ static inline struct page *dax_layout_bu
>  }
>
>  static inline int dax_writeback_mapping_range(struct address_space *mapping,
> -               struct block_device *bdev, struct writeback_control *wbc)
> +               struct dax_device *dax_dev, struct writeback_control *wbc)
>  {
>         return -EOPNOTSUPP;
>  }
> Index: rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/xfs/xfs_aops.c  2019-08-26 16:45:26.094710196 -0400
> +++ rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c       2019-08-26 16:45:29.471710196 -0400
> @@ -1120,7 +1120,7 @@ xfs_dax_writepages(
>  {
>         xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
>         return dax_writeback_mapping_range(mapping,
> -                       xfs_find_bdev_for_inode(mapping->host), wbc);
> +                       xfs_find_daxdev_for_inode(mapping->host), wbc);
>  }
>
>  STATIC int
> Index: rhvgoyal-linux-fuse/fs/ext4/inode.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/ext4/inode.c    2019-08-26 16:45:26.093710196 -0400
> +++ rhvgoyal-linux-fuse/fs/ext4/inode.c 2019-08-26 16:45:29.475710196 -0400
> @@ -2992,7 +2992,7 @@ static int ext4_dax_writepages(struct ad
>         percpu_down_read(&sbi->s_journal_flag_rwsem);
>         trace_ext4_writepages(inode, wbc);
>
> -       ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, wbc);
> +       ret = dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
>         trace_ext4_writepages_result(inode, wbc, ret,
>                                      nr_to_write - wbc->nr_to_write);
>         percpu_up_read(&sbi->s_journal_flag_rwsem);
> Index: rhvgoyal-linux-fuse/fs/ext2/inode.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/ext2/inode.c    2019-08-26 16:45:26.093710196 -0400
> +++ rhvgoyal-linux-fuse/fs/ext2/inode.c 2019-08-26 16:45:29.477710196 -0400
> @@ -957,8 +957,9 @@ ext2_writepages(struct address_space *ma
>  static int
>  ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  {
> -       return dax_writeback_mapping_range(mapping,
> -                       mapping->host->i_sb->s_bdev, wbc);
> +       struct ext2_sb_info *sbi = EXT2_SB(mapping->host->i_sb);
> +
> +       return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
>  }
>
>  const struct address_space_operations ext2_aops = {
