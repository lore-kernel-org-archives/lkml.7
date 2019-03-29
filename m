Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B44FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE8B218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RVd/NT2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfC2Rxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:53:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35806 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfC2Rxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:53:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2THrbaL038156;
        Fri, 29 Mar 2019 12:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553882017;
        bh=MsEeJq53XjQttzEDdAoYISvrRVtvlHqwQkgtFpHknOY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RVd/NT2NrsEhOIwxPtLZxEndh2ZFRZChO556OKYZG9m1sc6XeOUlogR0j29bTZTuh
         7++XatbNf1oJO0Lfhwt1wASMKc3dnOtcpWh0KGUA6pGF2IiPq7MTDS6wj+e8Tgg/Xm
         xYYfWvcwybKj6xffOyBo2TvzjgzePzzEJDvPZT/E=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2THrbf8068916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 12:53:37 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 12:53:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 12:53:37 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2THrbTE023131;
        Fri, 29 Mar 2019 12:53:37 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2THraU25908;
        Fri, 29 Mar 2019 12:53:36 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 2/5] ARM: dts: am43xx-epos-evm: Keep DCDC3 regulator on in suspend to memory
Date:   Fri, 29 Mar 2019 12:53:33 -0500
Message-ID: <20190329175336.19824-2-afd@ti.com>
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

From: Mike Erdahl <m-erdahl@ti.com>

When going to suspend to ram mode (or rtc-only mode), the DDR regulator
must be told to stay on, else this rail will go down when the PMIC_EN
signal is deasserted.

Signed-off-by: Mike Erdahl <m-erdahl@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 7db5cf3facde..606b848d809f 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -620,6 +620,12 @@
 			regulator-name = "vdcdc3";
 			regulator-boot-on;
 			regulator-always-on;
+			regulator-state-mem {
+				regulator-on-in-suspend;
+			};
+			regulator-state-disk {
+				regulator-off-in-suspend;
+			};
 		};
 
 		dcdc4: regulator-dcdc4 {
-- 
2.21.0

