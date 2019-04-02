Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0370BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99512084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDBXK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:10:56 -0400
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:44654 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:10:56 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 19:10:47 EDT
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id BSQZhhs5XGusjBSQahTVxO; Tue, 02 Apr 2019 17:02:48 -0600
X-Authority-Analysis: v=2.3 cv=fOdHIqSe c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=oexKYjalfGEA:10 a=Q-fNiiVtAAAA:8
 a=nEoe6GGM0fj7lErqnHgA:9 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id F3D243010142FE; Tue,  2 Apr 2019 16:02:46 -0700 (PDT)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] memory: brcmstb: dpfe: prepare for API-dependent sysfs attributes
Date:   Tue,  2 Apr 2019 16:01:02 -0700
Message-Id: <20190402230103.25491-6-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402230103.25491-1-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHms0JvIk2OhUXdKqqesYKQxioLZy7kmYeMDS3Y6Tv3p3W9m3o+LOeJL3AbWQ78+aCNRHZY9rDnJyFVBRfuVyE0tMthBPbcCbEDX0X+PyNBmBQ1KWm1Z
 VHSuhDo37qNR48INZpZEmUHPmjvm1inTQr4mqZMgYwkXVzOeVsSB+/WhkgN2s39lL2tQy37kFsddCS8g54VxO6/FQogpZe8UCWQ3c4L9Aia65j3JZBr7wiNE
 1u7HwZ9usVX1H7IuJ3mXXUFBFsb4Y8nA7aSuNWZyj9XdNXfrgmNEGCxRxGqtt6zAtU1GC4zn4qk+nhe4SUjRj5d2cpClezEz4SXqbW31X1p20zwmjwAdRaZg
 W6tBEOJIKT87VRMwJhyzsVCgmsPis7KoKRJFgMrkksm3cKQWBi1dEw1TfaRSEpwObFPRrMJSN+tgOldyFro7ew8bwDiCJw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Prepare the driver so that sysfs attributes can differ based on the API
version.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 47 +++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 9ad5ea08c134..43a53246abb3 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -168,6 +168,7 @@ struct init_data {
 struct dpfe_api {
 	int version;
 	const char *fw_name;
+	const struct attribute_group **sysfs_attrs;
 	u32 command[DPFE_CMD_MAX][MSG_FIELD_MAX];
 };
 
@@ -186,10 +187,39 @@ static const char *error_text[] = {
 	"Incorrect checksum", "Malformed command", "Timed out",
 };
 
+/*
+ * Forward declaration of our sysfs attribute functions, so we can declare the
+ * attribute data structures early.
+ */
+static ssize_t show_info(struct device *, struct device_attribute *, char *);
+static ssize_t show_refresh(struct device *, struct device_attribute *, char *);
+static ssize_t store_refresh(struct device *, struct device_attribute *,
+			  const char *, size_t);
+static ssize_t show_vendor(struct device *, struct device_attribute *, char *);
+
+/*
+ * Declare our attributes early, so they can be referenced in the API data
+ * structure. We need to do this, because the attributes depend on the API
+ * version.
+ */
+static DEVICE_ATTR(dpfe_info, 0444, show_info, NULL);
+static DEVICE_ATTR(dpfe_refresh, 0644, show_refresh, store_refresh);
+static DEVICE_ATTR(dpfe_vendor, 0444, show_vendor, NULL);
+
+/* API v2 sysfs attributes */
+static struct attribute *dpfe_v2_attrs[] = {
+	&dev_attr_dpfe_info.attr,
+	&dev_attr_dpfe_refresh.attr,
+	&dev_attr_dpfe_vendor.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(dpfe_v2);
+
 /* API v2 firmware commands */
 static const struct dpfe_api dpfe_api_v2 = {
 	.version = 2,
 	.fw_name = "dpfe.bin",
+	.sysfs_attrs = dpfe_v2_groups,
 	.command = {
 		[DPFE_CMD_GET_INFO] = {
 			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
@@ -687,17 +717,6 @@ static int brcmstb_dpfe_resume(struct platform_device *pdev)
 	return brcmstb_dpfe_download_firmware(pdev, &init);
 }
 
-static DEVICE_ATTR(dpfe_info, 0444, show_info, NULL);
-static DEVICE_ATTR(dpfe_refresh, 0644, show_refresh, store_refresh);
-static DEVICE_ATTR(dpfe_vendor, 0444, show_vendor, NULL);
-static struct attribute *dpfe_attrs[] = {
-	&dev_attr_dpfe_info.attr,
-	&dev_attr_dpfe_refresh.attr,
-	&dev_attr_dpfe_vendor.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(dpfe);
-
 static int brcmstb_dpfe_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -750,7 +769,7 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sysfs_create_groups(&pdev->dev.kobj, dpfe_groups);
+	ret = sysfs_create_groups(&pdev->dev.kobj, priv->dpfe_api->sysfs_attrs);
 	if (!ret)
 		dev_info(dev, "registered with API v%d.\n",
 			 priv->dpfe_api->version);
@@ -760,7 +779,9 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 
 static int brcmstb_dpfe_remove(struct platform_device *pdev)
 {
-	sysfs_remove_groups(&pdev->dev.kobj, dpfe_groups);
+	struct private_data *priv = dev_get_drvdata(&pdev->dev);
+
+	sysfs_remove_groups(&pdev->dev.kobj, priv->dpfe_api->sysfs_attrs);
 
 	return 0;
 }
-- 
2.17.1

