Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D4CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86672182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B6VyycWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfEJDmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:42:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46324 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfEJDmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:42:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4A3gKqs054137;
        Thu, 9 May 2019 22:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557459740;
        bh=BGE0HgmawIDEddyLw38mLcYPatpeZ+CLQRhnqzTStVU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B6VyycWFyK8GlciTphsyG/E7bdIfdxiV1PZBWeYGYY4Rch9hzqP5Tmiro+/Ro0wc6
         A1QemXqs4nVsEsJ5lgHbQ77RWmxFdwgE5+muEzzrrK/VsQ0pVtL93K5AyDiJraoEoz
         Ln+17jT9LB1DJ+eDTQpOesiitFBQHDNVYKMB3yq8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4A3gKTc026064
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 May 2019 22:42:20 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 9 May
 2019 22:42:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 9 May 2019 22:42:19 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4A3gD2q002845;
        Thu, 9 May 2019 22:42:18 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2 2/3] mmc: sdhci_am654: Print error message if the DLL fails to lock
Date:   Fri, 10 May 2019 09:12:27 +0530
Message-ID: <20190510034228.32211-3-faiz_abbas@ti.com>
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

Print an error message and return if DLL fails to lock.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 337c24b8f4a8..3ff949925127 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -137,6 +137,11 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
 					       val, val & DLLRDY_MASK, 1000,
 					       1000000);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
+			return;
+		}
+
 		sdhci_am654->dll_on = true;
 	}
 }
-- 
2.19.2

