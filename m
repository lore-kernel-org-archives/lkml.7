Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0B3C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037D420856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="aXpDJ9aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfILJqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:46:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44658 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfILJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:46:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id p2so22159087edx.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+UyKiSlCaUkZGSuO0Sn5mI0OYBngHSXLKAH/562lIqI=;
        b=aXpDJ9aB0wt3TGU0/ZL7E4RmOYJxeN5X/S5JG56aeGrcXRjwWCzWTem0AkaoNFe990
         bbE9Omc+2tzXG9k75Ev0aAclSuz8BCC9xlRjcZY5SkuudR4RcJLpGcGK6TqZvqbiSrOn
         W0OEkpagpUWEmj45mgjtp27+YzCfGbvHnPUtQXLjRci0ORz4NZco6SDSjS6kxxeuNqf8
         dAMhtWIDh5TXG8Ti3lTRUNNrp3i/dODe9ejjJmlbJuL5Ie7yK+TxFSC20cIM2TwFaTV/
         KPVnBfabA9Ld+Zvd1kdKeLfKUdaRigCO94b1SCtPgCv0zksO1KPMyWvI+eaXpEFpfNPB
         gSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+UyKiSlCaUkZGSuO0Sn5mI0OYBngHSXLKAH/562lIqI=;
        b=NpUn1JXr31RCtNTIhbOXD8K3z18KEe36hEFl1tjmz3A7h/6Cmeu9QKJnBCYsuHervD
         GHu0MFIqv5uQ+y/+qRgpIMlGBPDxfmmV4fE+nb7KOFhJ2HHfhDsmcW/sQVS3lDbqevUW
         FrwLMq4V0xkx5QlP68RElwNsI35pqYxp1zv7N7FRnVnWjWPkJD5+bHhTAHrRfuNhZTor
         9XPUW//bh5EO8rfVmXXA2PgTTTGoexkrz+EBP6peS50xUBKIzIX+YGFV3evPLIexd3mW
         6wHp7cHqIVX7G3lIZzflH4ABztJNawAceKdhfEzAWEf53hiprW+Pj9rAL4UkzwJpl3/9
         Tyew==
X-Gm-Message-State: APjAAAW1EqK8V+Px4aDfXsWiCrydHJVC/KSChaumtuC3JPM23FozBLkx
        EgKmJ+EgQmDrHvqhy/dFbN/V9g==
X-Google-Smtp-Source: APXvYqzcJuQSNTfTiOqDf5b9PLpt0sipTAEEY55d+MmxRm6Hkg07fkj/J7ssBpH9EfThJXAmhT/EVw==
X-Received: by 2002:aa7:d899:: with SMTP id u25mr39791190edq.289.1568281582725;
        Thu, 12 Sep 2019 02:46:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t21sm2728489ejf.27.2019.09.12.02.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 02:46:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3884C100B4A; Thu, 12 Sep 2019 12:46:23 +0300 (+03)
Date:   Thu, 12 Sep 2019 12:46:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: clean up validate_slab()
Message-ID: <20190912094623.fn6qdefrnnskdai5@box>
References: <20190912004401.jdemtajrspetk3fh@box>
 <20190912023111.219636-1-yuzhao@google.com>
 <20190912023111.219636-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912023111.219636-2-yuzhao@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:31:09PM -0600, Yu Zhao wrote:
> The function doesn't need to return any value, and the check can be
> done in one pass.
> 
> There is a behavior change: before the patch, we stop at the first
> invalid free object; after the patch, we stop at the first invalid
> object, free or in use. This shouldn't matter because the original
> behavior isn't intended anyway.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  mm/slub.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 62053ceb4464..7b7e1ee264ef 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4386,31 +4386,26 @@ static int count_total(struct page *page)
>  #endif
>  
>  #ifdef CONFIG_SLUB_DEBUG
> -static int validate_slab(struct kmem_cache *s, struct page *page,
> +static void validate_slab(struct kmem_cache *s, struct page *page,
>  						unsigned long *map)
>  {
>  	void *p;
>  	void *addr = page_address(page);
>  
> -	if (!check_slab(s, page) ||
> -			!on_freelist(s, page, NULL))
> -		return 0;
> +	if (!check_slab(s, page) || !on_freelist(s, page, NULL))
> +		return;
>  
>  	/* Now we know that a valid freelist exists */
>  	bitmap_zero(map, page->objects);
>  
>  	get_map(s, page, map);
>  	for_each_object(p, s, addr, page->objects) {
> -		if (test_bit(slab_index(p, s, addr), map))
> -			if (!check_object(s, page, p, SLUB_RED_INACTIVE))
> -				return 0;
> -	}
> +		u8 val = test_bit(slab_index(p, s, addr), map) ?
> +			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;

Proper 'if' would be more readable.

Other than that look fine to me.

>  
> -	for_each_object(p, s, addr, page->objects)
> -		if (!test_bit(slab_index(p, s, addr), map))
> -			if (!check_object(s, page, p, SLUB_RED_ACTIVE))
> -				return 0;
> -	return 1;
> +		if (!check_object(s, page, p, val))
> +			break;
> +	}
>  }
>  
>  static void validate_slab_slab(struct kmem_cache *s, struct page *page,
> -- 
> 2.23.0.162.g0b9fbb3734-goog
> 

-- 
 Kirill A. Shutemov
