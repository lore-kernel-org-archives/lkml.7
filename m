Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D8AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9086F20883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfE0QhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:37:04 -0400
Received: from proxy04.fsdata.se ([89.221.252.227]:50417 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725991AbfE0QhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:37:04 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 12:37:03 EDT
Received: from localhost (94.234.40.49) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 May 2019 18:21:49
 +0200
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <dvhart@infradead.org>, <andy@infradead.org>,
        <mario.limonciello@dell.com>, <mjg59@srcf.ucam.org>,
        <pali.rohar@gmail.com>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] platform/x86: wmi: add context argument to the probe function
Date:   Mon, 27 May 2019 18:21:30 +0200
Message-ID: <4db1cd4649f5d169acfc08dde6e6a41cf308dd53.1558968964.git.2pi@mok.nu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558968964.git.2pi@mok.nu>
References: <cover.1558968964.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.40.49]
X-ClientProxiedBy: PROXY02.HMC.local (192.168.46.52) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct wmi_device_id has a context pointer field, forward this
pointer as an argument to the probe function in struct wmi_driver.

Update existing users of the same probe function to accept this new
context argument.

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---
 drivers/platform/x86/dell-smbios-wmi.c       | 2 +-
 drivers/platform/x86/dell-wmi-descriptor.c   | 3 ++-
 drivers/platform/x86/dell-wmi.c              | 2 +-
 drivers/platform/x86/huawei-wmi.c            | 2 +-
 drivers/platform/x86/intel-wmi-thunderbolt.c | 3 ++-
 drivers/platform/x86/wmi-bmof.c              | 2 +-
 drivers/platform/x86/wmi.c                   | 3 ++-
 include/linux/wmi.h                          | 2 +-
 8 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell-smbios-wmi.c
index c3ed3c8c17b9..add2687079f7 100644
--- a/drivers/platform/x86/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell-smbios-wmi.c
@@ -146,7 +146,7 @@ static long dell_smbios_wmi_filter(struct wmi_device *wdev, unsigned int cmd,
 	return ret;
 }
 
-static int dell_smbios_wmi_probe(struct wmi_device *wdev)
+static int dell_smbios_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct wmi_driver *wdriver =
 		container_of(wdev->dev.driver, struct wmi_driver, driver);
diff --git a/drivers/platform/x86/dell-wmi-descriptor.c b/drivers/platform/x86/dell-wmi-descriptor.c
index 14ab250b7d5a..9994fd1a5acf 100644
--- a/drivers/platform/x86/dell-wmi-descriptor.c
+++ b/drivers/platform/x86/dell-wmi-descriptor.c
@@ -106,7 +106,8 @@ EXPORT_SYMBOL_GPL(dell_wmi_get_hotfix);
  * WMI buffer length        12       4    <length>
  * WMI hotfix number        16       4    <hotfix>
  */
-static int dell_wmi_descriptor_probe(struct wmi_device *wdev)
+static int dell_wmi_descriptor_probe(struct wmi_device *wdev,
+				     const void *context)
 {
 	union acpi_object *obj = NULL;
 	struct descriptor_priv *priv;
diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index d118bb73fcae..72b0a69a6ed0 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -672,7 +672,7 @@ static int dell_wmi_events_set_enabled(bool enable)
 	return dell_smbios_error(ret);
 }
 
-static int dell_wmi_probe(struct wmi_device *wdev)
+static int dell_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct dell_wmi_priv *priv;
 	int ret;
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 52fcac5b393a..195a7f3638cb 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -166,7 +166,7 @@ static int huawei_wmi_input_setup(struct wmi_device *wdev)
 	return input_register_device(priv->idev);
 }
 
-static int huawei_wmi_probe(struct wmi_device *wdev)
+static int huawei_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct huawei_wmi_priv *priv;
 	int err;
diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel-wmi-thunderbolt.c
index 4dfa61434a76..974c22a7ff61 100644
--- a/drivers/platform/x86/intel-wmi-thunderbolt.c
+++ b/drivers/platform/x86/intel-wmi-thunderbolt.c
@@ -56,7 +56,8 @@ static const struct attribute_group tbt_attribute_group = {
 	.attrs = tbt_attrs,
 };
 
-static int intel_wmi_thunderbolt_probe(struct wmi_device *wdev)
+static int intel_wmi_thunderbolt_probe(struct wmi_device *wdev,
+				       const void *context)
 {
 	int ret;
 
diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
index 8751a13134be..105a82b6b076 100644
--- a/drivers/platform/x86/wmi-bmof.c
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -54,7 +54,7 @@ read_bmof(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static int wmi_bmof_probe(struct wmi_device *wdev)
+static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
 {
 	struct bmof_priv *priv;
 	int ret;
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index f41f1410da9d..09bc6270ec16 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -926,7 +926,8 @@ static int wmi_dev_probe(struct device *dev)
 		dev_warn(dev, "failed to enable device -- probing anyway\n");
 
 	if (wdriver->probe) {
-		ret = wdriver->probe(dev_to_wdev(dev));
+		ret = wdriver->probe(dev_to_wdev(dev),
+				find_guid_context(wblock, wdriver));
 		if (ret != 0)
 			goto probe_failure;
 	}
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 592f81afecbb..1e84c474a993 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -44,7 +44,7 @@ struct wmi_driver {
 	struct device_driver driver;
 	const struct wmi_device_id *id_table;
 
-	int (*probe)(struct wmi_device *wdev);
+	int (*probe)(struct wmi_device *wdev, const void *context);
 	int (*remove)(struct wmi_device *wdev);
 	void (*notify)(struct wmi_device *device, union acpi_object *data);
 	long (*filter_callback)(struct wmi_device *wdev, unsigned int cmd,
-- 
2.21.0

