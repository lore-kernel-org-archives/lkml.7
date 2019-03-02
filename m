Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F166C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E861D20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lxtcKuD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfCBFUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:20:31 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9806 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbfCBFUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 00:20:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7a12a70000>; Fri, 01 Mar 2019 21:20:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 21:20:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Mar 2019 21:20:30 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 05:20:30 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 2 Mar 2019 05:20:30 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.134]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7a129b0001>; Fri, 01 Mar 2019 21:20:29 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 01/11] mmc: tegra: fix ddr signaling for non-ddr modes
Date:   Fri, 1 Mar 2019 21:20:15 -0800
Message-ID: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551504039; bh=Qe2T48QJX1FMDt69wX/5uHHEUnqPGEOo62jpymdGE50=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=lxtcKuD+qW5/YBbhFQsOJCjhgJ5hQLM3klmDJR0v1JK69DAZQMJmJhBn0LtZ7X/3k
         14wtgBydG+RPtAtxPRmdBZmW2LNEAyMjuxR7/ruiSsTvjdtKi0oTT5hGZSaoEWFo/r
         jMYmqj//fEEPYDELTq74RHi94V78nkG2vgypOGRprA1rNqmZ4N+Ya5Q7u4Qqi5bsag
         HnRsKtnJA3agieKtksQcwpJ3pm5MLab/ElebnAa+xVeIIy7H/T9TqI72cgGQmiOBkD
         GYiUmK+SmdnZ+cC1xfMvAknFuRqA2/oZcDpmAHma/oJVn9jb1ue6w8EruetyMVq3Io
         EupwgF+PDJkxQ==
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

