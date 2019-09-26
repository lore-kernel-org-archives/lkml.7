Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF142C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CA2217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="A08rDIsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfIZKwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:52:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37487 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfIZKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:52:32 -0400
Received: by mail-io1-f68.google.com with SMTP id b19so5325915iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 03:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fxhdsNNMNOySMdgwpp/hTz3bcuxtYKqOwOCCS5liLI=;
        b=A08rDIsgFqp0S4tLVysMgwV8jHdgA7/onwiOVofbKYlSiN1Q4purLsp49Se1xorQDo
         9/FWXERfQ7l4o2RNz8cmWgzm3ZFo9yoA8HeiOUnjeddOsljrwaZCCelo69VP8iKZBC78
         vCBQWj/kxEIo21Qz58NBDRbCMylIxFdzwwExc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fxhdsNNMNOySMdgwpp/hTz3bcuxtYKqOwOCCS5liLI=;
        b=uTg1OBVmxDHj5+F+GrKoy/8DbrGXu7S9bRbULbHFio1xCkyT+sww3m3TVnJHX6POjX
         Ygijd4adTEYuhHELeYMDhG1DOpXZ8RXFpL/CsLVuAC62sRyw4suGVw+zQ8bun5WuRkFI
         c/UeS/+/ZzLHHhlZoo4MJn0havptM9cVk3+VKJ9KV3Y3w20YrqVdlqKEpKf/+gsUVm5A
         wbH8cFiGR+106QygC2/UajQF5WJOhjZD4/lOo3oSd2ZpQmZxVmqpCs9JGaHB3WibyWO6
         +HKAOFM6Y95RAIbCaURBH/5EVqSuSYTwd5Zq5keIvPQv0pCe1SIFL/Ok9q27tKX3D+YR
         gUew==
X-Gm-Message-State: APjAAAVSuiSzkaPrSsx1RAnTxpVqIlmT751ZrPBHSClRdDRVHr56cvGw
        lHEwePCoFFlFQsE3mUdTz2QNl0z0Aa2srxvtQwA=
X-Google-Smtp-Source: APXvYqytawKyzDtt7dv/0ueiehcZ+we3nLEOkFzRVbSt9HvgF/DxnmH6z9zjmeZuWvo8KvzjoeAm6lrjYzc2dIdft70=
X-Received: by 2002:a6b:8f15:: with SMTP id r21mr2812731iod.259.1569495151337;
 Thu, 26 Sep 2019 03:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <1569209505-15801-1-git-send-email-teawaterz@linux.alibaba.com> <CALZtOND21Lo7_a7a0LKMZzdo1_=+42GgbhAAn0LOJHbFe8yjFA@mail.gmail.com>
In-Reply-To: <CALZtOND21Lo7_a7a0LKMZzdo1_=+42GgbhAAn0LOJHbFe8yjFA@mail.gmail.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Thu, 26 Sep 2019 06:51:55 -0400
Message-ID: <CALZtOND_44Y=AJ24gtVv8kFK6j54tqhXp=A7+QVMno=YGDHrRA@mail.gmail.com>
Subject: Re: [RFC v3] zswap: Add CONFIG_ZSWAP_IO_SWITCH to handle swap IO issue
To:     Hui Zhu <teawaterz@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, chris@chris-wilson.co.uk,
        Johannes Weiner <hannes@cmpxchg.org>, ziqian.lzq@antfin.com,
        osandov@fb.com, Huang Ying <ying.huang@intel.com>,
        aryabinin@virtuozzo.com, vovoy@chromium.org,
        richard.weiyang@gmail.com, jgg@ziepe.ca, dan.j.williams@intel.com,
        rppt@linux.ibm.com, jglisse@redhat.com, b.zolnierkie@samsung.com,
        axboe@kernel.dk, dennis@kernel.org,
        Josef Bacik <josef@toxicpanda.com>, tj@kernel.org,
        oleg@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 4:14 PM Dan Streetman <ddstreet@ieee.org> wrote:
