Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123AAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03B82084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCSS13gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfCAUZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:25:32 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39038 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCAUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:25:31 -0500
Received: by mail-it1-f194.google.com with SMTP id l15so23400722iti.4;
        Fri, 01 Mar 2019 12:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrTgf+nIymAj0SLnVWmRNwnM/Fww7UgIvkfvav4dLNw=;
        b=DCSS13gl7uEef2ydZVX8CvBFB4sG/O3XJyHMovmdPD4uMiqB1JtkVQWAeX5259EEE+
         jUAjkgO9Mp7taNJDJR958votHlyJu8RJeDVD0prDaGaDtTImXf/OvVD9jRpZGKeZYFdl
         pSRCWbsA6NkA1fI7obbzIgH47RI60JpAWhiwfmSCpQ7dKFdoWlzzOLyKE6eru4+ztRGh
         gzPOo7/nufidZ15pBT7PGAZemUVxgWVUpUbC2ULXR2uSoKQa/N+XLrcx7AGrQmwBuwz9
         oTJ4gTgu325ky9H9phC/vQZefxfa0UhRKiZtkfLcwi6EIqOORcaooICMbvbrO3167R9s
         lYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrTgf+nIymAj0SLnVWmRNwnM/Fww7UgIvkfvav4dLNw=;
        b=hMD8dtPaU+Mj018qv/InADG72yyIjH2Pxo1HK5i3nJjFymrovsSECjabqwe1VyA4PJ
         5EI9mfL3fjpqpVZ1ovy+8dzQRAEOAeNmbVmrWaE7/eAqY0F5Z6S8rUGO4BhFN5AOcenG
         OX3xynQkjngVLlGJoZ3coSPKyk1GUkQo6T6QqOFmF2UsRhYVy6hs046m/y3EIdtXBSlb
         k97HRTnWiNAB2AFBtefKx77uroGE3anE1HGzCObBXlYjalulff3hDeIU1K/tGKsYLwAR
         BDaW1jVDNg9WXIbLrJnEVeynIDeQ4vuFVYtRIeVgwjL62tVzdhELqh5t0dMKHVZ6uO45
         xGpg==
X-Gm-Message-State: APjAAAUwmUNzLM0knc8ZvBxqOZynC1qnbAjAIDI62sY993c/nfg3AshB
        7/cy+pz9I9z5yV+/VcrBO644BjNOKfQHMacycT4=
X-Google-Smtp-Source: APXvYqwJxc8NFtfI2vaNqsdtIc0j2Zkx+FJy2tE0MWVHQwKEsPJEKTxslBv0C3BBSN6Vn4ajm/zfIUsk6vypiki85Jk=
X-Received: by 2002:a02:1854:: with SMTP id k81mr3726756jad.144.1551471930313;
 Fri, 01 Mar 2019 12:25:30 -0800 (PST)
