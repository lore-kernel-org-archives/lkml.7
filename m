Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AC6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4D32084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDJTnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:43:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJTnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:43:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F34B3094501;
        Wed, 10 Apr 2019 19:43:53 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78DF661995;
        Wed, 10 Apr 2019 19:43:52 +0000 (UTC)
Date:   Wed, 10 Apr 2019 15:43:50 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: pass down the bvec we need to read into in the
 work struct
Message-ID: <20190410194350.GA25351@redhat.com>
References: <20190408183219.26377-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408183219.26377-1-jglisse@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 10 Apr 2019 19:43:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding more Cc and stable (i thought this was 5.1 addition). Note that
without this patch on arch/kernel where PAGE_SIZE != 4096 userspace
could read random memory through a zram block device (thought userspace
probably would have no control on the address being read).

On Mon, Apr 08, 2019 at 02:32:19PM -0400, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> When scheduling work item to read page we need to pass down the proper
> bvec struct which point to the page to read into. Before this patch it
> uses randomly initialized bvec (only if PAGE_SIZE != 4096) which is
> wrong.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/block/zram/zram_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 399cad7daae7..d58a359a6622 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -774,18 +774,18 @@ struct zram_work {
>  	struct zram *zram;
>  	unsigned long entry;
>  	struct bio *bio;
> +	struct bio_vec bvec;
>  };
>  
>  #if PAGE_SIZE != 4096
>  static void zram_sync_read(struct work_struct *work)
>  {
> -	struct bio_vec bvec;
>  	struct zram_work *zw = container_of(work, struct zram_work, work);
>  	struct zram *zram = zw->zram;
>  	unsigned long entry = zw->entry;
>  	struct bio *bio = zw->bio;
>  
> -	read_from_bdev_async(zram, &bvec, entry, bio);
> +	read_from_bdev_async(zram, &zw->bvec, entry, bio);
>  }
>  
>  /*
> @@ -798,6 +798,7 @@ static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
>  {
>  	struct zram_work work;
>  
> +	work.bvec = *bvec;
>  	work.zram = zram;
>  	work.entry = entry;
>  	work.bio = bio;
> -- 
> 2.20.1
> 
