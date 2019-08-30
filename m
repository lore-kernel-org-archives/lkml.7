Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD72C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DA52343B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567198210;
	bh=+F7ljiSg6p5FWNKeDI6T/1PPD+xSpDlAYKC1QB46hI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UJlmWc+CA3E0tVAKc8pRNl9NoNSRrEMGXW4lLKGRz+0WvcnN07a3Y/AXqpSsGK3kQ
	 nI1KxSZAQgrL8H2BBDjMethEd3MlCTUQRSKaxmrZ06B/8MFu5OqyTvfEQV4pV37QfJ
	 0yXft4spyWcHbrruFj1I244y+VCNYfMJxoTtfTIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfH3UuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfH3UuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:50:09 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 258C123439;
        Fri, 30 Aug 2019 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567198208;
        bh=+F7ljiSg6p5FWNKeDI6T/1PPD+xSpDlAYKC1QB46hI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2d7DVqD9TskavURNZTbEB1iY1v0A5qusBehdR9V9DI2GTRw1T9+qOWAhs5lRRkDuN
         8/s1Z64FbnjVvdSZO8S7ndWxbXSBfupq+SQ6/57SQ3/F0j/M8ygAy0TvGdy81uPh41
         LrAPQ5tECRaUSOjvulcECL1rd1t31LTP5Fk6pAOg=
Date:   Fri, 30 Aug 2019 13:50:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     urezki@gmail.com, guro@fb.com, rpenyaev@suse.de, mhocko@suse.com,
        rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: move 'area->pages' after if statement
Message-Id: <20190830135007.8b5949bd57975d687ff0a3f8@linux-foundation.org>
In-Reply-To: <20190830035716.GA190684@LGEARND20B15>
References: <20190830035716.GA190684@LGEARND20B15>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 12:57:16 +0900 Austin Kim <austindh.kim@gmail.com> wrote:

> If !area->pages statement is true where memory allocation fails, 
> area is freed.
> 
> In this case 'area->pages = pages' should not executed.
> So move 'area->pages = pages' after if statement.
> 
> ...
>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2416,13 +2416,15 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	} else {
>  		pages = kmalloc_node(array_size, nested_gfp, node);
>  	}
> -	area->pages = pages;
> -	if (!area->pages) {
> +
> +	if (!pages) {
>  		remove_vm_area(area->addr);
>  		kfree(area);
>  		return NULL;
>  	}
>  
> +	area->pages = pages;
> +
>  	for (i = 0; i < area->nr_pages; i++) {
>  		struct page *page;
>  

Fair enough.  But we can/should also do this?

--- a/mm/vmalloc.c~mm-vmalloc-move-area-pages-after-if-statement-fix
+++ a/mm/vmalloc.c
@@ -2409,7 +2409,6 @@ static void *__vmalloc_area_node(struct
 	nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
 	array_size = (nr_pages * sizeof(struct page *));
 
-	area->nr_pages = nr_pages;
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
 		pages = __vmalloc_node(array_size, 1, nested_gfp|highmem_mask,
@@ -2425,6 +2424,7 @@ static void *__vmalloc_area_node(struct
 	}
 
 	area->pages = pages;
+	area->nr_pages = nr_pages;
 
 	for (i = 0; i < area->nr_pages; i++) {
 		struct page *page;
_

