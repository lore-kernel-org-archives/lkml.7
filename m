Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E0FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED51C214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfDWKjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:39:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDWKjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:39:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40CCE7E436;
        Tue, 23 Apr 2019 10:39:22 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4EB660142;
        Tue, 23 Apr 2019 10:39:16 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x3NAdG8v030235;
        Tue, 23 Apr 2019 06:39:16 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x3NAdFY3030232;
        Tue, 23 Apr 2019 06:39:15 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 23 Apr 2019 06:39:15 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng Ye <yehs2007@zoho.com>
cc:     snitzer@redhat.com, agk@redhat.com, prarit@redhat.com,
        chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH] dm-writecache: remove unused member page_offset in
 writeback_struct
In-Reply-To: <20190420162017.6052-1-yehs2007@zoho.com>
Message-ID: <alpine.LRH.2.02.1904230638030.11112@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190420162017.6052-1-yehs2007@zoho.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 23 Apr 2019 10:39:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Apr 2019, Huaisheng Ye wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> The structure member page_offset in writeback_struct never has been
> used actually. Remove it.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

Acked-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-writecache.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index cfbbfbc..ddf1732 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -190,7 +190,6 @@ struct writeback_struct {
>  	struct dm_writecache *wc;
>  	struct wc_entry **wc_list;
>  	unsigned wc_list_n;
> -	unsigned page_offset;
>  	struct page *page;
>  	struct wc_entry *wc_list_inline[WB_LIST_INLINE];
>  	struct bio bio;
> @@ -1481,7 +1480,6 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
>  		bio->bi_end_io = writecache_writeback_endio;
>  		bio_set_dev(bio, wc->dev->bdev);
>  		bio->bi_iter.bi_sector = read_original_sector(wc, e);
> -		wb->page_offset = PAGE_SIZE;
>  		if (max_pages <= WB_LIST_INLINE ||
>  		    unlikely(!(wb->wc_list = kmalloc_array(max_pages, sizeof(struct wc_entry *),
>  							   GFP_NOIO | __GFP_NORETRY |
> -- 
> 1.8.3.1
> 
> 
