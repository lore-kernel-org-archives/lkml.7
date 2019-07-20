Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CEFC76196
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB3D217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 13:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="nrlSOOgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfGTNZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 09:25:09 -0400
Received: from mx1.cock.li ([185.10.68.5]:55563 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfGTNZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 09:25:05 -0400
From:   Robert Karszniewicz <avoidr@firemail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1563628601; bh=CiPsTawZqXfJt7Eiw/U9QfiZjEhy5OsaZncE1aLe4S8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrlSOOggLAJ/nxnsPllN5glQ2YHNoAxFECNwndxShyqvphQdV8YFkbMcqfnUUuV+Y
         fKT75xN901x0cWxYDUn7kEE/JPkyB5HkwOWnJArCR2jVk/wCmjhVo92ytJC5X+bJTz
         OvmfkBVViWDufRpd/G6AYRx/E4j26AbpwOEZpgK3TQWIiKzdHdtCTwAF7V47it+yI1
         aqVMPPC3ITEyoicv9TAOi5en5BbgRM8VWflpe8qULaph//3wB7SOp7H4dNY6V6tJnw
         OaSAow0wJvDFvil6wzk1ODhVfqXcrpfVoDpwRTJ/He9Cuk7Wbku9Ld8lhENuqkTyEO
         NgIkp7nD5USYw==
To:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Robert Karszniewicz <avoidr@firemail.cc>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (k8temp) update to use new hwmon registration API
Date:   Sat, 20 Jul 2019 15:16:37 +0200
Message-Id: <020f87268cd1a41fec68d1789e015552cfbb9da1.1563522498.git.avoidr@firemail.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563522498.git.avoidr@firemail.cc>
References: <cover.1563522498.git.avoidr@firemail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also removes hwmon_dev from k8temp_data struct, as that is now passed
to callbacks, anyway.

Also reduces binary size:
   text    data     bss     dec     hex filename
   4185    1384       0    5569    15c1 drivers/hwmon/k8temp.ko.bak
   3877    1120       0    4997    1385 drivers/hwmon/k8temp.ko

Signed-off-by: Robert Karszniewicz <avoidr@firemail.cc>
---
 drivers/hwmon/k8temp.c | 204 +++++++++++++++++++----------------------
 1 file changed, 92 insertions(+), 112 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 4994c90c8929..2e8fa1e07398 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -13,7 +13,6 @@
 #include <linux/jiffies.h>
 #include <linux/pci.h>
 #include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <asm/processor.h>
@@ -24,7 +23,6 @@
 #define SEL_CORE	0x04
 
 struct k8temp_data {
-	struct device *hwmon_dev;
 	struct mutex update_lock;
 	const char *name;
 	char valid;		/* zero until following fields are valid */
@@ -40,7 +38,7 @@ struct k8temp_data {
 static struct k8temp_data *k8temp_update_device(struct device *dev)
 {
 	struct k8temp_data *data = dev_get_drvdata(dev);
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
 	u8 tmp;
 
 	mutex_lock(&data->update_lock);
@@ -82,50 +80,10 @@ static struct k8temp_data *k8temp_update_device(struct device *dev)
 	return data;
 }
 
-/*
- * Sysfs stuff
- */
-
-static ssize_t name_show(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
-{
-	struct k8temp_data *data = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", data->name);
-}
-
-
-static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
-			 char *buf)
-{
-	struct sensor_device_attribute_2 *attr =
-	    to_sensor_dev_attr_2(devattr);
-	int core = attr->nr;
-	int place = attr->index;
-	int temp;
-	struct k8temp_data *data = k8temp_update_device(dev);
-
-	if (data->swap_core_select && (data->sensorsp & SEL_CORE))
-		core = core ? 0 : 1;
-
-	temp = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
-
-	return sprintf(buf, "%d\n", temp);
-}
-
-/* core, place */
-
-static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0, 0);
-static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 0, 1);
-static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 1, 0);
-static SENSOR_DEVICE_ATTR_2_RO(temp4_input, temp, 1, 1);
-static DEVICE_ATTR_RO(name);
-
 static const struct pci_device_id k8temp_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ 0 },
 };
-
 MODULE_DEVICE_TABLE(pci, k8temp_ids);
 
 static int is_rev_g_desktop(u8 model)
