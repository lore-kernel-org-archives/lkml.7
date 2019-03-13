Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB16C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC16E20854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QjWT4wBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfCMVp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:45:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1269 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCMVp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:45:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c897a140000>; Wed, 13 Mar 2019 14:45:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 14:45:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 14:45:55 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 21:45:54 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 21:45:54 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.74]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c897a120001>; Wed, 13 Mar 2019 14:45:54 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V3 01/10] mmc: tegra: fix ddr signaling for non-ddr modes
Date:   Wed, 13 Mar 2019 14:45:43 -0700
Message-ID: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552513556; bh=hyG6nL5bNLc49xU60zbU/EdhEZ33+W/EFOQiFZDWv4I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=QjWT4wBbJ6r9f4wL0kyr9VZMqC6Zrsx3m6aMmiSozctyEXoYwFCd1a7WC7qlTYCYz
         JBGsFNKsSNGJScG/Li39WyLTQrTRqt0FTJe9S/Bxvb00NoKsfPgtLkMLnQkZAsJtBf
         jEsH+S24HrimslPxcy/UKg988T5tGMQ7nIVPmH3bvTgPsMQ+UCc59GlHz+0eMUJsFz
         KQevnW7Yy+xKt+3oFkAJEfiEgZZuOw2bXwUqOoS32GOi+EnFdlVtWEdlsDiPYRTXMc
         uOWTKCmx5+0kkA1zMldtNGiCPApVzqcq8ENk4vj8BVULUhENjRslsL1pfLT3FG/1el
         a/WL41cndtg0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddr_signaling is set to true for DDR50 and DDR52 modes but is
not set back to false for other modes. This programs incorrect
host clock when mode change happens from DDR52/DDR50 to other
SDR or HS modes like incase of mmc_retune where it switches
from HS400 to HS DDR and then from HS DDR to HS mode and then
to HS200.

This patch fixes the ddr_signaling to set properly for non DDR
modes.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 32e62904c0d3..46086dd43bfb 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -779,6 +779,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 	bool set_dqs_trim = false;
 	bool do_hs400_dll_cal = false;
 
+	tegra_host->ddr_signaling = false;
 	switch (timing) {
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_SDR104:
-- 
2.7.4

