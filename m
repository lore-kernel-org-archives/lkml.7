Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523C6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110B820870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ceC6C+oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDHJwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:52:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50258 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHJwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:52:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x389qjIf092225;
        Mon, 8 Apr 2019 04:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554717165;
        bh=FLh29FmXXYCgkrmxYwSkJoF9CjtzyPpbJugmeYCvrwI=;
        h=From:To:CC:Subject:Date;
        b=ceC6C+oal5CjYtoH3jN45qFNGHc7UkTZ/Zf596aV+lpnlPpZhtCFXQ4dRYbbGTQS9
         bAbQvTTWxm+m4nEykXXC8ojSWPb4oFohrO7JRuj3M7Z0+67ksF4cPxn1NzzDrZ86tN
         wEhqSa4+t698NCuPgqDz20dRo6swfe8R3ETNUzB4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x389qj0u021135
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Apr 2019 04:52:45 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Apr
 2019 04:52:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Apr 2019 04:52:44 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x389qgbC016970;
        Mon, 8 Apr 2019 04:52:42 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <s-anna@ti.com>, <t-kristo@ti.com>, <nsekhar@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2] bus: ti-sysc: Add generic enable/disable functions
Date:   Mon, 8 Apr 2019 12:52:39 +0300
Message-ID: <20190408095239.30378-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
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
Boot tested on
- beagle-x15 (AM5728 GP EVM)
- AM571x IDK
- DRA7 EVM

Changelog:
v2:
- Add helper to get best idle mode.
- Add comment about not preventing clockdomain autoidle
  during enable/disable.
- Omit PRU-ICSS specific handling. PRU-ICSS moudle can re-use omap4-simple.
  The STANDBY_INIT and SUB_MWAIT bits are specific to PRUSS application
  usage and should be managed by the PRUSS driver.

cheers,
-roger

 drivers/bus/ti-sysc.c | 129 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 5c8796276828..c37b3be1e3e2 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -793,6 +793,127 @@ static void sysc_show_registers(struct sysc *ddata)
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
+	/*
+	 * TODO: Need to prevent clockdomain autoidle?
+	 * See clkdm_deny_idle() in arch/mach-omap2/omap_hwmod.c
+	 */
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
+static int sysc_best_idle_mode(u32 idlemodes, u32 *best_mode)
+{
+	if (idlemodes & BIT(SYSC_IDLE_SMART_WKUP))
+		*best_mode = SYSC_IDLE_SMART_WKUP;
+	else if (idlemodes & BIT(SYSC_IDLE_SMART))
+		*best_mode = SYSC_IDLE_SMART;
+	else if (idlemodes & SYSC_IDLE_FORCE)
+		*best_mode = SYSC_IDLE_FORCE;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sysc_disable_module(struct device *dev)
+{
+	struct sysc *ddata;
+	const struct sysc_regbits *regbits;
+	u32 reg, idlemodes, best_mode;
+	int ret;
+
+	ddata = dev_get_drvdata(dev);
+	if (ddata->offsets[SYSC_SYSCONFIG] == -ENODEV)
+		return 0;
+
+	/*
+	 * TODO: Need to prevent clockdomain autoidle?
+	 * See clkdm_deny_idle() in arch/mach-omap2/omap_hwmod.c
+	 */
+
+	regbits = ddata->cap->regbits;
+	reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+
+	/* Set MIDLE mode */
+	idlemodes = ddata->cfg.midlemodes;
+	if (!idlemodes || regbits->midle_shift < 0)
+		goto set_sidle;
+
+	ret = sysc_best_idle_mode(idlemodes, &best_mode);
+	if (ret) {
+		dev_err(dev, "%s: invalid midlemode\n", __func__);
+		return ret;
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
+	ret = sysc_best_idle_mode(idlemodes, &best_mode);
+	if (ret) {
+		dev_err(dev, "%s: invalid sidlemode\n", __func__);
+		return ret;
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
@@ -849,6 +970,10 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 		error = sysc_runtime_suspend_legacy(dev, ddata);
 		if (error)
 			return error;
+	} else {
+		error = sysc_disable_module(dev);
+		if (error)
+			return error;
 	}
 
 	sysc_disable_main_clocks(ddata);
@@ -885,6 +1010,10 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
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

