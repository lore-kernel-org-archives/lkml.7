Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903E8C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB7A2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfD3RMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:12:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:1851 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:12:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 10:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="295860336"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 30 Apr 2019 10:12:37 -0700
Date:   Tue, 30 Apr 2019 10:15:23 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 18/19] iommu/vt-d: Support flushing more translation
 cache types
Message-ID: <20190430101523.000e57a0@jacob-builder>
In-Reply-To: <4c54cbe9-b639-d560-4546-0ad84a622e89@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-19-git-send-email-jacob.jun.pan@linux.intel.com>
        <5ad35536-4993-13f1-5199-ddd99f7009e5@redhat.com>
        <20190429142921.1d36f560@jacob-builder>
        <4c54cbe9-b639-d560-4546-0ad84a622e89@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 06:41:13 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 4/29/19 11:29 PM, Jacob Pan wrote:
> > On Sat, 27 Apr 2019 11:04:04 +0200
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Jacob,
> >>
> >> On 4/24/19 1:31 AM, Jacob Pan wrote:  
> >>> When Shared Virtual Memory is exposed to a guest via vIOMMU,
> >>> extended IOTLB invalidation may be passed down from outside IOMMU
> >>> subsystems. This patch adds invalidation functions that can be
> >>> used for additional translation cache types.
> >>>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> ---
> >>>  drivers/iommu/dmar.c        | 48
> >>> +++++++++++++++++++++++++++++++++++++++++++++
> >>> include/linux/intel-iommu.h | 21 ++++++++++++++++---- 2 files
> >>> changed, 65 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> >>> index 9c49300..680894e 100644
> >>> --- a/drivers/iommu/dmar.c
> >>> +++ b/drivers/iommu/dmar.c
> >>> @@ -1357,6 +1357,20 @@ void qi_flush_iotlb(struct intel_iommu
> >>> *iommu, u16 did, u64 addr, qi_submit_sync(&desc, iommu);
> >>>  }
> >>>      
> >> /* PASID-based IOTLB Invalidate */  
> >>> +void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64
> >>> addr, u32 pasid,
> >>> +		unsigned int size_order, u64 granu)
> >>> +{
> >>> +	struct qi_desc desc;
> >>> +
> >>> +	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> >>> +		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
> >>> +	desc.qw1 = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(0) |
> >>> +		QI_EIOTLB_AM(size_order);    
> >> I see IH it hardcoded to 0. Don't you envision to cascade the IH.
> >> On ARM this was needed for perf sake.  
> > Right, we should cascade IH based on IOMMU_INV_ADDR_FLAGS_LEAF. Just
> > curious how do you deduce the IH information on ARM? I guess you
> > need to get the non-leaf page directory info?
> > I will add an argument for IH.  
> On ARM we have the "Leaf" field in the stage1 TLB invalidation
> command. "When Leaf==1, only cached entries for the last level of
> translation table walk are required to be invalidated".
> 
Thanks for explaining, I guess I didn't ask the right question. I was
wondering how SMMU driver determines when to set the Leaf bit. I guess
it is this function? It is not apparent to me whether the sharing of
non-leaf TLBs are considered.
io_pgtable_tlb_add_flush(iop, iova, blk_size, blk_size, true);

> Thanks
> 
> Eric
>  [...]  
> >> /* Pasid-based Device-TLB Invalidation */  
>  [...]  
> >>> +void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16
> >>> pfsid,
> >>> +		u32 pasid,  u16 qdep, u64 addr, unsigned size,
> >>> u64 granu) +{
> >>> +	struct qi_desc desc;
> >>> +
> >>> +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) |
> >>> QI_DEV_EIOTLB_SID(sid) |
> >>> +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> >>> +		QI_DEV_IOTLB_PFSID(pfsid);
> >>> +	desc.qw1 |= QI_DEV_EIOTLB_GLOB(granu);  
> > should be desc.qw1 =  
> >>> +
> >>> +	/* If S bit is 0, we only flush a single page. If S bit
> >>> is set,
> >>> +	 * The least significant zero bit indicates the size.
> >>> VT-d spec
> >>> +	 * 6.5.2.6
> >>> +	 */
> >>> +	if (!size)
> >>> +		desc.qw0 = QI_DEV_EIOTLB_ADDR(addr) &
> >>> ~QI_DEV_EIOTLB_SIZE;    
> >> desc.q1 |= ?  
> > Right, I also missed previous qw1 assignment.  
> >>> +	else {
> >>> +		unsigned long mask = 1UL << (VTD_PAGE_SHIFT +
> >>> size); +
> >>> +		desc.qw1 = QI_DEV_EIOTLB_ADDR(addr & ~mask) |
> >>> QI_DEV_EIOTLB_SIZE;    
> >> desc.q1 |=  
> > right, thanks  
> >>> +	}
> >>> +	qi_submit_sync(&desc, iommu);
> >>> +}
> >>> +    
> >> /* PASID-cache invalidation */  
> >>> +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64
> >>> granu, int pasid) +{
> >>> +	struct qi_desc desc;
> >>> +
> >>> +	desc.qw0 = QI_PC_TYPE | QI_PC_DID(did) |
> >>> QI_PC_GRAN(granu) | QI_PC_PASID(pasid);
> >>> +	desc.qw1 = 0;
> >>> +	desc.qw2 = 0;
> >>> +	desc.qw3 = 0;
> >>> +	qi_submit_sync(&desc, iommu);
> >>> +}
> >>>  /*
> >>>   * Disable Queued Invalidation interface.
> >>>   */
> >>> diff --git a/include/linux/intel-iommu.h
> >>> b/include/linux/intel-iommu.h index 5d67d0d4..38e5efb 100644
> >>> --- a/include/linux/intel-iommu.h
> >>> +++ b/include/linux/intel-iommu.h
> >>> @@ -339,7 +339,7 @@ enum {
> >>>  #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >>
> >>> (DMA_TLB_FLUSH_GRANU_OFFSET-4)) #define QI_IOTLB_ADDR(addr)
> >>> (((u64)addr) & VTD_PAGE_MASK) #define
> >>> QI_IOTLB_IH(ih)		(((u64)ih) << 6) -#define
> >>> QI_IOTLB_AM(am)		(((u8)am)) +#define
> >>> QI_IOTLB_AM(am)		(((u8)am) & 0x3f) 
> >>>  #define QI_CC_FM(fm)		(((u64)fm) << 48)
> >>>  #define QI_CC_SID(sid)		(((u64)sid) << 32)
> >>> @@ -357,17 +357,22 @@ enum {
> >>>  #define QI_PC_DID(did)		(((u64)did) << 16)
> >>>  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
> >>>  
> >>> -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
> >>> -#define QI_PC_PASID_SEL		(QI_PC_TYPE |
> >>> QI_PC_GRAN(1)) +/* PASID cache invalidation granu */
> >>> +#define QI_PC_ALL_PASIDS	0
> >>> +#define QI_PC_PASID_SEL		1
> >>>  
> >>>  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
> >>>  #define QI_EIOTLB_GL(gl)	(((u64)gl) << 7)
> >>>  #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
> >>> -#define QI_EIOTLB_AM(am)	(((u64)am))
> >>> +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
> >>>  #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
> >>>  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
> >>>  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
> >>>  
> >>> +/* QI Dev-IOTLB inv granu */
> >>> +#define QI_DEV_IOTLB_GRAN_ALL		1
> >>> +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
> >>> +
> >>>  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
> >>>  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> >>>  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> >>> @@ -658,8 +663,16 @@ extern void qi_flush_context(struct
> >>> intel_iommu *iommu, u16 did, u16 sid, u8 fm, u64 type);
> >>>  extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did,
> >>> u64 addr, unsigned int size_order, u64 type);
> >>> +extern void qi_flush_piotlb(struct intel_iommu *iommu, u16 did,
> >>> u64 addr,
> >>> +			u32 pasid, unsigned int size_order, u64
> >>> type); extern void qi_flush_dev_iotlb(struct intel_iommu *iommu,
> >>> u16 sid, u16 pfsid, u16 qdep, u64 addr, unsigned mask);
> >>> +
> >>> +extern void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16
> >>> sid, u16 pfsid,
> >>> +			u32 pasid, u16 qdep, u64 addr, unsigned
> >>> size, u64 granu); +
> >>> +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16
> >>> did, u64 granu, int pasid); +
> >>>  extern int qi_submit_sync(struct qi_desc *desc, struct
> >>> intel_iommu *iommu); 
> >>>  extern int dmar_ir_support(void);
> >>>     
> >>
> >> Thanks
> >>
> >> Eric  
> > 
> > [Jacob Pan]
> >   

[Jacob Pan]
