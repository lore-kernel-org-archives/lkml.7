Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD55C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04282146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CxGlve3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfDBNiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:38:10 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43754 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730639AbfDBNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:38:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32Dc48Z103113;
        Tue, 2 Apr 2019 08:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554212284;
        bh=0/edQbd/JCK6PPPftxF7RTw4Vc6XeooZElbDVEEf+4M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CxGlve3ad1ndAlgnnA5HpOyNoWvx5q36UgCdY02/5rypkxJduvMbcOVECDP5s2vIq
         Lr7wZ0uhhfOZAVsgqJMQKl/xGKG6Zt5qEEDmqmpTdlcJtranzstWHmkfVdZ56vORkD
         vdueFcxlIY518odHKBVFTEr8AxkTYif6I3I9Fn4Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32Dc4uf098759
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 08:38:04 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 08:38:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 08:38:03 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32DbsU2051551;
        Tue, 2 Apr 2019 08:38:02 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <nsekhar@ti.com>, <s-anna@ti.com>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 4/4] bus: ti-sysc: Ensure PRU-ICSS doesn't break suspend/resume
Date:   Tue, 2 Apr 2019 16:37:52 +0300
Message-ID: <20190402133752.6912-5-rogerq@ti.com>
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

The PRU-ICSS subsystem's SYSCONFIG register is similar to
omap4-simple but has 2 special bits STANDBY_INIT and SUB_MWAIT.

The STANDBY_INIT bit initiates a Standby sequence (when set) and
triggers a MStandby request to the SoC's PRCM module. This same
bit is also used to enable the OCP master ports (when cleared).

Some PRU applications require the OCP master port access to be
enabled thus keeping it out of standby.
During sustem suspend/resume we must ensure that the PRUSS is in
standby else it will break resume.

NOTE:
1. This patch only adds the PM callbacks with code to fix the System
Suspend/Resume hang issue on AM33xx/AM437x SoCs, but does not
implement the full context save and restore required for the PRUSS
drivers to work across system suspend/resume when the power domain
is switched off (L4PER domain is switched OFF on AM335x/AM437x
during system suspend/resume, so PRUSS modules do lose context).
2. The PRUSS driver functionality on AM57xx SoCs is not affected that
much because the PER power domain to which the PRUSS IPs belong is
not switched OFF during suspend/resume.

Based on work by Suman Anna.

Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/bus/ti-sysc.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e4ab4d422ea5..9c94ce08dd36 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -71,6 +71,7 @@ static const char * const clock_names[SYSC_MAX_CLOCKS] = {
  * @name: name if available
  * @revision: interconnect target module revision
  * @needs_resume: runtime resume needed on resume from suspend
+ * @in_standby: flag used by PRUSS type during suspend/resume
  */
 struct sysc {
 	struct device *dev;
@@ -92,6 +93,7 @@ struct sysc {
 	bool enabled;
 	bool needs_resume;
 	bool child_needs_resume;
+	bool in_standby;
 	struct delayed_work idle_work;
 };
 
@@ -1023,6 +1025,21 @@ static int __maybe_unused sysc_noirq_suspend(struct device *dev)
 	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
 		return 0;
 
+	if (ddata->cap->type == TI_SYSC_PRUSS) {
+		u32 reg, mask;
+		const struct sysc_regbits *regbits = ddata->cap->regbits;
+
+		mask = BIT(regbits->standby_init_shift);
+		reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+		ddata->in_standby = reg & mask;
+
+		/* initiate MStandby */
+		if (!ddata->in_standby) {
+			reg |= mask;
+			sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+		}
+	}
+
 	return pm_runtime_force_suspend(dev);
 }
 
@@ -1035,6 +1052,25 @@ static int __maybe_unused sysc_noirq_resume(struct device *dev)
 	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
 		return 0;
 
+	if (ddata->cap->type == TI_SYSC_PRUSS && !ddata->in_standby) {
+		u32 reg;
+		const struct sysc_regbits *regbits = ddata->cap->regbits;
+
+		/* re-enable OCP master ports/disable MStandby */
+		reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+		reg &= ~BIT(regbits->standby_init_shift);
+		sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+		ddata->in_standby = 0;
+
+		/* wait till ready for transactions - delay is arbitrary */
+		usleep_range(50, 100);
+		reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+		if (reg & BIT(regbits->sub_mwait_shift)) {
+			dev_err(dev, "timeout waiting for SUB_MWAIT_READY\n");
+			return -ETIMEDOUT;
+		}
+	}
+
 	return pm_runtime_force_resume(dev);
 }
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

