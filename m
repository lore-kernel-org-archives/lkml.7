Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EA2215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfICM6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:58:52 -0400
Received: from 8bytes.org ([81.169.241.247]:52972 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbfICM6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:58:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6786C284; Tue,  3 Sep 2019 14:58:50 +0200 (CEST)
Date:   Tue, 3 Sep 2019 14:58:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     will@kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] iommu/arm-smmu-v3: Fix build error without
 CONFIG_PCI_ATS
Message-ID: <20190903125848.GC11530@8bytes.org>
References: <20190903024212.20300-1-yuehaibing@huawei.com>
 <20190903065056.17988-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903065056.17988-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:50:56PM +0800, YueHaibing wrote:
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
> v2: Add arm_smmu_ats_supported() of no CONFIG_PCI_ATS
> ---
>  drivers/iommu/arm-smmu-v3.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

