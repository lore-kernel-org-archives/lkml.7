Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020EFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9E1222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pGcjRe0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfIZOCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:02:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37756 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfIZOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:02:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4so2150023edy.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HqMZowksWDEmK1Fr1I/qjh+3Z9WA+7ouwIOIARruFCo=;
        b=pGcjRe0CqEgRPI2GwJCc8ude/A8nS4wWSYKUibc51HceIeslgsZiabkoPgLplPtHJm
         GaMZ/xDBVWd7tfnuNdqCz27Da9mzZAcGnRsNVPEQEQNorBp2qk3W1TduAH+8Vdlw7iVs
         oOdf+pH+iYoUgVS1bueqJMeUZx2Q/3PZ0XSGx0I87FlVutpkSKbtd3XdGiCevUeP5Fsa
         icDiWoBt5TaJqGrWIHqKCvrldW73H93QwPr+BKFyN3tXXrQvxXxZ9aLPw3WHaHs47xUG
         lTNC3JCtpjjO4JCQKpua6uhx4ckq+sSEdM7iFj7hoOcR3ArceZx5Bp1wBlMHDiKvXeIK
         BU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HqMZowksWDEmK1Fr1I/qjh+3Z9WA+7ouwIOIARruFCo=;
        b=K75YKKDju/0tpTIBN0cSbjgXyTK9LN/D7sMKjxiXJg29liWrOQs1lxU8O7b9aIduWK
         kYBOw7oBNzMQQOaTgjok++koIlT3NWzPJ+/endzt0WgrdpHlWG0x8uBjmVCdUCwuHJxQ
         c6UwlVjNwGJVbEib1Iem7DmIFtuwL2rm2XpJV6ZMpTUq9KxT43HPvraIcZ/mXwqQ8gnl
         fCCewsxJ7q1o3h0YItSOXgCxN72vQEJPe30TCIWj5dB5ITA/jU+06LLpmTvzkghfpiEf
         /LqUJRayikddwhzhs8gLQrq6vublVe93QkAPwMEn2lU3dp3l8DPmNe8UlQkI+pXoD/ZJ
         A05Q==
X-Gm-Message-State: APjAAAUa4gWvynF/ZReNonrTSaIfCR7lSGZ6XyywIGNO7EeUXCHP5H0F
        BvpgM6sDfZK7w0XMr7l8cynE54qD/R4gBA==
X-Google-Smtp-Source: APXvYqxn1DAthLI1mxQooX7Y1Hqazoc6Inpuq0kb1jILQIzkrHHBgKYpH3qDtqldGu+gk9Qi+FqGIQ==
X-Received: by 2002:a17:906:1e57:: with SMTP id i23mr3272680ejj.204.1569506529181;
        Thu, 26 Sep 2019 07:02:09 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j10sm499205ede.59.2019.09.26.07.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 07:02:08 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 71CC1101CFB; Thu, 26 Sep 2019 17:02:11 +0300 (+03)
Date:   Thu, 26 Sep 2019 17:02:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] mm: Add file_offset_of_ helpers
Message-ID: <20190926140211.rm4b6yn2i5rlyvop@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-4-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:02PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The page_offset function is badly named for people reading the functions
> which call it.  The natural meaning of a function with this name would
> be 'offset within a page', not 'page offset in bytes within a file'.
> Dave Chinner suggests file_offset_of_page() as a replacement function
> name and I'm also adding file_offset_of_next_page() as a helper for the
> large page work.  Also add kernel-doc for these functions so they show
> up in the kernel API book.
> 
> page_offset() is retained as a compatibility define for now.

This should be trivial for coccinelle, right?

> ---
>  drivers/net/ethernet/ibm/ibmveth.c |  2 --
>  include/linux/pagemap.h            | 25 ++++++++++++++++++++++---
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index c5be4ebd8437..bf98aeaf9a45 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -978,8 +978,6 @@ static int ibmveth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  	return -EOPNOTSUPP;
>  }
>  
> -#define page_offset(v) ((unsigned long)(v) & ((1 << 12) - 1))
> -
>  static int ibmveth_send(struct ibmveth_adapter *adapter,
>  			union ibmveth_buf_desc *descs, unsigned long mss)
>  {
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 750770a2c685..103205494ea0 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -428,14 +428,33 @@ static inline pgoff_t page_to_pgoff(struct page *page)
>  	return page_to_index(page);
>  }
>  
> -/*
> - * Return byte-offset into filesystem object for page.
> +/**
> + * file_offset_of_page - File offset of this page.
> + * @page: Page cache page.
> + *
> + * Context: Any context.
> + * Return: The offset of the first byte of this page.
>   */
> -static inline loff_t page_offset(struct page *page)
> +static inline loff_t file_offset_of_page(struct page *page)
>  {
>  	return ((loff_t)page->index) << PAGE_SHIFT;
>  }
>  
> +/* Legacy; please convert callers */
> +#define page_offset(page)	file_offset_of_page(page)
> +
> +/**
> + * file_offset_of_next_page - File offset of the next page.
> + * @page: Page cache page.
> + *
> + * Context: Any context.
> + * Return: The offset of the first byte after this page.
> + */
> +static inline loff_t file_offset_of_next_page(struct page *page)
> +{
> +	return ((loff_t)page->index + compound_nr(page)) << PAGE_SHIFT;

Wouldn't it be more readable as

	return file_offset_of_page(page) + page_size(page);

?

> +}
> +
>  static inline loff_t page_file_offset(struct page *page)
>  {
>  	return ((loff_t)page_index(page)) << PAGE_SHIFT;
> -- 
> 2.23.0
> 
> 

-- 
 Kirill A. Shutemov
