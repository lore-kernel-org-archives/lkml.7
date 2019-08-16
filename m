Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A894C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA9320578
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHPIhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:37:53 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:1938 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfHPIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:37:50 -0400
IronPort-SDR: QHXqsxKNVGMZTzMI0sQgJEMvQS/1YxGrIpq5MlLSTLCxdEUumxSnlIiXJqpPkBJIQB/4iZ2B5V
 mFCTIEJbZzPtOdD6z17XNmTCYvcHUYvtcxYBPNx441VNfvuRr5mu9W5JjWMlDvr6PZ7XxW2+EE
 2F3itdrOXSXxFwDkNVhEmB17fnA+h3D5VBgxo46qrKtd2Je+a+ww8ds7cY1a5GaTL4fdAmP0KU
 AhER1NdaLTVPxxM9YusvAAmoXU7Oxx3aPCQPKkJWfjefwEmudyy+EZr+yhQziBhBknu+LNRFiY
 sLQ=
X-IronPort-AV: E=Sophos;i="5.64,391,1559548800"; 
   d="scan'208";a="40484288"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 16 Aug 2019 00:34:46 -0800
IronPort-SDR: gc3OeUSWoHtEFLIM71heKMSCLciyBspMLFB3ndI+7f7JljMFNudoreDPZ3FOuUBOMcfbnPWvfe
 tFt9NPyHQjGgDKvEB21202eCWGRnYXsX/rAWXSicwDaD7eFSKFrVNk1Qfzxjfj3+MVVoYXHLhh
 2V609kRBG6kt09HGuJXIEFwwCmK6X0fJwPCt+TaLeAKekk6ri1ERRZuMZRq4+SP3VyxU3hs+lN
 YruYO59hJaCvy1wnrYFrvBrAZgFEEYRHttGID7fgK5n1mhbZ4U5fR9yGd+PYjY269r97BTFhPD
 7pE=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>, <george_davis@mentor.com>
Subject: [PATCH v1 31/63] Input: atmel_mxt_ts - add memory access interface via sysfs
Date:   Fri, 16 Aug 2019 17:34:19 +0900
Message-ID: <20190816083451.18947-2-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190816083451.18947-1-jiada_wang@mentor.com>
References: <20190816083451.18947-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Atmel maXTouch chips can be addressed via an "Object Based Protocol" which
defines how i2c registers are mapped to different functions within the
chips. This interface exposes the register map and allows user-space
utilities to inspect and alter object configuration, and to view diagnostic
data, while the device is running.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
(cherry picked from ndyer/linux/for-upstream commit 80731e95c888d09b663ad9eeaf4163939bfe17f8)
Signed-off-by: George G. Davis <george_davis@mentor.com>
[jiada: Fix compilation warnings]
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 74 ++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index e317900279ed..05b21c9c0c04 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -335,6 +335,7 @@ struct mxt_data {
 	u8 t100_aux_ampl;
 	u8 t100_aux_area;
 	u8 t100_aux_vect;
+	struct bin_attribute mem_access_attr;
 	bool debug_enabled;
 	u8 max_reportid;
 	u32 config_crc;
@@ -3553,6 +3554,56 @@ static ssize_t mxt_debug_enable_store(struct device *dev,
 	return ret;
 }
 
+static int mxt_check_mem_access_params(struct mxt_data *data, loff_t off,
+				       size_t *count)
+{
+	if (off >= data->mem_size)
+		return -EIO;
+
+	if (off + *count > data->mem_size)
+		*count = data->mem_size - off;
+
+	if (*count > MXT_MAX_BLOCK_WRITE)
+		*count = MXT_MAX_BLOCK_WRITE;
+
+	return 0;
+}
+
+static ssize_t mxt_mem_access_read(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *bin_attr, char *buf, loff_t off, size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct mxt_data *data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = mxt_check_mem_access_params(data, off, &count);
+	if (ret < 0)
+		return ret;
+
+	if (count > 0)
+		ret = __mxt_read_reg(data->client, off, count, buf);
+
+	return ret == 0 ? (ssize_t)count : ret;
+}
+
+static ssize_t mxt_mem_access_write(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *bin_attr, char *buf, loff_t off,
+	size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct mxt_data *data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = mxt_check_mem_access_params(data, off, &count);
+	if (ret < 0)
+		return ret;
+
+	if (count > 0)
+		ret = __mxt_write_reg(data->client, off, count, buf);
+
+	return ret == 0 ? (ssize_t)count : ret;
+}
+
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);
 
 static struct attribute *mxt_fw_attrs[] = {
@@ -3598,13 +3649,36 @@ static int mxt_sysfs_init(struct mxt_data *data)
 		return error;
 	}
 
+	sysfs_bin_attr_init(&data->mem_access_attr);
+	data->mem_access_attr.attr.name = "mem_access";
+	data->mem_access_attr.attr.mode = S_IRUGO | S_IWUSR;
+	data->mem_access_attr.read = mxt_mem_access_read;
+	data->mem_access_attr.write = mxt_mem_access_write;
+	data->mem_access_attr.size = data->mem_size;
+
+	error = sysfs_create_bin_file(&client->dev.kobj,
+				  &data->mem_access_attr);
+	if (error) {
+		dev_err(&client->dev, "Failed to create %s\n",
+			data->mem_access_attr.attr.name);
+		goto err_remove_sysfs_group;
+	}
+
 	return 0;
+
+err_remove_sysfs_group:
+	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
+	return error;
 }
 
 static void mxt_sysfs_remove(struct mxt_data *data)
 {
 	struct i2c_client *client = data->client;
 
+	if (data->mem_access_attr.attr.name)
+		sysfs_remove_bin_file(&client->dev.kobj,
+				      &data->mem_access_attr);
+
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 }
 
-- 
2.19.2

