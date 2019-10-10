Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DABFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648792067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Mi2zYeeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbfJJI1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:27:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34583 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfJJI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:27:06 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so11876912ion.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3Wh2bHreWYpMsfb9refbYuNNl1DVVmRfzyyuv+onY8=;
        b=Mi2zYeeQOPnOeVeoxKrsURYJGkF70xS0cvJ2E6RGApb/oyGJJzafn1nqfzBrEyxPvw
         ZKqqbhe8M8yw+Q1ftRK70mXOzaYzJfsR9gWzmvhZf7zvxdXBOvvbodS/9DHPmzK6lX1g
         yRYkWy5PE2BeSsbDJg84ONIX173ZRalvjprdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3Wh2bHreWYpMsfb9refbYuNNl1DVVmRfzyyuv+onY8=;
        b=AzXZwQoRZWX20rGKiuOD1oZPA4EE92a7zC5NNn77QLopFE6n2ZWzQ0TS0wGtG+dv+b
         m3B16uqQ4SCVCpkkwf9ngSgPLomNuLn+j/wEd2Wcwq7hNz0aAmWlTjIlCJAnJvjX5ocb
         AoJrzFph335IEw9x5sfBiN/yOZBtD7CnNpb4BkP6BQWdkicinobXj67UbMS+skSoNlbg
         8AE9M/rW9tMhXjY7/GyAMsIdk9ofGeJFl6U1aEFicbdr8zn7xFBe9wBlu5tJnK1nq1ym
         ZNFzJ5i23riodlrr6+5bOmzl4RrPMf0ynEbMEVnJILqrdcm8KevjXBhd7k6sAk+yWTLx
         NaQQ==
X-Gm-Message-State: APjAAAU0YtdgjRZoOPsy8IN+R3FsU+A5wSocbmGsNv0fgGr+5Z42bIR3
        5oWSaIKN0Es4J0RNpaHhrgyPdHfm45F2Tzy8140=
X-Google-Smtp-Source: APXvYqxcNuhUnJ+1aQiDFF/ofQKqut0PFuxxuGwds0OjA3KBneThq7drNZ7uEqppSSOVAr51Eo7r3RAKbGDzAPC1HVs=
X-Received: by 2002:a02:9a05:: with SMTP id b5mr9494775jal.111.1570696023686;
 Thu, 10 Oct 2019 01:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <1570522026-12757-1-git-send-email-teawaterz@linux.alibaba.com>
In-Reply-To: <1570522026-12757-1-git-send-email-teawaterz@linux.alibaba.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Thu, 10 Oct 2019 04:26:27 -0400
Message-ID: <CALZtONDhft+coE+1USCg5udW9hTpM8-CSboGazpJY_rrqabhhw@mail.gmail.com>
Subject: Re: [RFC v4] zswap: Add CONFIG_ZSWAP_IO_SWITCH to handle swap IO issue
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, ziqian.lzq@antfin.com,
        osandov@fb.com, arunks@codeaurora.org,
        Huang Ying <ying.huang@intel.com>, richard.weiyang@gmail.com,
        jgg@ziepe.ca, dan.j.williams@intel.com, rppt@linux.ibm.com,
        jglisse@redhat.com, b.zolnierkie@samsung.com, axboe@kernel.dk,
        dennis@kernel.org, nborisov@suse.com, tj@kernel.org,
        oleg@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 4:07 AM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>
> This is the fourth version of this patch.  The perious versions
> are in [1], [2] and [3].
>
> The parameters read_in_flight_limit and write_in_flight_limit were
> replaced by io_switch_enabled_enabled in this verion to make this
> function more clear.
>
> Currently, I use a VM that has 1 CPU, 4G memory and 4G swap file.
> I found that swap will affect the IO performance when it is running.
> So I open zswap to handle it because it just use CPU cycles but not
> disk IO.
>
> It work OK but I found that zswap is slower than normal swap in this
> VM.  zswap is about 300M/s and normal swap is about 500M/s. (The reason
> is the swap disk device config is "cache=none,aio=native".)
> So open zswap is make memory shrinker slower but good for IO performance
> in this VM.
> So I just want zswap work when the disk of the swap file is under high
> IO load.

I'm still not excited about this, I feel like this will only be useful
in situations where zswap probably wasn't a good idea in the first
place.  And I'm still not clear on why you're using zswap *at all*, if
your disk I/O is faster than zswap can compress pages - you clearly
should have zswap disabled, if that's the case.

