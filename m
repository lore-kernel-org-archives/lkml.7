Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015D1208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS5O6ycQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfENEzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 00:55:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44389 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENEzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 00:55:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id f24so13109552qtk.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 21:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5JAMGDZa4nozhQfSyXGRiH9TTGPMZ/aE5k3Zbert4E=;
        b=cS5O6ycQBbw3TdMsls7wSyBgezuwIq6oq8ZTDIop7Mcqiw/gz7Xk/Ca5w8qh1kXOmN
         XS3nPQUlfMHVSacKsQ2ERt+BeEVlXml685hsdkB0KYSVyObO4QbsxZBPQ0lL+8otmtrn
         jflUFFx8HDU7T0QOd13XOOyOh6L9ECAFshM5/ph6vr49f9j5vRAA0Qde57282L0C2W1Q
         DB9FBjt4G5NXVi1j73LfB9doYCvZ/FaUF/q05HqWA50ZZjoWZirTb2QpaqD3s26jQ1Wr
         Sk3kPsu7Peq8CFQ1WWQ8ceatG8XsBuatl8Dc8YLYdiySCBT5WaMMacsrblXCBQR40D3e
         tyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5JAMGDZa4nozhQfSyXGRiH9TTGPMZ/aE5k3Zbert4E=;
        b=eMzT8KygVBLkOQ9jtsIevZXWqy6zkBfOR9GzhQB1OofKjk7rpdYvxqqc39q9klkD9o
         MddP+tASV8xUoVvEaGgFxZDzEbg9P0K9pYinQ0TjHDo68KXPhVsYmMzp9rPkZgQwe9Gm
         ZirewDC7KVmntKh2TMYbhQ2R/gJKhVftJCjvQhCwsQj057l3vrSJwK1RBt6+Bauc4vm+
         4gWtcBYQuaN5KUKHqxT+NYnaS3PY+trvT96CFTANZ8cdoyHLIOdBYy6R2dn7utnyk4Ga
         19eobyl7bTF86BcsqeD7IWGybqNR74eqV0x51oq2PJAujun/1DaZJObzxiZVZF7xnxAT
         kxnQ==
X-Gm-Message-State: APjAAAX61La8ac+yqPGNs7VaNMG9qVb31vhctnfVuVa6KGFQ0yZnRuSv
        w3CQaG8D3ol9wUmTEYYI+98IPgao7Bg93oq+mTA=
X-Google-Smtp-Source: APXvYqyDkBH8kfXm9OtMf4RtTNNq1dg4+3zFnC7Gfvd9z21u+VqxDMB42w2eSm+taegbP6lKJ5lKxOo0Hh/TCT8O6K4=
X-Received: by 2002:ac8:1671:: with SMTP id x46mr5224535qtk.240.1557809744003;
 Mon, 13 May 2019 21:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190219081529.5106-1-yuchao0@huawei.com> <51637fbc-2b55-8215-952e-b155487cc63d@huawei.com>
 <20190301175510.GB8246@jaegeuk-macbookpro.roam.corp.google.com>
In-Reply-To: <20190301175510.GB8246@jaegeuk-macbookpro.roam.corp.google.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Tue, 14 May 2019 13:55:32 +0900
Message-ID: <CAD14+f0ga3F6d7TD3XaRiB_G4XtmJDoqsZWiyy8i5uShOBxZNQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: add bio cache for IPU
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is this still causing hangs?
Just wondering why this isn't merged yet.

Thanks.