>
> On Sun, Sep 22, 2019 at 11:32 PM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
> >
> > This is the third version of this patch.  The first and second version
> > is in [1] and [2].
> > This verion is updated according to the comments from Randy Dunlap
> > in [3].
> >
> > Currently, I use a VM that has 2 CPUs, 4G memory and 4G swap file.
> > I found that swap will affect the IO performance when it is running.
> > So I open zswap to handle it because it just use CPU cycles but not
> > disk IO.
> >
> > It work OK but I found that zswap is slower than normal swap in this
> > VM.  zswap is about 300M/s and normal swap is about 500M/s. (The reason
> > is disk inside VM has fscache in host machine.)
>
> I must be missing something here - if zswap in the guest is *slower*
> than real swap, why are you using zswap?
>
> Also, I don't see why zswap is slower than normal swap, unless you
> mean that your zswap is full, since once zswap fills up any additional
> swap will absolutely be slower than not having zswap at all.
>
> > So open zswap is make memory shrinker slower but good for IO performance
> > in this VM.
> > So I just want zswap work when the disk of the swap file is under high
> > IO load.
> >
> > This commit is designed for this idea.
> > It add two parameters read_in_flight_limit and write_in_flight_limit to
> > zswap.
> > In zswap_frontswap_store, pages will be stored to zswap only when
> > the IO in flight number of swap device is bigger than
> > zswap_read_in_flight_limit or zswap_write_in_flight_limit
> > when zswap is enabled.
> > Then the zswap just work when the IO in flight number of swap device
> > is low.
>
> Ok, so maybe I understand what you mean, your disk I/O is normally
> very fast, but once your host-side cache is full it starts actually
> writing to your host physical disk, and your guest swap I/O drops way
> down (since caching pages in host memory is much faster than writing
> to a host physical disk).  Is that what's going on?  That was not
> clear at all to me from the commit description...
>
> In general I think the description of this commit, as well as the docs
> and even user interface of how to use it, is very confusing.  I can
> see how it would be beneficial in this specific situation, but I'm not
> a fan of the implementation, and I'm very concerned that nobody will
> be able to understand how to use it properly - when should they enable
> it?  What limit values should they use?  Why are there separate read
> and write limits?  None of that is clear to me, and I'm fairly
> certainly it would not be clear to other normal users.
>
> Is there a better way this can be done?
>
> >
> > [1] https://lkml.org/lkml/2019/9/11/935
> > [2] https://lkml.org/lkml/2019/9/20/90
> > [3] https://lkml.org/lkml/2019/9/20/1076
> >
> > Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

Nacked-by: Dan Streetman <ddstreet@ieee.org>

due to my concerns that I emailed before


