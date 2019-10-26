Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033D0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7165206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfJZCZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 22:25:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:4437 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfJZCZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 22:25:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 19:25:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="224098539"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 19:25:17 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 10/11] iommu/vt-d: Support flushing more translation
 cache types
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-11-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <40776827-c053-2a30-5606-d4ccdbd35fc8@linux.intel.com>
Date:   Sat, 26 Oct 2019 10:22:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-11-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/25/19 3:55 AM, Jacob Pan wrote:
> When Shared Virtual Memory is exposed to a guest via vIOMMU, scalable
> IOTLB invalidation may be passed down from outside IOMMU subsystems.
> This patch adds invalidation functions that can be used for additional
> translation cache types.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/dmar.c        | 46 +++++++++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/intel-pasid.c |  3 ++-
>   include/linux/intel-iommu.h | 21 +++++++++++++++++----
>   3 files changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 49bb7d76e646..0ce2d32ff99e 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1346,6 +1346,20 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>   	qi_submit_sync(&desc, iommu);
>   }
>   
> +/* PASID-based IOTLB Invalidate */
> +void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr, u32 pasid,
> +		unsigned int size_order, u64 granu, int ih)
> +{
> +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
> +
> +	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> +		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
> +	desc.qw1 = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(ih) |
> +		QI_EIOTLB_AM(size_order);
> +
> +	qi_submit_sync(&desc, iommu);
> +}
> +
>   void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   			u16 qdep, u64 addr, unsigned mask)
>   {
> @@ -1369,6 +1383,38 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   	qi_submit_sync(&desc, iommu);
>   }
>   
> +/* PASID-based device IOTLB Invalidate */
> +void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +		u32 pasid,  u16 qdep, u64 addr, unsigned size_order, u64 granu)
> +{
> +	struct qi_desc desc;

Do you need to set qw2 and qw3 to 0?

> +
> +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> +		QI_DEV_IOTLB_PFSID(pfsid);
> +	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
> +
> +	/* If S bit is 0, we only flush a single page. If S bit is set,
> +	 * The least significant zero bit indicates the invalidation address
> +	 * range. VT-d spec 6.5.2.6.
> +	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates 16KB.
> +	 */
> +	if (!size_order) {
> +		desc.qw0 |= QI_DEV_EIOTLB_ADDR(addr) & ~QI_DEV_EIOTLB_SIZE;
> +	} else {
> +		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order);
> +		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr & ~mask) | QI_DEV_EIOTLB_SIZE;
> +	}
> +	qi_submit_sync(&desc, iommu);
> +}
> +
> +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid)
> +{
> +	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> +
> +	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) | QI_PC_GRAN(granu) | QI_PC_TYPE;
> +	qi_submit_sync(&desc, iommu);
> +}
>   /*
>    * Disable Queued Invalidation interface.
>    */
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index f846a907cfcf..6d7a701ef4d3 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -491,7 +491,8 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>   {
>   	struct qi_desc desc;
>   
> -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
> +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> +		QI_PC_PASID(pasid) | QI_PC_TYPE;
>   	desc.qw1 = 0;
>   	desc.qw2 = 0;
>   	desc.qw3 = 0;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 6c74c71b1ebf..a25fb3a0ea5b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -332,7 +332,7 @@ enum {
>   #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >> (DMA_TLB_FLUSH_GRANU_OFFSET-4))
>   #define QI_IOTLB_ADDR(addr)	(((u64)addr) & VTD_PAGE_MASK)
>   #define QI_IOTLB_IH(ih)		(((u64)ih) << 6)
> -#define QI_IOTLB_AM(am)		(((u8)am))
> +#define QI_IOTLB_AM(am)		(((u8)am) & 0x3f)
>   
>   #define QI_CC_FM(fm)		(((u64)fm) << 48)
>   #define QI_CC_SID(sid)		(((u64)sid) << 32)
> @@ -350,16 +350,21 @@ enum {
>   #define QI_PC_DID(did)		(((u64)did) << 16)
>   #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
>   
> -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
> -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
> +/* PASID cache invalidation granu */
> +#define QI_PC_ALL_PASIDS	0
> +#define QI_PC_PASID_SEL		1
>   
>   #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
>   #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
> -#define QI_EIOTLB_AM(am)	(((u64)am))
> +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
>   #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
>   #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
>   #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
>   
> +/* QI Dev-IOTLB inv granu */
> +#define QI_DEV_IOTLB_GRAN_ALL		1
> +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
> +
>   #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>   #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
>   #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> @@ -655,8 +660,16 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
>   			     u8 fm, u64 type);
>   extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>   			  unsigned int size_order, u64 type);
> +extern void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr,
> +			u32 pasid, unsigned int size_order, u64 type, int ih);
>   extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   			u16 qdep, u64 addr, unsigned mask);
> +
> +extern void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +			u32 pasid, u16 qdep, u64 addr, unsigned size_order, u64 granu);
> +
> +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid);
> +
>   extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
>   
>   extern int dmar_ir_support(void);
> 

Best regards,
baolu
