Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B52C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2896E206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570661039;
	bh=QYiuKQzerNfHpXb9a1u7OylhgeqCXDHzQMZ/9DtKieM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dg+Ivmv++brP+O9J56H5oiaVdjToBuqxjUaOz2nQRJd6P8+c7TEcp6gsCRZ4vhmlV
	 dYQd+FyJjIhiY8YFfLmfuO1kZx/B8PJr0ibnpKE0p4HcY97AeEZQNhxub9VfXF2llw
	 Yvw9j3pW+ELquOcN/mDGpsVzKZjPFpZJbCqYzhKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfJIWn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:43:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40398 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbfJIWn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:43:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so1763360pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=00g0gfol9RJzRPWbkeeT8ZIvY5uGonsXfuas28jebqc=;
        b=NPudgn2rNbJ4GsO9Xe8lglZpwIH9cElsJGpgxmZW1fVZi90cox8QMjusz+eqtLzQjs
         waWp1JsWDpoRG/5l3Gz+I+hS8PIrF44pBpyY5fazpW0pZI+h7aXtMYn/p8rZsXEo1RgB
         hM0fSvfjN699RNzbGGRAROF6hC4MbKcWo3gfwzdw6fjbB3jMKrQyGB8QA2X9cNzMncM9
         Wayz5fQmpxlCBnDAjuEyMbAzhwq/oq0f95UZETWHCp8eSrrOUhDAZmn+WdKi93IQiNqz
         A0qq45SIWtBhnt9AnvMxxibNd6H/2eBYkJDXlCH/LxUhxNh7A6yuVSDlpVhVPlJ9I+ki
         qMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=00g0gfol9RJzRPWbkeeT8ZIvY5uGonsXfuas28jebqc=;
        b=K5hVS7WWrrP4srHljoMxnFbVl0fBnIUNwzjf9/z5//o0MeMQnXGEKu9k8XyLSNluSc
         adIAVnHVNr4kIMwTPzd1rifjV26R+fjc8tuiGoZWfkKbZuYl4Hc3tnG8PH0b+9Ew7o3K
         y8qjx/znV6KAo7QBvoh73NHYq/IU7DcBFHJ+afkbzAdzGohRKGH8LY3BSvsXEBm2bwsi
         fSqqyT8yWv8tIIcvSHeVvbWkgJPX+CTTtTLOi18FwoPvGaVq4gqiiDaBYsy1lJ2OIP/g
         fcwfHwHZDCGenSRoafdEGR7Pkh7e6yeCszxI4hm1tPJ5YaFaDz5lPBU4ARudt1yyHVqq
         wgSw==
X-Gm-Message-State: APjAAAUytBMPE/mdDtzBB9UCRw86uhk+aAIFsD8/aS80bT7550u+t1WW
        QHyg8lenAZXJ7Iils+YXkwE=
X-Google-Smtp-Source: APXvYqzl1UID70I008rOENSyOuw8kamFQYecb+i3Y7NX2qTGDmC9p+1nyHnKVpZGgaCqdF7S4nurLg==
X-Received: by 2002:a17:902:8f89:: with SMTP id z9mr5314721plo.228.1570661036771;
        Wed, 09 Oct 2019 15:43:56 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id q42sm3356237pja.16.2019.10.09.15.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 15:43:55 -0700 (PDT)
Date:   Wed, 9 Oct 2019 15:43:53 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] fs: annotate refault stalls from bdev_read_page
Message-ID: <20191009224353.GA63899@google.com>
References: <20191009211857.35587-1-minchan@kernel.org>
 <CALvZod4-hTrOy_Fdd+3tCm0cNHwOOr0UFwLwVkGOw=qJDxfFEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4-hTrOy_Fdd+3tCm0cNHwOOr0UFwLwVkGOw=qJDxfFEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:25:10PM -0700, Shakeel Butt wrote:
> On Wed, Oct 9, 2019 at 2:19 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > From: Minchan Kim <minchan@google.com>
> >
> > If block device supports rw_page operation, it doesn't submit bio
> > so annotation in submit_bio for refault stall doesn't work.
> > It happens with zram in android, especially swap read path which
> > could consume CPU cycle for decompress.
> 
> What about zswap? Do we need the same in zswap_frontswap_load()?

Yub, it needs it. Maybe, a annotation in swap_readpage will cover both
all at once in real pratice unless we need to take care of nvdimms
which supports rw_page operation.

Thanks.
> 
> >
> > Annotate bdev_read_page() to account the synchronous IO overhead
> > to prevent underreport memory pressure.
> >
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Minchan Kim <minchan@google.com>
> > ---
> >  fs/block_dev.c | 13 +++++++++++++
> >  mm/memory.c    |  1 +
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 9c073dbdc1b0..82ca28eb9a57 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/writeback.h>
> >  #include <linux/mpage.h>
> >  #include <linux/mount.h>
> > +#include <linux/psi.h>
> >  #include <linux/pseudo_fs.h>
> >  #include <linux/uio.h>
> >  #include <linux/namei.h>
> > @@ -701,6 +702,8 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
> >  {
> >         const struct block_device_operations *ops = bdev->bd_disk->fops;
> >         int result = -EOPNOTSUPP;
> > +       unsigned long pflags;
> > +       bool workingset_read;
> >
> >         if (!ops->rw_page || bdev_get_integrity(bdev))
> >                 return result;
> > @@ -708,9 +711,19 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
> >         result = blk_queue_enter(bdev->bd_queue, 0);
> >         if (result)
> >                 return result;
> > +
> > +       workingset_read = PageWorkingset(page);
> > +       if (workingset_read)
> > +               psi_memstall_enter(&pflags);
> > +
> >         result = ops->rw_page(bdev, sector + get_start_sect(bdev), page,
> >                               REQ_OP_READ);
> > +
> > +       if (workingset_read)
> > +               psi_memstall_leave(&pflags);
> > +
> >         blk_queue_exit(bdev->bd_queue);
> > +
> >         return result;
> >  }
> >  EXPORT_SYMBOL_GPL(bdev_read_page);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 06935826d71e..6357d5a0a2a5 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2801,6 +2801,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                         if (page) {
> >                                 __SetPageLocked(page);
> >                                 __SetPageSwapBacked(page);
> > +                               SetPageWorkingset(page);
> >                                 set_page_private(page, entry.val);
> >                                 lru_cache_add_anon(page);
> >                                 swap_readpage(page, true);
> > --
> > 2.23.0.581.g78d2f28ef7-goog
> >
