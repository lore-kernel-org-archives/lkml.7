Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EEDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20812189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="er8Hs2X/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfH1LTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:19:09 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10624 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1LTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:19:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d66632e0000>; Wed, 28 Aug 2019 04:19:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 04:19:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 04:19:08 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 11:19:07 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 11:19:07 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 11:19:07 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.65.118]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6663290007>; Wed, 28 Aug 2019 04:19:07 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [PATCH] soc/tegra: fuse: Add clock error check in tegra_fuse_readl
Date:   Wed, 28 Aug 2019 16:48:49 +0530
Message-ID: <1566991129-13479-1-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566991150; bh=XJmw8rJIYl8ASZgjnRhhbtz8wWn60Bv7q4Vqx5l9vik=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=er8Hs2X/Ea925DFQeeGgKXHWc2hQ+7tN34pibn62S9m1lEbzGT1LCNgrueNPHh0O+
         B+InccAVUj9xf6eoT+PTZPnYbOEL7TkRAHmsKTrrEYt+vNnaQZ17S7jYGH5I1s/+TR
         QjOf9PPzgctp5Rx/QxFTxDzW29S8eaWKz9zdyBlvrPO2r+feuTFPCjbmFWAPrs4Mxe
         PDfIyOQ+/gwCaIVX9C092S52COr9VQ3uin3qPQlMfEputbs3ieR9J1Hwbh65FU7KWe
         nUrkwVanq61oyfQ5GcT62MkzBZ/Subw6TWOOnImokdxCsFaxWh03XwjalkJAHNQh5E
         YjPeJTcqZxNYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra fuse clock handle is retrieved in tegra_fuse_probe().
tegra_fuse_readl() is exported symbol, which can be called from drivers
at any time. tegra_fuse_readl() enables fuse clock and reads corresponding
fuse register offset.

Calling tegra_fuse_readl() before tegra_fuse_probe(), will cause data
abort. Add DEFER_PROBE error check for fuse clock in tegra_fuse_readl(),
to avoid enabling of fuse clock, before clock is available.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 3eb44e6..21b39b7 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -186,7 +186,7 @@ u32 __init tegra_fuse_read_early(unsigned int offset)
 
 int tegra_fuse_readl(unsigned long offset, u32 *value)
 {
-	if (!fuse->read)
+	if (!fuse->read || (PTR_ERR(fuse->clk) == -EPROBE_DEFER))
 		return -EPROBE_DEFER;
 
 	*value = fuse->read(fuse, offset);
-- 
2.7.4

