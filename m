Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129BC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDF520863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fJ9a2qgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfCBFUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:20:50 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9830 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbfCBFUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 00:20:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7a12b70000>; Fri, 01 Mar 2019 21:20:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 21:20:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Mar 2019 21:20:46 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 05:20:46 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 05:20:45 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Sat, 2 Mar 2019 05:20:45 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.134]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7a12ab0000>; Fri, 01 Mar 2019 21:20:45 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V1 06/11] arm64: tegra: fix default tap and trim values
Date:   Fri, 1 Mar 2019 21:20:20 -0800
Message-ID: <1551504025-3541-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551504055; bh=qUjFbWXCUApzKfPArZ5J7ifVPmb5w+NFtEc2jWgZ0SQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=fJ9a2qgQsFaJIFeBeUXPQtpEPNrH258npT+ocWclkQITQJ4YkiHtCUG/L/crPbRXR
         NYNrQVaUXe32tQfIcsQLOmNR2qU7aJsLeMbo5IjtRQoGmcun0ZHim+YclFajk1ARaa
         Z+uUpfIN3/e0ENY99Cf+vfyBAXfErQa9TSuQuH5g4Gmsbeoq9Pkr+4MLw4AnnLsZwd
         upN5beLV/eYAmqVuYqdeJthTrVoQdu2KO3Aoa8xdLHmBK/Q1bJqV93NvUyc0P7I7IE
         RzY+ZIAZ9ah2WHAlVw2y65TfFqu0SKXujLmx8IQdBqKQ5bHnqiS9iSwMGjtzle+9gt
         E/Th7RiCejdRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default tap and trim values are incorrect for Tegra186 SDMMC4.
This patch fixes it.

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

