Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C967BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B45D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="1j7bAZKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfDXKUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54128 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbfDXKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:03 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OA6f7K003010;
        Wed, 24 Apr 2019 12:19:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=1qyx5n5yMrkv5gfN2MwhOkJMoRwpnipFKGrbpD1y6Rg=;
 b=1j7bAZKq4hNou+vSEorHQH8RdwSRNQmiMDJ0lwnIy5Gw3qGncRydV5tDwXJMDbYJlGJu
 cyPsSTodyG/HbIttpP0lfPNSqCxf5C+wWLnD6KI6/fnGWXyi/XPH/+xiLaP6cosZ0Djl
 FIkUu3sjUgYAbP9WiftplJeJwtLy/SHOXzsWc3W1JMZwYmbCtWy0G3Rh4phRpg9k2t+b
 sKkpV65/0EXLJk/X842+l7EbH/6vxG2bl1pl8nqjZ4WObLNPKIUfKQob+EqmJlmQ84FM
 sVTIroyGQ+4486lDSmsdQMwFmoVf7TQ94dwYhIutCcEjoM7xYm2/B7Gh+mvwFPGFjbWT yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad5uaw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 12:19:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 090CB3D;
        Wed, 24 Apr 2019 10:19:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A978D1656;
        Wed, 24 Apr 2019 10:19:32 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 12:19:32 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr 2019 12:19:30
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rafael.j.wysocki@intel.com>, <dmitry.torokhov@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <hadess@hadess.net>,
        <frowand.list@gmail.com>, <m.felsch@pengutronix.de>,
        <agx@sigxcpu.org>, <yannick.fertre@st.com>, <arnd@arndb.de>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/5] of/device: Add of_ functions for device_link_{add,remove}
Date:   Wed, 24 Apr 2019 12:19:09 +0200
Message-ID: <20190424101913.1534-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190424101913.1534-1-benjamin.gaignard@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to create and remove links between consumer and suppliers from 
device-tree data. Use 'links-add' property from consumer node to setup
a link with a list of suppliers.
Consumers will be suspend before their suppliers and resume after them.

Add devm_of_device_links_add() to automatically remove the links
when the device is unbound from the bus.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/of/device.c       | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_device.h |  20 +++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3717f2a20d0d..011ba9bf7642 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -336,3 +336,106 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
+
+/**
+ * of_device_links_add - Create links between consumer and suppliers from
+ * device tree data
+ *
+ * @consumer: consumer device
+ *
+ * Returns 0 on success, < 0 on failure.
+ */
+int of_device_links_add(struct device *consumer)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	int i = 0;
+
+	np = of_parse_phandle(consumer->of_node, "links-add", i++);
+	while (np) {
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!pdev)
+			return -EINVAL;
+
+		device_link_add(consumer, &pdev->dev, DL_FLAG_STATELESS);
+		platform_device_put(pdev);
+
+		np = of_parse_phandle(consumer->of_node, "links-add", i++);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_device_links_add);
+
+/**
+ * of_device_links_remove - Remove links between consumer and suppliers from
+ * device tree data
+ *
+ * @consumer: consumer device
+ *
+ * Returns 0 on success, < 0 on failure.
+ */
+int of_device_links_remove(struct device *consumer)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	int i = 0;
+
+	np = of_parse_phandle(consumer->of_node, "links-add", i++);
+	while (np) {
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!pdev)
+			return -EINVAL;
+
+		device_link_remove(consumer, &pdev->dev);
+		platform_device_put(pdev);
+
+		np = of_parse_phandle(consumer->of_node, "links-add", i++);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_device_links_remove);
+
+static void devm_of_device_links_remove(struct device *dev, void *res)
+{
+	of_device_links_remove(*(struct device **)res);
+}
+
+/**
+ * devm_of_device_links_add - Create links between consumer and suppliers
+ * from device tree data
+ *
+ * @consumer: consumer device
+ *
+ * Returns 0 on success, < 0 on failure.
+ *
+ * Similar to of_device_links_add(), but will automatically call
+ * of_device_links_remove() when the device is unbound from the bus.
+ */
+int devm_of_device_links_add(struct device *consumer)
+{
+		struct device **ptr;
+	int ret;
+
+	if (!consumer)
+		return -EINVAL;
+
+	ptr = devres_alloc(devm_of_device_links_remove,
+			   sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = of_device_links_add(consumer);
+	if (ret < 0) {
+		devres_free(ptr);
+	} else {
+		*ptr = consumer;
+		devres_add(consumer, ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_device_links_add);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8d31e39dd564..ad01db6828e8 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -41,6 +41,11 @@ extern int of_device_request_module(struct device *dev);
 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
 
+
+extern int of_device_links_add(struct device *consumer);
+extern int of_device_links_remove(struct device *consumer);
+extern int devm_of_device_links_add(struct device *consumer);
+
 static inline void of_device_node_put(struct device *dev)
 {
 	of_node_put(dev->of_node);
@@ -91,6 +96,21 @@ static inline int of_device_uevent_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static int of_device_links_add(struct device *consumer)
+{
+	return 0;
+}
+
+static int of_device_links_remove(struct device *consumer)
+{
+	return 0;
+}
+
+static int devm_of_device_links_add(struct device *consumer)
+{
+	return 0;
+}
+
 static inline void of_device_node_put(struct device *dev) { }
 
 static inline const struct of_device_id *__of_match_device(
-- 
2.15.0

