Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E183C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500E320843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nv9GeemU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfEPBqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40366 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfEOXdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:33:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so775085pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=djKpp0+BHbp5KVBEx90JiFN57Gm/WbDeClRhCLK6F4g=;
        b=nv9GeemUHg9Ck9WHEPtTACJZ7OgdsjblkCFtaEkdeQJfA22VhPDEoCDvM7q/C1mfoO
         0FNXng6oezdyuzS4O8ioDjNLNczUR2HoiEDBNCsYkNnpIH9ZoBYuVcbENfTYTcsFVGQK
         3enQzMf3jsqOxl9jrQauCcF2v/gwXuUSZ8NK6vafEPg41DzqIw/pEsksTULJ+/A/8dEx
         iedXGCKhDl2a4KbUUdciQ7BWneL9SMhIrrN09ZDlQ9Oh+uRm1LPueXSiVGS8mEw9T7sd
         0jhsbzFrlq21+bp3Zhv0603B48bIcM69XJRKRWZo1cjNCYJQRaVB1m3hsVlR7Iz1bZOe
         kysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=djKpp0+BHbp5KVBEx90JiFN57Gm/WbDeClRhCLK6F4g=;
        b=iyhEMkgKzrro607J0V3+gYij2zWM24INRGJsO3Nfw8ubT7MYjozSD3X4yhSwdXZbjB
         X6T8aw6AQx9Q6EKZTqiQAO60DhoMAr7hkNTgaAf6TieLnPTayVySy27QbO3eaWhPmhhV
         569bDMIW7+1F4BiRluJyqDUUWE51fO5PGrtHJ9PWF4R4IjPRv09KxQlI9wIGWFyUR3En
         94fUCEgSIJN2EdSvCBJIiOl+8TW9IK/musrUQcYlsH5liws/PmPFb40cJa79JkVpluS4
         I8BkTz3PpY8bAgOc5AZFDq279YDYPMgkCCvKFI0qTn5grkGB4bIej65R6u+9wkHnqkjp
         EIqA==
X-Gm-Message-State: APjAAAXmB4uN008cGsj1xMjWguaHLvnko8tYc+80ihAQnzi0Q396jvki
        J0hOQWDlSRk8cOxckLRibldAoT1fN6s=
X-Google-Smtp-Source: APXvYqyrXnVeiR2IKdFoQs+/KyHKdfWtdip/KqmSq2+qQIWEc62Pl0Ip2kKHk13I4sqWwYIihDM5Lg==
X-Received: by 2002:aa7:9ac4:: with SMTP id x4mr50439288pfp.43.1557963198628;
        Wed, 15 May 2019 16:33:18 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e6sm7215087pfl.115.2019.05.15.16.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 16:32:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vgautam@qti.qualcomm.com>
Subject: [PATCH] iommu: io-pgtable: Support non-coherent page tables
Date:   Wed, 15 May 2019 16:32:34 -0700
Message-Id: <20190515233234.22990-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the memory related to page table walks as non-cachable for iommu
instances that are not DMA coherent.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/io-pgtable-arm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4e21efbc4459..68ff22ffd2cb 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -803,9 +803,15 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	/* TCR */
-	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
+	if (cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) {
+		reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
+	} else {
+		reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT);
+	}
 
 	switch (ARM_LPAE_GRANULE(data)) {
 	case SZ_4K:
-- 
2.18.0