On Sat, Mar 2, 2019 at 2:55 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> On 02/28, Chao Yu wrote:
> > Ping,
>
> Ditto.
>
> >
> > On 2019/2/19 16:15, Chao Yu wrote:
> > > SQLite in Wal mode may trigger sequential IPU write in db-wal file, after
> > > commit d1b3e72d5490 ("f2fs: submit bio of in-place-update pages"), we
> > > lost the chance of merging page in inner managed bio cache, result in
> > > submitting more small-sized IO.
> > >
> > > So let's add temporary bio in writepages() to cache mergeable write IO as
> > > much as possible.
> > >
> > > Test case:
> > > 1. xfs_io -f /mnt/f2fs/file -c "pwrite 0 65536" -c "fsync"
> > > 2. xfs_io -f /mnt/f2fs/file -c "pwrite 0 65536" -c "fsync"
> > >
> > > Before:
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65544, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65552, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65560, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65568, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65576, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65584, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65592, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65600, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65608, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65616, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65624, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65632, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65640, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65648, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65656, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65664, size = 4096
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), NODE, sector = 57352, size = 4096
> > >
> > > After:
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65544, size = 65536
> > > f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), NODE, sector = 57368, size = 4096
> > >
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > > v4:
> > > - fix to set *bio to NULL in f2fs_submit_ipu_bio()
> > > - spread f2fs_submit_ipu_bio()
> > > - fix to count dirty encrypted page correctly in f2fs_merge_page_bio()
> > > - remove redundant assignment of fio->last_block
> > >  fs/f2fs/data.c    | 88 ++++++++++++++++++++++++++++++++++++++++++-----
> > >  fs/f2fs/f2fs.h    |  3 ++
> > >  fs/f2fs/segment.c |  5 ++-
> > >  3 files changed, 86 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 35910ff23582..e4c183e85de8 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -296,20 +296,20 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
> > >     io->bio = NULL;
> > >  }
> > >
> > > -static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
> > > +static bool __has_merged_page(struct bio *bio, struct inode *inode,
> > >                                             struct page *page, nid_t ino)
> > >  {
> > >     struct bio_vec *bvec;
> > >     struct page *target;
> > >     int i;
> > >
> > > -   if (!io->bio)
> > > +   if (!bio)
> > >             return false;
> > >
> > >     if (!inode && !page && !ino)
> > >             return true;
> > >
> > > -   bio_for_each_segment_all(bvec, io->bio, i) {
> > > +   bio_for_each_segment_all(bvec, bio, i) {
> > >
> > >             if (bvec->bv_page->mapping)
> > >                     target = bvec->bv_page;
> > > @@ -360,7 +360,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
> > >                     struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
> > >
> > >                     down_read(&io->io_rwsem);
> > > -                   ret = __has_merged_page(io, inode, page, ino);
> > > +                   ret = __has_merged_page(io->bio, inode, page, ino);
> > >                     up_read(&io->io_rwsem);
> > >             }
> > >             if (ret)
> > > @@ -429,6 +429,61 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
> > >     return 0;
> > >  }
> > >
> > > +int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> > > +{
> > > +   struct bio *bio = *fio->bio;
> > > +   struct page *page = fio->encrypted_page ?
> > > +                   fio->encrypted_page : fio->page;
> > > +
> > > +   if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> > > +                   __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
> > > +           return -EFAULT;
> > > +
> > > +   trace_f2fs_submit_page_bio(page, fio);
> > > +   f2fs_trace_ios(fio, 0);
> > > +
> > > +   if (bio && (*fio->last_block + 1 != fio->new_blkaddr ||
> > > +                   !__same_bdev(fio->sbi, fio->new_blkaddr, bio))) {
> > > +           __submit_bio(fio->sbi, bio, fio->type);
> > > +           bio = NULL;
> > > +   }
> > > +alloc_new:
> > > +   if (!bio) {
> > > +           bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
> > > +                           BIO_MAX_PAGES, false, fio->type, fio->temp);
> > > +           bio_set_op_attrs(bio, fio->op, fio->op_flags);
> > > +   }
> > > +
> > > +   if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
> > > +           __submit_bio(fio->sbi, bio, fio->type);
> > > +           bio = NULL;
> > > +           goto alloc_new;
> > > +   }
> > > +
> > > +   if (fio->io_wbc)
> > > +           wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
> > > +
> > > +   inc_page_count(fio->sbi, WB_DATA_TYPE(page));
> > > +
> > > +   *fio->last_block = fio->new_blkaddr;
> > > +   *fio->bio = bio;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +void f2fs_submit_ipu_bio(struct f2fs_sb_info *sbi, struct bio **bio,
> > > +                                                   struct page *page)
> > > +{
> > > +   if (!bio)
> > > +           return;
> > > +
> > > +   if (!__has_merged_page(*bio, NULL, page, 0))
> > > +           return;
> > > +
> > > +   __submit_bio(sbi, *bio, DATA);
> > > +   *bio = NULL;
> > > +}
> > > +
> > >  void f2fs_submit_page_write(struct f2fs_io_info *fio)
> > >  {
> > >     struct f2fs_sb_info *sbi = fio->sbi;
> > > @@ -1854,6 +1909,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
> > >  }
> > >
> > >  static int __write_data_page(struct page *page, bool *submitted,
> > > +                           struct bio **bio,
> > > +                           sector_t *last_block,
> > >                             struct writeback_control *wbc,
> > >                             enum iostat_type io_type)
> > >  {
> > > @@ -1879,6 +1936,8 @@ static int __write_data_page(struct page *page, bool *submitted,
> > >             .need_lock = LOCK_RETRY,
> > >             .io_type = io_type,
> > >             .io_wbc = wbc,
> > > +           .bio = bio,
> > > +           .last_block = last_block,
> > >     };
> > >
> > >     trace_f2fs_writepage(page, DATA);
> > > @@ -1976,10 +2035,13 @@ static int __write_data_page(struct page *page, bool *submitted,
> > >     }
> > >
> > >     unlock_page(page);
> > > -   if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
> > > +   if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode)) {
> > > +           f2fs_submit_ipu_bio(sbi, bio, page);
> > >             f2fs_balance_fs(sbi, need_balance_fs);
> > > +   }
> > >
> > >     if (unlikely(f2fs_cp_error(sbi))) {
> > > +           f2fs_submit_ipu_bio(sbi, bio, page);
> > >             f2fs_submit_merged_write(sbi, DATA);
> > >             submitted = NULL;
> > >     }
> > > @@ -2006,7 +2068,7 @@ static int __write_data_page(struct page *page, bool *submitted,
> > >  static int f2fs_write_data_page(struct page *page,
> > >                                     struct writeback_control *wbc)
> > >  {
> > > -   return __write_data_page(page, NULL, wbc, FS_DATA_IO);
> > > +   return __write_data_page(page, NULL, NULL, NULL, wbc, FS_DATA_IO);
> > >  }
> > >
> > >  /*
> > > @@ -2022,6 +2084,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
> > >     int done = 0;
> > >     struct pagevec pvec;
> > >     struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
> > > +   struct bio *bio = NULL;
> > > +   sector_t last_block;
> > >     int nr_pages;
> > >     pgoff_t uninitialized_var(writeback_index);
> > >     pgoff_t index;
> > > @@ -2098,17 +2162,20 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
> > >                     }
> > >
> > >                     if (PageWriteback(page)) {
> > > -                           if (wbc->sync_mode != WB_SYNC_NONE)
> > > +                           if (wbc->sync_mode != WB_SYNC_NONE) {
> > >                                     f2fs_wait_on_page_writeback(page,
> > >                                                     DATA, true, true);
> > > -                           else
> > > +                                   f2fs_submit_ipu_bio(sbi, &bio, page);
> > > +                           } else {
> > >                                     goto continue_unlock;
> > > +                           }
> > >                     }
> > >
> > >                     if (!clear_page_dirty_for_io(page))
> > >                             goto continue_unlock;
> > >
> > > -                   ret = __write_data_page(page, &submitted, wbc, io_type);
> > > +                   ret = __write_data_page(page, &submitted, &bio,
> > > +                                   &last_block, wbc, io_type);
> > >                     if (unlikely(ret)) {
> > >                             /*
> > >                              * keep nr_to_write, since vfs uses this to
> > > @@ -2157,6 +2224,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
> > >     if (nwritten)
> > >             f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
> > >                                                             NULL, 0, DATA);
> > > +   /* submit cached bio of IPU write */
> > > +   if (bio)
> > > +           __submit_bio(sbi, bio, DATA);
> > >
> > >     return ret;
> > >  }
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 46db3ed87c84..7c4355927d28 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -1048,6 +1048,8 @@ struct f2fs_io_info {
> > >     bool retry;             /* need to reallocate block address */
> > >     enum iostat_type io_type;       /* io type */
> > >     struct writeback_control *io_wbc; /* writeback control */
> > > +   struct bio **bio;               /* bio for ipu */
> > > +   sector_t *last_block;           /* last block number in bio */
> > >     unsigned char version;          /* version of the node */
> > >  };
> > >
> > > @@ -3105,6 +3107,7 @@ void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
> > >                             nid_t ino, enum page_type type);
> > >  void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
> > >  int f2fs_submit_page_bio(struct f2fs_io_info *fio);
> > > +int f2fs_merge_page_bio(struct f2fs_io_info *fio);
> > >  void f2fs_submit_page_write(struct f2fs_io_info *fio);
> > >  struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
> > >                     block_t blk_addr, struct bio *bio);
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index b2167d53fb9d..66838ab2f21e 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -3196,7 +3196,10 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
> > >
> > >     stat_inc_inplace_blocks(fio->sbi);
> > >
> > > -   err = f2fs_submit_page_bio(fio);
> > > +   if (fio->bio)
> > > +           err = f2fs_merge_page_bio(fio);
> > > +   else
> > > +           err = f2fs_submit_page_bio(fio);
> > >     if (!err)
> > >             update_device_state(fio);
> > >
> > >
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
