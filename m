Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574C9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2AE2071B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574266039;
	bh=JqtM3uieK4F0AT1KOQl+ms5JG2OW35LEmqi8mfgeS28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UkzxWjOc0fR8WqlYdwG7l4Iq2SEWrZieoh4phc+graSWhLcsG2A6C4g8gNGAYQ+Gd
	 HOj5eKlOOATvnKCtDu5PfcNyBXF3rXWX09qIJ+5D7WDdjLu2s76vm6Mstt+Wwhev47
	 EDDWkbbdVtx0lhOOmGSyyQ+z1n7Ckm83JgcoPBzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbfKTQHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:07:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfKTQHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:07:17 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8019B20674;
        Wed, 20 Nov 2019 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574266037;
        bh=JqtM3uieK4F0AT1KOQl+ms5JG2OW35LEmqi8mfgeS28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdN+TGHv8cjFuVQV2V+NWGv5035/01gZw8/X/NiN/YfSKsHhl/sH+J896AiOfEmRv
         CwcngduCPLQ7Mr5M966I+uIwfPJPOIZKoZU/BcQHt+VVUeAMLIhuwIS+0L3sjbzid+
         WhOiVNmkpTRFefgOsN5CMmtmURo3D/cH/QDQXyFU=
Date:   Wed, 20 Nov 2019 16:07:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        xuwei5@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Populate VMID field for
 CMDQ_OP_TLBI_NH_VA
Message-ID: <20191120160711.GA31165@willie-the-truck>
References: <20191113161138.22336-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113161138.22336-1-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:11:38PM +0000, Shameer Kolothum wrote:
> CMDQ_OP_TLBI_NH_VA requires VMID and this was missing since
> commit 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask
> for CMD_TLBI_S2_IPA"). Add it back.
> 
> Fixes: 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask for CMD_TLBI_S2_IPA")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> This came to light while verifying the "SMMUv3 Nested Stage Setup"
> series by Eric. Please find the discusiion here,
> https://lore.kernel.org/patchwork/cover/1099617/
> ---
>  drivers/iommu/arm-smmu-v3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 8da93e730d6f..9b5274346df0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -856,6 +856,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
>  		break;
>  	case CMDQ_OP_TLBI_NH_VA:
> +		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
>  		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
>  		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
>  		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;

Thanks. I don't think this matters with the way things currently work (we
only have VMID 0 for stage-1 domains), so I'll queue it for 5.6.

Will
