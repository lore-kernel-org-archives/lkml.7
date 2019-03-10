Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28CAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D8020657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfCJQZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:25:05 -0400
Received: from shell.v3.sk ([90.176.6.54]:45141 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfCJQZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:25:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 853FE102CAE;
        Sun, 10 Mar 2019 17:24:57 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vJV4UIvmpEQj; Sun, 10 Mar 2019 17:24:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D180C102CA4;
        Sun, 10 Mar 2019 17:24:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8boTejMd10vv; Sun, 10 Mar 2019 17:24:32 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C3288102CBA;
        Sun, 10 Mar 2019 17:24:31 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 10/10] power: supply: olpc_battery: Have the framework register sysfs files for us
Date:   Sun, 10 Mar 2019 17:24:19 +0100
Message-Id: <20190310162419.11861-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310162419.11861-1-lkundrak@v3.sk>
References: <20190310162419.11861-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power framework gained ability to register groups of sysfs
attributes in commit cef8fe6a382c ("power: supply: core: add support for
custom sysfs attributes").

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Suggested-by: Sebastian Reichel <sre@kernel.org>

---
Changes since v5:
- Added this patch

 drivers/power/supply/olpc_battery.c | 64 ++++++++++++++++-------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 0d67158c13d6..c628d3a47e14 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -551,7 +551,7 @@ static ssize_t olpc_bat_eeprom_read(struct file *filp=
, struct kobject *kobj,
 	return count;
 }
=20
-static const struct bin_attribute olpc_bat_eeprom =3D {
+static struct bin_attribute olpc_bat_eeprom =3D {
 	.attr =3D {
 		.name =3D "eeprom",
 		.mode =3D S_IRUGO,
@@ -575,7 +575,7 @@ static ssize_t olpc_bat_error_read(struct device *dev=
,
 	return sprintf(buf, "%d\n", ec_byte);
 }
=20
-static const struct device_attribute olpc_bat_error =3D {
+static struct device_attribute olpc_bat_error =3D {
 	.attr =3D {
 		.name =3D "error",
 		.mode =3D S_IRUGO,
@@ -583,6 +583,27 @@ static const struct device_attribute olpc_bat_error =
=3D {
 	.show =3D olpc_bat_error_read,
 };
=20
+static struct attribute *olpc_bat_sysfs_attrs[] =3D {
+	&olpc_bat_error.attr,
+	NULL
+};
+
+static struct bin_attribute *olpc_bat_sysfs_bin_attrs[] =3D {
+	&olpc_bat_eeprom,
+	NULL
+};
+
+static const struct attribute_group olpc_bat_sysfs_group =3D {
+	.attrs =3D olpc_bat_sysfs_attrs,
+	.bin_attrs =3D olpc_bat_sysfs_bin_attrs,
+
+};
+
+static const struct attribute_group *olpc_bat_sysfs_groups[] =3D {
+	&olpc_bat_sysfs_group,
+	NULL
+};
+
 /*********************************************************************
  *		Initialisation
  *********************************************************************/
@@ -615,7 +636,8 @@ static int olpc_battery_suspend(struct platform_devic=
e *pdev,
=20
 static int olpc_battery_probe(struct platform_device *pdev)
 {
-	struct power_supply_config psy_cfg =3D {};
+	struct power_supply_config bat_psy_cfg =3D {};
+	struct power_supply_config ac_psy_cfg =3D {};
 	struct olpc_battery_data *data;
 	uint8_t status;
 	uint8_t ecver;
@@ -654,10 +676,11 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
=20
 	/* Ignore the status. It doesn't actually matter */
=20
-	psy_cfg.of_node =3D pdev->dev.of_node;
-	psy_cfg.drv_data =3D data;
+	ac_psy_cfg.of_node =3D pdev->dev.of_node;
+	ac_psy_cfg.drv_data =3D data;
=20
-	data->olpc_ac =3D devm_power_supply_register(&pdev->dev, &olpc_ac_desc,=
 &psy_cfg);
+	data->olpc_ac =3D devm_power_supply_register(&pdev->dev, &olpc_ac_desc,
+								&ac_psy_cfg);
 	if (IS_ERR(data->olpc_ac))
 		return PTR_ERR(data->olpc_ac);
=20
@@ -671,37 +694,21 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
 	}
=20
-	data->olpc_bat =3D devm_power_supply_register(&pdev->dev, &olpc_bat_des=
c, &psy_cfg);
+	bat_psy_cfg.of_node =3D pdev->dev.of_node;
+	bat_psy_cfg.drv_data =3D data;
+	bat_psy_cfg.attr_grp =3D olpc_bat_sysfs_groups;
+
+	data->olpc_bat =3D devm_power_supply_register(&pdev->dev, &olpc_bat_des=
c,
+								&bat_psy_cfg);
 	if (IS_ERR(data->olpc_bat))
 		return PTR_ERR(data->olpc_bat);
=20
-	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
-	if (ret)
-		return ret;
-
-	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
-	if (ret)
-		goto error_failed;
-
 	if (olpc_ec_wakeup_available()) {
 		device_set_wakeup_capable(&data->olpc_ac->dev, true);
 		device_set_wakeup_capable(&data->olpc_bat->dev, true);
 	}
=20
 	return 0;
-
-error_failed:
-	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
-	return ret;
-}
-
-static int olpc_battery_remove(struct platform_device *pdev)
-{
-	struct olpc_battery_data *data =3D platform_get_drvdata(pdev);
-
-	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
-	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
-	return 0;
 }
=20
 static const struct of_device_id olpc_battery_ids[] =3D {
@@ -717,7 +724,6 @@ static struct platform_driver olpc_battery_driver =3D=
 {
 		.of_match_table =3D olpc_battery_ids,
 	},
 	.probe =3D olpc_battery_probe,
-	.remove =3D olpc_battery_remove,
 	.suspend =3D olpc_battery_suspend,
 };
=20
--=20
2.20.1

