Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94E0C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25B921019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML6xZxh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfE2HYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:24:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46248 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2HYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:24:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so1012758pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 00:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpHPXBq8KvHvbVOvl8VVx4rTQEIBc+yRDEo5R/DXTDM=;
        b=ML6xZxh0hJe90j/v3mWzzYkO2KOVBfDxOp7EOrttZpaxNgo4v+jkI3jRGxPjOxUYsz
         k4iwHnLNKvBlXesx1X/1jJY006WLsz3g+q47Fld6/v+0QSazSDC5D1/my1y5oxIy9UjG
         nCJ3dtpF+62FL6onG4KgZa/e+vQU8Bu1MZXxqUg6X2rLeKY5D8E8mDqKzjua+yFsVEi+
         ohpMrYnsqr5+HTSyR3+ESLIcZUgtcDqWRPTut2AFJmoO/x88CKkBBfGzldCg+zibW2Kw
         po7tc87f+I9Mp2oOBaTx8WyH7K91cz1Wk8vl4V9UdwTmdylc6FuvDYKfnWUWbPSmBkdU
         AI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpHPXBq8KvHvbVOvl8VVx4rTQEIBc+yRDEo5R/DXTDM=;
        b=NAJO/D5lr1lIu0+OIbDKfYOEJzC5E94Yjo6yW5YLLuCoRGrPibjfpY7DAFFPt9QfXi
         qvpDP8upBpqpg5360Vi3KSWcp/kUZ/ySPOKp2lakpRrsmE5qqgFyd1sEMVXU6hzO9Oyq
         Rf811m2Dto2gEfMOLA3vSg6AcbK0ho9QXKHOQIU2K6OZSvTrVkovflNdpivsv0En1FQn
         QxnnDRtZO2TFs6Vvdmv4BVp9mlrrICgVK2B/L5KrNkPMedZjPMJREJbZ05aG9RE4tENt
         01uZilUcPV7s+qAqSS4ydRGXT+iBV0pigA0R4t2cQkkvhx0ZLbOs5NWsNheTfzl4KguU
         W5lQ==
X-Gm-Message-State: APjAAAUKEoZZbSnj42lBuYG+BpjTM4WkSKVO/o33LSjjMrUV2YJUxCHm
        dOpZY6j+F+V5Gbfg0X3mDM2xqIRK
X-Google-Smtp-Source: APXvYqxuvCTK3y2JN1wKkhCPAxhMoMaWb9H7F3jZFEtwkZAkDx2qQHpZo7gG1LJtGH2wZ33pY/T12A==
X-Received: by 2002:a17:90a:9b8b:: with SMTP id g11mr10095555pjp.103.1559114669495;
        Wed, 29 May 2019 00:24:29 -0700 (PDT)
Received: from localhost ([110.70.55.225])
        by smtp.gmail.com with ESMTPSA id l8sm5093517pgb.76.2019.05.29.00.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:24:28 -0700 (PDT)
Date:   Wed, 29 May 2019 16:24:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [UPSTREAM KERNEL] mm/zsmalloc.c: Add module parameter
 malloc_force_movable
Message-ID: <20190529072424.GA29276@jagdpanzerIV>
References: <20190529012230.89042-1-teawaterz@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529012230.89042-1-teawaterz@linux.alibaba.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/29/19 09:22), Hui Zhu wrote:
> When it enabled:
> ~# echo 1 > /sys/module/zsmalloc/parameters/malloc_force_movable
> ~# echo lz4 > /sys/module/zswap/parameters/compressor
> ~# echo zsmalloc > /sys/module/zswap/parameters/zpool
> ~# echo 1 > /sys/module/zswap/parameters/enabled
> ~# swapon /swapfile

[..]

>   * We assign a page to ZS_ALMOST_EMPTY fullness group when:
>   *	n <= N / f, where
> @@ -1479,6 +1486,9 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  	if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
>  		return 0;
>  
> +	if (zs_malloc_force_movable)
> +		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
> +
>  	handle = cache_alloc_handle(pool, gfp);
>  	if (!handle)
>  		return 0;

It's zsmalloc user's responsibility to pass appropriate GFP mask
to zs_malloc().

Take a loot at ZRAM, for instance,

	                handle = zs_malloc(zram->mem_pool, comp_len,
                                __GFP_KSWAPD_RECLAIM |
                                __GFP_NOWARN |
                                __GFP_HIGHMEM |
                                __GFP_MOVABLE);

zsmalloc should not change GFP. If zswap, for some reason,
doesn't pass __GFP_MOVABLE, then I'd suggest to patch zswap.

	-ss
