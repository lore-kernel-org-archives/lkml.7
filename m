Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4FBC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A7B20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sgHy6VMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLWXLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 18:11:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfLWXLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 18:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8UqunE6pGKgBFGh/0KYtTzCv0Na6jyRZMicJ6zr2gBA=; b=sgHy6VMUuDdjbg+SJ7kYPqOGz
        vLZWV459e0hnwluTTXSS5VfDCzpVrRLfVsgNgsv+w9N9ENuylDt+3ucrxUKChU9AvbLZaUa7ndKS/
        RGTTkZblZFEkSICjCEKQzZaYefus3p4q0abDkiB/w8PHoCmGVKrUvvWX7tt9GS3sSUSmeJ+fmH0eU
        Gm6Jm29U3VrH1gT+AJ6RALKWbtO/m8zFMlyvMjlHKUeV0k1YGNlEDGCjrly0iAyfrkU7vUYqgSAt/
        tyasLxK80fWnF8sJsOEtDqOfGKpBv/xbH/jpEd+6a550XR4j1pUoUdn4PdeKIv1aon6Is9OnGxB/N
        g9v+NisMg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ijWrB-0003my-0m; Mon, 23 Dec 2019 23:11:21 +0000
Date:   Mon, 23 Dec 2019 15:11:20 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [Patch v2] mm/rmap.c: split huge pmd when it really is
Message-ID: <20191223231120.GA31820@bombadil.infradead.org>
References: <20191223222856.7189-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223222856.7189-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 06:28:56AM +0800, Wei Yang wrote:
> When page is not NULL, function is called by try_to_unmap_one() with
> TTU_SPLIT_HUGE_PMD set. There are two cases to call try_to_unmap_one()
> with TTU_SPLIT_HUGE_PMD set:
> 
>   * unmap_page()
>   * shrink_page_list()
> 
> In both case, the page passed to try_to_unmap_one() is PageHead() of the
> THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
> aligned, this means the THP is not mapped as PMD THP in this process.
> This could happen when we do mremap() a PMD size range to an un-aligned
> address.
> 
> Currently, this case is handled by following check in __split_huge_pmd()
> luckily.
> 
>   page != pmd_page(*pmd)
> 
> This patch checks the address to skip some work.

The description here is confusing to me.

> +	/*
> +	 * When page is not NULL, function is called by try_to_unmap_one()
> +	 * with TTU_SPLIT_HUGE_PMD set. There are two places set
> +	 * TTU_SPLIT_HUGE_PMD
> +	 *
> +	 *     unmap_page()
> +	 *     shrink_page_list()
> +	 *
> +	 * In both cases, the "page" here is the PageHead() of a THP.
> +	 *
> +	 * If the page is not a PMD mapped huge page, e.g. after mremap(), it
> +	 * is not necessary to split it.
> +	 */
> +	if (page && !IS_ALIGNED(address, HPAGE_PMD_SIZE))
> +		return;

Repeating 75% of it as comments doesn't make it any less confusing.  And
it feels like we're digging a pothole for someone to fall into later.
Why not make it make sense ...

	if (page && !IS_ALIGNED(address, page_size(page))
		return;

