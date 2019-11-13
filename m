Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174DDC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EC122459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573624066;
	bh=CJjXEjxR2Mu7s5Ipuwyvj1rSxYqmnpVD6MbxLhm6Qgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zPccANb4r7jnyWn7+0ApayDXf1Ay3IPTxXvm3/yk43OdL1zwadhqXWTu+rWQ/FCeR
	 VrtCBM6qgp28prQB4VUAb3ePagkdoPtDbHq99nDAWXy2wBT5KL51TBwwwv8MfozKP1
	 xuEhdN4IlXV0maG+JcKXh6k2ejXqZzpv1QHawuW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfKMFrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 00:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfKMFrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 00:47:45 -0500
Received: from localhost (unknown [8.46.76.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC2AC21783;
        Wed, 13 Nov 2019 05:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573624064;
        bh=CJjXEjxR2Mu7s5Ipuwyvj1rSxYqmnpVD6MbxLhm6Qgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crGR8zI7RAGHrsQJThSHLxCMeIZuYUsWxmisll1JKWsInGzPsdTzLt+lV88Tr+OIj
         xdCHQkfIQGFSNdYubOhFDR4LKodNVx6M4qRPYQKJsTCy5EGBkX/e9KV6JqnV9RBJ4Z
         WuP2s1p0kVVgjp8RTFOKgkB89ei1tMsicPxC9m0w=
Date:   Wed, 13 Nov 2019 06:47:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     syzbot+787bcbef9b5fec61944b@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: convert WARN to a pr_info
Message-ID: <20191113054734.GA2058890@kroah.com>
References: <20191113025035.186051-1-valdis.kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113025035.186051-1-valdis.kletnieks@vt.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 09:50:34PM -0500, Valdis Kletnieks wrote:
> syzbot took a nosedive because it runs with panic_on_warn set. And
> it's quite correct, it shouldn't have been a WARN in the first place.
> Other locations just use a pr_info(), so do that here too.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Reported-by: syzbot+787bcbef9b5fec61944b@syzkaller.appspotmail.com
> Fixes: c48c9f7ff32b ("staging: exfat: add exfat filesystem code to staging")
> ---
>  drivers/staging/exfat/exfat_blkdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
> index 7bcd98b13109..8204720b2bf2 100644
> --- a/drivers/staging/exfat/exfat_blkdev.c
> +++ b/drivers/staging/exfat/exfat_blkdev.c
> @@ -59,8 +59,8 @@ int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head *
>  	if (*bh)
>  		return 0;
>  
> -	WARN(!p_fs->dev_ejected,
> -	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
> +	if (p_fs->dev_ejected)
> +		pr_info("[EXFAT] No bh, device seems wrong or to be ejected.\n");
>  
>  	return -EIO;
>  }
> @@ -112,8 +112,8 @@ int exfat_bdev_write(struct super_block *sb, sector_t secno, struct buffer_head
>  	return 0;
>  
>  no_bh:
> -	WARN(!p_fs->dev_ejected,
> -	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
> +	if (p_fs->dev_ejected)
> +		pr_info("[EXFAT] No bh, device seems wrong or to be ejected.\n");

Shouldn't these all be pr_err() calls as something did go wrong.

thanks,

greg k-h
