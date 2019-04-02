Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E65AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2505020883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JJP1JIR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfDBNiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:38:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60154 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfDBNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:38:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32Dc2lM023114;
        Tue, 2 Apr 2019 08:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554212282;
        bh=aAk0r9TUo1AqkBkCxh24GlYC3DNt9KEpMWg5nv+RvLQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JJP1JIR+ChPZJCf05+ZpB9w0KhVeOwG1X8wXR6XiLCr0/FVkwyO3JGb1NdU8p/bkJ
         9pMkHSi3zqtdpe5RVcXWgzwGoASStdpDPSpZMTvsXE8xigmbAjnroo8fOQldmYnz4c
         W+h6gbBQSHFycF2l9b3Fjn9x7HI3vf51zZ42teNU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32Dc2a7018468
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 08:38:02 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 08:38:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 08:38:00 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32DbsU0051551;
        Tue, 2 Apr 2019 08:37:58 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <nsekhar@ti.com>, <s-anna@ti.com>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 2/4] bus: ti-sysc: Add generic enable/disable functions
Date:   Tue, 2 Apr 2019 16:37:50 +0300
Message-ID: <20190402133752.6912-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402133752.6912-1-rogerq@ti.com>
References: <20190402133752.6912-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non legacy cases, add generic sysc_enable_module()
and sysc_disable_module() functions.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/bus/ti-sysc.c | 114 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 5c0dd80021cc..1e63b6265764 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -793,6 +793,112 @@ static void sysc_show_registers(struct sysc *ddata)
 		buf);
 }
 
+#define SYSC_IDLE_MASK	(SYSC_NR_IDLEMODES - 1)
+
+static int sysc_enable_module(struct device *dev)
+{
+	struct sysc *ddata;
+	const struct sysc_regbits *regbits;
+	u32 reg, idlemodes, best_mode;
+
+	ddata = dev_get_drvdata(dev);
+	if (ddata->offsets[SYSC_SYSCONFIG] == -ENODEV)
+		return 0;
+
+	regbits = ddata->cap->regbits;
+	reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+
+	/* Set SIDLE mode */
+	idlemodes = ddata->cfg.sidlemodes;
+	if (!idlemodes || regbits->sidle_shift < 0)
+		goto set_midle;
+
+	best_mode = fls(ddata->cfg.sidlemodes) - 1;
+	if (best_mode > SYSC_IDLE_MASK) {
+		dev_err(dev, "%s: invalid sidlemode\n", __func__);
+		return -EINVAL;
+	}
+
+	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
+	reg |= best_mode << regbits->sidle_shift;
+	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+
+set_midle:
+	/* Set MIDLE mode */
+	idlemodes = ddata->cfg.midlemodes;
+	if (!idlemodes || regbits->midle_shift < 0)
+		return 0;
+
+	best_mode = fls(ddata->cfg.midlemodes) - 1;
+	if (best_mode > SYSC_IDLE_MASK) {
+		dev_err(dev, "%s: invalid midlemode\n", __func__);
+		return -EINVAL;
+	}
+
+	reg &= ~(SYSC_IDLE_MASK << regbits->midle_shift);
+	reg |= best_mode << regbits->midle_shift;
+	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+
+	return 0;
+}
+
+static int sysc_disable_module(struct device *dev)
+{
+	struct sysc *ddata;
+	const struct sysc_regbits *regbits;
+	u32 reg, idlemodes, best_mode;
+
+	ddata = dev_get_drvdata(dev);
+	if (ddata->offsets[SYSC_SYSCONFIG] == -ENODEV)
+		return 0;
+
+	regbits = ddata->cap->regbits;
+	reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+
+	/* Set MIDLE mode */
+	idlemodes = ddata->cfg.midlemodes;
+	if (!idlemodes || regbits->midle_shift < 0)
+		goto set_sidle;
+
+	if (idlemodes & BIT(SYSC_IDLE_SMART_WKUP)) {
+		best_mode = SYSC_IDLE_SMART_WKUP;
+	} else if (idlemodes & BIT(SYSC_IDLE_SMART)) {
+		best_mode = SYSC_IDLE_SMART;
+	} else if (idlemodes & SYSC_IDLE_FORCE) {
+		best_mode = SYSC_IDLE_FORCE;
+	} else {
+		dev_err(dev, "%s: invalid midlemode\n", __func__);
+		return -EINVAL;
+	}
+
+	reg &= ~(SYSC_IDLE_MASK << regbits->midle_shift);
+	reg |= best_mode << regbits->midle_shift;
+	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+
+set_sidle:
+	/* Set SIDLE mode */
+	idlemodes = ddata->cfg.sidlemodes;
+	if (!idlemodes || regbits->sidle_shift < 0)
+		return 0;
+
+	if (idlemodes & BIT(SYSC_IDLE_SMART_WKUP)) {
+		best_mode = SYSC_IDLE_SMART_WKUP;
+	} else if (idlemodes & BIT(SYSC_IDLE_SMART)) {
+		best_mode = SYSC_IDLE_SMART;
+	} else if (idlemodes & SYSC_IDLE_FORCE) {
+		best_mode = SYSC_IDLE_FORCE;
+	} else {
+		dev_err(dev, "%s: invalid sidlemode\n", __func__);
+		return -EINVAL;
+	}
+
+	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
+	reg |= best_mode << regbits->sidle_shift;
+	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+
+	return 0;
+}
+
 static int __maybe_unused sysc_runtime_suspend_legacy(struct device *dev,
 						      struct sysc *ddata)
 {
@@ -849,6 +955,10 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 		error = sysc_runtime_suspend_legacy(dev, ddata);
 		if (error)
 			return error;
+	} else {
+		error = sysc_disable_module(dev);
+		if (error)
+			return error;
 	}
 
 	sysc_disable_main_clocks(ddata);
@@ -885,6 +995,10 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 		error = sysc_runtime_resume_legacy(dev, ddata);
 		if (error)
 			goto err_main_clocks;
+	} else {
+		error = sysc_enable_module(dev);
+		if (error)
+			goto err_main_clocks;
 	}
 
 	ddata->enabled = true;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

