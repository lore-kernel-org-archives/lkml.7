Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D05C76196
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 22:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6827208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 22:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="gBGnZREA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfGUW4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 18:56:08 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52701 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGUW4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 18:56:08 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D38D3891AB;
        Mon, 22 Jul 2019 10:56:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1563749765;
        bh=Th6xSjXuHNJjGLRd9aoDajb/emE1LzqtVwlVo5H5ass=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gBGnZREAQCwZV9DeA2f6coAIhA/mAbSso6RzuzihsbE7ApAdIcHoT/tLl+bsx/+KJ
         qyyedb3lt27NaK58rkoy77EAHaFGHzsCw1XHDPf3lUwS3X5SY46n9zg9P50EEGU9X4
         404LpZM0wkPpNDk4h2ELZTsXNjim8xH5YuSMJWQYMAYf561jWj+h0lGlGjF6vxJWcz
         65R6pYUj4x7SWdV+MZ57K2O4xNRg0tjy69H4Pqjqy/VQS5JbpMY+xC7GZNJwh30g7i
         HsUE91KtCiXtICxAoGxzEzPyGz7H+QGZ2eJTcM75bm5wSDGy5Qd3m3RQ+ZcDSdhSg/
         9tzThPMhR9mgQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d34ed850000>; Mon, 22 Jul 2019 10:56:05 +1200
Received: from grantmc-dl.ws.atlnz.lc (grantmc-dl.ws.atlnz.lc [10.33.24.16])
        by smtp (Postfix) with ESMTP id 8A4A313EECE;
        Mon, 22 Jul 2019 10:56:07 +1200 (NZST)
Received: by grantmc-dl.ws.atlnz.lc (Postfix, from userid 1772)
        id 873DC100E0A; Mon, 22 Jul 2019 10:56:05 +1200 (NZST)
From:   Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
Subject: [PATCH v2 1/1] hwmon: (adt7475) Convert to use hwmon_device_register_with_groups()
Date:   Mon, 22 Jul 2019 10:55:30 +1200
Message-Id: <20190721225530.28799-2-grant.mcewan@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190721225530.28799-1-grant.mcewan@alliedtelesis.co.nz>
References: <20190721225530.28799-1-grant.mcewan@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwmon_device_register() is a deprecated function and produces a warning.

Converting the driver to use the hwmon_device_register_with_groups()
instead.

Signed-off-by: Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
---
 drivers/hwmon/adt7475.c | 146 ++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 96 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index c3c6031a7285..6c64d50c9aae 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -187,7 +187,7 @@ static const struct of_device_id __maybe_unused adt74=
