Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD1C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18A1208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="vqT6INZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfGUKeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 06:34:14 -0400
Received: from mx1.cock.li ([185.10.68.5]:39117 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfGUKeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:34:14 -0400
From:   Robert Karszniewicz <avoidr@firemail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1563667064; bh=uezqzlmF1TflZxVAEHnTtpcUNbI9EQ2sRz89fTQhRs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqT6INZuk6znA+3NEm6Ud7GqKWNmU9m/FTTg9JmUtKXjHo3ga3+l2cAepQA6sZzNk
         2H0t6kO253lv8OxAn0S9f6zQnKP3uear7o6alUMDVKKXupudM65n1VfkVIO6cTdHXt
         n9cNBl9WvAxNPDPgSbNVtV6mLnBpmtbMJthc8S3pg05LmCFq6wwGAfyoOgUqvVeRYj
         pB3UfIGNMDVF8wIPZsk54D4sYqKfiaB8+ZM3IX0FieHrbQI6cJGIQzzhOkYXg1rgx6
         R9IDCjRjZq1t+nSFf+SJ2j1fvBD4YEo/+kimEjxdAf8U4TzrLotBnvFs3/2DJSsMAI
         9/2VCtMI+vHGA==
To:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Robert Karszniewicz <avoidr@firemail.cc>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] hwmon: (k8temp) update to use new hwmon registration API
Date:   Sun, 21 Jul 2019 01:56:21 +0200
Message-Id: <20190720235621.29322-1-avoidr@firemail.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <020f87268cd1a41fec68d1789e015552cfbb9da1.1563522498.git.avoidr@firemail.cc>
References: <020f87268cd1a41fec68d1789e015552cfbb9da1.1563522498.git.avoidr@firemail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes:
- hwmon_dev from k8temp_data struct, as that is now passed
  to callbacks, anyway.
- other k8temp_data struct fields, too.
- k8temp_update_device()

Also reduces binary size:
   text    data     bss     dec     hex filename
   4139    1448       0    5587    15d3 drivers/hwmon/k8temp.ko.bak
   3077    1220       0    4297    10c9 drivers/hwmon/k8temp.ko

Signed-off-by: Robert Karszniewicz <avoidr@firemail.cc>
---
Changes from v1:
- correct is_visible() and remove unnecessary checks
- k8temp_read(): remove unnecessary checks and replace the switch
- use HWMON_CHANNEL_INFO()
- remove k8temp->name and pass the string directly
- use PTR_ERR_OR_ZERO()
- remove k8temp_update_device() and more k8temp_data fields

 drivers/hwmon/k8temp.c | 234 ++++++++++++-----------------------------
 1 file changed, 70 insertions(+), 164 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 4994c90c8929..0bedb3abee74 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -10,10 +10,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/jiffies.h>
 #include <linux/pci.h>
 #include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <asm/processor.h>
@@ -24,108 +22,18 @@
 #define SEL_CORE	0x04
 
 struct k8temp_data {
-	struct device *hwmon_dev;
 	struct mutex update_lock;
-	const char *name;
-	char valid;		/* zero until following fields are valid */
-	unsigned long last_updated;	/* in jiffies */
 
 	/* registers values */
 	u8 sensorsp;		/* sensor presence bits - SEL_CORE, SEL_PLACE */
-	u32 temp[2][2];		/* core, place */
 	u8 swap_core_select;    /* meaning of SEL_CORE is inverted */
 	u32 temp_offset;
 };
 
-static struct k8temp_data *k8temp_update_device(struct device *dev)
-{
-	struct k8temp_data *data = dev_get_drvdata(dev);
-	struct pci_dev *pdev = to_pci_dev(dev);
-	u8 tmp;
-
-	mutex_lock(&data->update_lock);
-
-	if (!data->valid
-	    || time_after(jiffies, data->last_updated + HZ)) {
-		pci_read_config_byte(pdev, REG_TEMP, &tmp);
-		tmp &= ~(SEL_PLACE | SEL_CORE);	/* Select sensor 0, core0 */
-		pci_write_config_byte(pdev, REG_TEMP, tmp);
-		pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);
-
-		if (data->sensorsp & SEL_PLACE) {
-			tmp |= SEL_PLACE;	/* Select sensor 1, core0 */
-			pci_write_config_byte(pdev, REG_TEMP, tmp);
-			pci_read_config_dword(pdev, REG_TEMP,
-					      &data->temp[0][1]);
-		}
-
-		if (data->sensorsp & SEL_CORE) {
-			tmp &= ~SEL_PLACE;	/* Select sensor 0, core1 */
-			tmp |= SEL_CORE;
-			pci_write_config_byte(pdev, REG_TEMP, tmp);
-			pci_read_config_dword(pdev, REG_TEMP,
-					      &data->temp[1][0]);
-
-			if (data->sensorsp & SEL_PLACE) {
-				tmp |= SEL_PLACE; /* Select sensor 1, core1 */
-				pci_write_config_byte(pdev, REG_TEMP, tmp);
-				pci_read_config_dword(pdev, REG_TEMP,
-						      &data->temp[1][1]);
-			}
-		}
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
-	return data;
-}
-
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
@@ -159,14 +67,77 @@ static int is_rev_g_desktop(u8 model)
 	return 1;
 }
 
+static umode_t
+k8temp_is_visible(const void *drvdata, enum hwmon_sensor_types type,
+		  u32 attr, int channel)
+{
+	const struct k8temp_data *data = drvdata;
+
+	if ((channel & 1) && !(data->sensorsp & SEL_PLACE))
+		return 0;
+
+	if ((channel & 2) && !(data->sensorsp & SEL_CORE))
+		return 0;
+
+	return 0444;
+}
+
+static int
+k8temp_read(struct device *dev, enum hwmon_sensor_types type,
+	    u32 attr, int channel, long *val)
+{
+	struct k8temp_data *data = dev_get_drvdata(dev);
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
+	int core, place;
+	u32 temp;
+	u8 tmp;
+
+	core = (channel >> 1) & 1;
+	place = channel & 1;
+
+	if (data->swap_core_select)
+		core ^= 1;
+
+	mutex_lock(&data->update_lock);
+	pci_read_config_byte(pdev, REG_TEMP, &tmp);
+	tmp &= ~(SEL_PLACE | SEL_CORE);
+	if (core)
+		tmp |= SEL_CORE;
+	if (place)
+		tmp |= SEL_PLACE;
+	pci_write_config_byte(pdev, REG_TEMP, tmp);
+	pci_read_config_dword(pdev, REG_TEMP, &temp);
+	mutex_unlock(&data->update_lock);
+
+	*val = TEMP_FROM_REG(temp) + data->temp_offset;
+
+	return 0;
+}
+
+static const struct hwmon_ops k8temp_ops = {
+	.is_visible = k8temp_is_visible,
+	.read = k8temp_read,
+};
+
+static const struct hwmon_channel_info *k8temp_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+		HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT),
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
@@ -231,86 +202,21 @@ static int k8temp_probe(struct pci_dev *pdev,
 			data->sensorsp &= ~SEL_CORE;
 	}
 
-	data->name = "k8temp";
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
-
-	err = device_create_file(&pdev->dev, &dev_attr_name);
-	if (err)
-		goto exit_remove;
 
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+							 "k8temp",
+							 data,
+							 &k8temp_chip_info,
+							 NULL);
 
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	return 0;
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
+	return PTR_ERR_OR_ZERO(hwmon_dev);
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

