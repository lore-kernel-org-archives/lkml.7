Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC403C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0E721850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfDEKCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:02:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45072 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbfDEKCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:02:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10303168F;
        Fri,  5 Apr 2019 03:02:35 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4DEE3F721;
        Fri,  5 Apr 2019 03:02:32 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] iommu: io-pgtable: Add ARM Mali midgard MMU page
 table format
From:   Robin Murphy <robin.murphy@arm.com>
To:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        iommu@lists.linux-foundation.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-2-robh@kernel.org>
 <8d091874-11b0-e348-c4f1-dd1bcfa4bf97@arm.com>
Message-ID: <85471882-3044-eba7-8351-fb01330004d8@arm.com>
Date:   Fri, 5 Apr 2019 11:02:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8d091874-11b0-e348-c4f1-dd1bcfa4bf97@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 20:11, Robin Murphy wrote:
> On 01/04/2019 08:47, Rob Herring wrote:
>> ARM Mali midgard GPU is similar to standard 64-bit stage 1 page 
>> tables, but
>> have a few differences. Add a new format type to represent the format. 
>> The
>> input address size is 48-bits and the output address size is 40-bits (and
>> possibly less?). Note that the later bifrost GPUs follow the standard
>> 64-bit stage 1 format.
>>
>> The differences in the format compared to 64-bit stage 1 format are:
>>
>> The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
>>
>> The access flags are not read-only and unprivileged, but read and write.
>> This is similar to stage 2 entries, but the memory attributes field 
>> matches
>> stage 1 being an index.
>>
>> The nG bit is not set by the vendor driver. This one didn't seem to 
>> matter,
>> but we'll keep it aligned to the vendor driver.
>>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: iommu@lists.linux-foundation.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Please ack this as I need to apply it to the drm-misc tree. Or we need a
>> stable branch with this patch.
> 
> With the diff below squashed in to address my outstanding style nits,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
> I don't foresee any conflicting io-pgtable changes to prevent this going 
> via DRM, but I'll leave the final say up to Joerg.

Urgh, sorry, turns out I flipped one condition too many there. On 
reflection I may also forget my clever trick in future and inadvertently 
break it, so it probably warrants a comment. Please supersede my 
previous request with the (actually tested) diff below :)

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 98551d0cff59..4f7be5a3e19b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -197,12 +197,13 @@ struct arm_lpae_io_pgtable {

  typedef u64 arm_lpae_iopte;

-static inline bool iopte_leaf(arm_lpae_iopte pte, int l, enum 
io_pgtable_fmt fmt)
+static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
+			      enum io_pgtable_fmt fmt)
  {
-	if ((l == (ARM_LPAE_MAX_LEVELS - 1)) && (fmt != ARM_MALI_LPAE))
-		return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE;
+	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
+		return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_PAGE;

-	return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK;
+	return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_BLOCK;
  }

  static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
@@ -310,12 +311,9 @@ static void __arm_lpae_init_pte(struct 
arm_lpae_io_pgtable *data,
  	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
  		pte |= ARM_LPAE_PTE_NS;

-	if (lvl == ARM_LPAE_MAX_LEVELS - 1) {
-		if (data->iop.fmt == ARM_MALI_LPAE)
-			pte |= ARM_LPAE_PTE_TYPE_BLOCK;
-		else
-			pte |= ARM_LPAE_PTE_TYPE_PAGE;
-	} else
+	if (data->iop.fmt != ARM_MALI_LPAE && lvl == ARM_LPAE_MAX_LEVELS - 1)
+		pte |= ARM_LPAE_PTE_TYPE_PAGE;
+	else
  		pte |= ARM_LPAE_PTE_TYPE_BLOCK;

  	if (data->iop.fmt != ARM_MALI_LPAE)
@@ -452,7 +450,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct 
arm_lpae_io_pgtable *data,
  		if (prot & IOMMU_WRITE)
  			pte |= ARM_LPAE_PTE_HAP_WRITE;
  	}
-
+	/*
+	 * Note that this logic is structured to accommodate Mali LPAE
+	 * having stage-1-like attributes but stage-2-like permissions.
+	 */
  	if (data->iop.fmt == ARM_64_LPAE_S2 ||
  	    data->iop.fmt == ARM_32_LPAE_S2) {
  		if (prot & IOMMU_MMIO)
