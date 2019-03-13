Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D01BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA2E20854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NOL+20Rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfCMVqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:46:40 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19129 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfCMVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:45:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c897a0a0000>; Wed, 13 Mar 2019 14:45:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 14:45:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 14:45:58 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 21:45:58 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 21:45:58 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.74]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c897a150006>; Wed, 13 Mar 2019 14:45:57 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V3 05/10] arm64: tegra: fix default tap and trim values
Date:   Wed, 13 Mar 2019 14:45:47 -0700
Message-ID: <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552513546; bh=MC8hZnKDIr0hdGyS3iqqnCZtCPIWqd4U0aiKTpE75g8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=NOL+20RbflK2iYvZ85K8/IxhJc+Oa7gwKoYf1FmdIHs3hqXtY88BWUMIPbvqFJugz
         N7qTn4Cf4oSKGmBq4cxLUnJNO1np5XzKiMOnvKaKU9kBpRFwXX7hcG/vOxF4yFr4Se
         BUEzaqdaIsmYeaqpv8cazB6AYkRHUyI5qFu9lMJ08PJ8h30ydovZB01Zc8LmOe60tY
         NQkjG6rFKh126FsD9tg0+KXqyHdsUu/fqza7BYbXkpwEnF1iUIQpKvFCUXOZIvvnvQ
         KN68395SSniSie92yGLwPar9WyfVP8ajLh5EKp/MMxRiOncGwUvvJqA97qZrfk6ruP
         D2UnpA9CLdxQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default tap and trim values are incorrect for Tegra186 SDMMC4.
This patch fixes it.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 97aeb946ed5e..472f55fe9488 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -317,8 +317,8 @@
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
 		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
 		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x0a>;
-		nvidia,default-tap = <0x5>;
-		nvidia,default-trim = <0x9>;
+		nvidia,default-tap = <0x9>;
+		nvidia,default-trim = <0x5>;
 		nvidia,dqs-trim = <63>;
 		mmc-hs400-1_8v;
 		status = "disabled";
-- 
2.7.4

