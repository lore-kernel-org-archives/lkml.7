Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C24CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34C32073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iyx5HTgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfLMAai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:30:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30632 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731342AbfLMAai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576197037;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jS6U1pgpCajQvRuzqz6/DRsKR0QCJ6hk9xIEhJ0Onh0=;
        b=Iyx5HTgCiL2qHLtORDAVEgIod4inKXNkHDDzYcHV3c+66Z3LO6Q2ytoYH0N6f7GK6ibECP
        0HOxd8Cxxhi04PrE34Eg2+yKHIyB9CJpEJpQXe/zlVISrNSJ6T3EfNMtaC5jkNtY8SJxcX
        iZZz2bE5aA1hXJ7thaQ6HXacbqtrnu0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-zq1iplMJO4iBwJktcF-0sw-1; Thu, 12 Dec 2019 19:30:35 -0500
X-MC-Unique: zq1iplMJO4iBwJktcF-0sw-1
Received: by mail-yb1-f198.google.com with SMTP id k79so622963ybf.14
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=jS6U1pgpCajQvRuzqz6/DRsKR0QCJ6hk9xIEhJ0Onh0=;
        b=pt24SISYNpfukVyYIoPa1WyJheBeP2PaIDTjSJDqr+0FJq8eY9dm/7T06qXMwu3MSS
         AZmm42vN8Zs/nCZrWz8h+dCIefxxrIPrJn/K7PNxA6ZnNTrGxgqzlXx3TgZBzyy936q5
         CJnebq5c0PeLlF4Gyi61Ba3+ukhjE1nebKolrXDMJwhDVXw8dQq0YEL5emmlOcwQyXjj
         lvpb5C7HErKWH0YXY4zrRwbOSbh7uJjQvmyFW+T16+u4NMrPz3J3/yb+eu34QNooOnWM
         Lg3ARVTQCw0CLX5NY3CidFgOLlpB9dSRIykJqp7s5nmvIVYQDh4ZmXZBr1Yoha1aq9aU
         pv7g==
X-Gm-Message-State: APjAAAXVnUYp8FsUwsoXmwL32KOereQ0QyjsKKjz6nMDhspnPJWj24sp
        KbAzpAKbiUdzLQt2AQZ5tkxfNABNEaDpe60g9o8L0X1Rvpvm5zL3Z/UvVa5KdAq6qLOgMNfm9fj
        aUgX3H+Xjc+Rz2ZenF+gZnORH
X-Received: by 2002:a81:498c:: with SMTP id w134mr6683680ywa.391.1576197034962;
        Thu, 12 Dec 2019 16:30:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqyV7bxeIbdjA2RjieoU8xu+V/i2Ro+FbC2boqYfNwO1+evCBVPio5ha6QZdRyIltr6nkNf1aQ==
X-Received: by 2002:a81:498c:: with SMTP id w134mr6683661ywa.391.1576197034599;
        Thu, 12 Dec 2019 16:30:34 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id f22sm3571083ywb.104.2019.12.12.16.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:30:33 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:30:13 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191213003013.gc3zg3fpzpjntnzg@cantor>
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

I'm testing with this patch, my patch that moves the direct mapping call,
and Alex's patch for the ISA bridge. It solved the 2 iommu mapping errors
I was seeing with default passthrough, I no longer see all the dmar pte
read access errors, and the system boots allowing me to login. I'm tracking
down 2 issues at the moment. With passthrough I see a problem with 01:00.4
that I mentioned in the earlier email:

[   78.978573] uhci_hcd: USB Universal Host Controller Interface driver
[   78.980842] uhci_hcd 0000:01:00.4: UHCI Host Controller
[   78.982738] uhci_hcd 0000:01:00.4: new USB bus registered, assigned bus number 3
[   78.985222] uhci_hcd 0000:01:00.4: detected 8 ports
[   78.986907] uhci_hcd 0000:01:00.4: port count misdetected? forcing to 2 ports
[   78.989316] uhci_hcd 0000:01:00.4: irq 16, io base 0x00003c00
[   78.994634] uhci_hcd 0000:01:00.4: DMAR: 32bit DMA uses non-identity mapping
[   7 0000:01:00.4: unable to allocate consistent memory for frame list
[   79.499891] uhci_hcd 0000:01:00.4: startup error -16
[   79.501588] uhci_hcd 0000:01:00.4: USB bus 3 deregistered
[   79.503494] uhci_hcd 0000:01:00.4: init 0000:01:00.4 fail, -16
[   79.505497] uhci_hcd: probe of 0000:01:00.4 failed with error -16

If I boot the system with iommu=nopt I see an iommu map failure due to
the prot check in __domain_mapping:

[   40.940589] pci 0000:00:1f.0: iommu_group_add_device: calling iommu_group_create_direct_mappings
[   40.943558] pci 0000:00:1f.0: iommu_group_create_direct_mappings: iterating through mappings
[   40.946402] pci 0000:00:1f.0: iommu_group_create_direct_mappings: calling apply_resv_region
[   40.949184] pci 0000:00:1f.0: iommu_group_create_direct_mappings: entry type is direct
[   40.951819] DMAR: intel_iommu_map: enter
[   40.953128] DMAR: __domain_mapping: prot & (DMA_PTE_READ|DMA_PTE_WRITE) == 0
[   40.955486] DMAR: domain_mapping: __domain_mapping failed
[   40.957348] DMAR: intel_iommu_map: domain_pfn_mapping returned -22
[   40.959466] DMAR: intel_iommu_map: leave
[   40.959468] iommu: iommu_map: ops->map failed iova 0x0 pa 0x0000000000000000 pgsize 0x1000
[   40.963511] pci 0000:00:1f.0: iommu_group_create_direct_mappings: iommu_map failed
[   40.966026] pci 0000:00:1f.0: iommu_group_create_direct_mappings: leaving func
[   40.968487] pci 0000:00:1f.0: iommu_group_add_device: calling __iommu_attach_device
[   40.971016] pci 0000:00:1f.0: Adding to iommu group 19
[   40.972731] pci 0000:00:1f.0: DMAR: domain->type is dma

/sys/kernel/iommu_groups/19
[root@hp-dl388g8-07 19]# cat reserved_regions 
0x0000000000000000 0x0000000000ffffff direct
0x00000000bdf6e000 0x00000000bdf84fff direct
0x00000000fee00000 0x00000000feefffff msi

00:1f.0 ISA bridge: Intel Corporation C600/X79 series chipset LPC Controller

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

