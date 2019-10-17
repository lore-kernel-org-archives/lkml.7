Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A5ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6999B21D7C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Z5ozsxrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406416AbfJQOjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:39:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41346 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403882AbfJQOjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:39:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id c17so893991qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPv4xGfmhNBcAudJ2m+U/PKGMmIbhs2/YkiMhF6fFPc=;
        b=Z5ozsxrLAow7bEU7nWG80R2CgeNG8zQPVzUL28MShaR4HDycfhOGCi8NaffDyAPvgD
         AIybmU8gw9TlH06J5Nu25r9iEAEFg/z7wjCu9bDYmbUcoBXw+plOlzkljXN+iUpVrvHe
         PGlPrqiGayV2ryqP8DJu8SMiX8/842fiXxbfVj52XoDzxXNqvWQJbkq3yn2W8ZI2jG4n
         DE2brcxf0FTMIcjPOygTmldJbycUwHlOhn1WI5Ac8dbJ3kAOm7ECVCqI30SsiNMJO0Te
         /3WwkxredcNT8VESSObYg2jVa3gZ2otkmLjZtpTOKAm9DNMPn9V8XlYjdpzOKpf8Rg1z
         x0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPv4xGfmhNBcAudJ2m+U/PKGMmIbhs2/YkiMhF6fFPc=;
        b=Bw3ZdjrX+1bad7szmLVdzmq8zsjEnNInDfH3k+xHrdJ8qNdwNOBPVayeT7z5cvivh9
         +/fwjahXckRPxvgXYwjU7jrzNlA+e53XpdUPPFsLLFyexHa4oUAhe8RU0cxiz1qRYxb/
         wtRKG3yjYL0gEF5uGwoTx+6jcXdX0JnZbblv5aM10/X1znDplEFbEecRSdzdPnv7bnuQ
         bWNlx95M6uiPvTwioyOqQvoWKpI1rO+qWOeceUdxYrvarIQI85v55iFbzuYcCVbi+46e
         UzN+muzZKcv6LHfCJkWOFDDNFfmGc5/+DKGB8IePh66A5MxdTg11+hckF6F3rk5nKMSr
         vvYQ==
X-Gm-Message-State: APjAAAVxRV93EW00C+eG9z8vml+GxBH7lsBkc1zlkXzPov0LWpoEdGX9
        wdIhE6YRABJJxYHVKgA+RaK2AA==
X-Google-Smtp-Source: APXvYqy7YdxTEZrz6r7lhrlzaTDa41hLtMCzXF8omQ5PUo8wn41x4fS6Wd2cEiqylNBXkJ0ldg5xJA==
X-Received: by 2002:ac8:6144:: with SMTP id d4mr4164799qtm.282.1571323156758;
        Thu, 17 Oct 2019 07:39:16 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i66sm1135765qkb.105.2019.10.17.07.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 07:39:15 -0700 (PDT)
Message-ID: <1571323153.5937.67.camel@lca.pw>
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
From:   Qian Cai <cai@lca.pw>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Oct 2019 10:39:13 -0400
In-Reply-To: <20191016154455.GG4695@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
         <1571237982.5937.60.camel@lca.pw> <20191016154455.GG4695@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 17:44 +0200, Joerg Roedel wrote:
> On Wed, Oct 16, 2019 at 10:59:42AM -0400, Qian Cai wrote:
> > BTW, the previous x86 warning was from only reverted one patch "iommu: Add gfp
> > parameter to iommu_ops::map" where proved to be insufficient. Now, pasting the
> > correct warning.
> 
> Can you please test this small fix:

This works fine so far.

> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 78a2cca3ac5c..e7a4464e8594 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2562,7 +2562,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
>  	if (iommu_prot & IOMMU_WRITE)
>  		prot |= IOMMU_PROT_IW;
>  
> -	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
> +	ret = iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
>  
>  	domain_flush_np_cache(domain, iova, page_size);
>  
> 
