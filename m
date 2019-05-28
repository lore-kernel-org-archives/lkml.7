Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A55CC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164A520883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="kJXW1iPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE1SvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:51:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36092 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfE1SvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:51:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so8714214plr.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lf1AnB62qhw98+618ZGhLajUkR17f9jQjLMbh4Rz9FI=;
        b=kJXW1iPNTRcAE9Q9c+VH9v1aGEM2iCTBz5wN+z65UUimrkHePkXEv0b0l1oY+anN4l
         WIsHpNLC3mTITPs6iksgTo9vXGR7iiVtMgupJnyesqRdsCU7XksSIfRX6SkUDr9Ua0NT
         6AlMO9VI9Z+gbyDrgMlrmb6zTJHLo4RwNbIMbpWdkvcgq+abFWdy2ljeukAmGlyZajgd
         zkAemVggg2YN9e3RhMvUvBcU6gibx35AyMsE+/MWTuxHtwWM2cBccZWOC2sQ3gt6mG5W
         86BQVnqAvexCPVBnKG/IbNWS4udQRaIMj+RnmDtF1wANiK65u4qnneGcmQ1X/LK36tIw
         AyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lf1AnB62qhw98+618ZGhLajUkR17f9jQjLMbh4Rz9FI=;
        b=HpIxu9VS962xjxjNIJ8fikoONJMShC8mHLZ2lOcxKreVzCB9RSBa+GaS764T6ThPPx
         U4McKnyAfRvZuBHmTGdmIivdXSYvAz8NYPgitC66kKDQTbuR2KvC1XBIrPirL6k0dGo/
         FzevLLIcIOZXJdZZe3MXeM4X0/Pi6bJfkKlzGvXB9f8jva9SZ/7xxPNcLRIcsBpAgWew
         CMOVKzgDhPVJfKT+uPts41WdQZGS2sqe5ua/BIP6g/Akn9ddGcJK5TeYSKIig5hxvCV2
         Ft7q7MvsYFcbBN6EJ5It5XcNqwZjRauEg64oh3LynfIOKs+WOZm94yJVrxX9WoXJ5Mzi
         TeSQ==
X-Gm-Message-State: APjAAAWYfjyA2Xeg6yBqob7CC8hlfJB/xeJqJl2FlRmx7aXCjOFiJjin
        bJQNAjVMB53lNBhQfqovdE1q1g==
X-Google-Smtp-Source: APXvYqzvnaB3xomsPWJIxIOMgQ7SOE8O+VgQEpFlys1d3ApVfYJPufOQP6OgNmLxk/I7PpRdHvAZTQ==
X-Received: by 2002:a17:902:a982:: with SMTP id bh2mr32098325plb.224.1559069460961;
        Tue, 28 May 2019 11:51:00 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:6f81])
        by smtp.gmail.com with ESMTPSA id i7sm15109099pfo.19.2019.05.28.11.50.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 11:51:00 -0700 (PDT)
Date:   Tue, 28 May 2019 11:50:59 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Peng Wang <wangpeng15@xiaomi.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Wang <rocking@whu.edu.cn>
Subject: Re: [PATCH] block: use KMEM_CACHE macro
Message-ID: <20190528185059.GB25022@vader>
References: <20190527114835.2071-1-wangpeng15@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527114835.2071-1-wangpeng15@xiaomi.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 07:48:35PM +0800, Peng Wang wrote:
> From: Peng Wang <rocking@whu.edu.cn>
> 
> Use the preferred KMEM_CACHE helper for brevity.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Peng Wang <rocking@whu.edu.cn>
> ---
>  block/blk-core.c | 3 +--
>  block/blk-ioc.c  | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 1bf83a0df0f6..841bf0b12755 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1789,8 +1789,7 @@ int __init blk_dev_init(void)
>  	if (!kblockd_workqueue)
>  		panic("Failed to create kblockd\n");
>  
> -	blk_requestq_cachep = kmem_cache_create("request_queue",
> -			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
> +	blk_requestq_cachep = KMEM_CACHE(request_queue, SLAB_PANIC);
>  
>  #ifdef CONFIG_DEBUG_FS
>  	blk_debugfs_root = debugfs_create_dir("block", NULL);
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 5ed59ac6ae58..58c79aeca955 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -408,8 +408,7 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
>  
>  static int __init blk_ioc_init(void)
>  {
> -	iocontext_cachep = kmem_cache_create("blkdev_ioc",
> -			sizeof(struct io_context), 0, SLAB_PANIC, NULL);
> +	iocontext_cachep = KMEM_CACHE(io_context, SLAB_PANIC);

This will change the name of the slab in slabinfo, but I can't imagine
that matters.

>  	return 0;
>  }
>  subsys_initcall(blk_ioc_init);
> -- 
> 2.19.1
> 
