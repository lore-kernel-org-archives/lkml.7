Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B14C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063B1217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vgRAVnpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfEJDma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:42:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60544 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfEJDmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:42:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4A3gMRq052832;
        Thu, 9 May 2019 22:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557459742;
        bh=M/SGTtKq5pF3iCeqds/u2kqAzxGBNIlia2Td4yVN5T4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vgRAVnpc0wO4Bi2FAXLU9wOskjXscY2IAMDOYQUeHG238uc9dqogSQMk0lF0z+MM0
         h0PMMEidCRPFJYpOXQU7fTNK/Z5SHfQKJg9XU8UbVwNBPAtuNL88Bf41C44SnOWbfW
         dAWCMHw3uGKJDG9Qb+enLWM3SpNn9w+1pZbzrLnM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4A3gMTj026084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 May 2019 22:42:22 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 9 May
 2019 22:42:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 9 May 2019 22:42:21 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4A3gD2r002845;
        Thu, 9 May 2019 22:42:20 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2 3/3] mmc: sdhci_am654: Fix SLOTTYPE write
Date:   Fri, 10 May 2019 09:12:28 +0530
Message-ID: <20190510034228.32211-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190510034228.32211-1-faiz_abbas@ti.com>
References: <20190510034228.32211-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the call to regmap_update_bits() for SLOTTYPE, the mask and value
fields are exchanged. Fix this. This didn't have any affect on the
driver because this was a NOP and it was taking the correct value from
the bootloader.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 3ff949925127..d0b20780dd0f 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -227,8 +227,8 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
 
-	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, ctl_cfg_2,
-			   SLOTTYPE_MASK);
+	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
+			   ctl_cfg_2);
 
 	return sdhci_add_host(host);
 }
-- 
2.19.2

