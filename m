Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E071C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453BF206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfCCQrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:47:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:31315 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfCCQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:47:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 08:47:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,436,1544515200"; 
   d="scan'208";a="128667517"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2019 08:47:11 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hong Liu <hong.liu@intel.com>
Subject: [PATCH 1/9] HID: intel-ish-hid: Add match callback to ishtp bus type
Date:   Sun,  3 Mar 2019 08:46:46 -0800
Message-Id: <20190303164654.29400-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
References: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hong Liu <hong.liu@intel.com>

Currently we depend on the guid check in ishtp_cl_driver.probe to match
the device and driver. However Linux device core first calls the match()
callback to decide the matching of driver and device, and then does some
preparation before calling the driver probe function. If we return error
in the driver probe, it needs to tear down all the preparation work and
retry with next driver.

Adding the match callback can avoid the unnecessary entry into unmatched
driver probe function for ishtp clients reported by FW.

Signed-off-by: Hong Liu <hong.liu@intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c |  5 +----
 drivers/hid/intel-ish-hid/ishtp/bus.c        | 21 ++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h        |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 30fe0c5e6fad..fbb9d85ba6df 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -788,10 +788,6 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 	if (!cl_device)
 		return	-ENODEV;
 
-	if (!guid_equal(&hid_ishtp_guid,
-			&cl_device->fw_client->props.protocol_name))
-		return	-ENODEV;
-
 	client_data = devm_kzalloc(&cl_device->dev, sizeof(*client_data),
 				   GFP_KERNEL);
 	if (!client_data)
@@ -922,6 +918,7 @@ static const struct dev_pm_ops hid_ishtp_pm_ops = {
 
 static struct ishtp_cl_driver	hid_ishtp_cl_driver = {
 	.name = "ish-hid",
+	.guid = &hid_ishtp_guid,
 	.probe = hid_ishtp_cl_probe,
 	.remove = hid_ishtp_cl_remove,
 	.reset = hid_ishtp_cl_reset,
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index d5f4b6438d86..6348fee8aadc 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -219,6 +219,26 @@ static int ishtp_cl_device_probe(struct device *dev)
 	return driver->probe(device);
 }
 
+/**
+ * ishtp_cl_bus_match() - Bus match() callback
+ * @dev: the device structure
+ * @drv: the driver structure
+ *
+ * This is a bus match callback, called when a new ishtp_cl_device is
+ * registered during ishtp bus client enumeration. Use the guid_t in
+ * drv and dev to decide whether they match or not.
+ *
+ * Return: 1 if dev & drv matches, 0 otherwise.
+ */
+static int ishtp_cl_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct ishtp_cl_device *device = to_ishtp_cl_device(dev);
+	struct ishtp_cl_driver *driver = to_ishtp_cl_driver(drv);
+
+	return guid_equal(driver->guid,
+			  &device->fw_client->props.protocol_name);
+}
+
 /**
  * ishtp_cl_device_remove() - Bus remove() callback
  * @dev: the device structure
@@ -372,6 +392,7 @@ static struct bus_type ishtp_cl_bus_type = {
 	.name		= "ishtp",
 	.dev_groups	= ishtp_cl_dev_groups,
 	.probe		= ishtp_cl_device_probe,
+	.match		= ishtp_cl_bus_match,
 	.remove		= ishtp_cl_device_remove,
 	.pm		= &ishtp_cl_bus_dev_pm_ops,
 	.uevent		= ishtp_cl_uevent,
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.h b/drivers/hid/intel-ish-hid/ishtp/bus.h
index 4cf7ad586c37..c96e7fb42f01 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.h
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.h
@@ -64,6 +64,7 @@ struct ishtp_cl_device {
 struct ishtp_cl_driver {
 	struct device_driver driver;
 	const char *name;
+	const guid_t *guid;
 	int (*probe)(struct ishtp_cl_device *dev);
 	int (*remove)(struct ishtp_cl_device *dev);
 	int (*reset)(struct ishtp_cl_device *dev);
-- 
2.17.2

