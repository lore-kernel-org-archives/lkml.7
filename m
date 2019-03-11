Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80E1C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34A2206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OTvuHwgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfCKSDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:03:18 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13904 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfCKSCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:02:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c86a2c50000>; Mon, 11 Mar 2019 11:02:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Mar 2019 11:02:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Mar 2019 11:02:45 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Mar
 2019 18:02:45 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Mar
 2019 18:02:45 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Mar 2019 18:02:45 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.53]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c86a2c50000>; Mon, 11 Mar 2019 11:02:45 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 05/10] arm64: tegra: fix default tap and trim values
Date:   Mon, 11 Mar 2019 11:02:34 -0700
Message-ID: <1552327359-8036-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
References: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552327365; bh=MC8hZnKDIr0hdGyS3iqqnCZtCPIWqd4U0aiKTpE75g8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OTvuHwgwtYKj/1wfZOPdNfI1pok9I+4uW1ze3vAbBR3eDlc2IDeUvsIiqzc+Em6cp
         8YgPGFdHAySG4l28U0U9OoUZh5GhHqr442vu9+erTsL4Dnr5j44UrpzimERRzZ7+LL
         3ESfbwuoilEmaQi2y5iAV42tvycDF+xWwVpAOBpNR3ypbPP7L4AM5W9VqtyWePD7x2
         7o9eRSQWX8SsroKRdyUmI0gX9msFzCmCgRVGYk6QG+h6V0TauGryEapBoN8sK+4lr1
         OX+9KrGwXaDsKTs0FublnRhlmZTkZzGAgX6Qx6nlWexwzzqXp6rOe5eMGsyrCM5A0S
         ErsIBp+517+dA==
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

