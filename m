Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B56C2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 03:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0203B2072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 03:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="cuwUcU9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgAADhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 22:37:14 -0500
Received: from onstation.org ([52.200.56.107]:51180 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgAADhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 22:37:14 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2D1E43E9DC;
        Wed,  1 Jan 2020 03:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1577849833;
        bh=RGCPcDUKbPetkDE7FuEoQ8XfM4bfw2xCgy4VWuugn3g=;
        h=From:To:Cc:Subject:Date:From;
        b=cuwUcU9WjPruzvvuITwzFQONu++vaiNQjg5tbZQBhLYY8QUlVja+yW6v21cySqY71
         ioNuv6UYS5fNYayI9/VfjgOS6L4vmAWoh44Gqg44eqS5YZzLmYLtKCR/YIyPVwzuZ5
         EpgjZGhuNPPQ9ynVmh4WlBlNW5qIiaon3OM7a58I=
From:   Brian Masney <masneyb@onstation.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: qcom: scm: add 32 bit iommu page table support
Date:   Tue, 31 Dec 2019 22:37:04 -0500
Message-Id: <20200101033704.32264-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 32 bit implmentations of the functions
__qcom_scm_iommu_secure_ptbl_size() and
__qcom_scm_iommu_secure_ptbl_init() that are required by the qcom_iommu
driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/firmware/qcom_scm-32.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 48e2ef794ea3..f149a85d36b0 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -638,13 +638,41 @@ int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
 int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
 				      size_t *size)
 {
-	return -ENODEV;
+	int psize[2] = { 0, 0 };
+	int ret;
+
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
+			    QCOM_SCM_IOMMU_SECURE_PTBL_SIZE,
+			    &spare, sizeof(spare), &psize, sizeof(psize));
+	if (ret || psize[1])
+		return ret ? ret : -EINVAL;
+
+	*size = psize[0];
+
+	return 0;
 }
 
 int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr, u32 size,
 				      u32 spare)
 {
-	return -ENODEV;
+	struct msm_scm_ptbl_init {
+		__le32 paddr;
+		__le32 size;
+		__le32 spare;
+	} req;
+	int ret, scm_ret = 0;
+
+	req.paddr = addr;
+	req.size = size;
+	req.spare = spare;
+
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
+			    QCOM_SCM_IOMMU_SECURE_PTBL_INIT,
+			    &req, sizeof(req), &scm_ret, sizeof(scm_ret));
+	if (ret || scm_ret)
+		return ret ? ret : -EINVAL;
+
+	return 0;
 }
 
 int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr,
-- 
2.21.0

