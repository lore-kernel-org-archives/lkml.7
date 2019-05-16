Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066CCC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3342206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0BHnDF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfEPLXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:23:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44419 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfEPLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:23:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so4678716edm.11;
        Thu, 16 May 2019 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LV1CkEaEqDI0sBIvJmZERS53kRl0OTlvTtScZy5Ad/M=;
        b=r0BHnDF87+z9s+FxD0fWmVXlzNhHZfMGNjy9XQ4m3Cne8SdI+1y22gen05yZdoHX40
         JnVLCZ/NFRZ5yvASCZPsjDPko9keQ7mV/OqDITHdaFVnkuKh4ISSzGRZd6VCh/VSrOkQ
         7B7elPESfOzvEV00cRJLidAgr+FAJbph4gPct2TCHSL40gd8MEn2O3/vLDyPE2z5/p6h
         EClUt2XeKdg7QlYPIbCN2EKUep20Hplc0eZqvDaRYEjdp3EK9cKf62Rz7aB4VimujdOb
         L6Yofly2DtndxTk33EYEvaXn5Gp+0Ev/tps9NAx36755l92iFp0EjquV86wYUzVNbWNR
         pmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LV1CkEaEqDI0sBIvJmZERS53kRl0OTlvTtScZy5Ad/M=;
        b=qqo00OJBG7kWETULm0jMMtzW3853NmPpg80DEDys1AIt4Zu43ReSLzlgbjl+4m98fx
         byXvTsGsPsO8nhSvQfNwLK0HikEgXgVb5xrdnxidFEHqy6ofAf16QGcImgon/4Mwgojh
         fTjw4H+pHv5CG0eCPgYC1ykMERNRfn1waJyvZTH8Tp0FLgDj29kWrVF9aJefiQdHjZU4
         c3w3en1WGr439y9+meJErZqfIlyCETkrqnjFpE7LKcxLD937PD+dzHuuPSRaSxlUIdi2
         c01CXUetxmBtE95Rhb9dDkHAFsvlne1LXULrd5YQ91nQ0OIgtlFywMeDcF7EcypUhsSW
         YO5A==
X-Gm-Message-State: APjAAAUOqOUjQRbYfuSPDLYowI5qGU3Ap8SqSswWGvdchlfNKbY7CH8L
        OtVWwM0l+QHCTcIhlCNZzOtjPHdp
X-Google-Smtp-Source: APXvYqwTd2yfrjCLq+03LWLkIiHcUb3QKno+8Q0ZZsvoqd99/Kmo5mybs3u1pwAK0551NvZ1yC7yfw==
X-Received: by 2002:a17:906:2482:: with SMTP id e2mr38405804ejb.289.1558005812033;
        Thu, 16 May 2019 04:23:32 -0700 (PDT)
Received: from geeko ([191.249.67.249])
        by smtp.gmail.com with ESMTPSA id d19sm1040239ejb.89.2019.05.16.04.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 04:23:31 -0700 (PDT)
Date:   Thu, 16 May 2019 08:23:19 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     neilb@suse.com, Shaohua Li <shli@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] drivers: md: Unify common definitions of raid1 and raid10
Message-ID: <20190516112317.GA8611@geeko>
References: <20190509111849.22927-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509111849.22927-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping.

