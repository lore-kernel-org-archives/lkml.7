Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F0C47404
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F432222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B/fMs0X1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o8mRnDXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfJCAGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:06:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45032 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJCAGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:06:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C1A7D60744; Thu,  3 Oct 2019 00:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570061199;
        bh=UfQYYcXITHs98xOB69Xw/qbyimXAGXlGMvhd+tkeSZY=;
        h=From:To:Cc:Subject:Date:From;
        b=B/fMs0X1f3Om1UM4zMoCrmN9EjMwVXnPBpPeXpgAKyf0wdWXhH9Zda94vMFUpB1fL
         XJqN5bmLde4q16NUzsWWyT658qg9RCT9NZQzMoZGFgpEzFqxKobQsHafxG5nqiFofB
         J3VT4yDokc2pfCG7BoNxHGJGLSEoAc784Ko7QgAg=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mnalajal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72A3561156;
        Thu,  3 Oct 2019 00:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570061197;
        bh=UfQYYcXITHs98xOB69Xw/qbyimXAGXlGMvhd+tkeSZY=;
        h=From:To:Cc:Subject:Date:From;
        b=o8mRnDXNhGyDJtHjcQD9iVltRw9HKUSxHwoAXGfonbuMME41ijDiv7asFnvpQJEpb
         9DpPQ0qYMgQSYxmM/BYulm2J6kPMBKhUBqDxOuD2nfr3Zvf9qfIUr2NJdoAhkvwTYh
         Ip7B3cjqB5eE+Oo9a3GzAQ2ER/0/NxmoxqUJkdOQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72A3561156
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mnalajal@codeaurora.org
From:   Murali Nalajala <mnalajal@codeaurora.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     mnalajal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: [PATCH] base: soc: Handle custom soc information sysfs entries
Date:   Wed,  2 Oct 2019 17:06:14 -0700
Message-Id: <1570061174-4918-1-git-send-email-mnalajal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soc framework exposed sysfs entries are not sufficient for some
of the h/w platforms. Currently there is no interface where soc
drivers can expose further information about their SoCs via soc
framework. This change address this limitation where clients can
pass their custom entries as attribute group and soc framework
would expose them as sysfs properties.

Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
---
 drivers/base/soc.c      | 26 ++++++++++++++++++--------
 include/linux/sys_soc.h |  1 +
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 7c0c5ca..ec70a58 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -15,6 +15,8 @@
 #include <linux/err.h>
 #include <linux/glob.h>
 
+#define NUM_ATTR_GROUPS 3
+
 static DEFINE_IDA(soc_ida);
 
 static ssize_t soc_info_get(struct device *dev,
@@ -104,11 +106,6 @@ static ssize_t soc_info_get(struct device *dev,
 	.is_visible = soc_attribute_mode,
 };
 
-static const struct attribute_group *soc_attr_groups[] = {
-	&soc_attr_group,
-	NULL,
-};
-
 static void soc_release(struct device *dev)
 {
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
@@ -121,6 +118,7 @@ static void soc_release(struct device *dev)
 struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
 {
 	struct soc_device *soc_dev;
+	const struct attribute_group **soc_attr_groups = NULL;
 	int ret;
 
 	if (!soc_bus_type.p) {
@@ -136,10 +134,20 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 		goto out1;
 	}
 
+	soc_attr_groups = kzalloc(sizeof(*soc_attr_groups) *
+						NUM_ATTR_GROUPS, GFP_KERNEL);
+	if (!soc_attr_groups) {
+		ret = -ENOMEM;
+		goto out2;
+	}
+	soc_attr_groups[0] = &soc_attr_group;
+	soc_attr_groups[1] = soc_dev_attr->custom_attr_group;
+	soc_attr_groups[2] = NULL;
+
 	/* Fetch a unique (reclaimable) SOC ID. */
 	ret = ida_simple_get(&soc_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0)
-		goto out2;
+		goto out3;
 	soc_dev->soc_dev_num = ret;
 
 	soc_dev->attr = soc_dev_attr;
@@ -151,14 +159,16 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 
 	ret = device_register(&soc_dev->dev);
 	if (ret)
-		goto out3;
+		goto out4;
 
 	return soc_dev;
 
-out3:
+out4:
 	ida_simple_remove(&soc_ida, soc_dev->soc_dev_num);
 	put_device(&soc_dev->dev);
 	soc_dev = NULL;
+out3:
+	kfree(soc_attr_groups);
 out2:
 	kfree(soc_dev);
 out1:
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
index 48ceea8..d9b3cf0 100644
--- a/include/linux/sys_soc.h
+++ b/include/linux/sys_soc.h
@@ -15,6 +15,7 @@ struct soc_device_attribute {
 	const char *serial_number;
 	const char *soc_id;
 	const void *data;
+	const struct attribute_group *custom_attr_group;
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

