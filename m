Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9778EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A47D2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVMM2CqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfCYSu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:50:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35345 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:50:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so7031626pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eHEqN8RchpW9cQqx29MhEE+6xAHCbDTQMusBcMWC6HA=;
        b=ZVMM2CqYTw61pb0x+nI/e/GyrmwL9NSbWBZlrIIwIiNJ7mjfrGnaFluJ1opDtp4W0n
         DxDlSXMrLIGz3OgPbeZ4RCT9eMVlco08pNFyv9sqX/hirZbHUJCahAD2wuteg/U84XBP
         3cEmNa2UOZi2qCdJAUv48IyxSI1GcdVGjvu+uJkN62wlNF5oGIuuKzLBeRsCeW+s4NGF
         tgLXCN9HyY1mLzUYQiwrj4sCxjbinBofMLLR7N2ce3lBlC5iG9j9ZbZPjd6x27cOmxcN
         twwFjx6LsAKSQeNu9CGr/1KKUWMLKD9Dz0roB7YrQq1Py6Eh6nZosWJeZKe8z3xpJwyS
         xw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eHEqN8RchpW9cQqx29MhEE+6xAHCbDTQMusBcMWC6HA=;
        b=e2vZyVcgKOOt8WKNwNEfu3lmZ1vmQUEjNHXcRvhDzr1pOdNokDp09CulnC/Xbi03oz
         SKQtiVd4PJnLQ39BQUHIR8E/w55h2VsKndIgbg2yYcRST2aZTb/GekSsI4+ttReRAr5y
         /FMjqBlSaN3sEIJR0zlfTZYAWxKI9NCk852V4XlTSD/PGSuMt0jvW4fjswg9ACkRjXz8
         EpOtunqoy9DBuo+t/JUU8BfngnDOH/x4lYTfFpKjQeZswOECfvAPTIEWG9lcWYXFT7to
         wnYI8fIxqpNrXJQ5N3TdsiWfUT36G+rbU3Y9xVbnibcky1d89Iml2n07Y/10ZP/srlaJ
         6ujw==
X-Gm-Message-State: APjAAAV09IkpxGq7BEVccMKdO+2xrJW0SJ+cC8J2SSpG7dLFICKMdkIZ
        CvKWQThsd+nXLpgrgwpizAU=
X-Google-Smtp-Source: APXvYqw2ujdsGltJwCw3aBx9fMEYw9b+DIR9c+2St8VhgWNS7XDm285yigrG3g+NzYUa17UgumtKhA==
X-Received: by 2002:aa7:8289:: with SMTP id s9mr12752691pfm.208.1553539828221;
        Mon, 25 Mar 2019 11:50:28 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w18sm28928437pfg.75.2019.03.25.11.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 11:50:27 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:50:23 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH v2 RFC/RFT] dma-contiguous: Get normal pages for
 single-page allocations
Message-ID: <20190325185022.GA24188@Asurada-Nvidia>
References: <20190305183202.16216-1-nicoleotsuka@gmail.com>
 <20190319144301.GG59586@arrakis.emea.arm.com>
 <20190321233248.GA6941@Asurada-Nvidia>
 <20190322105712.GB13384@arrakis.emea.arm.com>
 <20190322200925.GA22219@Asurada-Nvidia>
 <20190325121436.hwmzgqkaggxvnfqx@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325121436.hwmzgqkaggxvnfqx@mbp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 12:14:37PM +0000, Catalin Marinas wrote:

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index fcdb23e8d2fc..8955ba6f52fc 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -111,8 +111,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  again:
>  	/* CMA can be used only in the context which permits sleeping */
>  	if (gfpflags_allow_blocking(gfp)) {
> -		page = dma_alloc_from_contiguous(dev, count, page_order,
> -						 gfp & __GFP_NOWARN);
> +		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);

Oh...yea...It should have this part. I messed up with some
thing else so couldn't get it. Thanks for the reply.

I will go for the previous change by returning NULL in the
dma_alloc_from_contiguous() so the no_warm parameter would
not be touched.
