Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B184EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810A7214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WYBqi8fB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfCLJPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:15:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42440 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfCLJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:15:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2C9Fer3026411;
        Tue, 12 Mar 2019 04:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552382140;
        bh=zEIKqJdgbYtK7Y2ted5UVe+EUGGzDWOq2RiKmyOrHeM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WYBqi8fBQp1o9iltGf+PI5zjHoOVEUVztxEqgUXRxuqP3zo42RuGrdsCJ3cCPYbUI
         0QzW1nL2JGuR8VjyLDP2+hPh3OFmEQkjGsGYAZ26gBMvVWGRJRqmQNlSUmXCP9TSKw
         zXBw95EeI4uIfw23dSn1JyyYxIeDEJbw1koG6gS0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2C9FdCP019887
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 04:15:40 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 04:15:39 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 04:15:39 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2C9FVdx008524;
        Tue, 12 Mar 2019 04:15:37 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] pwm: Kconfig: Enable ehrpwm driver to be compiled for ARCH_K3
Date:   Tue, 12 Mar 2019 14:46:29 +0530
Message-ID: <20190312091629.31701-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312091629.31701-1-vigneshr@ti.com>
References: <20190312091629.31701-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K3 devices have the same EHRPWM IP as OMAP SoCs. Enable driver to be built
for K3 devices. Also, drop reference to AM33xx in help text, as IP is
found on multiple TI SoCs.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/pwm/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 54f8238aac0d..c054bd1dba36 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -467,10 +467,9 @@ config  PWM_TIECAP
 
 config  PWM_TIEHRPWM
 	tristate "EHRPWM PWM support"
-	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3
 	help
-	  PWM driver support for the EHRPWM controller found on AM33XX
-	  TI SOC
+	  PWM driver support for the EHRPWM controller found on TI SOCs
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tiehrpwm.
-- 
2.21.0

