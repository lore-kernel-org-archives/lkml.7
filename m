Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5726C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952D12184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="b0QMlkMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfGSBlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:41:52 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49265 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfGSBlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:41:51 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 694C5891AB;
        Fri, 19 Jul 2019 13:41:48 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1563500508;
        bh=GCwWTTvZWjLZoYIVvBtBDfbCvFOBTlmjDF9yXN2JoYk=;
        h=From:To:Cc:Subject:Date;
        b=b0QMlkMmdsIHALhWtK310b3onY19uaHU6qx20WkLoJlzbJIpar+16xIswwdqKHHdk
         phf/GfHBbffYKqxcCKzaVsPf5GA5yk/1hqVno+ytue59uC6xRTK3Hs092aZ1cO8bLI
         qZdS9rgRD6mhJYAbApu1NpmsAxURYT7H8U2VvtZBGlZKkY2vDYbhfTRug+s05a2BlG
         +GJemy6zOcy/sTrqWzE3sV3qDJHCd0E0raRr5S5Fev8U+AcNyBAxCgNcH3UMlcwfqh
         wmkminnXBNfA4KJ7HxsH1b4mvD7Ucl6B1JLoHlV6tfdfTdXdkfZCvwTDtFrLyolGDP
         RP92m0QkWPKMw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d311fda0000>; Fri, 19 Jul 2019 13:41:48 +1200
Received: from grantmc-dl.ws.atlnz.lc (grantmc-dl.ws.atlnz.lc [10.33.24.16])
        by smtp (Postfix) with ESMTP id 88AED13EF59;
        Fri, 19 Jul 2019 13:41:48 +1200 (NZST)
Received: by grantmc-dl.ws.atlnz.lc (Postfix, from userid 1772)
        id 8E84410164A; Fri, 19 Jul 2019 13:41:46 +1200 (NZST)
From:   Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
Subject: [PATCH] hwmon: (adt7475) Convert to use hwmon_device_register_with_groups()
Date:   Fri, 19 Jul 2019 13:41:30 +1200
Message-Id: <20190719014130.1090-1-grant.mcewan@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.22.0
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
 drivers/hwmon/adt7475.c | 104 +++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 56 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index c3c6031a7285..4e838555102f 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -188,6 +188,7 @@ MODULE_DEVICE_TABLE(of, adt7475_of_match);
=20
 struct adt7475_data {
 	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex lock;
=20
 	unsigned long measure_updated;
@@ -212,6 +213,7 @@ struct adt7475_data {
=20
 	u8 vid;
 	u8 vrm;
+	const struct attribute_group *groups[8];
 };
=20
 static struct i2c_driver adt7475_driver;
@@ -346,8 +348,8 @@ static ssize_t voltage_store(struct device *dev,
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
@@ -440,8 +442,8 @@ static ssize_t temp_store(struct device *dev, struct =
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
@@ -542,8 +544,7 @@ static ssize_t temp_st_show(struct device *dev, struc=
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
@@ -570,8 +571,8 @@ static ssize_t temp_st_store(struct device *dev,
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
@@ -647,8 +648,8 @@ static ssize_t point2_show(struct device *dev, struct=
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
@@ -710,8 +711,8 @@ static ssize_t tach_store(struct device *dev, struct =
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
@@ -769,8 +770,8 @@ static ssize_t pwm_store(struct device *dev, struct d=
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
@@ -818,8 +819,8 @@ static ssize_t stall_disable_show(struct device *dev,
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
@@ -830,8 +831,8 @@ static ssize_t stall_disable_store(struct device *dev=
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
@@ -914,8 +915,8 @@ static ssize_t pwmchan_store(struct device *dev,
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
@@ -938,8 +939,8 @@ static ssize_t pwmctrl_store(struct device *dev,
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
@@ -982,8 +983,8 @@ static ssize_t pwmfreq_store(struct device *dev,
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
@@ -1022,8 +1023,8 @@ static ssize_t pwm_use_point2_pwm_at_crit_store(str=
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
@@ -1305,6 +1306,9 @@ static const struct attribute_group in4_attr_group =
=3D { .attrs =3D in4_attrs };
 static const struct attribute_group in5_attr_group =3D { .attrs =3D in5_=
attrs };
 static const struct attribute_group vid_attr_group =3D { .attrs =3D vid_=
attrs };
=20
+/* Number of possible attribute groups to add into sysfs */
+#define ATTR_GROUP_COUNT 8
+
 static int adt7475_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
@@ -1489,7 +1493,7 @@ static int adt7475_probe(struct i2c_client *client,
 	};
=20
 	struct adt7475_data *data;
-	int i, ret =3D 0, revision;
+	int i, ret =3D 0, revision, group_num =3D 0;
 	u8 config2, config3;
=20
 	data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
@@ -1497,6 +1501,7 @@ static int adt7475_probe(struct i2c_client *client,
 		return -ENOMEM;
=20
 	mutex_init(&data->lock);
+	data->client =3D client;
 	i2c_set_clientdata(client, data);
=20
 	if (client->dev.of_node)
@@ -1590,49 +1595,37 @@ static int adt7475_probe(struct i2c_client *clien=
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
+	/* register device with all the acquired attributes */
+	data->hwmon_dev =3D hwmon_device_register_with_groups(&client->dev,
+							    client->name, data,
+							    data->groups);
+
 	if (IS_ERR(data->hwmon_dev)) {
 		ret =3D PTR_ERR(data->hwmon_dev);
 		goto eremove;
@@ -1757,8 +1750,8 @@ static void adt7475_read_pwm(struct i2c_client *cli=
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
@@ -1854,8 +1847,7 @@ static int adt7475_update_measure(struct device *de=
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

