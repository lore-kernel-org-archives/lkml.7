Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702A9C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4C72064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfCSQgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:36:43 -0400
Received: from sauhun.de ([88.99.104.3]:46116 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbfCSQgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:36:41 -0400
Received: from localhost (p5486CE21.dip0.t-ipconnect.de [84.134.206.33])
        by pokefinder.org (Postfix) with ESMTPSA id 87FEF4A1350;
        Tue, 19 Mar 2019 17:36:39 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 1/1] hid: hid-sensor-custom: simplify getting .driver_data
Date:   Tue, 19 Mar 2019 17:36:38 +0100
Message-Id: <20190319163638.31003-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/hid/hid-sensor-custom.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index bb012bc032e0..462e653a7bbb 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -157,8 +157,7 @@ static int usage_id_cmp(const void *p1, const void *p2)
 static ssize_t enable_sensor_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", sensor_inst->enable);
 }
@@ -237,8 +236,7 @@ static ssize_t enable_sensor_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 	int value;
 	int ret = -EINVAL;
 
@@ -283,8 +281,7 @@ static const struct attribute_group enable_sensor_attr_group = {
 static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 	struct hid_sensor_hub_attribute_info *attribute;
 	int index, usage, field_index;
 	char name[HID_CUSTOM_NAME_LENGTH];
@@ -392,8 +389,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 static ssize_t store_value(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 	int index, field_index, usage;
 	char name[HID_CUSTOM_NAME_LENGTH];
 	int value;
-- 
2.11.0

