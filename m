Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0F6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C98527134
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D6wG026h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFCSQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:16:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46895 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCSQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:16:56 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so5204609iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAckVISWLJwv9nm3Aw+n1+y3ZFIECEV9oa3vdFLyLTE=;
        b=D6wG026hBYH7UsTeDPMStAkv/58a+vTNsbPIbz3WAzGZu2RL/qVcnZc/jDjopmpjnS
         CzE6ytCMoE4W+T9CeLTY7rSWuLK/+JRSoM0l6XSYUNhT2vb0Uir0tslPJkATfxr/o7yt
         Ju2Q505tbmUh69B+ukR8BrsWOd3gD7HQQn5N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAckVISWLJwv9nm3Aw+n1+y3ZFIECEV9oa3vdFLyLTE=;
        b=MTjAeKDZ6Q1RJBq+estIGSIrYZ/bkcKRkT5CAis10vBXu5WGPHa9WBTjIcbTkBUSU1
         yNg1O7rCtZxRp6jgDdrz7f88dkhOSMZmFWoJcKiX/LK79BT+SRyn1MIkXx0w9nCz7dWJ
         VP20RAYv90P2oGaCYMY2o1hSjaSU4s6j68Dtny2dqjKN4HLFoJv4RK0bMRUXc7jN2wPh
         AT5Oo73u1HyBi32VXJ654N5MtsScjgh5JdUzcOoUFrpk+s5RsSSWq1a143gLl9vPElK2
         zH/3OsJrZ4LIn53bdpEJnReiBSJ74jz3mIbXaJSsobpR0acQUdf5gcAdX+MRx84mNtxC
         tzmw==
X-Gm-Message-State: APjAAAXG2NFmv5RaNfrmli9lkxP54kiGVYuW0jVXbmnTyOjDEJKyPvKo
        auafWZwMSzJbtbE8Fdt2+guNkZfYt/k=
X-Google-Smtp-Source: APXvYqxlZLw7bJiV4E47T0ON1UaWX3pls4Uz7J7KDq5Ang19izfN7+l+Bzvgti4pk4XizNC1RtYSTA==
X-Received: by 2002:a5d:83d8:: with SMTP id u24mr16726644ior.51.1559585815163;
        Mon, 03 Jun 2019 11:16:55 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id b18sm4331209itl.32.2019.06.03.11.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:16:54 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     enric.balletbo@collabora.com, ncrews@chromium.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH v2] platform/chrome: wilco_ec: Add version sysfs entries
Date:   Mon,  3 Jun 2019 12:16:49 -0600
Message-Id: <20190603181649.143640-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to extract version information from the EC.

Example Output:
$ cd /sys/bus/platform/devices/GOOG000C:00
$ tail build_date build_revision version model_number
==> build_date <==
04/25/19

==> build_revision <==
d2592cae0

==> version <==
00.00.14

==> model_number <==
08B6

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
This patch is rebased on chromeos-platform/for-next. It was originally
developed on the chromiumos 4.19 kernel which has the following patch
applied: https://lore.kernel.org/patchwork/patch/1062995/. That patch is
not currently upstream.

Changes in v2:
- Removed version directory
- Renamed label to version
- Sorted documentation

 .../ABI/testing/sysfs-platform-wilco-ec       | 31 ++++++++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 79 +++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
index 8e5d6eee44db2..8827a734f9331 100644
--- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
+++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
@@ -7,3 +7,34 @@ Description:
 		want to run their device headless or with a dock.
 
 		Input should be parseable by kstrtou8() to 0 or 1.
+
+What:          /sys/bus/platform/devices/GOOG000C\:00/build_date
+Date:          May 2019
+KernelVersion: 5.3
+Description:
+               Display Wilco Embedded Controller firmware build date.
+               Output will a MM/DD/YY string.
+
+What:          /sys/bus/platform/devices/GOOG000C\:00/build_revision
+Date:          May 2019
+KernelVersion: 5.3
+Description:
+               Display Wilco Embedded Controller build revision.
+               Output will a version string be similar to the example below:
+               d2592cae0
+
+What:          /sys/bus/platform/devices/GOOG000C\:00/model_number
+Date:          May 2019
+KernelVersion: 5.3
+Description:
+               Display Wilco Embedded Controller model number.
+               Output will a version string be similar to the example below:
+               08B6
+
+What:          /sys/bus/platform/devices/GOOG000C\:00/version
+Date:          May 2019
+KernelVersion: 5.3
+Description:
+               Display Wilco Embedded Controller firmware version.
+               The format of the string is x.y.z. Where x is major, y is minor
+               and z is the build number. For example: 95.00.06
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index f84f0480460ae..3b86a21005d3e 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -23,6 +23,25 @@ struct boot_on_ac_request {
 	u8 reserved7;
 } __packed;
 
+#define CMD_EC_INFO			0x38
+enum get_ec_info_op {
+	CMD_GET_EC_LABEL	= 0,
+	CMD_GET_EC_REV		= 1,
+	CMD_GET_EC_MODEL	= 2,
+	CMD_GET_EC_BUILD_DATE	= 3,
+};
+
+struct get_ec_info_req {
+	u8 cmd;			/* Always CMD_EC_INFO */
+	u8 reserved;
+	u8 op;			/* One of enum get_ec_info_op */
+} __packed;
+
+struct get_ec_info_resp {
+	u8 reserved[2];
+	char value[9]; /* __nonstring: might not be null terminated */
+} __packed;
+
 static ssize_t boot_on_ac_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
@@ -57,8 +76,68 @@ static ssize_t boot_on_ac_store(struct device *dev,
 
 static DEVICE_ATTR_WO(boot_on_ac);
 
+static ssize_t get_info(struct device *dev, char *buf, enum get_ec_info_op op)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct get_ec_info_req req = { .cmd = CMD_EC_INFO, .op = op };
+	struct get_ec_info_resp resp;
+	int ret;
+
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_LEGACY,
+		.request_data = &req,
+		.request_size = sizeof(req),
+		.response_data = &resp,
+		.response_size = sizeof(resp),
+	};
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%.*s\n", (int)sizeof(resp.value),
+			 (char *)&resp.value);
+}
+
+static ssize_t version_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	return get_info(dev, buf, CMD_GET_EC_LABEL);
+}
+
+static DEVICE_ATTR_RO(version);
+
+static ssize_t build_revision_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return get_info(dev, buf, CMD_GET_EC_REV);
+}
+
+static DEVICE_ATTR_RO(build_revision);
+
+static ssize_t build_date_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return get_info(dev, buf, CMD_GET_EC_BUILD_DATE);
+}
+
+static DEVICE_ATTR_RO(build_date);
+
+static ssize_t model_number_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return get_info(dev, buf, CMD_GET_EC_MODEL);
+}
+
+static DEVICE_ATTR_RO(model_number);
+
+
 static struct attribute *wilco_dev_attrs[] = {
 	&dev_attr_boot_on_ac.attr,
+	&dev_attr_build_date.attr,
+	&dev_attr_build_revision.attr,
+	&dev_attr_model_number.attr,
+	&dev_attr_version.attr,
 	NULL,
 };
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