Can you run some more tests and make sure this param really, actually,
helps your workload?  Please also check that you aren't filling up
zswap as well; if your problem is you're filling up zswap and that's
when you want to divert more pages into swap, then I think that would
be much better handled by adding hysteresis logic instead of checking
the swap device io load.

>
> This commit is designed for this idea.
> When this function is enabled by the swap parameter
> io_switch_enabled_enabled, zswap will just work when the swap disk has
> outstanding I/O requests.
>
> [1] https://lkml.org/lkml/2019/9/11/935
> [2] https://lkml.org/lkml/2019/9/20/90
> [3] https://lkml.org/lkml/2019/9/22/927
>
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  include/linux/swap.h |  3 +++
>  mm/Kconfig           | 14 ++++++++++++++
>  mm/page_io.c         | 16 ++++++++++++++++
>  mm/zswap.c           | 25 +++++++++++++++++++++++++
>  4 files changed, 58 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index de2c67a..82b621f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -389,6 +389,9 @@ extern void end_swap_bio_write(struct bio *bio);
>  extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
>         bio_end_io_t end_write_func);
>  extern int swap_set_page_dirty(struct page *page);
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +extern void swap_io_in_flight(struct page *page, unsigned int inflight[2]);
> +#endif
>
>  int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
>                 unsigned long nr_pages, sector_t start_block);
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 56cec63..f5740e3 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -546,6 +546,20 @@ config ZSWAP
>           they have not be fully explored on the large set of potential
>           configurations and workloads that exist.
>
> +config ZSWAP_IO_SWITCH

let's drop this, if we're going to add this I don't think we need both
a build time and runtime switch.  Just defaulting the runtime switch
to off should be fine.

> +       bool "Compressed cache for swap pages according to the IO status"
> +       depends on ZSWAP
> +       help
> +         This function helps the system that normal swap speed is higher
> +         than zswap speed to handle the swap IO issue.
> +         For example, a VM where the swap disk device with config
> +         "cache=none,aio=native".
> +
> +         When this function is enabled by the swap parameter
> +         io_switch_enabled_enabled, zswap will just work when the swap disk
> +         has outstanding I/O requests.

I think this doc should go into Documentation/vm/zswap.rst instead, please.

> +         If unsure, say "n".
> +
>  config ZPOOL
>         tristate "Common API for compressed memory storage"
>         help
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 24ee600..e66b050 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -434,3 +434,19 @@ int swap_set_page_dirty(struct page *page)
>                 return __set_page_dirty_no_writeback(page);
>         }
>  }
> +
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +void swap_io_in_flight(struct page *page, unsigned int inflight[2])
> +{
> +       struct swap_info_struct *sis = page_swap_info(page);
> +
> +       if (!sis->bdev) {
> +               inflight[0] = 0;
> +               inflight[1] = 0;

I'm not quite sure when a swap_info_struct won't have a bdev (looks
like if it's neither ISBLK nor ISREG, and I'm not sure what's left
after those), but if you set both to 0 that means it will effectively
disable zswap completely for this swap device, writing all pages to
it.  Is that really the right thing to do?

> +               return;
> +       }
> +
> +       part_in_flight_rw(bdev_get_queue(sis->bdev), sis->bdev->bd_part,
> +                                         inflight);
> +}
> +#endif
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0e22744..b50d8fb 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -114,6 +114,18 @@ static bool zswap_same_filled_pages_enabled = true;
>  module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
>                    bool, 0644);
>
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +/*
> + * Enable/disable the io switch functon (disabled by default)
> + * When the io switch functon is enabled, zswap will only try to
> + * store pages when IO of the swap device is low (read and write io in
> + * flight number is 0).
> + */
> +static bool zswap_io_switch_enabled;
> +module_param_named(io_switch_enabled_enabled, zswap_io_switch_enabled,

let's use only a single 'enabled' in the name, i.e. 'io_switch_enabled'

> +                  bool, 0644);
> +#endif
> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -1009,6 +1021,19 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>                 goto reject;
>         }
>
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +       if (zswap_io_switch_enabled) {
> +               unsigned int inflight[2];
> +
> +               swap_io_in_flight(page, inflight);
> +
> +               if (inflight[0] == 0 || inflight[1] == 0) {

can you move the above logic up into swap_io_in_flight(), i think it
would be clearer to just have

if (zswap_io_switch_enabled && swap_io_in_flight(page)) {

> +                       ret = -EIO;
> +                       goto reject;
> +               }
> +       }
> +#endif
> +
>         /* reclaim space if needed */
>         if (zswap_is_full()) {
>                 zswap_pool_limit_hit++;
> --
> 2.7.4
>
