Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ED0218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dn6kwszb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfCXEpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:45:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7539 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfCXEpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:45:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c970b6e0000>; Sat, 23 Mar 2019 21:45:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 23 Mar 2019 21:45:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 23 Mar 2019 21:45:35 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 04:45:35 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 24 Mar 2019 04:45:35 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.168.175]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c970b6d0000>; Sat, 23 Mar 2019 21:45:34 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V4 10/10] arm64: tegra: enable command queue for tegra186 sdmmc4
Date:   Sat, 23 Mar 2019 21:45:27 -0700
Message-ID: <1553402727-23130-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553402734; bh=XRJSPEMXnOfGmyWHXqCKDR2X7Tf9RwugO0JR03NUVwg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=dn6kwszbgEwCERWCFcSJ5FGtViEjFZ4qq/MncWwo/RbJzpuMB7FLb5cwqGX5VDjPB
         xvxH2d3iXYxfL3/PlMaa0nPvacSiwZpwgNQxePDw3tI4Y2fXoSDN4tvnr0QtVGevIq
         WtKm5rwuZbONcKnPd86ww9RX6xknPxiUM/eVkrB9PBOqQb2Vp3UHdN1cUZoAU7nvaC
         /Vhq/b2QZVahvp/t1frXGquEFqGSq+5UPuhOvqvv6O6amXbPg97OAzsYbFdRAmJ3PO
         vd7hjy65jPQB2qO2KvU8H3aGXty9raot6BmASgexB8+pGLXglLZthfXWE9DxQ44If6
         tsLvClYT4Brmw==
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