MIME-Version: 1.0
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org> <1551469117-3404-3-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1551469117-3404-3-git-send-email-jcrouse@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 1 Mar 2019 15:25:18 -0500
Message-ID: <CAF6AEGtb3MAS8U8AQEFXBMVB5x5+1786+r+hybrg5qzqZuqnLg@mail.gmail.com>
Subject: Re: [Freedreno] [RFC PATCH v1 02/15] iommu/arm-smmu: Add split
 pagetable support for arm-smmu-v2
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        dianders@chromimum.org,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, baolu.lu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 2:38 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add support for a split pagetable (TTBR0/TTBR1) scheme for
> arm-smmu-v2. If split pagetables are enabled, create a
> pagetable for TTBR1 and set up the sign extension bit so
> that all IOVAs with that bit set are mapped and translated
> from the TTBR1 pagetable.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/iommu/arm-smmu-regs.h  |  18 +++++
>  drivers/iommu/arm-smmu.c       | 149 +++++++++++++++++++++++++++++++++++++----
>  drivers/iommu/io-pgtable-arm.c |   3 +-
>  3 files changed, 154 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4..56f9709 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -193,7 +193,25 @@ enum arm_smmu_s2cr_privcfg {
>  #define RESUME_RETRY                   (0 << 0)
>  #define RESUME_TERMINATE               (1 << 0)
>
> +#define TTBCR_EPD1                     (1 << 23)
> +#define TTBCR_T1SZ_SHIFT               16
> +#define TTBCR_IRGN1_SHIFT              24
> +#define TTBCR_ORGN1_SHIFT              26
> +#define TTBCR_RGN_WBWA                 1
> +#define TTBCR_SH1_SHIFT                        28
> +#define TTBCR_SH_IS                    3
> +
> +#define TTBCR_TG1_16K                  (1 << 30)
> +#define TTBCR_TG1_4K                   (2 << 30)
> +#define TTBCR_TG1_64K                  (3 << 30)
> +
>  #define TTBCR2_SEP_SHIFT               15
> +#define TTBCR2_SEP_31                  (0x0 << TTBCR2_SEP_SHIFT)
> +#define TTBCR2_SEP_35                  (0x1 << TTBCR2_SEP_SHIFT)
> +#define TTBCR2_SEP_39                  (0x2 << TTBCR2_SEP_SHIFT)
> +#define TTBCR2_SEP_41                  (0x3 << TTBCR2_SEP_SHIFT)
> +#define TTBCR2_SEP_43                  (0x4 << TTBCR2_SEP_SHIFT)
> +#define TTBCR2_SEP_47                  (0x5 << TTBCR2_SEP_SHIFT)
>  #define TTBCR2_SEP_UPSTREAM            (0x7 << TTBCR2_SEP_SHIFT)
>  #define TTBCR2_AS                      (1 << 4)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index af18a7e..05eb126 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -151,6 +151,7 @@ struct arm_smmu_cb {
>         u32                             tcr[2];
>         u32                             mair[2];
>         struct arm_smmu_cfg             *cfg;
> +       u64                             split_table_mask;
>  };
>
>  struct arm_smmu_master_cfg {
> @@ -208,6 +209,7 @@ struct arm_smmu_device {
>         unsigned long                   va_size;
>         unsigned long                   ipa_size;
>         unsigned long                   pa_size;
> +       unsigned long                   ubs_size;
>         unsigned long                   pgsize_bitmap;
>
>         u32                             num_global_irqs;
> @@ -252,13 +254,14 @@ enum arm_smmu_domain_stage {
>
>  struct arm_smmu_domain {
>         struct arm_smmu_device          *smmu;
> -       struct io_pgtable_ops           *pgtbl_ops;
> +       struct io_pgtable_ops           *pgtbl_ops[2];
>         const struct iommu_gather_ops   *tlb_ops;
>         struct arm_smmu_cfg             cfg;
>         enum arm_smmu_domain_stage      stage;
>         bool                            non_strict;
>         struct mutex                    init_mutex; /* Protects smmu pointer */
>         spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
> +       u32 attributes;
>         struct iommu_domain             domain;
>  };
>
> @@ -618,6 +621,69 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>         return IRQ_HANDLED;
>  }
>
> +static void arm_smmu_init_ttbr1(struct arm_smmu_domain *smmu_domain,
> +               struct io_pgtable_cfg *pgtbl_cfg)
> +{
> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +       struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
> +       int pgsize = 1 << __ffs(pgtbl_cfg->pgsize_bitmap);
> +
> +       /* Enable speculative walks through the TTBR1 */
> +       cb->tcr[0] &= ~TTBCR_EPD1;
> +
> +       cb->tcr[0] |= TTBCR_SH_IS << TTBCR_SH1_SHIFT;
> +       cb->tcr[0] |= TTBCR_RGN_WBWA << TTBCR_IRGN1_SHIFT;
> +       cb->tcr[0] |= TTBCR_RGN_WBWA << TTBCR_ORGN1_SHIFT;
> +
> +       switch (pgsize) {
> +       case SZ_4K:
> +               cb->tcr[0] |= TTBCR_TG1_4K;
> +               break;
> +       case SZ_16K:
> +               cb->tcr[0] |= TTBCR_TG1_16K;
> +               break;
> +       case SZ_64K:
> +               cb->tcr[0] |= TTBCR_TG1_64K;
> +               break;
> +       }
> +
> +       cb->tcr[0] |= (64ULL - smmu->va_size) << TTBCR_T1SZ_SHIFT;
> +
> +       /* Clear the existing SEP configuration */
> +       cb->tcr[1] &= ~TTBCR2_SEP_UPSTREAM;
> +
> +       /* Set up the sign extend bit */
> +       switch (smmu->va_size) {
> +       case 32:
> +               cb->tcr[1] |= TTBCR2_SEP_31;
> +               cb->split_table_mask = (1ULL << 31);
> +               break;
> +       case 36:
> +               cb->tcr[1] |= TTBCR2_SEP_35;
> +               cb->split_table_mask = (1ULL << 35);
> +               break;
> +       case 40:
> +               cb->tcr[1] |= TTBCR2_SEP_39;
> +               cb->split_table_mask = (1ULL << 39);
> +               break;
> +       case 42:
> +               cb->tcr[1] |= TTBCR2_SEP_41;
> +               cb->split_table_mask = (1ULL << 41);
> +               break;
> +       case 44:
> +               cb->tcr[1] |= TTBCR2_SEP_43;
> +               cb->split_table_mask = (1ULL << 43);
> +               break;
> +       case 48:
> +               cb->tcr[1] |= TTBCR2_SEP_UPSTREAM;
> +               cb->split_table_mask = (1ULL << 48);
> +       }
> +
> +       cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> +       cb->ttbr[1] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
> +}
> +
>  static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>                                        struct io_pgtable_cfg *pgtbl_cfg)
>  {
> @@ -650,8 +716,12 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>                 } else {
>                         cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>                         cb->ttbr[0] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
> -                       cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
> -                       cb->ttbr[1] |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
> +
> +                       /*
> +                        * Set TTBR1 to empty by default - it will get
> +                        * programmed later if it is enabled
> +                        */
> +                       cb->ttbr[1] = (u64)cfg->asid << TTBRn_ASID_SHIFT;
>                 }
>         } else {
>                 cb->ttbr[0] = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
> @@ -760,11 +830,13 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  {
>         int irq, start, ret = 0;
>         unsigned long ias, oas;
> -       struct io_pgtable_ops *pgtbl_ops;
> +       struct io_pgtable_ops *pgtbl_ops[2];
>         struct io_pgtable_cfg pgtbl_cfg;
>         enum io_pgtable_fmt fmt;
>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>         struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +       bool split_tables =
> +               (smmu_domain->attributes & (1 << DOMAIN_ATTR_SPLIT_TABLES));

BIT(DOMAIN_ATTR_SPLIT_TABLES) ?

>
>         mutex_lock(&smmu_domain->init_mutex);
>         if (smmu_domain->smmu)
> @@ -794,8 +866,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>          *
>          * Note that you can't actually request stage-2 mappings.
>          */
> -       if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
> +       if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1)) {
>                 smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> +               /* FIXME: fail instead? */
> +               split_tables = false;

yeah, I think we want to return an error somewhere if not supported.
I think we want to fall back to not using per-process pagetables if
this fails.


BR,
-R


> +       }
>         if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>                 smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>
> @@ -812,8 +887,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>         if (IS_ENABLED(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) &&
>             !IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_ARM_LPAE) &&
>             (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S) &&
> -           (smmu_domain->stage == ARM_SMMU_DOMAIN_S1))
> +           (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)) {
> +               /* FIXME: fail instead? */
> +               split_tables = false;
>                 cfg->fmt = ARM_SMMU_CTX_FMT_AARCH32_S;
> +       }
>         if ((IS_ENABLED(CONFIG_64BIT) || cfg->fmt == ARM_SMMU_CTX_FMT_NONE) &&
>             (smmu->features & (ARM_SMMU_FEAT_FMT_AARCH64_64K |
>                                ARM_SMMU_FEAT_FMT_AARCH64_16K |
> @@ -903,8 +981,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>                 pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>
>         smmu_domain->smmu = smmu;
> -       pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
> -       if (!pgtbl_ops) {
> +       pgtbl_ops[0] = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
> +       if (!pgtbl_ops[0]) {
>                 ret = -ENOMEM;
>                 goto out_clear_smmu;
>         }
> @@ -916,6 +994,22 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>
>         /* Initialise the context bank with our page table cfg */
>         arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> +
> +       pgtbl_ops[1] = NULL;
> +
> +       if (split_tables) {
> +               /* FIXME: I think it is safe to reuse pgtbl_cfg here */
> +               pgtbl_ops[1] = alloc_io_pgtable_ops(fmt, &pgtbl_cfg,
> +                       smmu_domain);
> +               if (!pgtbl_ops[1]) {
> +                       free_io_pgtable_ops(pgtbl_ops[0]);
> +                       ret = -ENOMEM;
> +                       goto out_clear_smmu;
> +               }
> +
> +               arm_smmu_init_ttbr1(smmu_domain, &pgtbl_cfg);
> +       }
> +
>         arm_smmu_write_context_bank(smmu, cfg->cbndx);
>
>         /*
> @@ -934,7 +1028,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>         mutex_unlock(&smmu_domain->init_mutex);
>
>         /* Publish page table ops for map/unmap */
> -       smmu_domain->pgtbl_ops = pgtbl_ops;
> +       smmu_domain->pgtbl_ops[0] = pgtbl_ops[0];
> +       smmu_domain->pgtbl_ops[1] = pgtbl_ops[1];
> +
>         return 0;
>
>  out_clear_smmu:
> @@ -970,7 +1066,9 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>                 devm_free_irq(smmu->dev, irq, domain);
>         }
>
> -       free_io_pgtable_ops(smmu_domain->pgtbl_ops);
> +       free_io_pgtable_ops(smmu_domain->pgtbl_ops[0]);
> +       free_io_pgtable_ops(smmu_domain->pgtbl_ops[1]);
> +
>         __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
>
>         arm_smmu_rpm_put(smmu);
> @@ -1285,10 +1383,23 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>         return ret;
>  }
>
> +static struct io_pgtable_ops *
> +arm_smmu_get_pgtbl_ops(struct iommu_domain *domain, unsigned long iova)
> +{
> +       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +       struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
> +
> +       if (iova & cb->split_table_mask)
> +               return smmu_domain->pgtbl_ops[1];
> +
> +       return smmu_domain->pgtbl_ops[0];
> +}
> +
>  static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>                         phys_addr_t paddr, size_t size, int prot)
>  {
> -       struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> +       struct io_pgtable_ops *ops = arm_smmu_get_pgtbl_ops(domain, iova);
>         struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
>         int ret;
>
> @@ -1305,7 +1416,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>  static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>                              size_t size)
>  {
> -       struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> +       struct io_pgtable_ops *ops = arm_smmu_get_pgtbl_ops(domain, iova);
>         struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
>         size_t ret;
>
> @@ -1349,7 +1460,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>         struct arm_smmu_device *smmu = smmu_domain->smmu;
>         struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> -       struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
> +       struct io_pgtable_ops *ops = arm_smmu_get_pgtbl_ops(domain, iova);
>         struct device *dev = smmu->dev;
>         void __iomem *cb_base;
>         u32 tmp;
> @@ -1397,7 +1508,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
>                                         dma_addr_t iova)
>  {
>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> -       struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> +       struct io_pgtable_ops *ops = arm_smmu_get_pgtbl_ops(domain, iova);
>
>         if (domain->type == IOMMU_DOMAIN_IDENTITY)
>                 return iova;
> @@ -1584,6 +1695,11 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>                 case DOMAIN_ATTR_NESTING:
>                         *(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>                         return 0;
> +               case DOMAIN_ATTR_SPLIT_TABLES:
> +                       *((int *)data) =
> +                               !!(smmu_domain->attributes &
> +                                  (1 << DOMAIN_ATTR_SPLIT_TABLES));
> +                       return 0;
>                 default:
>                         return -ENODEV;
>                 }
> @@ -1624,6 +1740,11 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>                         else
>                                 smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>                         break;
> +               case DOMAIN_ATTR_SPLIT_TABLES:
> +                       if (*((int *)data))
> +                               smmu_domain->attributes |=
> +                                       (1 << DOMAIN_ATTR_SPLIT_TABLES);
> +                       break;
>                 default:
>                         ret = -ENODEV;
>                 }
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 237cacd..dc9fb2e 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -475,8 +475,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>         if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>                 return 0;
>
> -       if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
> -                   paddr >= (1ULL << data->iop.cfg.oas)))
> +       if (WARN_ON(paddr >= (1ULL << data->iop.cfg.oas)))
>                 return -ERANGE;
>
>         prot = arm_lpae_prot_to_pte(data, iommu_prot);
> --
> 2.7.4
>
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
