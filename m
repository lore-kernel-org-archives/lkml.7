Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B83C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE593206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H6Y/h6c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDKTh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:37:58 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16003 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKTh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:37:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf97910000>; Thu, 11 Apr 2019 12:37:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 12:37:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 12:37:56 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 19:37:56 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 19:37:56 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5caf97930009>; Thu, 11 Apr 2019 12:37:55 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V1 1/2] arm64: tegra: fix default tap and trim values
Date:   Thu, 11 Apr 2019 12:37:53 -0700
Message-ID: <1555011474-20107-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555011473; bh=MC8hZnKDIr0hdGyS3iqqnCZtCPIWqd4U0aiKTpE75g8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=H6Y/h6c4UAqrZAQy3jx0MsCQa/L7cYlDT3OpNYoMH2hzcNK9FcWULSYGFcISGeg+m
         grqnX+yitrAIW5UAR4Mj9AJNkAlISo19dGWIli351WQ00iVvHfuDPEE16935cDg8UX
         RcwyvsENbyxAuVofctbh1Mtgpb5dVXH6SPf2MtSzjkAVaJ9lxno/b1vU45Y7NoGzgb
         puv+gwI+eIE3jb6Aehyac+JbO46q7150C7+bIImMkzifJAXU/t6aaaV3OnGd+oKq1g
         YXW3/Mg/RbwxxHzKPKrsorlmFtTBkNJ9osQTwmayE+dWzX+VqmRO4+Cw+eSUqUiyTW
         nCeGLYZU7HIxA==
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

