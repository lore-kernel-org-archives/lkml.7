Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B4DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA9721850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mI8yGQTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfDWUEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:04:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40104 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfDWUEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:04:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id d46so13812555eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=vFjhjgT8J7J/y48rMlFt3N0exp7AnVL6x1jQtFEwJmA=;
        b=mI8yGQTMJJh7Cn3t53GITJ7AnDAMMH3Gb2+EvEuxbUvz/yvODXcDKLwCkoVfk3Xi1U
         d+3QlmYt52HZ7SqMCsb5IOvyluTstovnK7WcalvZOCL/dpCx854RM2+qody/rxdiYaeg
         PRZ905oyROMMLv6teBg61hvKM8bMjuStQWeiSfLPkV2W1KKLs0rk68A7z9mRE08hBF2B
         Evtau2ZxHslCFl2aaJlixONLIUBiMoEXlgSfng1Bz6R3SaFpxpiMT/Eplda4Y9XtDXC3
         II/fe0MFVcY7l+nK4XoOtL/PUcwhwV3Ay/RH/O1TfJFXkuRValyvEZ5fTV6XXdqMUqJB
         o6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vFjhjgT8J7J/y48rMlFt3N0exp7AnVL6x1jQtFEwJmA=;
        b=bK7RY5uEmNTOSmboBGQTSuB5mHwcqThcfgCq/ACnIxtfOKUUbDS4eDCdC2PEWU32vj
         Zjvw9phOapYlTh6qwxV7Gxp9BWeQCOsaof3G+QGlzAiSEDGs1O18GxlCdj9KJO92lmSR
         zAIwNyBZGPimFapj94/TLVN4e+RkwxOKbb6HcAmB7/2IFUa3Eevu0HI6izm2mNERa+XT
         6tSK26zeM8kZw6+LzJCTC2wXDp8N6wWkqydUeBzZZCyNEAw67djLovfmqYmFjBOV9c1K
         rcjjM033DzqfPRuKTztP5nTU5k4ixodh5/35CTR/Qs4cLk8FJAr+dLVqoaZD9npaBKqj
         7XVg==
X-Gm-Message-State: APjAAAVWdN3Se2iAUWJS28eUL2FqCD1WPkF1zj43KSBcq5r5E8lC5hOj
        mFpcaDXf9PMuNcLTvsebxHMd7Q==
X-Google-Smtp-Source: APXvYqxaAnK6AtYePG+GxF6pAlJM0XJ8IeMly8zDdWCF2/Fo0nOgrbK6yfMwfKMwpIbSiDRpd+YOHQ==
X-Received: by 2002:a17:906:c389:: with SMTP id t9mr5089629ejz.64.1556049874311;
        Tue, 23 Apr 2019 13:04:34 -0700 (PDT)
Received: from linux-ThinkPad-X1-Carbon-5th.Hitronhub.home ([80.111.101.37])
        by smtp.gmail.com with ESMTPSA id l10sm3762140eda.8.2019.04.23.13.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:04:33 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove old no iommu direct mapping code
Date:   Tue, 23 Apr 2019 21:03:34 +0100
Message-Id: <20190423200335.3888-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These checks were intended to handle devices not mapped by the IOMMU.
Since the AMD IOMMU driver uses per-device dma_ops these functions can
no longer be called by direct mapped devices. So these checks aren't
needed anymore.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b319e51c379b..67cdc9e5304b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2503,9 +2503,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	u64 dma_mask;
 
 	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL)
-		return (dma_addr_t)paddr;
-	else if (IS_ERR(domain))
+	if (IS_ERR(domain))
 		return DMA_MAPPING_ERROR;
 
 	dma_mask = *dev->dma_mask;
@@ -2676,11 +2674,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	struct page *page;
 
 	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL) {
-		page = alloc_pages(flag, get_order(size));
-		*dma_addr = page_to_phys(page);
-		return page_address(page);
-	} else if (IS_ERR(domain))
+	if (IS_ERR(domain))
 		return NULL;
 
 	dma_dom   = to_dma_ops_domain(domain);
-- 
2.17.1