> > ---
> >  include/linux/swap.h |  3 +++
> >  mm/Kconfig           | 18 ++++++++++++++++
> >  mm/page_io.c         | 16 +++++++++++++++
> >  mm/zswap.c           | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 95 insertions(+)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index de2c67a..82b621f 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -389,6 +389,9 @@ extern void end_swap_bio_write(struct bio *bio);
> >  extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
> >         bio_end_io_t end_write_func);
> >  extern int swap_set_page_dirty(struct page *page);
> > +#ifdef CONFIG_ZSWAP_IO_SWITCH
> > +extern void swap_io_in_flight(struct page *page, unsigned int inflight[2]);
> > +#endif
> >
> >  int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
> >                 unsigned long nr_pages, sector_t start_block);
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 56cec63..387c3b5 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -546,6 +546,24 @@ config ZSWAP
> >           they have not be fully explored on the large set of potential
> >           configurations and workloads that exist.
> >
> > +config ZSWAP_IO_SWITCH
> > +       bool "Compressed cache for swap pages according to the IO status"
> > +       depends on ZSWAP
> > +       help
> > +         This function helps the system that normal swap speed is higher
> > +         than zswap speed to handle the swap IO issue.
> > +         For example, a VM where the disk device is not set cache config or
> > +         set cache=writeback.
> > +
> > +         This function makes zswap just work when the disk of the swap file
> > +         is under high IO load.
> > +         It add two parameters (read_in_flight_limit and
> > +         write_in_flight_limit) to zswap.  When zswap is enabled, pages will
> > +         be stored to zswap only when the IO in flight number of swap device
> > +         is bigger than zswap_read_in_flight_limit or
> > +         zswap_write_in_flight_limit.
> > +         If unsure, say "n".
> > +
> >  config ZPOOL
> >         tristate "Common API for compressed memory storage"
> >         help
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index 24ee600..e66b050 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -434,3 +434,19 @@ int swap_set_page_dirty(struct page *page)
> >                 return __set_page_dirty_no_writeback(page);
> >         }
> >  }
> > +
> > +#ifdef CONFIG_ZSWAP_IO_SWITCH
> > +void swap_io_in_flight(struct page *page, unsigned int inflight[2])
> > +{
> > +       struct swap_info_struct *sis = page_swap_info(page);
> > +
> > +       if (!sis->bdev) {
> > +               inflight[0] = 0;
> > +               inflight[1] = 0;
> > +               return;
> > +       }
> > +
> > +       part_in_flight_rw(bdev_get_queue(sis->bdev), sis->bdev->bd_part,
> > +                                         inflight);
>
> this potentially will read inflight stats info from all possible cpus,
> that's not something I'm a big fan of adding to every single page swap
> call...it's not awful, but there might be scaling issues for systems
> with lots of cpus.
>
> > +}
> > +#endif
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 0e22744..0190b2d 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -62,6 +62,14 @@ static u64 zswap_reject_compress_poor;
> >  static u64 zswap_reject_alloc_fail;
> >  /* Store failed because the entry metadata could not be allocated (rare) */
> >  static u64 zswap_reject_kmemcache_fail;
> > +#ifdef CONFIG_ZSWAP_IO_SWITCH
> > +/*
> > + * Store failed because zswap_read_in_flight_limit or
> > + * zswap_write_in_flight_limit is bigger than IO in flight number of
> > + * swap device
> > + */
> > +static u64 zswap_reject_io;
> > +#endif
> >  /* Duplicate store was encountered (rare) */
> >  static u64 zswap_duplicate_entry;
> >
> > @@ -114,6 +122,24 @@ static bool zswap_same_filled_pages_enabled = true;
> >  module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
> >                    bool, 0644);
> >
> > +#ifdef CONFIG_ZSWAP_IO_SWITCH
> > +/*
> > + * zswap will not try to store the page if zswap_read_in_flight_limit is
> > + * bigger than IO read in flight number of swap device
> > + */
> > +static unsigned int zswap_read_in_flight_limit;
> > +module_param_named(read_in_flight_limit, zswap_read_in_flight_limit,
> > +                  uint, 0644);
> > +
> > +/*
> > + * zswap will not try to store the page if zswap_write_in_flight_limit is
> > + * bigger than IO write in flight number of swap device
> > + */
> > +static unsigned int zswap_write_in_flight_limit;
> > +module_param_named(write_in_flight_limit, zswap_write_in_flight_limit,
> > +                  uint, 0644);
> > +#endif
> > +
> >  /*********************************
> >  * data structures
> >  **********************************/
> > @@ -1009,6 +1035,34 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> >                 goto reject;
> >         }
> >
> > +#ifdef CONFIG_ZSWAP_IO_SWITCH
> > +       if (zswap_read_in_flight_limit || zswap_write_in_flight_limit) {
> > +               unsigned int inflight[2];
> > +               bool should_swap = false;
> > +
> > +               swap_io_in_flight(page, inflight);
> > +
> > +               if (zswap_write_in_flight_limit &&
> > +                       inflight[1] < zswap_write_in_flight_limit)
> > +                       should_swap = true;
> > +
> > +               if (zswap_read_in_flight_limit &&
> > +                       (should_swap ||
> > +                        (!should_swap && !zswap_write_in_flight_limit))) {
> > +                       if (inflight[0] < zswap_read_in_flight_limit)
> > +                               should_swap = true;
> > +                       else
> > +                               should_swap = false;
> > +               }
> > +
> > +               if (should_swap) {
> > +                       zswap_reject_io++;
> > +                       ret = -EIO;
> > +                       goto reject;
> > +               }
> > +       }
> > +#endif
> > +
> >         /* reclaim space if needed */
> >         if (zswap_is_full()) {
> >                 zswap_pool_limit_hit++;
> > @@ -1264,6 +1318,10 @@ static int __init zswap_debugfs_init(void)
> >                            zswap_debugfs_root, &zswap_reject_kmemcache_fail);
> >         debugfs_create_u64("reject_compress_poor", 0444,
> >                            zswap_debugfs_root, &zswap_reject_compress_poor);
> > +#ifdef CONFIG_ZSWAP_IO_SWITCH
> > +       debugfs_create_u64("reject_io", 0444,
>
> "reject_io" is not very clear about why it was rejected; I think most
> people will assume this means pages were rejected because of I/O
> errors, not because the I/O inflight page count was lower than the set
> limit.
>
> > +                          zswap_debugfs_root, &zswap_reject_io);
> > +#endif
> >         debugfs_create_u64("written_back_pages", 0444,
> >                            zswap_debugfs_root, &zswap_written_back_pages);
> >         debugfs_create_u64("duplicate_entry", 0444,
> > --
> > 2.7.4
> >
