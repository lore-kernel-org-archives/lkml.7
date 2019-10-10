Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC1DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327B1208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VWoUIcV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733198AbfJJKvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:51:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53748 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfJJKvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:51:54 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9AAppY3025712;
        Thu, 10 Oct 2019 05:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570704711;
        bh=XliUJLuFlKaXm7moRyemAIXwBCYUezk8mD1oOP4tL/4=;
        h=From:To:CC:Subject:Date;
        b=VWoUIcV5P1Q0lX2rGonFyGrhv6XlFshYs58FpzK97RH28zdf4vVZqIeoBpUWGcq6c
         9JltJReyowpcs8/UgWVeMJewMVSxAq0mpLEilPcrVY9365Zs8LOLMSCvEpIl/1bJYb
         yxfMRyPcWQK7XAK16Hv5u17pFBQAmi0OvMPA+YDo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9AApoqG125211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Oct 2019 05:51:51 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 10
 Oct 2019 05:51:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 10 Oct 2019 05:51:47 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9AApmvE122351;
        Thu, 10 Oct 2019 05:51:49 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH] mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
Date:   Thu, 10 Oct 2019 16:22:30 +0530
Message-ID: <20191010105230.16736-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the App note[1] detailing the tuning algorithm, for
temperatures < -20C, the initial tuning value should be min(largest
value in LPW - 24, ceil(13/16 ratio of LPW)). The largest value in
LPW is (max_window + 4 * (max_len - 1)) and not (max_window + 4 * max_len)
itself. Fix this implementation.

[1] http://www.ti.com/lit/an/spraca9b/spraca9b.pdf

Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
SDR104/HS200 tuning failures (i929)")
Cc: stable@vger.kernel.org
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 41c2677c587f..083e7e053c95 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -372,7 +372,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * on temperature
 	 */
 	if (temperature < -20000)
-		phase_delay = min(max_window + 4 * max_len - 24,
+		phase_delay = min(max_window + 4 * (max_len - 1) - 24,
 				  max_window +
 				  DIV_ROUND_UP(13 * max_len, 16) * 4);
 	else if (temperature < 20000)
-- 
2.19.2

