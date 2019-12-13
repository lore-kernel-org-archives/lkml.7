Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5402FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEA122527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B373uGGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfLMFmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:42:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50615 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732100AbfLMFmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576215762;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwi+j/3c3L6Rt5/e01jNkvMX57Zg4McK7tkL0V4Tb6w=;
        b=B373uGGV4dPCawv4SthG2SvD3WV1gllnIb5gtaEZ/xmGZ91KIinzo1HeMgW11byhlxOubo
        TTSAnV/houIWE2jRdzw6hbTxro4Vb3+pOMOGpGARcQrc8PBMoAORl33t49qH82BCwnPzJL
        7ND5aPnTIrmnSqV1l6BFBMYxo413dSg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-0_j0QVrdPgiNZMbtGlkdwg-1; Fri, 13 Dec 2019 00:42:39 -0500
X-MC-Unique: 0_j0QVrdPgiNZMbtGlkdwg-1
Received: by mail-pg1-f200.google.com with SMTP id p1so745414pgg.19
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 21:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=cwi+j/3c3L6Rt5/e01jNkvMX57Zg4McK7tkL0V4Tb6w=;
        b=oF3D9tETRD8s6emj1o+M1YxUPRe66zXZGuIUibLGe+nro4xgSqJ5fVvvyIGQAqIXs6
         +L/GZPVq2yv/kcuDoJz0K73jFIHK/IFxtXUGJtZ6bNXUPjwrGn0W3NgFHJkQc39pBzTc
         BpjG/NgnR6c4ni3d/ZkjNOrNf+xEOl5u6DHMsFkLusGqTQGtvq3VMGWti+TZ9VxHYToU
         tYIpnGR9I1I+G6LNvv+PceiGCa0NDeLnAn8RJINqVPEWrLC2x+pXoyzeP+9l7PYYeMuo
         7bJz267OypmQcFRmyfTwa35Tw/Z8N6IHUcVrHu5/OjbPqB8z0J6E6aPVEmyZVCL04RuP
         yDEw==
X-Gm-Message-State: APjAAAX2OUUnzVl6IlCRfC70cpmvhn4+lA/UV0567mv56UdzEdT2+BPC
        YFLSm3qX6n3sL0ojhUPnV1SFc3fj2P2ZmPT4Gf0u/yQP54sMjbflVIs3fCiVHRaqVH6tQxCocj9
        Rzb61QLsiCqSYLAXq44L+SmWf
X-Received: by 2002:a17:902:8601:: with SMTP id f1mr13902160plo.291.1576215758092;
        Thu, 12 Dec 2019 21:42:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaZWfRZsAfWxIXK1Nhr+ThnebZtUh2mZS1cGIcgrxlVtTubvH0gXKnXGkrHtK9Ar79iHIXJA==
X-Received: by 2002:a17:902:8601:: with SMTP id f1mr13902137plo.291.1576215757695;
        Thu, 12 Dec 2019 21:42:37 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id t5sm7910818pje.6.2019.12.12.21.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 21:42:36 -0800 (PST)
Date:   Thu, 12 Dec 2019 22:42:17 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191213054217.sykaftujydkaa4r2@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
 <20191212014952.vlrmxrk2cebwxjnp@cantor>
 <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 12 19, Lu Baolu wrote:
>Hi,
>
>On 12/12/19 9:49 AM, Jerry Snitselaar wrote:
>>On Wed Dec 11 19, Lu Baolu wrote:
>>>If the default DMA domain of a group doesn't fit a device, it
>>>will still sit in the group but use a private identity domain.
>>>When map/unmap/iova_to_phys come through iommu API, the driver
>>>should still serve them, otherwise, other devices in the same
>>>group will be impacted. Since identity domain has been mapped
>>>with the whole available memory space and RMRRs, we don't need
>>>to worry about the impact on it.
>>>
>>>Link: https://www.spinics.net/lists/iommu/msg40416.html
>>>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>>>Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains 
>>>replaced with private")
>>>Cc: stable@vger.kernel.org # v5.3+
>>>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>
>>Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>Can you please try this fix and check whether it can fix your problem?
>If it helps, do you mind adding a Tested-by?
>
>Best regards,
>baolu
>

Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>

>>
>>>---
>>>drivers/iommu/intel-iommu.c | 8 --------
>>>1 file changed, 8 deletions(-)
>>>
>>>diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>>index 0c8d81f56a30..b73bebea9148 100644
>>>--- a/drivers/iommu/intel-iommu.c
>>>+++ b/drivers/iommu/intel-iommu.c
>>>@@ -5478,9 +5478,6 @@ static int intel_iommu_map(struct 
>>>iommu_domain *domain,
>>>    int prot = 0;
>>>    int ret;
>>>
>>>-    if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>>>-        return -EINVAL;
>>>-
>>>    if (iommu_prot & IOMMU_READ)
>>>        prot |= DMA_PTE_READ;
>>>    if (iommu_prot & IOMMU_WRITE)
>>>@@ -5523,8 +5520,6 @@ static size_t intel_iommu_unmap(struct 
>>>iommu_domain *domain,
>>>    /* Cope with horrid API which requires us to unmap more than the
>>>       size argument if it happens to be a large-page mapping. */
>>>    BUG_ON(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level));
>>>-    if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>>>-        return 0;
>>>
>>>    if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
>>>        size = VTD_PAGE_SIZE << level_to_offset_bits(level);
>>>@@ -5556,9 +5551,6 @@ static phys_addr_t 
>>>intel_iommu_iova_to_phys(struct iommu_domain *domain,
>>>    int level = 0;
>>>    u64 phys = 0;
>>>
>>>-    if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>>>-        return 0;
>>>-
>>>    pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
>>>    if (pte)
>>>        phys = dma_pte_addr(pte);
>>>-- 
>>>2.17.1
>>>
>>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

