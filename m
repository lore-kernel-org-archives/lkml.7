Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A269C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0BF208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5yUuDrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfCZWx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:53:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39598 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfCZWx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:53:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so5248913pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IvI0L3Y11eT0LetkIXPjNVoXo7x8LZy31wCroQGbBwY=;
        b=F5yUuDrO9R6lsgmTPlObxDyOZMdHZ2uJIrmZUWHnHWMd5EPToTe88VH4ePxdtzWOWK
         bLQL+Urp5ayvClio7uBhOPwneeu5fpvN7pxH8pttue6+NEYNBRT6GukF0KIQX5zBJIqw
         YYPmxv46RryGiTsqhDtjowAUOrQFiuIiHQ3zGOPaPB1RMCLxRtnoHVgoRSRSzX0woU29
         N9rQRBj9Svn0k3RnQvZICPKkaUf1VGcOBszWNZYQuaDrz9TmYoekzEmMnO2nJwyOsfX7
         iUTM3RG6+i1wHY0SN8WPj6AU6pRRjAnqXyZLJhnW2uFhwTVjVntk+MhfIj2KOEzBYvFq
         fzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IvI0L3Y11eT0LetkIXPjNVoXo7x8LZy31wCroQGbBwY=;
        b=ulRyY5Cl/W22WHcu2XbqVK5FGwIq4UFWna+RaxpbTbIveTv6rjvLdOGXB/22/L3WAs
         RsiDuS8ykXEzdIsNyzWhE3fnuRjIkUTKzalCC/5UZ20x31t1QV9MtiawDMRis1NvZZ8z
         ROn0yAsyiH+Z8y9Yo5ddIEMfO9MFtB7KpMpargRi9DaOnRJpneHu4V33KhlZmkXEet80
         jYRlKEZk5vtszVWfvtZP2UEXhevbdJY2YGRCCOX5u1KQxsZgxtYRWqtR+twLSa0eefoP
         k3dVWw6/J8nPP2/yhDfTvdoxIEMs4eylTPdYe+uxAAMz8zj57jVNbOmP+InL1HqjjnXC
         o4EQ==
X-Gm-Message-State: APjAAAUzomPtVyHcfWSt0qFHEQxDtewqQOfqSOs/BY6F9cutbGQulK/a
        lUL7JlkZo5PmqUT7YqXzo0k=
X-Google-Smtp-Source: APXvYqxLaZY4Vdrd4gJh3m1BMmbbu/YLnn3PtHtgSGpgNvz+0LnCKe1gaKKYfeCUvvHTFQ4wjTJKKQ==
X-Received: by 2002:a63:c54a:: with SMTP id g10mr9442469pgd.71.1553640807238;
        Tue, 26 Mar 2019 15:53:27 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z77sm38303944pfi.155.2019.03.26.15.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 15:53:26 -0700 (PDT)
Date:   Tue, 26 Mar 2019 15:53:22 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: Re: [PATCH RFC/RFT 2/5] dma-remap: Run alloc_pages() on failure
Message-ID: <20190326225321.GA6796@Asurada-Nvidia>
References: <20190326224959.9656-1-nicoleotsuka@gmail.com>
 <20190326224959.9656-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326224959.9656-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:49:56PM -0700, Nicolin Chen wrote:
> @@ -116,7 +116,7 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
>  	if (dev_get_cma_area(NULL))
>  		page = dma_alloc_from_contiguous(NULL, nr_pages,
>  						 pool_size_order, false);
> -	else
> +	if (!page)
>  		page = alloc_pages(gfp, pool_size_order);

Just realized a missing change in this patch, will send v2.
Please ignore this version.
