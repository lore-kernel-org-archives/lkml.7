Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7022BC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454E42175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfDWPtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:49:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfDWPtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:49:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30CD73003B46;
        Tue, 23 Apr 2019 15:49:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 509741001DDC;
        Tue, 23 Apr 2019 15:49:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x3NFnVHH019162;
        Tue, 23 Apr 2019 11:49:31 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x3NFnVdW019159;
        Tue, 23 Apr 2019 11:49:31 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 23 Apr 2019 11:49:31 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng Ye <huye@redhat.com>
cc:     snitzer@redhat.com, agk@redhat.com, prarit@redhat.com,
        chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH] dm-writecache: simplify the using of pointer wb
In-Reply-To: <20190412152718.27102-1-huye@redhat.com>
Message-ID: <alpine.LRH.2.02.1904231148150.17390@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190412152718.27102-1-huye@redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 23 Apr 2019 15:49:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Apr 2019, Huaisheng Ye wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> In function __writecache_writeback_pmem, the pointer bio has been
> already there, it doesn't need to seek bio's address from pointer wb.

The compiler optimizer knows that the offset between "wb" and "bio" is 
constant, so that there is no difference in the generated code before or 
after this patch.

Mikulas

> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  drivers/md/dm-writecache.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index f782287..5b4d1c1 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -1478,9 +1478,9 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
>  		bio = bio_alloc_bioset(GFP_NOIO, max_pages, &wc->bio_set);
>  		wb = container_of(bio, struct writeback_struct, bio);
>  		wb->wc = wc;
> -		wb->bio.bi_end_io = writecache_writeback_endio;
> -		bio_set_dev(&wb->bio, wc->dev->bdev);
> -		wb->bio.bi_iter.bi_sector = read_original_sector(wc, e);
> +		bio->bi_end_io = writecache_writeback_endio;
> +		bio_set_dev(bio, wc->dev->bdev);
> +		bio->bi_iter.bi_sector = read_original_sector(wc, e);
>  		wb->page_offset = PAGE_SIZE;
>  		if (max_pages <= WB_LIST_INLINE ||
>  		    unlikely(!(wb->wc_list = kmalloc_array(max_pages, sizeof(struct wc_entry *),
> @@ -1507,12 +1507,12 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
>  			wb->wc_list[wb->wc_list_n++] = f;
>  			e = f;
>  		}
> -		bio_set_op_attrs(&wb->bio, REQ_OP_WRITE, WC_MODE_FUA(wc) * REQ_FUA);
> +		bio_set_op_attrs(bio, REQ_OP_WRITE, WC_MODE_FUA(wc) * REQ_FUA);
>  		if (writecache_has_error(wc)) {
>  			bio->bi_status = BLK_STS_IOERR;
> -			bio_endio(&wb->bio);
> +			bio_endio(bio);
>  		} else {
> -			submit_bio(&wb->bio);
> +			submit_bio(bio);
>  		}
>  
>  		__writeback_throttle(wc, wbl);
> -- 
> 1.8.3.1
> 
