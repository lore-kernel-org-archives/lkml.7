Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDEFC2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB682206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577782005;
	bh=N+mb5kzkC+/jQqgTQg/iLdcfYCH1MlyJvn+yg/LGA0A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=B4vvkIf/SC0DQS1kUJoMyTQ5Ey9jNm1yXT/ncYrOxMkbv+/C8UcGNf1JS8XFoNj5F
	 TPgbqWN3v/hal1lS2Inhq4pN/UGkWqVYjCggOfjpom2ZqnqG3zH8WslXEZo+L0CXVN
	 5qcA4STlPBXbUlXDqy9UexdT0ePnkm2qooUgB8WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfLaIqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 03:46:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfLaIqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 03:46:36 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73FBF206D9;
        Tue, 31 Dec 2019 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577781995;
        bh=N+mb5kzkC+/jQqgTQg/iLdcfYCH1MlyJvn+yg/LGA0A=;
        h=From:To:Cc:Subject:Date:From;
        b=U1CJmPK099QMqNkzK0JvajMZ4genSOrHHVhxwa9xPTKIpiWhy/0qRSRyUeVL/zert
         ZQ53UJizYsyWHAIyZH/Cp1oORVxGvwHaXgFjdYgMgNxx+g9X+GKwZFkqe3sFXOVeyI
         tHfhnib17vuZB8vRX+jH+RW7MypPOO75ad4acibU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT] iommu: omap: Fix -Woverflow warnings when compiling on 64-bit architectures
Date:   Tue, 31 Dec 2019 09:46:27 +0100
Message-Id: <1577781987-32035-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the OMAP IOMMU driver supports only ARMv7 (32-bit) platforms,
it can be compile tested for other architectures, including 64-bit ones.
In such case the warning appears:

       In file included from drivers/iommu/omap-iommu.c:33:0:
       drivers/iommu/omap-iommu.c: In function 'omap_iommu_iova_to_phys':
    >> drivers/iommu/omap-iopgtable.h:44:21: warning: large integer implicitly truncated to unsigned type [-Woverflow]
        #define IOPTE_MASK  (~(IOPTE_SIZE - 1))
                            ^
    >> drivers/iommu/omap-iommu.c:1641:41: note: in expansion of macro 'IOPTE_MASK'
           ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
                                                ^~~~~~~~~~

Fix this by using architecture-depending types in omap_iommu_translate():
1. Pointer should be cast to unsigned long,
2. Virtual addresses should be cast to dma_addr_t.

On 32-bit this will be the same as original code (using u32).  On 64-bit
it should produce meaningful result, although it does not really matter.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware.
---
 drivers/iommu/omap-iopgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iopgtable.h b/drivers/iommu/omap-iopgtable.h
index 1a4adb59a859..51d74002cc30 100644
--- a/drivers/iommu/omap-iopgtable.h
+++ b/drivers/iommu/omap-iopgtable.h
@@ -63,7 +63,8 @@
  *
  * va to pa translation
  */
-static inline phys_addr_t omap_iommu_translate(u32 d, u32 va, u32 mask)
+static inline phys_addr_t omap_iommu_translate(unsigned long d, dma_addr_t va,
+					       dma_addr_t mask)
 {
 	return (d & mask) | (va & (~mask));
 }
-- 
2.7.4

