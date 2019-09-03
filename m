Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A6C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168FB22DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567492236;
	bh=PNDgAQs78MSbUv+4jSX7U1x7Syw3aaKg9ZwbknDGfpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r1Yqipyir/2utbQQw1DtJG0Mlcnoe+NBZXO/t5wysDzD+LKpSqc18QxwpTRnVl8gZ
	 hQ4V+wobNBLZSjkrlP+rlRCbRTYIUA9aqZzmApkPIt3ST2pO+qMiv9eMgnWyRDt/UJ
	 ARlQecG4VNCd2s49/oXmQu7YogzKXNMzVDvpncQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfICGaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfICGae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:30:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB09120882;
        Tue,  3 Sep 2019 06:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567492233;
        bh=PNDgAQs78MSbUv+4jSX7U1x7Syw3aaKg9ZwbknDGfpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2flIbda+GBUm/IB7GHSnk6uGdGg0zgS5DOJ+/IYOI0/7RxHS85LYg1CpCRZ5uXKP+
         1xprgvh3okb4QOafNS8bl7iN0uwzrb5gsZMPqlFFm2mfJ/u2XkC71UU1Dypl1bZgCB
         giogOpYJbdIltm4YZZA3oIaIqs7T3Ca005jAjOcc=
Date:   Tue, 3 Sep 2019 07:30:29 +0100
From:   Will Deacon <will@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/arm-smmu-v3: Fix build error without
 CONFIG_PCI_ATS
Message-ID: <20190903063028.6ryuk5dmaohi2fqa@willie-the-truck>
References: <20190903024212.20300-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903024212.20300-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:42:12AM +0800, YueHaibing wrote:
> If CONFIG_PCI_ATS is not set, building fails:
> 
> drivers/iommu/arm-smmu-v3.c: In function arm_smmu_ats_supported:
> drivers/iommu/arm-smmu-v3.c:2325:35: error: struct pci_dev has no member named ats_cap; did you mean msi_cap?
>   return !pdev->untrusted && pdev->ats_cap;
>                                    ^~~~~~~
> 
> ats_cap should only used when CONFIG_PCI_ATS is defined,
> so use #ifdef block to guard this.
> 
> Fixes: bfff88ec1afe ("iommu/arm-smmu-v3: Rework enabling/disabling of ATS for PCI masters")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 66bf641..44ac9ac 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2313,7 +2313,7 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
>  
>  static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>  {
> -	struct pci_dev *pdev;
> +	struct pci_dev *pdev __maybe_unused;
>  	struct arm_smmu_device *smmu = master->smmu;
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
>  
> @@ -2321,8 +2321,10 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>  	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
>  		return false;
>  
> +#ifdef CONFIG_PCI_ATS
>  	pdev = to_pci_dev(master->dev);
>  	return !pdev->untrusted && pdev->ats_cap;
> +#endif
>  }

Hmm, I really don't like the missing return statement here, even though we
never get this far thanks to the feature not getting set during ->probe().
I'd actually prefer just to duplicate the function:

#ifndef CONFIG_PCI_ATS
static bool
arm_smmu_ats_supported(struct arm_smmu_master *master) { return false; }
#else
<current code here>
#endif

Can you send a v2 like that, please?

Will
