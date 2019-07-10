Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACFAC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA98F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="UZK6Vmsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfGJRvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:51:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40501 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfGJRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:51:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so1589085pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uKVGZA2rdeScy3bwyoxpCnlfJ0pW69jxWknu9B37i2E=;
        b=UZK6Vmsl0GscAoMkvtUuBih99iOojK11B4bvX2Y3xO14yXORhC/0bcYZdxrAsSPYm0
         3cghVrqwrNceZtWVPS2OmuOTg8jqhlsmP74StkkSqNt3ZRtstSVQ2rqC4oa52GhxYWYP
         szwnVtXKZPWmkwhy+poSNKK7HVBlvyd6PMe0AaVqrSmXPBtUAl6kBVIteBLTp/hzC6Ca
         k1HlOYguhdbAY0QSGQauUptYzwBBp44xNU1GSIkDnJl7S8EffJ29kXDie/6fcE2Xx+9R
         LzD9VvJHiopZz0iXo4NPCaCU19GtW2sXRJBRyMMl3LJh1svVA5UnfRFEThRroQv5H/BN
         8IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uKVGZA2rdeScy3bwyoxpCnlfJ0pW69jxWknu9B37i2E=;
        b=SbfWmoQo5ocgK5L78yDimnNg7YlK3hA3bXHYob1qd1quuOw94mv+sNp0E3ye5dJWaj
         ogsleDd3WNzTzR3bhd3uhkM/jT1p0dGeYa6EYqfD7YTT0F7yExFqTgJXYgKlU4tikDX1
         LUD4opOu1l6mLF3zrsrPOVmaa4TCjnyia7MAr/POoqXSViGVERLpP7ZkenUqur0ZCMl1
         cygnJAS6GUciW0RnAi+hL0lcljugDiEGcvbhNll+377HNCj/QgKUZ0jG58CGj5P2f5sw
         NJn4Iu+HGkiNF1LosQc5IVrU8uD/lDsxmSGVuf2lI3A+xzxLdbgo+OHWGZGnyIoUbAbf
         xF7g==
X-Gm-Message-State: APjAAAUEyuF6Je7rSS1wOJD8PzLrwXxWmL9JPYIYQMf7+v3E78kQ+qwz
        mwqcAM09ecb2seTVpOBBUeGYDQ==
X-Google-Smtp-Source: APXvYqxf3k6wj0r1DWMxtICEKSsf7cXHz1s9bD0kZqyeu5LkX+cE8uIy0dD31APMZFjW0w+y3Coc3A==
X-Received: by 2002:a17:902:1486:: with SMTP id k6mr39639657pla.177.1562781093710;
        Wed, 10 Jul 2019 10:51:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id j15sm2877546pfr.146.2019.07.10.10.51.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:51:32 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:51:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 1/6] filemap: check compound_head(page)->mapping in
 filemap_fault()
Message-ID: <20190710175131.GB11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-2-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:41PM -0700, Song Liu wrote:
> Currently, filemap_fault() avoids trace condition with truncate by
> checking page->mapping == mapping. This does not work for compound
> pages. This patch let it check compound_head(page)->mapping instead.
> 
> Acked-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index df2006ba0cfa..f5b79a43946d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2517,7 +2517,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  		goto out_retry;
>  
>  	/* Did it get truncated? */
> -	if (unlikely(page->mapping != mapping)) {
> +	if (unlikely(compound_head(page)->mapping != mapping)) {

There is another check like these in pagecache_get_page(), which is
used by find_lock_page() and thus the truncate code (partial page
truncate calls, but this could happen against read-only cache).
