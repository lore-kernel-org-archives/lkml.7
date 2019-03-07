Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E6320675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZEGmPm5k";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rfm6QepV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCGMRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:17:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGMRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:17:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4478C60C72; Thu,  7 Mar 2019 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551961035;
        bh=4cepUczBnUTSTvYFMcspE8zX17l8chzMZZmcnbq0GBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEGmPm5kovfQOlKmqbsbceMT+a7v9T+X/FZ7yFtkNHwXODXmz265Tw9odCY6WMRoR
         WHKt7RNPkPH49aBF69460mAofTn/dKHoed4goe7loJ0hWKRWYICziTLNqSfM3avos5
         gi84b3gloA4Q8PAdkwJw3W2ga8QcQcKQvQONoXxU=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2405E60909;
        Thu,  7 Mar 2019 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551961034;
        bh=4cepUczBnUTSTvYFMcspE8zX17l8chzMZZmcnbq0GBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rfm6QepVI3WZV9yWI1WUkcIJ92pqcXZoczCeCSdh1PNvgHnABSrtWTjwWqxXRn8XH
         xbAfeU9892Qwwyz7f4Bd/DLv/km6HdGLCi+XYdVl1qm36xRmdFLe3lo1EMob4719JQ
         XHv/s5DGFEvamkXwUplumUZtmPMW2DIYNuGzUEP4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2405E60909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v1 1/2] Bluetooth: hci_qca: Added support to read the regulator values from DTS
Date:   Thu,  7 Mar 2019 17:46:51 +0530
Message-Id: <1551961012-23898-2-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551961012-23898-1-git-send-email-c-hbandi@codeaurora.org>
References: <1551961012-23898-1-git-send-email-c-hbandi@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wcn3990 as base chip. based on wcn3990 we have multiple bt chip sets,
with enhanced power numbers. So every chip set will have
its own power numbers, but the functionality is same as wcn3990.
With this change we read the regulator values from DTS in driver
initialization time. While initializing the regulators, it will
set the those current and voltage values. If no values set in DTS,
it will read the default values and set those values only.
This change will help in supporting multiple platforms.

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 76 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 237aea3..402336a7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -155,7 +155,7 @@ struct qca_vreg_data {
  */
 struct qca_power {
 	struct device *dev;
-	const struct qca_vreg_data *vreg_data;
+	struct qca_vreg_data *vreg_data;
 	struct regulator_bulk_data *vreg_bulk;
 	bool vregs_on;
 };
@@ -1387,10 +1387,48 @@ static int qca_power_setup(struct hci_uart *hu, bool on)
 	return ret;
 }
 
+/*
+ * Read function to get the voltage and current values
+ * for regulators from DTS.
+ */
+static void qca_regulator_get_voltage_current(struct device *dev,
+				      struct qca_vreg *vregs)
+{
+	char prop_name[32]; /* 32 is max size of property name */
+
+	snprintf(prop_name, 32, "%s-current", vregs->name);
+	BT_DBG("Looking up %s from device tree\n", prop_name);
+
+	if (device_property_read_bool(dev, prop_name))
+		device_property_read_u32(dev, prop_name, &vregs->load_uA);
+
+	snprintf(prop_name, 32, "%s-min-voltage", vregs->name);
+	BT_DBG("Looking up %s from device tree\n", prop_name);
+
+	if (device_property_read_bool(dev, prop_name))
+		device_property_read_u32(dev, prop_name, &vregs->min_uV);
+
+	snprintf(prop_name, 32, "%s-max-voltage", vregs->name);
+	BT_DBG("Looking up %s from device tree\n", prop_name);
+
+	if (device_property_read_bool(dev, prop_name))
+		device_property_read_u32(dev, prop_name, &vregs->max_uV);
+
+	BT_DBG("current %duA selected for regulator %s", vregs->load_uA,
+		vregs->name);
+	BT_DBG("min voltage %duA selected for regulator %s", vregs->min_uV,
+		vregs->name);
+	BT_DBG("max voltage %duA selected for regulator %s", vregs->max_uV,
+		vregs->name);
+}
+
 static int qca_init_regulators(struct qca_power *qca,
-				const struct qca_vreg *vregs, size_t num_vregs)
+				const struct qca_vreg_data *data)
 {
-	int i;
+	int i, num_vregs;
+	int load_uA;
+
+	num_vregs = data->num_vregs;
 
 	qca->vreg_bulk = devm_kcalloc(qca->dev, num_vregs,
 				      sizeof(struct regulator_bulk_data),
@@ -1398,8 +1436,32 @@ static int qca_init_regulators(struct qca_power *qca,
 	if (!qca->vreg_bulk)
 		return -ENOMEM;
 
-	for (i = 0; i < num_vregs; i++)
-		qca->vreg_bulk[i].supply = vregs[i].name;
+	qca->vreg_data = devm_kzalloc(qca->dev, sizeof(struct qca_vreg_data),
+				      GFP_KERNEL);
+	if (!qca->vreg_data)
+		return -ENOMEM;
+
+	qca->vreg_data->num_vregs = num_vregs;
+
+	qca->vreg_data->vregs = devm_kzalloc(qca->dev, num_vregs *
+				      sizeof(struct qca_vreg_data),
+				      GFP_KERNEL);
+
+	if (!qca->vreg_data->vregs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_vregs; i++) {
+		/* copy regulator name, min voltage, max voltage */
+		qca->vreg_data->vregs[i].name = data->vregs[i].name;
+		qca->vreg_data->vregs[i].min_uV = data->vregs[i].min_uV;
+		qca->vreg_data->vregs[i].max_uV = data->vregs[i].max_uV;
+		load_uA = data->vregs[i].load_uA;
+		qca->vreg_data->vregs[i].load_uA = load_uA;
+		qca_regulator_get_voltage_current(qca->dev,
+			&qca->vreg_data->vregs[i]);
+
+		qca->vreg_bulk[i].supply = qca->vreg_data->vregs[i].name;
+	}
 
 	return devm_regulator_bulk_get(qca->dev, num_vregs, qca->vreg_bulk);
 }
@@ -1426,9 +1488,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return -ENOMEM;
 
 		qcadev->bt_power->dev = &serdev->dev;
-		qcadev->bt_power->vreg_data = data;
-		err = qca_init_regulators(qcadev->bt_power, data->vregs,
-					  data->num_vregs);
+		err = qca_init_regulators(qcadev->bt_power, data);
 		if (err) {
 			BT_ERR("Failed to init regulators:%d", err);
 			goto out;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

