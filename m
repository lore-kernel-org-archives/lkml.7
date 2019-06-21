Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0182085A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUAk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 20:40:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:10365 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFUAk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:40:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 17:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="183258684"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2019 17:40:56 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-nvdimm@lists.01.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] device-dax: Add a 'resource' attribute
Date:   Thu, 20 Jun 2019 18:40:38 -0600
Message-Id: <20190621004038.15180-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device-dax based devices were missing a 'resource' attribute to indicate
the physical address range contributed by the device in question. This
information is desirable to userspace tooling that may want to use the
dax device as system-ram, and wants to selectively hotplug and online
the memory blocks associated with a given device.

Without this, the tooling would have to parse /proc/iomem for the memory
ranges contributed by dax devices, which can be a workaround, but it is
far easier to provide this information in the sysfs hierarchy.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 2109cfe80219..2f3c42ca416a 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -295,6 +295,22 @@ static ssize_t target_node_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_node);
 
+static unsigned long long dev_dax_resource(struct dev_dax *dev_dax)
+{
+	struct dax_region *dax_region = dev_dax->region;
+
+	return dax_region->res.start;
+}
+
+static ssize_t resource_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sprintf(buf, "%#llx\n", dev_dax_resource(dev_dax));
+}
+static DEVICE_ATTR_RO(resource);
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -313,6 +329,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 
 	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
 		return 0;
+	if (a == &dev_attr_resource.attr)
+		return 0400;
 	return a->mode;
 }
 
@@ -320,6 +338,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_size.attr,
 	&dev_attr_target_node.attr,
+	&dev_attr_resource.attr,
 	NULL,
 };
 
-- 
2.20.1

