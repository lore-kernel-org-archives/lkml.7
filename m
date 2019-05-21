Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7BEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C212173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTlcfnaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfEUPP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:15:26 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37829 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:15:25 -0400
Received: by mail-it1-f193.google.com with SMTP id m140so5261973itg.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L32FrJBxFxvtOKGImjEKesOZkV1TeoxEIa7SyWQbKVo=;
        b=VTlcfnaKWeUBhCfF+Bq7ZCb8//nE5wr6n2I3F0CyYQRFITjBvvdXv70jvNQhXcVXVU
         8pPzttTNmKoPX9TdRL4hn3LHpu+KkT8xBvl2nRucpzuPyHcpVWACAqkDSJ82OR4a12S7
         xYQZkcFFeasnV2km0e05bfLog80oD4UKPUE1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L32FrJBxFxvtOKGImjEKesOZkV1TeoxEIa7SyWQbKVo=;
        b=r3DH/sFqYgE0sH7Xk/IJpgu6b57m6/HylXJBA69TAaLN9ke3WBv/3pdDDKzLVPMvGd
         X2guqoINJ7A32+pK+IQmW5RpvVcekwC5uVnMYwEzYnvKezFO/lis5Ke7h9eZCx0n3iPG
         gHVSFgQTpYKwk4zqEw6sY11zF+FbYGynUEB7OHQUXaiUsbH1MK6ioLLh7Oez42NinPTk
         G/OmLkWs7TzNawe4pVJZHKBrjuJVV98Nz0XJ+RnTE2aL1JUmA/4+80Rh/brYYPEn4vqE
         gEwTPVoKasiFwqW0pduYZfFVfflkeOJN99jnA8pbvmDQ2QjmB/cWpgcrYE/Zb+wTPs+t
         w1hQ==
X-Gm-Message-State: APjAAAW9QuXPw/JE12yz2+46bIg8qxj/2QAtn53zeG0PnPVqaS14oBcE
        2SfWIOjcoTIlPSmt6JnC8Vi+rg==
X-Google-Smtp-Source: APXvYqyu3pyTyw2vgeQymaZ8ABNHR2Dh2p0gOSVKduDgYqKZUAl0DI2tN0g72pFoz1Ad65nGKt2RMQ==
X-Received: by 2002:a24:bd4:: with SMTP id 203mr4164033itd.119.1558451724985;
        Tue, 21 May 2019 08:15:24 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id p23sm6832295ios.65.2019.05.21.08.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 08:15:24 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     enric.balletbo@collabora.com, ncrews@chromium.org
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH] platform/chrome: wilco_ec: Add version sysfs entries
Date:   Tue, 21 May 2019 09:15:19 -0600
Message-Id: <20190521151519.158273-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to extract version information from the EC.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

This patch is rebased on platform/chrome: wilco_ec: Add Boot on AC support.
https://lkml.org/lkml/2019/4/16/1374

That patch wasn't in the for-next branch, so I'm not 100% sure if it
applies cleanly to for-next.

Example Output:
/sys/bus/platform/devices/GOOG000C:00/version # tail *
==> build_date <==
04/25/19

==> build_revision <==
d2592cae0

==> label <==
00.00.14

==> model_number <==
08B6

 .../ABI/testing/sysfs-platform-wilco-ec       | 33 +++++++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 97 ++++++++++++++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
index 6694df8d4172f..00bc8e7c3b9c2 100644
--- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
+++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
@@ -102,3 +102,36 @@ KernelVersion: 5.3
 Description:
 		Read or write the battery percentage threshold for which the
 		peak shift policy is used. The valid range is [15, 100].
+
+What:          /sys/bus/platform/devices/GOOG000C\:00/version/label
+Date:          May 2019
+KernelVersion: 5.3
+Description:
+               Display Wilco Embedded Controller firmware version label.
+               Output will a version string be similar to the example below:
+               95.00.06
+
+What:          /sys/bus/platform/devices/GOOG000C\:00/version/build_revision
+
+Date:          May 2019
+KernelVersion: 5.3
+Description:
+               Display Wilco Embedded Controller build revision.
+               Output will a version string be similar to the example below:
+               d2592cae0
+
+What:          /sys/bus/platform/devices/GOOG000C\:00/version/model_number
+
+Date:          May 2019
+KernelVersion: 5.3
+Description:
+               Display Wilco Embedded Controller model number.
+               Output will a version string be similar to the example below:
+               08B6
+
+What:          /sys/bus/platform/devices/GOOG000C\:00/version/build_date
+Date:          May 2019
+KernelVersion: 5.3
+Description:
+               Display Wilco Embedded Controller firmware build date.
+               Output will a MM/DD/YY string.
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 6573a6cf9cb31..9bfb9dfde73d1 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -43,6 +43,25 @@ struct usb_power_share_response {
 	u8 val;		/* When getting, set by EC to either 0 or 1 */
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
@@ -158,12 +177,86 @@ static struct attribute_group wilco_dev_attr_group = {
 	.attrs = wilco_dev_attrs,
 };
 
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
+static ssize_t label_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	return get_info(dev, buf, CMD_GET_EC_LABEL);
+}
+
+static DEVICE_ATTR_RO(label);
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
+static struct attribute *wilco_version_attrs[] = {
+	&dev_attr_label.attr,
+	&dev_attr_build_revision.attr,
+	&dev_attr_build_date.attr,
+	&dev_attr_model_number.attr,
+	NULL,
+};
+
+static struct attribute_group wilco_version_group = {
+	.name = "version",
+	.attrs = wilco_version_attrs,
+};
+
+static const struct attribute_group *wilco_dev_attr_groups[] = {
+	&wilco_dev_attr_group,
+	&wilco_version_group,
+	NULL
+};
+
 int wilco_ec_add_sysfs(struct wilco_ec_device *ec)
 {
-	return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
+	return sysfs_create_groups(&ec->dev->kobj, wilco_dev_attr_groups);
 }
 
 void wilco_ec_remove_sysfs(struct wilco_ec_device *ec)
 {
-	sysfs_remove_group(&ec->dev->kobj, &wilco_dev_attr_group);
+	sysfs_remove_groups(&ec->dev->kobj, wilco_dev_attr_groups);
 }
-- 
2.21.0.1020.gf2820cf01a-goog