@@ -159,14 +117,97 @@ static int is_rev_g_desktop(u8 model)
 	return 1;
 }
 
+static umode_t
+k8temp_is_visible(const void *drvdata, enum hwmon_sensor_types type,
+		  u32 attr, int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	if (attr != hwmon_temp_input)
+		return 0;
+
+	return 0444;
+}
+
+static int
+k8temp_read(struct device *dev, enum hwmon_sensor_types type,
+	    u32 attr, int channel, long *val)
+{
+	struct k8temp_data *data = k8temp_update_device(dev);
+	int core, place;
+
+	if (type != hwmon_temp)
+		return -EINVAL;
+
+	if (attr != hwmon_temp_input)
+		return -EINVAL;
+
+	switch (channel) {
+	case 0:
+		core = 0;
+		place = 0;
+		break;
+	case 1:
+		core = 0;
+		place = 1;
+		break;
+	case 2:
+		core = 1;
+		place = 0;
+		break;
+	case 3:
+		core = 1;
+		place = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (data->swap_core_select)
+		core = core ? 0 : 1;
+
+	*val = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
+
+	return 0;
+}
+
+static const struct hwmon_ops k8temp_ops = {
+	.is_visible = k8temp_is_visible,
+	.read = k8temp_read,
+};
+
+static const u32 k8temp_config[] = {
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	0
+};
+
+static const struct hwmon_channel_info k8temp_temp_info = {
+	.type = hwmon_temp,
+	.config = k8temp_config,
+};
+
+static const struct hwmon_channel_info *k8temp_info[] = {
+	&k8temp_temp_info,
+	NULL
+};
+
+static const struct hwmon_chip_info k8temp_chip_info = {
+	.ops = &k8temp_ops,
+	.info = k8temp_info,
+};
+
 static int k8temp_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
-	int err;
 	u8 scfg;
 	u32 temp;
 	u8 model, stepping;
 	struct k8temp_data *data;
+	struct device *hwmon_dev;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct k8temp_data), GFP_KERNEL);
 	if (!data)
@@ -233,84 +274,23 @@ static int k8temp_probe(struct pci_dev *pdev,
 
 	data->name = "k8temp";
 	mutex_init(&data->update_lock);
-	pci_set_drvdata(pdev, data);
-
-	/* Register sysfs hooks */
-	err = device_create_file(&pdev->dev,
-			   &sensor_dev_attr_temp1_input.dev_attr);
-	if (err)
-		goto exit_remove;
-
-	/* sensor can be changed and reports something */
-	if (data->sensorsp & SEL_PLACE) {
-		err = device_create_file(&pdev->dev,
-				   &sensor_dev_attr_temp2_input.dev_attr);
-		if (err)
-			goto exit_remove;
-	}
-
-	/* core can be changed and reports something */
-	if (data->sensorsp & SEL_CORE) {
-		err = device_create_file(&pdev->dev,
-				   &sensor_dev_attr_temp3_input.dev_attr);
-		if (err)
-			goto exit_remove;
-		if (data->sensorsp & SEL_PLACE) {
-			err = device_create_file(&pdev->dev,
-					   &sensor_dev_attr_temp4_input.
-					   dev_attr);
-			if (err)
-				goto exit_remove;
-		}
-	}
 
-	err = device_create_file(&pdev->dev, &dev_attr_name);
-	if (err)
-		goto exit_remove;
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+							 data->name,
+							 data,
+							 &k8temp_chip_info,
+							 NULL);
 
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
 	return 0;
-
-exit_remove:
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp1_input.dev_attr);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp2_input.dev_attr);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp3_input.dev_attr);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp4_input.dev_attr);
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	return err;
-}
-
-static void k8temp_remove(struct pci_dev *pdev)
-{
-	struct k8temp_data *data = pci_get_drvdata(pdev);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp1_input.dev_attr);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp2_input.dev_attr);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp3_input.dev_attr);
-	device_remove_file(&pdev->dev,
-			   &sensor_dev_attr_temp4_input.dev_attr);
-	device_remove_file(&pdev->dev, &dev_attr_name);
 }
 
 static struct pci_driver k8temp_driver = {
 	.name = "k8temp",
 	.id_table = k8temp_ids,
 	.probe = k8temp_probe,
-	.remove = k8temp_remove,
 };
 
 module_pci_driver(k8temp_driver);
-- 
2.22.0

