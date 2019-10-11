Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F09C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C66521D82
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dRKTtlJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfJKNIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:08:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44342 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbfJKNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:08:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id m13so9724487ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 06:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rianfJYqECdE+QtZW64kQ5yJr8Uz6OZaARSFrVw9bs4=;
        b=dRKTtlJErIwNFWVHk1FM6s4j/GT2w063GFu4qYGKPW9/iqI/6KiBlI2str4R28wVaW
         4rpQ17qOSD4O81+2oGq2m9O/xphLmFW+MxtukVtcsG2m2yAFrtJwl0KCOERCSQf4YP9G
         qKKzrT4g5wqVcL59YHcAMqGCG3Y9GI5Kc8/mkqhd5D5B/291mg61LC2sZa/roTggWPL0
         +uhm7EusNkG0unhs57yT+Un6M86uH0dmgREsXCSwTqKywA7uG+ezCPRSAf4ryOIaI7Iy
         wZx5Jw8DS/W9L/0d9F30JzgJTBjY6NllJ8YMC5YPnLTC+ZTrTkZcERIxMWKeTC9A0RMx
         oi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rianfJYqECdE+QtZW64kQ5yJr8Uz6OZaARSFrVw9bs4=;
        b=LGz7DU06HOmB/W0dZ9Qxnr43CIQzKIYDV3y68wRqeQqu8Iya4U29scveYxt5fLA6h+
         W8CEwPv9sbHwsKI/3PbVUMEQ/4DKgt9R6KU/qP2fTavYViiwm4gsj2KEnLGnPgNeUfuw
         ievry/On9t9DDZ1dMg4CVQzO1Hp2yfBY7QVXmPA/OYzBPSsfmsBv5ojYiDXaxmYfNGOg
         84UjrLbG7ed3DysclHZ6zGY8qZ060ZRaf1jnBBBot8lqUawKgQLdHicnS+9tacKR/hvW
         n22HYdj90bAltTKAuEm7loLHBwDsEKOQDBo+po+0ZelpmhNtfQpe6lyav9XrDoybFX8t
         mEOg==
X-Gm-Message-State: APjAAAUDkiC3gyJO5J2BjRuMOdyQ+amlyraJr3JSpExkAL8gxemhs/NJ
        aTPyo5LTHTLp0Mow/8cQ+jXz9g==
X-Google-Smtp-Source: APXvYqwypjthT7nDft61JPMpe4A6BPPPb5GutnCDtzzxJ0ODUqmxKoczKMz8zINqEEhUApStCMTFBg==
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr9323694ljj.140.1570799321440;
        Fri, 11 Oct 2019 06:08:41 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i11sm1952023ljb.74.2019.10.11.06.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:08:40 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C7973102DC1; Fri, 11 Oct 2019 16:08:40 +0300 (+03)
Date:   Fri, 11 Oct 2019 16:08:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [RFC PATCH 1/4] mm: Have the mempolicy pagewalk to avoid
 positive callback return codes
Message-ID: <20191011130840.qusspibjxb7iswuq@box>
References: <20191010134058.11949-1-thomas_os@shipmail.org>
 <20191010134058.11949-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191010134058.11949-2-thomas_os@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 03:40:55PM +0200, Thomas Hellström (VMware) wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> The pagewalk code is being reworked to have positive callback return codes
> do walk control. Avoid using positive return codes: "1" is replaced by
> "-EBUSY".
> 
> Co-developed-by: Thomas Hellstrom <thellstrom@vmware.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>  mm/mempolicy.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967bcf954..df34c7498c27 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -482,8 +482,8 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>   *
>   * queue_pages_pte_range() has three possible return values:
>   * 0 - pages are placed on the right node or queued successfully.
> - * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> - *     specified.
> + * -EBUSY - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> + *          specified.
>   * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
>   *        on a node that does not follow the policy.
>   */
> @@ -503,7 +503,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  	if (ptl) {
>  		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
>  		if (ret != 2)
> -			return ret;
> +			return (ret == 1) ? -EBUSY : ret;

It would be cleaner to propagate the error code logic to queue_pages_pmd()
too: 0 - placed, 1 - split, -EBUSY - unmovable, ...

>  	}
>  	/* THP was split, fall through to pte walk */
>  
> @@ -546,7 +546,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  	cond_resched();
>  
>  	if (has_unmovable)
> -		return 1;
> +		return -EBUSY;
>  
>  	return addr != end ? -EIO : 0;
>  }
> @@ -669,9 +669,9 @@ static const struct mm_walk_ops queue_pages_walk_ops = {
>   * passed via @private.
>   *
>   * queue_pages_range() has three possible return values:
> - * 1 - there is unmovable page, but MPOL_MF_MOVE* & MPOL_MF_STRICT were
> - *     specified.
>   * 0 - queue pages successfully or no misplaced page.
> + * -EBUSY - there is unmovable page, but MPOL_MF_MOVE* & MPOL_MF_STRICT were
> + *	    specified.
>   * -EIO - there is misplaced page and only MPOL_MF_STRICT was specified.
>   */
>  static int
> @@ -1285,7 +1285,7 @@ static long do_mbind(unsigned long start, unsigned long len,
>  	ret = queue_pages_range(mm, start, end, nmask,
>  			  flags | MPOL_MF_INVERT, &pagelist);
>  
> -	if (ret < 0) {
> +	if (ret < 0 && ret != -EBUSY) {
>  		err = -EIO;
>  		goto up_out;
>  	}
> @@ -1303,7 +1303,7 @@ static long do_mbind(unsigned long start, unsigned long len,
>  				putback_movable_pages(&pagelist);
>  		}
>  
> -		if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
> +		if ((ret < 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
>  			err = -EIO;
>  	} else
>  		putback_movable_pages(&pagelist);
> -- 
> 2.21.0
> 

-- 
 Kirill A. Shutemov
