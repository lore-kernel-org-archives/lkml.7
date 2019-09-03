Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62C3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ECB217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D511TNyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfICK5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:57:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19917 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:57:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6e47260000>; Tue, 03 Sep 2019 03:57:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 03:57:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 03:57:40 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Sep
 2019 10:57:39 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Sep 2019 10:57:39 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.65.118]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6e47220000>; Tue, 03 Sep 2019 03:57:39 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V2] soc/tegra: fuse: Add fuse clock check in tegra_fuse_readl
Date:   Tue, 3 Sep 2019 16:26:52 +0530
Message-ID: <1567508212-1194-1-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567508262; bh=oZmGi1sLCM2WV+qf/aVhpNReB5QM4vMqnRpZls/4mbc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=D511TNyTOKWh5m/HiPYwOyvG0hQEWXOGbTg4ox7sWAZlndy8jd32quzZiwDabBEFI
         SJlnVrKl3vV+ZL2SKV+QQnlmu0NBAz1m26UCa6ys+oK2IdeKIBoLzAMeFiA+fiMOXn
         kR+RI+3Ohxh3EYEu4j35RYpPqpF0D6xBYqABvVO1ypA+QBRXJ5mT4A3VcRmj2sXjWz
         2ARA2EXKn8hxyijWAbZYZGjnfeEe6Rfr/UNPrICmFHKgMHXBDOltjyzKQMLOXQwgft
         6ZrQuDFtoov2IX7wPW32v+SjcoYII5c+g/5Fv1pUp3+Jqv/GVTJhnQIfN/f2VZ/9BO
         e3aysmADOQ7Jg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra_fuse_readl() can be called from drivers at any time. If this API is
called before tegra_fuse_probe(), we end up enabling clock before it is
registered. Add check for fuse clock in tegra_fuse_readl() and return
corresponding error if any.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
	- Added Null and other error checks for fuse->clk.
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 3eb44e6..58996c6 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -186,9 +186,12 @@ u32 __init tegra_fuse_read_early(unsigned int offset)
 
 int tegra_fuse_readl(unsigned long offset, u32 *value)
 {
-	if (!fuse->read)
+	if (!fuse->read || !fuse->clk)
 		return -EPROBE_DEFER;
 
+	if (IS_ERR(fuse->clk))
+		return PTR_ERR(fuse->clk);
+
 	*value = fuse->read(fuse, offset);
 
 	return 0;
-- 
2.7.4

