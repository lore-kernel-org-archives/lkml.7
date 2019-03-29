Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C49B2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zRRWN0Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfC2Rx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:53:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43402 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfC2Rxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:53:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2THre36088452;
        Fri, 29 Mar 2019 12:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553882020;
        bh=Kwc/IFqAkjWIOcmEgla+qEHkPII6IjRCmfJjPCHvfr8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zRRWN0JrsISfTE0kpvykgwsJeaxcHRt7oIF6KDQc+/9i3AEVX4EW9nc4Yhzs8Wf41
         NKSip6/YPSB0sLAoiNOWEzslC2swUxdq8ViiWAOq3jmGXL1cgWJj1NfM4DXErl40V7
         W8Nk/bmkPALNVirxolGTxbfEfOdAtztPIRJPnydc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2THreQI048625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 12:53:40 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 12:53:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 12:53:39 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2THrdt9126459;
        Fri, 29 Mar 2019 12:53:39 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2THrdU25939;
        Fri, 29 Mar 2019 12:53:39 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 5/5] ARM: OMAP2+: pm33xx-core: Do not Turn OFF CEFUSE as PPA may be using it
Date:   Fri, 29 Mar 2019 12:53:36 -0500
Message-ID: <20190329175336.19824-5-afd@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329175336.19824-1-afd@ti.com>
References: <20190329175336.19824-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kabir Sahane <x0153567@ti.com>

This area is used to store keys by HSPPA in case of AM438x SOC. Leave it
active.

Signed-off-by: Kabir Sahane <x0153567@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-omap2/pm33xx-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index 724cf5774a6c..c93b6efd565f 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -51,10 +51,12 @@ static int amx3_common_init(void)
 
 	/* CEFUSE domain can be turned off post bootup */
 	cefuse_pwrdm = pwrdm_lookup("cefuse_pwrdm");
-	if (cefuse_pwrdm)
-		omap_set_pwrdm_state(cefuse_pwrdm, PWRDM_POWER_OFF);
-	else
+	if (!cefuse_pwrdm)
 		pr_err("PM: Failed to get cefuse_pwrdm\n");
+	else if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		pr_info("PM: Leaving EFUSE power domain active\n");
+	else
+		omap_set_pwrdm_state(cefuse_pwrdm, PWRDM_POWER_OFF);
 
 	return 0;
 }
-- 
2.21.0

