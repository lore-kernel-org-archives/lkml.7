Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE9AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CB82077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfD0JEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfD0JEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:04:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 079798535C;
        Sat, 27 Apr 2019 09:04:11 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBAC617D64;
        Sat, 27 Apr 2019 09:04:05 +0000 (UTC)
Subject: Re: [PATCH v2 18/19] iommu/vt-d: Support flushing more translation
 cache types
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-19-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5ad35536-4993-13f1-5199-ddd99f7009e5@redhat.com>
Date:   Sat, 27 Apr 2019 11:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-19-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sat, 27 Apr 2019 09:04:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/24/19 1:31 AM, Jacob Pan wrote:
> When Shared Virtual Memory is exposed to a guest via vIOMMU, extended
> IOTLB invalidation may be passed down from outside IOMMU subsystems.
> This patch adds invalidation functions that can be used for additional
> translation cache types.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dmar.c        | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h | 21 ++++++++++++++++----
>  2 files changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 9c49300..680894e 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1357,6 +1357,20 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  	qi_submit_sync(&desc, iommu);
>  }
>  
/* PASID-based IOTLB Invalidate */
> +void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr, u32 pasid,
> +		unsigned int size_order, u64 granu)
> +{
> +	struct qi_desc desc;
> +
> +	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> +		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
> +	desc.qw1 = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(0) |
> +		QI_EIOTLB_AM(size_order);
I see IH it hardcoded to 0. Don't you envision to cascade the IH. On ARM
this was needed for perf sake.
> +	desc.qw2 = 0;
> +	desc.qw3 = 0;
> +	qi_submit_sync(&desc, iommu);
> +}
> +
>  void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  			u16 qdep, u64 addr, unsigned mask)
>  {
> @@ -1380,6 +1394,40 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  	qi_submit_sync(&desc, iommu);
>  }
>  
/* Pasid-based Device-TLB Invalidation */
> +void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +		u32 pasid,  u16 qdep, u64 addr, unsigned size, u64 granu)
> +{
> +	struct qi_desc desc;
> +
> +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> +		QI_DEV_IOTLB_PFSID(pfsid);
> +	desc.qw1 |= QI_DEV_EIOTLB_GLOB(granu);
> +
> +	/* If S bit is 0, we only flush a single page. If S bit is set,
> +	 * The least significant zero bit indicates the size. VT-d spec
> +	 * 6.5.2.6
> +	 */
> +	if (!size)
> +		desc.qw0 = QI_DEV_EIOTLB_ADDR(addr) & ~QI_DEV_EIOTLB_SIZE;
desc.q1 |= ?
> +	else {
> +		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size);
> +
> +		desc.qw1 = QI_DEV_EIOTLB_ADDR(addr & ~mask) | QI_DEV_EIOTLB_SIZE;
desc.q1 |=
> +	}
> +	qi_submit_sync(&desc, iommu);
> +}
> +
/* PASID-cache invalidation */
> +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid)
> +{
> +	struct qi_desc desc;
> +
> +	desc.qw0 = QI_PC_TYPE | QI_PC_DID(did) | QI_PC_GRAN(granu) | QI_PC_PASID(pasid);
> +	desc.qw1 = 0;
> +	desc.qw2 = 0;
> +	desc.qw3 = 0;
> +	qi_submit_sync(&desc, iommu);
> +}
>  /*
>   * Disable Queued Invalidation interface.
>   */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 5d67d0d4..38e5efb 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -339,7 +339,7 @@ enum {
>  #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >> (DMA_TLB_FLUSH_GRANU_OFFSET-4))
>  #define QI_IOTLB_ADDR(addr)	(((u64)addr) & VTD_PAGE_MASK)
>  #define QI_IOTLB_IH(ih)		(((u64)ih) << 6)
> -#define QI_IOTLB_AM(am)		(((u8)am))
> +#define QI_IOTLB_AM(am)		(((u8)am) & 0x3f)
>  
>  #define QI_CC_FM(fm)		(((u64)fm) << 48)
>  #define QI_CC_SID(sid)		(((u64)sid) << 32)
> @@ -357,17 +357,22 @@ enum {
>  #define QI_PC_DID(did)		(((u64)did) << 16)
>  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
>  
> -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
> -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
> +/* PASID cache invalidation granu */
> +#define QI_PC_ALL_PASIDS	0
> +#define QI_PC_PASID_SEL		1
>  
>  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
>  #define QI_EIOTLB_GL(gl)	(((u64)gl) << 7)
>  #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
> -#define QI_EIOTLB_AM(am)	(((u64)am))
> +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
>  #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
>  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
>  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
>  
> +/* QI Dev-IOTLB inv granu */
> +#define QI_DEV_IOTLB_GRAN_ALL		1
> +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
> +
>  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
>  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> @@ -658,8 +663,16 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
>  			     u8 fm, u64 type);
>  extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  			  unsigned int size_order, u64 type);
> +extern void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr,
> +			u32 pasid, unsigned int size_order, u64 type);
>  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  			u16 qdep, u64 addr, unsigned mask);
> +
> +extern void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +			u32 pasid, u16 qdep, u64 addr, unsigned size, u64 granu);
> +
> +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid);
> +
>  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
>  
>  extern int dmar_ir_support(void);
> 

Thanks

Eric