75_of_match[] =3D {
 MODULE_DEVICE_TABLE(of, adt7475_of_match);
=20
 struct adt7475_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex lock;
=20
 	unsigned long measure_updated;
@@ -212,6 +212,7 @@ struct adt7475_data {
=20
 	u8 vid;
 	u8 vrm;
+	const struct attribute_group *groups[9];
 };
=20
 static struct i2c_driver adt7475_driver;
@@ -346,8 +347,8 @@ static ssize_t voltage_store(struct device *dev,
 {
=20
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	unsigned char reg;
 	long val;
=20
@@ -440,8 +441,8 @@ static ssize_t temp_store(struct device *dev, struct =
device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	unsigned char reg =3D 0;
 	u8 out;
 	int temp;
@@ -542,8 +543,7 @@ static ssize_t temp_st_show(struct device *dev, struc=
t device_attribute *attr,
 			    char *buf)
 {
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
 	long val;
=20
 	switch (sattr->index) {
@@ -570,8 +570,8 @@ static ssize_t temp_st_store(struct device *dev,
 			     size_t count)
 {
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	unsigned char reg;
 	int shift, idx;
 	ulong val;
@@ -647,8 +647,8 @@ static ssize_t point2_show(struct device *dev, struct=
 device_attribute *attr,
 static ssize_t point2_store(struct device *dev, struct device_attribute =
*attr,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
 	int temp;
 	long val;
@@ -710,8 +710,8 @@ static ssize_t tach_store(struct device *dev, struct =
device_attribute *attr,
 {
=20
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	unsigned long val;
=20
 	if (kstrtoul(buf, 10, &val))
@@ -769,8 +769,8 @@ static ssize_t pwm_store(struct device *dev, struct d=
evice_attribute *attr,
 {
=20
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	unsigned char reg =3D 0;
 	long val;
=20
@@ -818,8 +818,8 @@ static ssize_t stall_disable_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+
 	u8 mask =3D BIT(5 + sattr->index);
=20
 	return sprintf(buf, "%d\n", !!(data->enh_acoustics[0] & mask));
@@ -830,8 +830,8 @@ static ssize_t stall_disable_store(struct device *dev=
,
 				   const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	long val;
 	u8 mask =3D BIT(5 + sattr->index);
=20
@@ -914,8 +914,8 @@ static ssize_t pwmchan_store(struct device *dev,
 			     size_t count)
 {
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	int r;
 	long val;
=20
@@ -938,8 +938,8 @@ static ssize_t pwmctrl_store(struct device *dev,
 			     size_t count)
 {
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	int r;
 	long val;
=20
@@ -982,8 +982,8 @@ static ssize_t pwmfreq_store(struct device *dev,
 			     size_t count)
 {
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	int out;
 	long val;
=20
@@ -1022,8 +1022,8 @@ static ssize_t pwm_use_point2_pwm_at_crit_store(str=
uct device *dev,
 					struct device_attribute *devattr,
 					const char *buf, size_t count)
 {
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	long val;
=20
 	if (kstrtol(buf, 10, &val))
@@ -1342,26 +1342,6 @@ static int adt7475_detect(struct i2c_client *clien=
t,
 	return 0;
 }
=20
-static void adt7475_remove_files(struct i2c_client *client,
-				 struct adt7475_data *data)
-{
-	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
-	if (data->has_fan4)
-		sysfs_remove_group(&client->dev.kobj, &fan4_attr_group);
-	if (data->has_pwm2)
-		sysfs_remove_group(&client->dev.kobj, &pwm2_attr_group);
-	if (data->has_voltage & (1 << 0))
-		sysfs_remove_group(&client->dev.kobj, &in0_attr_group);
-	if (data->has_voltage & (1 << 3))
-		sysfs_remove_group(&client->dev.kobj, &in3_attr_group);
-	if (data->has_voltage & (1 << 4))
-		sysfs_remove_group(&client->dev.kobj, &in4_attr_group);
-	if (data->has_voltage & (1 << 5))
-		sysfs_remove_group(&client->dev.kobj, &in5_attr_group);
-	if (data->has_vid)
-		sysfs_remove_group(&client->dev.kobj, &vid_attr_group);
-}
-
 static int adt7475_update_limits(struct i2c_client *client)
 {
 	struct adt7475_data *data =3D i2c_get_clientdata(client);
@@ -1489,7 +1469,8 @@ static int adt7475_probe(struct i2c_client *client,
 	};
=20
 	struct adt7475_data *data;
-	int i, ret =3D 0, revision;
+	struct device *hwmon_dev;
+	int i, ret =3D 0, revision, group_num =3D 0;
 	u8 config2, config3;
=20
 	data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
@@ -1497,6 +1478,7 @@ static int adt7475_probe(struct i2c_client *client,
 		return -ENOMEM;
=20
 	mutex_init(&data->lock);
+	data->client =3D client;
 	i2c_set_clientdata(client, data);
=20
 	if (client->dev.of_node)
@@ -1590,52 +1572,40 @@ static int adt7475_probe(struct i2c_client *clien=
t,
 		break;
 	}
=20
-	ret =3D sysfs_create_group(&client->dev.kobj, &adt7475_attr_group);
-	if (ret)
-		return ret;
+	data->groups[group_num++] =3D &adt7475_attr_group;
=20
 	/* Features that can be disabled individually */
 	if (data->has_fan4) {
-		ret =3D sysfs_create_group(&client->dev.kobj, &fan4_attr_group);
-		if (ret)
-			goto eremove;
+		data->groups[group_num++] =3D &fan4_attr_group;
 	}
 	if (data->has_pwm2) {
-		ret =3D sysfs_create_group(&client->dev.kobj, &pwm2_attr_group);
-		if (ret)
-			goto eremove;
+		data->groups[group_num++] =3D &pwm2_attr_group;
 	}
 	if (data->has_voltage & (1 << 0)) {
-		ret =3D sysfs_create_group(&client->dev.kobj, &in0_attr_group);
-		if (ret)
-			goto eremove;
+		data->groups[group_num++] =3D &in0_attr_group;
 	}
 	if (data->has_voltage & (1 << 3)) {
-		ret =3D sysfs_create_group(&client->dev.kobj, &in3_attr_group);
-		if (ret)
-			goto eremove;
+		data->groups[group_num++] =3D &in3_attr_group;
 	}
 	if (data->has_voltage & (1 << 4)) {
-		ret =3D sysfs_create_group(&client->dev.kobj, &in4_attr_group);
-		if (ret)
-			goto eremove;
+		data->groups[group_num++] =3D &in4_attr_group;
 	}
 	if (data->has_voltage & (1 << 5)) {
-		ret =3D sysfs_create_group(&client->dev.kobj, &in5_attr_group);
-		if (ret)
-			goto eremove;
+		data->groups[group_num++] =3D &in5_attr_group;
 	}
 	if (data->has_vid) {
 		data->vrm =3D vid_which_vrm();
-		ret =3D sysfs_create_group(&client->dev.kobj, &vid_attr_group);
-		if (ret)
-			goto eremove;
+		data->groups[group_num] =3D &vid_attr_group;
 	}
=20
-	data->hwmon_dev =3D hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret =3D PTR_ERR(data->hwmon_dev);
-		goto eremove;
+	/* register device with all the acquired attributes */
+	hwmon_dev =3D devm_hwmon_device_register_with_groups(&client->dev,
+							   client->name, data,
+							   data->groups);
+
+	if (IS_ERR(hwmon_dev)) {
+		ret =3D PTR_ERR(hwmon_dev);
+		return ret;
 	}
=20
 	dev_info(&client->dev, "%s device, revision %d\n",
@@ -1657,21 +1627,7 @@ static int adt7475_probe(struct i2c_client *client=
,
 	/* Limits and settings, should never change update more than once */
 	ret =3D adt7475_update_limits(client);
 	if (ret)
-		goto eremove;
-
-	return 0;
-
-eremove:
-	adt7475_remove_files(client, data);
-	return ret;
-}
-
-static int adt7475_remove(struct i2c_client *client)
-{
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	adt7475_remove_files(client, data);
+		return ret;
=20
 	return 0;
 }
@@ -1683,7 +1639,6 @@ static struct i2c_driver adt7475_driver =3D {
 		.of_match_table =3D of_match_ptr(adt7475_of_match),
 	},
 	.probe		=3D adt7475_probe,
-	.remove		=3D adt7475_remove,
 	.id_table	=3D adt7475_id,
 	.detect		=3D adt7475_detect,
 	.address_list	=3D normal_i2c,
@@ -1757,8 +1712,8 @@ static void adt7475_read_pwm(struct i2c_client *cli=
ent, int index)
=20
 static int adt7475_update_measure(struct device *dev)
 {
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *client =3D data->client;
 	u16 ext;
 	int i;
 	int ret;
@@ -1854,8 +1809,7 @@ static int adt7475_update_measure(struct device *de=
v)
=20
 static struct adt7475_data *adt7475_update_device(struct device *dev)
 {
-	struct i2c_client *client =3D to_i2c_client(dev);
-	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct adt7475_data *data =3D dev_get_drvdata(dev);
 	int ret;
=20
 	mutex_lock(&data->lock);
--=20
2.22.0

