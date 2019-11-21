Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5CBC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4143720855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUBWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:22:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:6862 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfKUBWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:22:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 17:22:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="218894494"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 20 Nov 2019 17:21:57 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH] iommu/vt-d: Add side channel for huge page support to
 Intel IOMMU.
To:     Yonghyun Hwang <yonghyun@google.com>
References: <20191120003616.181350-1-yonghyun@google.com>
 <82886067-2e19-01c4-b72d-2e68ebf3bad9@linux.intel.com>
 <CAEauFbyUGcj-ibKgdYt_AuXuaxMcrKdJpW75hQNrF3gwTE2upw@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a4b8fb13-9a52-7ac2-42ed-aad90da5dc6d@linux.intel.com>
Date:   Thu, 21 Nov 2019 09:18:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAEauFbyUGcj-ibKgdYt_AuXuaxMcrKdJpW75hQNrF3gwTE2upw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yonghyun,

Linux VT-d driver is developed and maintained according to VT-d spec
rev3.0. I didn't find anything about super page support for ATS in the
spec. I am not the spec maintainer so I have no idea about how the spec
evolves.

Best regards,
baolu

On 11/21/19 5:54 AM, Yonghyun Hwang wrote:
> Hello Baolu,
> 
> As far as I know, PCIe standard doesn't define a field for large page 
> attribution in a response message. This was the motivation to implement 
> the side channel.
> 
> I think I could miss something on your proposal. Could you elaborate how 
> VT-d can be involved to include the large page attribution in the 
> response message?
> 
> Kind regards,
> Yonghyun
> 
> On Tue, Nov 19, 2019 at 5:50 PM Lu Baolu <baolu.lu@linux.intel.com 
> <mailto:baolu.lu@linux.intel.com>> wrote:
> 
>     Hi,
> 
>     On 11/20/19 8:36 AM, Yonghyun Hwang wrote:
>      > PCIe Address Translation Service (ATS) allows a PCIe device to
>     look up
>      > VA->PA translations maintained by the IOMMU and cache them. The
>     IOMMU up
>      > until at least Skylake fractures all ATS responses into 4 KiB
>     pages, even
>      > if the underlying page is 2 MiB. For added performance, a side
>     channel is
>      > defined, which lets the device know if the page is actually a 2
>     MiB page
>      > and uses that information instead of the ATS Response size
>     information to
>      > determine the actual page size to use. The side channel is mapped
>     to an
>      > unused high-order PA bit, 45-bit, that is transferred intact from
>     the IOMMU
>      > PTE to the device.
> 
>     BIT 45 of VT-d second level page table entry is not ignored but Reserved
>     (must be 0). (Spec 3.0 section 9.8). So it couldn't be used for software
>     purpose.
> 
>     I guess the right approach should be VT-d hardware involved. For
>     example, VT-d reads the PTE entry in response of an ATS request, and
>     check the large page attribution of this PTE then include the large page
>     information in the response. It's not a good idea to hide the response
>     information in the pfn and walk around VT-d hardware.
> 
>     Best regards,
>     baolu
> 
>      >
>      > Signed-off-by: Yonghyun Hwang <yonghyun@google.com
>     <mailto:yonghyun@google.com>>
>      > ---
>      >   drivers/iommu/intel-iommu.c | 83
>     ++++++++++++++++++++++++++++++++-----
>      >   drivers/iommu/intel-pasid.c |  2 +-
>      >   include/linux/intel-iommu.h | 37 ++++++++++++-----
>      >   include/linux/iommu.h       |  1 +
>      >   4 files changed, 102 insertions(+), 21 deletions(-)
>      >
>      > diff --git a/drivers/iommu/intel-iommu.c
>     b/drivers/iommu/intel-iommu.c
>      > index fe8097078669..f748985b8081 100644
>      > --- a/drivers/iommu/intel-iommu.c
>      > +++ b/drivers/iommu/intel-iommu.c
>      > @@ -307,6 +307,9 @@ static int hw_pass_through = 1;
>      >    */
>      >   #define DOMAIN_FLAG_LOSE_CHILDREN           BIT(1)
>      >
>      > +/* Domain used for huge-page side channel. */
>      > +#define DOMAIN_FLAG_A45_HUGE_PAGE            (1 << 2)
>      > +
>      >   #define for_each_domain_iommu(idx, domain)                  \
>      >       for (idx = 0; idx < g_num_of_iommus; idx++)             \
>      >               if (domain->iommu_refcnt[idx])
>      > @@ -552,6 +555,20 @@ static inline int domain_type_is_si(struct
>     dmar_domain *domain)
>      >       return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
>      >   }
>      >
>      > +static inline void domain_type_set_a45_huge_page(struct
>     dmar_domain *domain,
>      > +                                          bool huge_page)
>      > +{
>      > +     if (huge_page)
>      > +             domain->flags |= DOMAIN_FLAG_A45_HUGE_PAGE;
>      > +     else
>      > +             domain->flags &= ~DOMAIN_FLAG_A45_HUGE_PAGE;
>      > +}
>      > +
>      > +inline bool domain_type_get_a45_huge_page(struct dmar_domain
>     *domain)
>      > +{
>      > +     return (domain->flags & DOMAIN_FLAG_A45_HUGE_PAGE) != 0;
>      > +}
>      > +
>      >   static inline int domain_pfn_supported(struct dmar_domain *domain,
>      >                                      unsigned long pfn)
>      >   {
>      > @@ -922,7 +939,7 @@ static struct dma_pte *pfn_to_dma_pte(struct
>     dmar_domain *domain,
>      >               if (level == 1)
>      >                       break;
>      >
>      > -             parent = phys_to_virt(dma_pte_addr(pte));
>      > +             parent = phys_to_virt(dma_pte_addr(pte, domain));
>      >               level--;
>      >       }
>      >
>      > @@ -958,7 +975,7 @@ static struct dma_pte
>     *dma_pfn_level_pte(struct dmar_domain *domain,
>      >                       return pte;
>      >               }
>      >
>      > -             parent = phys_to_virt(dma_pte_addr(pte));
>      > +             parent = phys_to_virt(dma_pte_addr(pte, domain));
>      >               total--;
>      >       }
>      >       return NULL;
>      > @@ -1012,7 +1029,7 @@ static void dma_pte_free_level(struct
>     dmar_domain *domain, int level,
>      >                       goto next;
>      >
>      >               level_pfn = pfn & level_mask(level);
>      > -             level_pte = phys_to_virt(dma_pte_addr(pte));
>      > +             level_pte = phys_to_virt(dma_pte_addr(pte, domain));
>      >
>      >               if (level > 2) {
>      >                       dma_pte_free_level(domain, level - 1,
>     retain_level,
>      > @@ -1073,7 +1090,7 @@ static struct page
>     *dma_pte_list_pagetables(struct dmar_domain *domain,
>      >   {
>      >       struct page *pg;
>      >
>      > -     pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
>      > +     pg = pfn_to_page(dma_pte_addr(pte, domain) >> PAGE_SHIFT);
>      >       pg->freelist = freelist;
>      >       freelist = pg;
>      >
>      > @@ -1125,7 +1142,8 @@ static struct page
>     *dma_pte_clear_level(struct dmar_domain *domain, int level,
>      >               } else if (level > 1) {
>      >                       /* Recurse down into a level that isn't
>     *entirely* obsolete */
>      >                       freelist = dma_pte_clear_level(domain,
>     level - 1,
>      > -                                                   
>     phys_to_virt(dma_pte_addr(pte)),
>      > +                                             phys_to_virt(
>      > +                                                   
>     dma_pte_addr(pte, domain)),
>      >                                                      level_pfn,
>     start_pfn, last_pfn,
>      >                                                      freelist);
>      >               }
>      > @@ -2063,7 +2081,7 @@ static int
>     domain_context_mapping_one(struct dmar_domain *domain,
>      >                        */
>      >                       for (agaw = domain->agaw; agaw >
>     iommu->agaw; agaw--) {
>      >                               ret = -ENOMEM;
>      > -                             pgd = phys_to_virt(dma_pte_addr(pgd));
>      > +                             pgd =
>     phys_to_virt(dma_pte_addr(pgd, domain));
>      >                               if (!dma_pte_present(pgd))
>      >                                       goto out_unlock;
>      >                       }
>      > @@ -2229,6 +2247,9 @@ static int __domain_mapping(struct
>     dmar_domain *domain, unsigned long iov_pfn,
>      >       unsigned long sg_res = 0;
>      >       unsigned int largepage_lvl = 0;
>      >       unsigned long lvl_pages = 0;
>      > +     uint64_t large_page = DMA_PTE_LARGE_PAGE |
>      > +         (domain_type_get_a45_huge_page(domain) ?
>      > +         DMA_PTE_A45_HUGE_PAGE : 0);
>      >
>      >       BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
>      >
>      > @@ -2265,7 +2286,7 @@ static int __domain_mapping(struct
>     dmar_domain *domain, unsigned long iov_pfn,
>      >                       if (largepage_lvl > 1) {
>      >                               unsigned long nr_superpages, end_pfn;
>      >
>      > -                             pteval |= DMA_PTE_LARGE_PAGE;
>      > +                             pteval |= large_page;
>      >                               lvl_pages =
>     lvl_to_nr_pages(largepage_lvl);
>      >
>      >                               nr_superpages = sg_res / lvl_pages;
>      > @@ -2280,7 +2301,7 @@ static int __domain_mapping(struct
>     dmar_domain *domain, unsigned long iov_pfn,
>      >                               dma_pte_free_pagetable(domain,
>     iov_pfn, end_pfn,
>      >                                                     
>     largepage_lvl + 1);
>      >                       } else {
>      > -                             pteval &=
>     ~(uint64_t)DMA_PTE_LARGE_PAGE;
>      > +                             pteval &= ~large_page;
>      >                       }
>      >
>      >               }
>      > @@ -5377,7 +5398,7 @@ static int
>     prepare_domain_attach_device(struct iommu_domain *domain,
>      >               pte = dmar_domain->pgd;
>      >               if (dma_pte_present(pte)) {
>      >                       dmar_domain->pgd = (struct dma_pte *)
>      > -                             phys_to_virt(dma_pte_addr(pte));
>      > +                             phys_to_virt(dma_pte_addr(pte,
>     dmar_domain));
>      >                       free_pgtable_page(pte);
>      >               }
>      >               dmar_domain->agaw--;
>      > @@ -5386,6 +5407,46 @@ static int
>     prepare_domain_attach_device(struct iommu_domain *domain,
>      >       return 0;
>      >   }
>      >
>      > +static int intel_iommu_domain_set_attr(struct iommu_domain *domain,
>      > +                                    enum iommu_attr attr, void
>     *data)
>      > +{
>      > +     struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>      > +     int ret = 0;
>      > +
>      > +     switch (attr) {
>      > +     case DOMAIN_ATTR_A45_HUGE_PAGE: {
>      > +             bool *huge_page = data;
>      > +
>      > +             domain_type_set_a45_huge_page(dmar_domain, *huge_page);
>      > +             break;
>      > +     }
>      > +     default:
>      > +             return -EINVAL;
>      > +     }
>      > +
>      > +     return ret;
>      > +}
>      > +
>      > +static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
>      > +                                    enum iommu_attr attr, void
>     *data)
>      > +{
>      > +     struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>      > +     int ret = 0;
>      > +
>      > +     switch (attr) {
>      > +     case DOMAIN_ATTR_A45_HUGE_PAGE: {
>      > +             bool *huge_page  = data;
>      > +
>      > +             *huge_page =
>     domain_type_get_a45_huge_page(dmar_domain);
>      > +             break;
>      > +     }
>      > +     default:
>      > +             return -EINVAL;
>      > +     }
>      > +
>      > +     return ret;
>      > +}
>      > +
>      >   static int intel_iommu_attach_device(struct iommu_domain *domain,
>      >                                    struct device *dev)
>      >   {
>      > @@ -5535,7 +5596,7 @@ static phys_addr_t
>     intel_iommu_iova_to_phys(struct iommu_domain *domain,
>      >
>      >       pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
>     &level);
>      >       if (pte)
>      > -             phys = dma_pte_addr(pte);
>      > +             phys = dma_pte_addr(pte, dmar_domain);
>      >
>      >       return phys;
>      >   }
>      > @@ -5958,6 +6019,8 @@ const struct iommu_ops intel_iommu_ops = {
>      >       .capable                = intel_iommu_capable,
>      >       .domain_alloc           = intel_iommu_domain_alloc,
>      >       .domain_free            = intel_iommu_domain_free,
>      > +     .domain_set_attr        = intel_iommu_domain_set_attr,
>      > +     .domain_get_attr        = intel_iommu_domain_get_attr,
>      >       .attach_dev             = intel_iommu_attach_device,
>      >       .detach_dev             = intel_iommu_detach_device,
>      >       .aux_attach_dev         = intel_iommu_aux_attach_device,
>      > diff --git a/drivers/iommu/intel-pasid.c
>     b/drivers/iommu/intel-pasid.c
>      > index 040a445be300..ca7bf35cb4a0 100644
>      > --- a/drivers/iommu/intel-pasid.c
>      > +++ b/drivers/iommu/intel-pasid.c
>      > @@ -553,7 +553,7 @@ int intel_pasid_setup_second_level(struct
>     intel_iommu *iommu,
>      >        */
>      >       pgd = domain->pgd;
>      >       for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
>      > -             pgd = phys_to_virt(dma_pte_addr(pgd));
>      > +             pgd = phys_to_virt(dma_pte_addr(pgd, domain));
>      >               if (!dma_pte_present(pgd)) {
>      >                       dev_err(dev, "Invalid domain page table\n");
>      >                       return -EINVAL;
>      > diff --git a/include/linux/intel-iommu.h
>     b/include/linux/intel-iommu.h
>      > index ed11ef594378..4c18fdf8bca3 100644
>      > --- a/include/linux/intel-iommu.h
>      > +++ b/include/linux/intel-iommu.h
>      > @@ -37,6 +37,17 @@
>      >   #define DMA_PTE_READ (1)
>      >   #define DMA_PTE_WRITE (2)
>      >   #define DMA_PTE_LARGE_PAGE (1 << 7)
>      > +/*
>      > + * PCIe Address Translation Service (ATS) allows a PCIe device
>     to look up VA->PA
>      > + * translations maintained by the IOMMU and cache them.
>     Unfortunately, up to at
>      > + * least Intel Skylake, the IOMMU fragments all ATS Translation
>     Responses to 4
>      > + * KiB, even if the underlying page size is 2 MiB. In order to
>     know if a page is
>      > + * mapped as 2 MiB, a side-channel is defined here by setting the
>      > + * DMA_PTE_A45_HUGE_PAGE bit in all huge-page PTEs. This bit can
>     be received as
>      > + * part of the ATS translation response and interpreted only as
>     2 MiB page size
>      > + * indicator, but ignored otherwise.
>      > + */
>      > +#define DMA_PTE_A45_HUGE_PAGE (1UL << 45)
>      >   #define DMA_PTE_SNP (1 << 11)
>      >
>      >   #define CONTEXT_TT_MULTI_LEVEL      0
>      > @@ -604,16 +615,6 @@ static inline void dma_clear_pte(struct
>     dma_pte *pte)
>      >       pte->val = 0;
>      >   }
>      >
>      > -static inline u64 dma_pte_addr(struct dma_pte *pte)
>      > -{
>      > -#ifdef CONFIG_64BIT
>      > -     return pte->val & VTD_PAGE_MASK;
>      > -#else
>      > -     /* Must have a full atomic 64-bit read */
>      > -     return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
>      > -#endif
>      > -}
>      > -
>      >   static inline bool dma_pte_present(struct dma_pte *pte)
>      >   {
>      >       return (pte->val & 3) != 0;
>      > @@ -624,6 +625,22 @@ static inline bool dma_pte_superpage(struct
>     dma_pte *pte)
>      >       return (pte->val & DMA_PTE_LARGE_PAGE);
>      >   }
>      >
>      > +bool domain_type_get_a45_huge_page(struct dmar_domain *domain);
>      > +static inline u64 dma_pte_addr(struct dma_pte *pte, struct
>     dmar_domain *domain)
>      > +{
>      > +#ifdef CONFIG_64BIT
>      > +     u64 mask = VTD_PAGE_MASK;
>      > +
>      > +     if (dma_pte_superpage(pte) &&
>     domain_type_get_a45_huge_page(domain))
>      > +             mask &= ~DMA_PTE_A45_HUGE_PAGE;
>      > +
>      > +     return pte->val & mask;
>      > +#else
>      > +     /* Must have a full atomic 64-bit read */
>      > +     return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
>      > +#endif
>      > +}
>      > +
>      >   static inline int first_pte_in_page(struct dma_pte *pte)
>      >   {
>      >       return !((unsigned long)pte & ~VTD_PAGE_MASK);
>      > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>      > index e28e80dea141..e4231f1759a0 100644
>      > --- a/include/linux/iommu.h
>      > +++ b/include/linux/iommu.h
>      > @@ -126,6 +126,7 @@ enum iommu_attr {
>      >       DOMAIN_ATTR_FSL_PAMUV1,
>      >       DOMAIN_ATTR_NESTING,    /* two stages of translation */
>      >       DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
>      > +     DOMAIN_ATTR_A45_HUGE_PAGE,  /* huge-page side channel */
>      >       DOMAIN_ATTR_MAX,
>      >   };
>      >
>      >
> 
