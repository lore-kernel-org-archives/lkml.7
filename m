Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B044CC06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895DA21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562069009;
	bh=lYy0biRRuIMTFPxZzKn1vOvJk9GO14ibys/DKnoKX4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pki55Xm24mMc5G2vTYFpfIveAi9wqLg70dNR6CDcRD13HJYamugC9tVEn2zxhgtcs
	 JTT1K+W+T0436yOErCG0khP6X1T0keCxI1IJwzP/SbVHrJU9fFBBnwnDjAJYIzKc7S
	 dmwLU0ZSLs2n2uwL563qonvDk1gLIep6KImZwZwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfGBMD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfGBMD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:03:27 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E4E2064B;
        Tue,  2 Jul 2019 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562069006;
        bh=lYy0biRRuIMTFPxZzKn1vOvJk9GO14ibys/DKnoKX4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMEpgyG6/0TGoxHxLutiQ3X8vIzEj/RQA7zp7oGwIadFBGwATD0vzjnJ3rOfaz4qe
         K3hqrN6iJ3azFUrZcbWV5XvbhqgqaUDmD7jdcNEwPJ7YpSWSPaKO9it2+AV5Z2W2f3
         nSOiywtaGGPfdtqIxoJ6w4EyOSI+GBho71qBPDks=
Date:   Tue, 2 Jul 2019 13:03:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhangshaokun <zhangshaokun@hisilicon.com>, joro@8bytes.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 2
Message-ID: <20190702120321.v3224ofd4aaxvytk@willie-the-truck>
References: <20190702195158.79aa5517@canb.auug.org.au>
 <000f56ac-2abc-bc6a-e2db-5ae38779d276@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000f56ac-2abc-bc6a-e2db-5ae38779d276@hisilicon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Joerg]

On Tue, Jul 02, 2019 at 06:40:45PM +0800, Zhangshaokun wrote:
> +Cc: Will Deacon
> 
> There is a compiler failure on arm64 platform, as follow:
> In file included from ./include/linux/list.h:9:0,
>                  from ./include/linux/kobject.h:19,
>                  from ./include/linux/of.h:17,
>                  from ./include/linux/irqdomain.h:35,
>                  from ./include/linux/acpi.h:13,
>                  from drivers/iommu/arm-smmu-v3.c:12:
> drivers/iommu/arm-smmu-v3.c: In function ‘arm_smmu_device_hw_probe’:
> drivers/iommu/arm-smmu-v3.c:194:40: error: ‘CONFIG_CMA_ALIGNMENT’ undeclared (first use in this function)
>  #define Q_MAX_SZ_SHIFT   (PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
>                                         ^
> It's the commit <d25f6ead162e> ("iommu/arm-smmu-v3: Increase maximum size of queues")

Thanks for the report. I've provided a fix below.

Joerg -- please can you take this on top of the SMMUv3 patches queued
for 5.3?

Cheers,

Will

--->8

From e8f9d8229e3aaa4817bfb72752e804eec97a3d8d Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Tue, 2 Jul 2019 12:53:18 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Fix compilation when CONFIG_CMA=n
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When compiling a kernel without support for CMA, CONFIG_CMA_ALIGNMENT
is not defined which results in the following build failure:

In file included from ./include/linux/list.h:9:0
                 from ./include/linux/kobject.h:19,
                 from ./include/linux/of.h:17
                 from ./include/linux/irqdomain.h:35,
                 from ./include/linux/acpi.h:13,
                 from drivers/iommu/arm-smmu-v3.c:12:
drivers/iommu/arm-smmu-v3.c: In function ‘arm_smmu_device_hw_probe’:
drivers/iommu/arm-smmu-v3.c:194:40: error: ‘CONFIG_CMA_ALIGNMENT’ undeclared (first use in this function)
 #define Q_MAX_SZ_SHIFT   (PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)

Fix the breakage by capping the maximum queue size based on MAX_ORDER
when CMA is not enabled.

Reported-by: Zhangshaokun <zhangshaokun@hisilicon.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 57fb4e080d6b..8e73a7615bf5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -191,7 +191,13 @@
 #define Q_BASE_RWA			(1UL << 62)
 #define Q_BASE_ADDR_MASK		GENMASK_ULL(51, 5)
 #define Q_BASE_LOG2SIZE			GENMASK(4, 0)
+
+/* Ensure DMA allocations are naturally aligned */
+#ifdef CONFIG_CMA_ALIGNMENT
 #define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
+#else
+#define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_ORDER - 1)
+#endif
 
 /*
  * Stream table.
-- 
2.11.0

