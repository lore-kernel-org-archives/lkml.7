Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B422176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLRM1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:27:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:58074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfLRM1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:27:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 92EFAB2DA;
        Wed, 18 Dec 2019 12:27:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2677C1E0B2D; Wed, 18 Dec 2019 13:27:41 +0100 (CET)
Date:   Wed, 18 Dec 2019 13:27:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] bdev: reset first_open when looping in __blkget_dev
Message-ID: <20191218122741.GA19387@quack2.suse.cz>
References: <20191217180428.8868-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217180428.8868-1-msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-12-19 19:04:28, Michal Suchanek wrote:
> It is not clear that no other thread cannot open the block device when
> __blkget_dev drops it and loop to restart label. Reset first_open to
> false when looping.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Yeah, good catch. Thanks for the patch. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/block_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 69bf2fb6f7cd..17e1231d5246 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1560,7 +1560,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>  	int ret;
>  	int partno;
>  	int perm = 0;
> -	bool first_open = false;
> +	bool first_open;
>  
>  	if (mode & FMODE_READ)
>  		perm |= MAY_READ;
> @@ -1580,6 +1580,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>   restart:
>  
>  	ret = -ENXIO;
> +	first_open = false;
>  	disk = bdev_get_gendisk(bdev, &partno);
>  	if (!disk)
>  		goto out;
> -- 
> 2.23.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
