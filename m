Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C94C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6142073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBZmtIH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfLKQfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:35:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39376 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729260AbfLKQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576082137;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=G2ZB3omzRfSfFMjDrR0LBqamRCs0vWgnzAtR96DPAFU=;
        b=TBZmtIH8PN8dWdMGlZxjiDmI9JZx/31WBjsVncYt2fLHWhEEOCaPzzEfsnDqKubXVrCWBn
        wOWmrhwOmN1FDQZLsXpAa55dm9KHfRHQReVOQwoq/UtAQLIjycdCiHHW5gOBr6I7CYCbO5
        djJIYcQzl86cmCB/h/ZFHMj2lft6Fjw=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216--ERRxf7MPzWx5EH9xbsn6w-1; Wed, 11 Dec 2019 11:35:35 -0500
X-MC-Unique: -ERRxf7MPzWx5EH9xbsn6w-1
Received: by mail-yw1-f70.google.com with SMTP id 199so17738719ywe.20
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 08:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=G2ZB3omzRfSfFMjDrR0LBqamRCs0vWgnzAtR96DPAFU=;
        b=oz4spAwVmkpaTDpdVtlz9Q9tWejB/S3IVC7gGGyymPyqUE3GnEaRCMJ2P75ghPEa/T
         dbZ6Yb1cDli7gPjxfDQ0WTAdnKaa4FUny0o4WRGbzsOoSDvxPhAyTX4c0G3/LhWHRzqX
         L7dHwwHYQCgNZF6w+gSVI7RzpQfhhfjOhT4fknX7/aIaMQODhBirten07LG9UAG9B3eR
         47RK7Pi77/QT0qI7tbbHQbVCav7hua3D6SRxjxu+5/FyL1EyizxN0cclSsPj+6CyG4IA
         YXvUqICBXVhkiQhrEdaKLN/JmDcE6l4/cCc9SV4v+cXQp1HGhzlC6WxavbYtpzFKzM6s
         JmUw==
X-Gm-Message-State: APjAAAWRbdQXtC3Kd2t/27/afKy9bzONaD+cSnyD/X7rbVsr4ULftR2z
        d+fP0EigWnZHV1a0iVtBJjww06bRxkKVKqMWG36zrLtggQV6nR+Hm5JOVnQ4TnlQT9y5+iZmiOs
        7xdxvYCGjDQ2cMWY8q/qSSRHT
X-Received: by 2002:a81:de03:: with SMTP id k3mr496981ywj.504.1576082135406;
        Wed, 11 Dec 2019 08:35:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQSheQ86BeD+t6fYx16LhovjTZbO/zkP9rZdQVuw6RgshPVg8mCAb+RC0yN7OH2NIGsZ9xUg==
X-Received: by 2002:a81:de03:: with SMTP id k3mr496966ywj.504.1576082135136;
        Wed, 11 Dec 2019 08:35:35 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l74sm1168529ywc.45.2019.12.11.08.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 08:35:34 -0800 (PST)
Date:   Wed, 11 Dec 2019 09:35:11 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191211163511.gjju2s3yy4sus44w@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191211014015.7898-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 11 19, Lu Baolu wrote:
>If the default DMA domain of a group doesn't fit a device, it
>will still sit in the group but use a private identity domain.
>When map/unmap/iova_to_phys come through iommu API, the driver
>should still serve them, otherwise, other devices in the same
>group will be impacted. Since identity domain has been mapped
>with the whole available memory space and RMRRs, we don't need
>to worry about the impact on it.
>

Does this pose any potential issues with the reverse case where the
group has a default identity domain, and the first device fits that,
but a later device in the group needs dma and gets a private dma
domain?

>Link: https://www.spinics.net/lists/iommu/msg40416.html
>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
>Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains replaced with private")
>Cc: stable@vger.kernel.org # v5.3+
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>---
> drivers/iommu/intel-iommu.c | 8 --------
> 1 file changed, 8 deletions(-)
>
>diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>index 0c8d81f56a30..b73bebea9148 100644
>--- a/drivers/iommu/intel-iommu.c
>+++ b/drivers/iommu/intel-iommu.c
>@@ -5478,9 +5478,6 @@ static int intel_iommu_map(struct iommu_domain *domain,
> 	int prot = 0;
> 	int ret;
>
>-	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>-		return -EINVAL;
>-
> 	if (iommu_prot & IOMMU_READ)
> 		prot |= DMA_PTE_READ;
> 	if (iommu_prot & IOMMU_WRITE)
>@@ -5523,8 +5520,6 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
> 	/* Cope with horrid API which requires us to unmap more than the
> 	   size argument if it happens to be a large-page mapping. */
> 	BUG_ON(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level));
>-	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>-		return 0;
>
> 	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
> 		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
>@@ -5556,9 +5551,6 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
> 	int level = 0;
> 	u64 phys = 0;
>
>-	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>-		return 0;
>-
> 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
> 	if (pte)
> 		phys = dma_pte_addr(pte);
>-- 
>2.17.1
>

