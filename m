Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364D7C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7CF21783
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561572034;
	bh=amZXky+dzy6w//rZtfTX48NyKxgLPjoPas3mxcVTbe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GIhK5VVDxmkSYcfk0TIPBiSo9Uwq328m56aR2muOLY7HjnweCO/trD/Nyw5noz1mD
	 IPLgN63X4qujmhZF6rQjPcVG8hCsIVAJveMC8wrwxPiH5cDPBLUw5YRy7QGtLmSnC3
	 l3LuFZK07RNnYmGzrjABGqVhEPbWCOLHhiRhBzHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfFZSAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZSAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:00:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2FC12177B;
        Wed, 26 Jun 2019 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561572030;
        bh=amZXky+dzy6w//rZtfTX48NyKxgLPjoPas3mxcVTbe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yjWHcRlpFsV3Ts63y+nh2Wr5JEyOiV/tm3lCQSVSJrExovUYgChIQnL3RkPEkPy//
         tRDUh7tJNyr68TWwrj1bgCY2qwIjsKCfUqYb45HxZltQOPAlWt/6Vm7V739Xajuanf
         wfGUH0ykQmRyIrO+fVMe1WlTsvKPI8heorx98kQA=
Date:   Wed, 26 Jun 2019 19:00:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     will.deacon@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        mark.rutland@arm.com, robin.murphy@arm.com,
        jacob.jun.pan@linux.intel.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com
Subject: Re: [PATCH 4/8] iommu/arm-smmu-v3: Add support for Substream IDs
Message-ID: <20190626180025.g4clm6qnbbna65de@willie-the-truck>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-5-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610184714.6786-5-jean-philippe.brucker@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 07:47:10PM +0100, Jean-Philippe Brucker wrote:
> At the moment, the SMMUv3 driver implements only one stage-1 or stage-2
> page directory per device. However SMMUv3 allows more than one address
> space for some devices, by providing multiple stage-1 page directories. In
> addition to the Stream ID (SID), that identifies a device, we can now have
> Substream IDs (SSID) identifying an address space. In PCIe, SID is called
> Requester ID (RID) and SSID is called Process Address-Space ID (PASID).
> 
> Prepare the driver for SSID support, by adding context descriptor tables
> in STEs (previously a single static context descriptor). A complete
> stage-1 walk is now performed like this by the SMMU:
> 
>       Stream tables          Ctx. tables          Page tables
>         +--------+   ,------->+-------+   ,------->+-------+
>         :        :   |        :       :   |        :       :
>         +--------+   |        +-------+   |        +-------+
>    SID->|  STE   |---'  SSID->|  CD   |---'  IOVA->|  PTE  |--> IPA
>         +--------+            +-------+            +-------+
>         :        :            :       :            :       :
>         +--------+            +-------+            +-------+
> 
> Implement a single level of context descriptor table for now, but as with
> stream and page tables, an SSID can be split to index multiple levels of
> tables.
> 
> In all stream table entries, we set S1DSS=SSID0 mode, making translations
> without an SSID use context descriptor 0. Although it would be possible by
> setting S1DSS=BYPASS, we don't currently support SSID when user selects
> iommu.passthrough.

I don't understand your comment here: iommu.passthrough works just as it did
before, right, since we set bypass in the STE config field so S1DSS is not
relevant? I also notice that SSID0 causes transactions with SSID==0 to
abort. Is a PASID of 0 reserved, so this doesn't matter?

> @@ -1062,33 +1143,90 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
>  	return val;
>  }
>  
> -static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
> -				    struct arm_smmu_s1_cfg *cfg)
> +static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> +				   int ssid, struct arm_smmu_ctx_desc *cd)
>  {
>  	u64 val;
> +	bool cd_live;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	__le64 *cdptr = arm_smmu_get_cd_ptr(&smmu_domain->s1_cfg, ssid);
>  
>  	/*
> -	 * We don't need to issue any invalidation here, as we'll invalidate
> -	 * the STE when installing the new entry anyway.
> +	 * This function handles the following cases:
> +	 *
> +	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
> +	 * (2) Install a secondary CD, for SID+SSID traffic.
> +	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
> +	 *     CD, then invalidate the old entry and mappings.
> +	 * (4) Remove a secondary CD.
>  	 */
> -	val = arm_smmu_cpu_tcr_to_cd(cfg->cd.tcr) |
> +
> +	if (!cdptr)
> +		return -ENOMEM;
> +
> +	val = le64_to_cpu(cdptr[0]);
> +	cd_live = !!(val & CTXDESC_CD_0_V);
> +
> +	if (!cd) { /* (4) */
> +		cdptr[0] = 0;

Should we be using WRITE_ONCE here? (although I notice we don't seem to
bother for STEs either...)

Will
