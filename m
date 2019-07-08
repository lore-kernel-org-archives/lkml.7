Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72679C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4241C20861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfGHPNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:13:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfGHPNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:13:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A8B8A3B6E;
        Mon,  8 Jul 2019 15:13:09 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0618551F0F;
        Mon,  8 Jul 2019 15:13:06 +0000 (UTC)
Subject: Re: [PATCH 5/8] iommu/arm-smmu-v3: Add second level of context
 descriptor table
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        will.deacon@arm.com
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-6-jean-philippe.brucker@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <3e69caf7-4e8a-4bce-7a89-51e21a0134b1@redhat.com>
Date:   Mon, 8 Jul 2019 17:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190610184714.6786-6-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 08 Jul 2019 15:13:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 6/10/19 8:47 PM, Jean-Philippe Brucker wrote:
> The SMMU can support up to 20 bits of SSID. Add a second level of page
> tables to accommodate this. Devices that support more than 1024 SSIDs now
> have a table of 1024 L1 entries (8kB), pointing to tables of 1024 context
> descriptors (64kB), allocated on demand.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 136 +++++++++++++++++++++++++++++++++---
>  1 file changed, 128 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d90eb604b65d..326b71793336 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -216,6 +216,8 @@
>  
>  #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
>  #define STRTAB_STE_0_S1FMT_LINEAR	0
> +#define STRTAB_STE_0_S1FMT_4K_L2	1
As you only use 64kB L2, I guess you can remove the 4K define?
> +#define STRTAB_STE_0_S1FMT_64K_L2	2
>  #define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
>  #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
>  
> @@ -255,6 +257,18 @@
>  
>  #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
>  
> +/*
> + * Linear: when less than 1024 SSIDs are supported
> + * 2lvl: at most 1024 L1 entrie,
entries
> + *      1024 lazy entries per table.
> + */
> +#define CTXDESC_SPLIT			10
> +#define CTXDESC_NUM_L2_ENTRIES		(1 << CTXDESC_SPLIT)
> +
> +#define CTXDESC_L1_DESC_DWORD		1
> +#define CTXDESC_L1_DESC_VALID		1
> +#define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
> +
>  /* Context descriptor (stage-1 only) */
>  #define CTXDESC_CD_DWORDS		8
>  #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
> @@ -530,7 +544,10 @@ struct arm_smmu_ctx_desc {
>  struct arm_smmu_s1_cfg {
>  	u8				s1fmt;
>  	u8				s1cdmax;
> -	struct arm_smmu_cd_table	table;
> +	struct arm_smmu_cd_table	*tables;
> +	size_t				num_tables;
> +	__le64				*l1ptr;
> +	dma_addr_t			l1ptr_dma;
>  
>  	/* Context descriptor 0, when substreams are disabled or s1dss = 0b10 */
>  	struct arm_smmu_ctx_desc	cd;
> @@ -1118,12 +1135,51 @@ static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
>  {
>  	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
>  
> +	if (!table->ptr)
> +		return;
>  	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
>  }
>  
> -static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_s1_cfg *cfg, u32 ssid)
> +static void arm_smmu_write_cd_l1_desc(__le64 *dst,
> +				      struct arm_smmu_cd_table *table)
>  {
> -	return cfg->table.ptr + ssid * CTXDESC_CD_DWORDS;
> +	u64 val = (table->ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
> +		  CTXDESC_L1_DESC_VALID;
> +
> +	*dst = cpu_to_le64(val);
> +}
> +
> +static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
> +				   u32 ssid)> +{
> +	unsigned int idx;
> +	struct arm_smmu_cd_table *table;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> +
> +	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
> +		table = &cfg->tables[0];
> +		idx = ssid;
> +	} else {
> +		idx = ssid >> CTXDESC_SPLIT;
> +		if (idx >= cfg->num_tables)
> +			return NULL;
> +
> +		table = &cfg->tables[idx];
> +		if (!table->ptr) {
> +			__le64 *l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORD;
> +
> +			if (arm_smmu_alloc_cd_leaf_table(smmu, table,
> +							 CTXDESC_NUM_L2_ENTRIES))
> +				return NULL;
> +
> +			arm_smmu_write_cd_l1_desc(l1ptr, table);
> +			/* An invalid L1 entry is allowed to be cached */
> +			arm_smmu_sync_cd(smmu_domain, ssid, false);
> +		}
> +		idx = ssid & (CTXDESC_NUM_L2_ENTRIES - 1);
> +	}
> +	return table->ptr + idx * CTXDESC_CD_DWORDS;
>  }
>  
>  static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
> @@ -1149,7 +1205,7 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  	u64 val;
>  	bool cd_live;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	__le64 *cdptr = arm_smmu_get_cd_ptr(&smmu_domain->s1_cfg, ssid);
> +	__le64 *cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
>  
>  	/*
>  	 * This function handles the following cases:
> @@ -1213,20 +1269,81 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
>  				    struct arm_smmu_master *master)
>  {
> +	int ret;
> +	size_t size = 0;
> +	size_t max_contexts, num_leaf_entries;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>  
>  	cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
>  	cfg->s1cdmax = master->ssid_bits;
> -	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
> +
> +	max_contexts = 1 << cfg->s1cdmax;
> +	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
> +	    max_contexts <= CTXDESC_NUM_L2_ENTRIES) {
> +		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
> +		cfg->num_tables = 1;
> +		num_leaf_entries = max_contexts;
> +	} else {
> +		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
> +		/*
> +		 * SSID[S1CDmax-1:10] indexes 1st-level table, SSID[9:0] indexes
> +		 * 2nd-level
> +		 */
> +		cfg->num_tables = max_contexts / CTXDESC_NUM_L2_ENTRIES;
> +
> +		size = cfg->num_tables * (CTXDESC_L1_DESC_DWORD << 3);
> +		cfg->l1ptr = dmam_alloc_coherent(smmu->dev, size,
> +						 &cfg->l1ptr_dma,
> +						 GFP_KERNEL | __GFP_ZERO);
> +		if (!cfg->l1ptr) {
> +			dev_warn(smmu->dev, "failed to allocate L1 context table\n");
> +			return -ENOMEM;
> +		}
> +
> +		num_leaf_entries = CTXDESC_NUM_L2_ENTRIES;
> +	}
> +
> +	cfg->tables = devm_kzalloc(smmu->dev, sizeof(struct arm_smmu_cd_table) *
> +				   cfg->num_tables, GFP_KERNEL);
> +	if (!cfg->tables)
> +		return -ENOMEM;
goto err_free_l1
> +
> +	ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0], num_leaf_entries);
don't you want to do that only in linear case. In 2-level mode, I
understand arm_smmu_get_cd_ptr() will do the job.