On Thu, May 09, 2019 at 08:18:49AM -0300, Marcos Paulo de Souza wrote:
> These definitions are being moved to raid1-10.c.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/md/raid1-10.c | 25 +++++++++++++++++++++++++
>  drivers/md/raid1.c    | 29 ++---------------------------
>  drivers/md/raid10.c   | 27 +--------------------------
>  3 files changed, 28 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index 400001b815db..7d968bf08e54 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -3,6 +3,31 @@
>  #define RESYNC_BLOCK_SIZE (64*1024)
>  #define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
>  
> +/*
> + * Number of guaranteed raid bios in case of extreme VM load:
> + */
> +#define	NR_RAID_BIOS 256
> +
> +/* when we get a read error on a read-only array, we redirect to another
> + * device without failing the first device, or trying to over-write to
> + * correct the read error.  To keep track of bad blocks on a per-bio
> + * level, we store IO_BLOCKED in the appropriate 'bios' pointer
> + */
> +#define IO_BLOCKED ((struct bio *)1)
> +/* When we successfully write to a known bad-block, we need to remove the
> + * bad-block marking which must be done from process context.  So we record
> + * the success by setting devs[n].bio to IO_MADE_GOOD
> + */
> +#define IO_MADE_GOOD ((struct bio *)2)
> +
> +#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
> +
> +/* When there are this many requests queue to be written by
> + * the raid thread, we become 'congested' to provide back-pressure
> + * for writeback.
> + */
> +static int max_queued_requests = 1024;
> +
>  /* for managing resync I/O pages */
>  struct resync_pages {
>  	void		*raid_bio;
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 0c8a098d220e..bb052c35bf29 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -50,31 +50,6 @@
>  	 (1L << MD_HAS_PPL) |		\
>  	 (1L << MD_HAS_MULTIPLE_PPLS))
>  
> -/*
> - * Number of guaranteed r1bios in case of extreme VM load:
> - */
> -#define	NR_RAID1_BIOS 256
> -
> -/* when we get a read error on a read-only array, we redirect to another
> - * device without failing the first device, or trying to over-write to
> - * correct the read error.  To keep track of bad blocks on a per-bio
> - * level, we store IO_BLOCKED in the appropriate 'bios' pointer
> - */
> -#define IO_BLOCKED ((struct bio *)1)
> -/* When we successfully write to a known bad-block, we need to remove the
> - * bad-block marking which must be done from process context.  So we record
> - * the success by setting devs[n].bio to IO_MADE_GOOD
> - */
> -#define IO_MADE_GOOD ((struct bio *)2)
> -
> -#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
> -
> -/* When there are this many requests queue to be written by
> - * the raid1 thread, we become 'congested' to provide back-pressure
> - * for writeback.
> - */
> -static int max_queued_requests = 1024;
> -
>  static void allow_barrier(struct r1conf *conf, sector_t sector_nr);
>  static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
>  
> @@ -2955,7 +2930,7 @@ static struct r1conf *setup_conf(struct mddev *mddev)
>  	if (!conf->poolinfo)
>  		goto abort;
>  	conf->poolinfo->raid_disks = mddev->raid_disks * 2;
> -	err = mempool_init(&conf->r1bio_pool, NR_RAID1_BIOS, r1bio_pool_alloc,
> +	err = mempool_init(&conf->r1bio_pool, NR_RAID_BIOS, r1bio_pool_alloc,
>  			   r1bio_pool_free, conf->poolinfo);
>  	if (err)
>  		goto abort;
> @@ -3240,7 +3215,7 @@ static int raid1_reshape(struct mddev *mddev)
>  	newpoolinfo->mddev = mddev;
>  	newpoolinfo->raid_disks = raid_disks * 2;
>  
> -	ret = mempool_init(&newpool, NR_RAID1_BIOS, r1bio_pool_alloc,
> +	ret = mempool_init(&newpool, NR_RAID_BIOS, r1bio_pool_alloc,
>  			   r1bio_pool_free, newpoolinfo);
>  	if (ret) {
>  		kfree(newpoolinfo);
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 3b6880dd648d..24cb116d950f 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -73,31 +73,6 @@
>   *    [B A] [D C]    [B A] [E C D]
>   */
>  
> -/*
> - * Number of guaranteed r10bios in case of extreme VM load:
> - */
> -#define	NR_RAID10_BIOS 256
> -
> -/* when we get a read error on a read-only array, we redirect to another
> - * device without failing the first device, or trying to over-write to
> - * correct the read error.  To keep track of bad blocks on a per-bio
> - * level, we store IO_BLOCKED in the appropriate 'bios' pointer
> - */
> -#define IO_BLOCKED ((struct bio *)1)
> -/* When we successfully write to a known bad-block, we need to remove the
> - * bad-block marking which must be done from process context.  So we record
> - * the success by setting devs[n].bio to IO_MADE_GOOD
> - */
> -#define IO_MADE_GOOD ((struct bio *)2)
> -
> -#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
> -
> -/* When there are this many requests queued to be written by
> - * the raid10 thread, we become 'congested' to provide back-pressure
> - * for writeback.
> - */
> -static int max_queued_requests = 1024;
> -
>  static void allow_barrier(struct r10conf *conf);
>  static void lower_barrier(struct r10conf *conf);
>  static int _enough(struct r10conf *conf, int previous, int ignore);
> @@ -3684,7 +3659,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
>  
>  	conf->geo = geo;
>  	conf->copies = copies;
> -	err = mempool_init(&conf->r10bio_pool, NR_RAID10_BIOS, r10bio_pool_alloc,
> +	err = mempool_init(&conf->r10bio_pool, NR_RAID_BIOS, r10bio_pool_alloc,
>  			   r10bio_pool_free, conf);
>  	if (err)
>  		goto out;
> -- 
> 2.21.0
> 

-- 
Thanks,
Marcos
