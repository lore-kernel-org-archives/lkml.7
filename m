Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FF620652
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qp/yQsrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfLLBuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:50:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30246 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727473AbfLLBuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576115415;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=zOCpd5dg0eh5r36GlPBDFDvAydvpE/EG+PVXZHD/BXE=;
        b=Qp/yQsrHMx2u4rVS/8qDEXIPiy6MiYQmgEUUzLJvUnqIav3uJq4PF9PVJgsQwSJBQRPKPa
        t+haXk/dMTKa5C7jXtQp30GRVhz8WG2z7ZPmq21pBtlPSThKpXQ6kr+XXIbXe7+OxCfbwS
        f7s9fA3fcy44gbt7burrY28ANKnoUBw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-sttKlC52PvS_guy4nrxQrw-1; Wed, 11 Dec 2019 20:50:12 -0500
X-MC-Unique: sttKlC52PvS_guy4nrxQrw-1
Received: by mail-qk1-f198.google.com with SMTP id a6so429677qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zOCpd5dg0eh5r36GlPBDFDvAydvpE/EG+PVXZHD/BXE=;
        b=EzplPijVGlz/VAMfKNz2zZaB102XG948D3PRNMx8FEqteHOcRuzvj2e7bMY7H+18bO
         vyzscmfXomGAK2HN8zfb/MraS/lkUWGQQ7tACdYi8+i/APkQ94W27JWc56PhTJCyuDJ9
         W51GT5ASXywgjXWqoBk+Syh4rzuVjzTHdxOrbiV9vXceKSHZ63vtFJgMu/P4vplH1Nvj
         wZKoHQanxJRTZEZqlHTQ77WsI0HCQh19a4AdB4Mg/oz6qyiK3Fd2Djr/7CZI3eKP0uzj
         8wh7ybqlrsP1AuE4rDlmqioIlz3GXV8E/Ry6Bks6oiZdEnHvjGQGwBWUO7gi9f8jXD2q
         wqNQ==
X-Gm-Message-State: APjAAAUqqe6o1bx1XxVaRs7TDvm4W6+IGWE2L8lmJYqawucvFTAJiRKt
        0bSNMN60MsleNpgrudg3glijP6IeyfVoe04LnjqRFOd4+b73Euby+FHUMOilcVvCdT7VxGBju59
        +pypeKSxh5B+pN9P1AWLLiM5e
X-Received: by 2002:a37:92c5:: with SMTP id u188mr5637353qkd.200.1576115411215;
        Wed, 11 Dec 2019 17:50:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfbRkU1ye8MmdMrabMR9H2moF0xl9FH3NmkfIwiVFtmXM1Vy3Vd2+hTWAPFImOsUzGrtoiAg==
X-Received: by 2002:a37:92c5:: with SMTP id u188mr5637331qkd.200.1576115410806;
        Wed, 11 Dec 2019 17:50:10 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x16sm1263627qki.110.2019.12.11.17.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 17:50:09 -0800 (PST)
Date:   Wed, 11 Dec 2019 18:49:52 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191212014952.vlrmxrk2cebwxjnp@cantor>
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
>Link: https://www.spinics.net/lists/iommu/msg40416.html
>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
>Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains replaced with private")
>Cc: stable@vger.kernel.org # v5.3+
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

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

