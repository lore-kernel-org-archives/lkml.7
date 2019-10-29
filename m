Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BDDCA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644B92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572336326;
	bh=PzbAw7ISADxFPEJ9RJkaVCHPc13ZdrvlPsM1FCf0Vrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nsn5tDJWdz2sLSgXidy8GOASogIoHe1lULDl4/StxzECuaooJV6+T3gtDMR3Zzz5W
	 wjtb9ED1SnliKRFn5oVSYtaNxYNNnCz7KQGVCHcI8dCHFuZzYWVrvuHsis43Gx8btW
	 ArMndHu0kPZD8Q3a0EyCsIPbiHD9yduluvyjAcPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfJ2IFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfJ2IFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:05:24 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C7920663;
        Tue, 29 Oct 2019 08:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572336323;
        bh=PzbAw7ISADxFPEJ9RJkaVCHPc13ZdrvlPsM1FCf0Vrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jq5pWBJu1F+2yAGQV7dYZ/v6bc4lLymodWJGH1+K+rEJcwDsdhuaBb/mTDfdmmQ9C
         NcV1Kt7CayhtdCN12x+FPv9v/RW8OP4JghN97AgOxAM7l0CDImanG3O8nZm2wM9DpM
         aeluFiM2mK0sCKSZisn+PEzpALwvoXMJKv3P+EUI=
Date:   Tue, 29 Oct 2019 09:05:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     valdis.kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat: Replace binary semaphores for
 mutexes
Message-ID: <20191029080521.GA494993@kroah.com>
References: <20191028024519.32344-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028024519.32344-1-dave@stgolabs.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 07:45:19PM -0700, Davidlohr Bueso wrote:
> At a slight footprint cost (24 vs 32 bytes), mutexes are more optimal
> than semaphores; it's also a nicer interface for mutual exclusion,
> which is why they are encouraged over binary semaphores, when possible.
> There is also lockdep support.
> 
> For both v_sem and z_sem, their semantics imply traditional lock
> ownership; that is, the lock owner is the same for both lock/unlock
> operations and nothing is done in irq context. Therefore it is safe
> to convert.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> This is part of further reducing semaphore users in the kernel.
> 
>  drivers/staging/exfat/exfat.h       |  2 +-
>  drivers/staging/exfat/exfat_super.c | 84 ++++++++++++++++++-------------------
>  2 files changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> index 6c12f2d79f4d..95c02f55de60 100644
> --- a/drivers/staging/exfat/exfat.h
> +++ b/drivers/staging/exfat/exfat.h
> @@ -618,7 +618,7 @@ struct fs_info_t {
>  	u32 dev_ejected;	/* block device operation error flag */
>  
>  	struct fs_func *fs_func;
> -	struct semaphore v_sem;
> +	struct mutex v_mutex;
>  
>  	/* FAT cache */
>  	struct buf_cache_t FAT_cache_array[FAT_CACHE_SIZE];
> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
> index 5f6caee819a6..c0b09b2dbe96 100644
> --- a/drivers/staging/exfat/exfat_super.c
> +++ b/drivers/staging/exfat/exfat_super.c
> @@ -283,7 +283,7 @@ static const struct dentry_operations exfat_dentry_ops = {
>  	.d_compare      = exfat_cmp,
>  };
>  
> -static DEFINE_SEMAPHORE(z_sem);
> +static DEFINE_MUTEX(z_mutex);
>  
>  static inline void fs_sync(struct super_block *sb, bool do_sync)
>  {
> @@ -352,11 +352,11 @@ static int ffsMountVol(struct super_block *sb)
>  
>  	pr_info("[EXFAT] trying to mount...\n");
>  
> -	down(&z_sem);
> +        mutex_lock(&z_mutex);

No tabs?  :(