> +	if (ret)
> +		goto err_free_l1;
> +
> +	if (cfg->l1ptr)
> +		arm_smmu_write_cd_l1_desc(cfg->l1ptr, &cfg->tables[0]);
that stuff could be removed as well? By the way I can see that
arm_smmu_get_cd_ptr() does a arm_smmu_sync_cd after. wouldn't it be
needed here as well?
> +
> +	return 0;
> +
> +err_free_l1:
> +	if (cfg->l1ptr)
> +		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
> +	devm_kfree(smmu->dev, cfg->tables);
> +	return ret;
>  }
>  
>  static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
>  {
> +	int i;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> +	size_t num_leaf_entries = 1 << cfg->s1cdmax;
> +	struct arm_smmu_cd_table *table = cfg->tables;
> +
> +	if (cfg->l1ptr) {
> +		size_t size = cfg->num_tables * (CTXDESC_L1_DESC_DWORD << 3);
>  
> -	arm_smmu_free_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
> +		dmam_free_coherent(smmu->dev, size, cfg->l1ptr,
> +				   cfg->l1ptr_dma);
> +		num_leaf_entries = CTXDESC_NUM_L2_ENTRIES;
> +	}
> +
> +	for (i = 0; i < cfg->num_tables; i++, table++)
> +		arm_smmu_free_cd_leaf_table(smmu, table, num_leaf_entries);
> +	devm_kfree(smmu->dev, cfg->tables);
>  }
>  
>  /* Stream table manipulation functions */
> @@ -1346,6 +1463,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  	}
>  
>  	if (s1_cfg) {
> +		dma_addr_t ptr_dma = s1_cfg->l1ptr ? s1_cfg->l1ptr_dma :
> +			             s1_cfg->tables[0].ptr_dma;
> +
>  		BUG_ON(ste_live);
>  		dst[1] = cpu_to_le64(
>  			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
> @@ -1358,7 +1478,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
>  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>  
> -		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> +		val |= (ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
>  			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
>  			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
>  			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
> @@ -1815,7 +1935,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>  
> -		if (cfg->table.ptr) {
> +		if (cfg->tables) {
>  			arm_smmu_free_cd_tables(smmu_domain);
>  			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
I don't get why the arm_smmu_bitmap_free is dependent on cfg->tables.

Thanks

Eric
>  		}
> 
