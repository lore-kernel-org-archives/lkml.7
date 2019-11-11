Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C341C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6B3214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573513334;
	bh=T++SfRocne6R+FT0e/lITsou/+T1aj32czwC2JdYewE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bAW8bWH+4HCxDIvBFbmo/5us0d9YpthEsjHzGXe80gO8+WbdDMqjoIN+wrBTBtpOB
	 OVqzisvj0nmACNzx4exovtUOx7NUnEQyAD6cXaFQdNQaFrh3cDpXSfWW3MRe6GII5o
	 ZLzcVqvRqpMbQrV19qyzQtPRv3AK1l+wZAdaOWi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKKXCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfKKXCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:02:12 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4492720659;
        Mon, 11 Nov 2019 23:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573513332;
        bh=T++SfRocne6R+FT0e/lITsou/+T1aj32czwC2JdYewE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CQKri5plHXv4HgoJ+hznYR/EVTHZncht0g03GeabqQzNuFkDQoAn9HRNxRxvyQ6rH
         Bcf1tfMKN6NFERrTVn2O7MLCZ+rP+17cVnPl9jOC9iMGgLjIOb91megU1DFFWn6pT5
         2Bls1ZdntaFz/ltxHQfDlZ+AEBX87iFA6r735cYc=
Date:   Mon, 11 Nov 2019 15:02:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/debug:
Message-Id: <20191111150211.9f75292d8c057769603edfb7@linux-foundation.org>
In-Reply-To: <20191111224935.19464-1-rcampbell@nvidia.com>
References: <20191111224935.19464-1-rcampbell@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 14:49:35 -0800 Ralph Campbell <rcampbell@nvidia.com> wrote:

> When dumping struct page information, __dump_page() prints the page type
> with a trailing blank followed by the page flags on a separate line:
> 
> anon
> flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
> 
> Fix this by using pr_cont() instead of pr_warn() to get a single line:
> 
> anon flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  mm/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 8345bb6e4769..752c78721ea0 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -87,7 +87,7 @@ void __dump_page(struct page *page, const char *reason)
>  	}
>  	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>  
> -	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
> +	pr_cont("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  
>  hex_only:
>  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,

This is the case if PageAnon || PageKsm || mapping.  If it is, say,
PageSlab then we effectively do

	pr_warn("stuff-with-no-newline");
	pr_cont("\n");
	pr_cont("flags: ...\n");

does this work OK?  what facility level will that "flags: " line get?
