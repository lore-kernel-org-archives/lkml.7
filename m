Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9BECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8509021835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rp4RA62M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfJKRce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:32:34 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33557 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfJKRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:32:33 -0400
Received: by mail-yw1-f68.google.com with SMTP id w140so3765128ywd.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmJncVeXidMltIZGfdmFWVyQQHHQU4TMT+HqFa7kOMc=;
        b=Rp4RA62MxqxqGPmI+Oen0nSznqGjtWzvZBTbW3kX6LjOLZJLuVwg3pIN4uQNIYNOC9
         IRQ3dvCkYUemQbyvxPi/VPhcRQErPm82rpIovJT1dE/gX5Byh3oHST327msCReABDLFs
         FRlyRAacPthqN7WiRrUWL1JVfP5Ef7tPuHcWcaNg5O9+kX5UeNjK5yy6AY+8p86Vlkxo
         xHOKbDCxIqc5z/xx/jbnIoOTyU4QEUWGLnwJRxUhnfya/HKI3GJUSu4Q0Q3HEp2E7CNc
         y9wp2Jd2iD7fiti5Ywb8DS8zQpF1AOlM8PRyOqdljYNrF6+3eB3Wkhe4e6DPLiWZyggM
         iJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmJncVeXidMltIZGfdmFWVyQQHHQU4TMT+HqFa7kOMc=;
        b=EVJNf6tBrmqmd8vWHKgT+lqzdFxvQ9Fy19gCfEFsgVnac0h8mtL2t3eEnckNId3wFX
         z1/paTHNhNKZUHHAxelEyT0JJRPxO9VGkzqMpEbVOGjooQBStS7V7pvkRlj/dwjxItRE
         0WXhoPUWLPyPqzlbbWyeQ4TLCLpK0Wff8VRn31pA65Qr5jQ6oyUhbRcPcr4M8HeeW1/l
         ZVWu1P1wlv7C7oXnXqKtuhCPK/11/pEBZbqul7bFOxp69hm+j9S5wsIkOlOaufkW+3oe
         Szl7NW0AUMV7kHg0EozirBcHfQazQJIe2soa2GmwD0xdCNkAqgsarPmrnzdddfLTWnc5
         hWSA==
X-Gm-Message-State: APjAAAVn6N/Z9pL8qR+vfjhrkggPT7IO5tYw4ZqhKHMXgrNz32m/GlOf
        50YQMdUI+HZXF9uZCAwHqQYZAOQu4iCdvxfAEmCY2g==
X-Google-Smtp-Source: APXvYqxZaonxZjZHZ847y1kn9EiJCNILTsxaNlJhU+iZBSCGDSLiFaS45ZvGraVliW5gvwSDKHTuRYeEx7T7XkJ4eew=
X-Received: by 2002:a81:6207:: with SMTP id w7mr3473534ywb.34.1570815152103;
 Fri, 11 Oct 2019 10:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191010152134.38545-1-minchan@kernel.org> <20191010191747.GA31673@cmpxchg.org>
 <20191010221105.GA115307@google.com>
In-Reply-To: <20191010221105.GA115307@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Oct 2019 10:32:20 -0700
Message-ID: <CALvZod4o496R889_OpCQCRGOrsFt3TLCXgKmksHzFvBGt6Xu9Q@mail.gmail.com>
Subject: Re: [PATCH] mm: annotate refault stalls from swap_readpage
To:     Minchan Kim <minchan@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 3:11 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Thu, Oct 10, 2019 at 03:17:47PM -0400, Johannes Weiner wrote:
> > On Thu, Oct 10, 2019 at 08:21:34AM -0700, Minchan Kim wrote:
> > > From: Minchan Kim <minchan@google.com>
> > >
> > > If block device supports rw_page operation, it doesn't submit bio
> > > so annotation in submit_bio for refault stall doesn't work.
> > > It happens with zram in android, especially swap read path which
> > > could consume CPU cycle for decompress. It is also a problem for
> > > zswap which uses frontswap.
> > >
> > > Annotate swap_readpage() to account the synchronous IO overhead
> > > to prevent underreport memory pressure.
> > >
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Minchan Kim <minchan@google.com>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Thanks, Johannes!
>
> >
> > Can you please add a comment to the caller? Lifted from submit_bio():
>
> Sure, I added a little about zram.
>
> >
> >       /*
> >        * Count submission time as memory stall. When the device is
> >        * congested, or the submitting cgroup IO-throttled,
> >        * submission can be a significant part of overall IO time.
> >        */
>
>
> From a8ae7cbc2d3f050aca810fd68285d45cb933b825 Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@google.com>
> Date: Thu, 10 Oct 2019 08:09:06 -0700
> Subject: [PATCH v2] mm: annotate refault stalls from swap_readpage
>
> If block device supports rw_page operation, it doesn't submit bio
> so annotation in submit_bio for refault stall doesn't work.
> It happens with zram in android, especially swap read path which
> could consume CPU cycle for decompress. It is also a problem for
> zswap which uses frontswap.
>
> Annotate swap_readpage() to account the synchronous IO overhead
> to prevent underreport memory pressure.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Minchan Kim <minchan@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/page_io.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 24ee600f9131..18f1f8e1d27f 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -22,6 +22,7 @@
>  #include <linux/writeback.h>
>  #include <linux/frontswap.h>
>  #include <linux/blkdev.h>
> +#include <linux/psi.h>
>  #include <linux/uio.h>
>  #include <linux/sched/task.h>
>  #include <asm/pgtable.h>
> @@ -354,10 +355,20 @@ int swap_readpage(struct page *page, bool synchronous)
>         struct swap_info_struct *sis = page_swap_info(page);
>         blk_qc_t qc;
>         struct gendisk *disk;
> +       unsigned long pflags;
>
>         VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
>         VM_BUG_ON_PAGE(!PageLocked(page), page);
>         VM_BUG_ON_PAGE(PageUptodate(page), page);
> +
> +       /*
> +        * Count submission time as memory stall. When the device is
> +        * congested, the submitting cgroup IO-throttled, or backing
> +        * device works synchronously(e.g., zram), submission can be
> +        * a significant part of overall IO time.
> +        */
> +       psi_memstall_enter(&pflags);
> +
>         if (frontswap_load(page) == 0) {
>                 SetPageUptodate(page);
>                 unlock_page(page);
> @@ -371,7 +382,7 @@ int swap_readpage(struct page *page, bool synchronous)
>                 ret = mapping->a_ops->readpage(swap_file, page);
>                 if (!ret)
>                         count_vm_event(PSWPIN);
> -               return ret;
> +               goto out;
>         }
>
>         ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> @@ -382,7 +393,7 @@ int swap_readpage(struct page *page, bool synchronous)
>                 }
>
>                 count_vm_event(PSWPIN);
> -               return 0;
> +               goto out;
>         }
>
>         ret = 0;
> @@ -418,6 +429,7 @@ int swap_readpage(struct page *page, bool synchronous)
>         bio_put(bio);
>
>  out:
> +       psi_memstall_leave(&pflags);
>         return ret;
>  }
>
> --
> 2.23.0.581.g78d2f28ef7-goog
>
