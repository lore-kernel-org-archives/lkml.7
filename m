Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6E0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F9221872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YDDE86ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfCMVqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:46:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19159 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfCMVqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:46:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c897a0e0000>; Wed, 13 Mar 2019 14:45:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 14:46:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 14:46:02 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 21:46:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 21:46:02 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.74]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c897a1a0000>; Wed, 13 Mar 2019 14:46:02 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V3 10/10] arm64: tegra: enable command queue for tegra186 sdmmc4
Date:   Wed, 13 Mar 2019 14:45:52 -0700
Message-ID: <1552513552-23423-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552513550; bh=XRJSPEMXnOfGmyWHXqCKDR2X7Tf9RwugO0JR03NUVwg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YDDE86efA2HDCcR+HoPpGCTRV0wQOC29U5pj42J1szKaazqaaRzwH7dv/smtH+K8g
         DZTINmPTKw7kFjg+Q3JWrwXU1z/zWvwHBG8752a0XGU5ThvjU6+Wp5sc6zlED4hCLE
         EFMtN+ylD9A6TNl7pILODckQjFSqKSiTQP/RznX1/kVuCe7RZCVwCz5hQeX57wjBMD
         1XX7Xx1w/oRQF2GhdTBa/ig78DWgC/+4S3IbMp9RGGKlPO7xBnPOmplmMzO5325NLp
         fgzee7GQiAxG9emx+eqJU/ZFyfdplcj07pJ64VNOMLIxBPfR1N7FCq7aNgsetNHar3
         nTXH/NNxAPcQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables command queue support for Tegra186 SDMMC4.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 472f55fe9488..6e2b6ce99df2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -321,6 +321,7 @@
 		nvidia,default-trim = <0x5>;
 		nvidia,dqs-trim = <63>;
 		mmc-hs400-1_8v;
+		supports-cqe;
 		status = "disabled";
 	};
 
-- 
2.7.4

