Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EC5C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF5D2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yC7kwJlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfFZHt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:49:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43924 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:49:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5Q7nkRO053910;
        Wed, 26 Jun 2019 02:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561535386;
        bh=zmZI9L/7aa+aZonFo/L+XtFMZfNbn+xOwQY5rhl7174=;
        h=From:To:CC:Subject:Date;
        b=yC7kwJlTN4tagiYZNYbJtSHvs7TZGr9esErsXGZeGArQ48iTBrRfjthe+IasZ9RXX
         Qy5OB9EjiVzQFumPjukWOn2ZmfD+eklfYFBvGnyE+yWchBwRvMF0wI/X2cwOll1lwb
         7xIpH8z5SOMT6VvNUbq3HphzdYsiUjmQtsm/fkJo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5Q7nkSG004765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jun 2019 02:49:46 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 26
 Jun 2019 02:49:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 26 Jun 2019 02:49:45 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5Q7nhd5049598;
        Wed, 26 Jun 2019 02:49:43 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>, <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <j-keerthy@ti.com>, <d-gerlach@ti.com>, <dan.carpenter@oracle.com>
Subject: [PATCH] soc: ti: pm33xx: Fix static checker warnings
Date:   Wed, 26 Jun 2019 13:20:14 +0530
Message-ID: <20190626075014.2911-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes a bunch of static checker warnings.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/soc/ti/pm33xx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index bb77c220b6f8..5f3a4499cf40 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -252,7 +252,7 @@ static int am33xx_pm_begin(suspend_state_t state)
 	if (state == PM_SUSPEND_MEM && pm_ops->check_off_mode_enable()) {
 		nvmem = devm_nvmem_device_get(&omap_rtc->dev,
 					      "omap_rtc_scratch0");
-		if (nvmem)
+		if (!IS_ERR(nvmem))
 			nvmem_device_write(nvmem, RTC_SCRATCH_MAGIC_REG * 4, 4,
 					   (void *)&rtc_magic_val);
 		rtc_only_idle = 1;
@@ -278,9 +278,12 @@ static void am33xx_pm_end(void)
 	struct nvmem_device *nvmem;
 
 	nvmem = devm_nvmem_device_get(&omap_rtc->dev, "omap_rtc_scratch0");
+	if (IS_ERR(nvmem))
+		return;
+
 	m3_ipc->ops->finish_low_power(m3_ipc);
 	if (rtc_only_idle) {
-		if (retrigger_irq)
+		if (retrigger_irq) {
 			/*
 			 * 32 bits of Interrupt Set-Pending correspond to 32
 			 * 32 interrupts. Compute the bit offset of the
@@ -291,8 +294,10 @@ static void am33xx_pm_end(void)
 			writel_relaxed(1 << (retrigger_irq & 31),
 				       gic_dist_base + GIC_INT_SET_PENDING_BASE
 				       + retrigger_irq / 32 * 4);
-			nvmem_device_write(nvmem, RTC_SCRATCH_MAGIC_REG * 4, 4,
-					   (void *)&val);
+		}
+
+		nvmem_device_write(nvmem, RTC_SCRATCH_MAGIC_REG * 4, 4,
+				   (void *)&val);
 	}
 
 	rtc_only_idle = 0;
@@ -415,7 +420,7 @@ static int am33xx_pm_rtc_setup(void)
 
 		nvmem = devm_nvmem_device_get(&omap_rtc->dev,
 					      "omap_rtc_scratch0");
-		if (nvmem) {
+		if (!IS_ERR(nvmem)) {
 			nvmem_device_read(nvmem, RTC_SCRATCH_MAGIC_REG * 4,
 					  4, (void *)&rtc_magic_val);
 			if ((rtc_magic_val & 0xffff) != RTC_REG_BOOT_MAGIC)
-- 
2.17.1

