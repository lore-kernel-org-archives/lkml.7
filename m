Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65482C06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0A0218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562230002;
	bh=1gMIyrG8zz1L+WGLjYc1vTwxG3KfgSDuIVw1K4VZDhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mGsxt3hECPqsUtz6+blza50xmly7xUvJZ1sRnRmq+blsxc7EPdZCAbLp3PSgLDLXb
	 3anLqydAbp5iAlg6mtqQIFJgE0NQq9Lb3zanJe+xVmntU7Rb6iF++MvhofaJ2XwlPK
	 92p6wE2cK+UtmvvE9uh5A8GGK0vtsAoKD3rfMckw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGDIqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfGDIqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:46:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABCE8218A0;
        Thu,  4 Jul 2019 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562229999;
        bh=1gMIyrG8zz1L+WGLjYc1vTwxG3KfgSDuIVw1K4VZDhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ey4q4tyK5k8N8IQJP5Ft1BVL9Bqo2dA69gHM4fSA1UTtJMRgysawqsaiCACK7GkBd
         t2z6cFLXdKm/D/tkoa9QzPt+EDnCvhSYEXJKb3GsG8jiSw6ShRHV/p3vByNNDAl5Rq
         BoJQpokuB7u+hZphY3a5sgR0q2SdB00LNQd6CIQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 01/11] Platform: add a dev_groups pointer to struct platform_driver
Date:   Thu,  4 Jul 2019 10:46:07 +0200
Message-Id: <20190704084617.3602-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers like to add sysfs groups to their device, but right now
they have to do it "by hand".  The driver core should handle this for
them, but there is no way to get to the bus-default attribute groups as
all platform devices are "special and unique" one-off drivers/devices.

To combat this, add a dev_groups pointer to platform_driver which allows
a platform driver to set up a list of default attributes that will be
properly created and removed by the platform driver core when a probe()
function is successful and removed right before the device is unbound.

Cc: Richard Gong <richard.gong@linux.intel.com>
Cc: Romain Izard <romain.izard.pro@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mans Rullgard <mans@mansr.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/platform.c         | 40 +++++++++++++++++++++------------
 include/linux/platform_device.h |  1 +
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 713903290385..d81fcd435b52 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -598,6 +598,21 @@ struct platform_device *platform_device_register_full(
 }
 EXPORT_SYMBOL_GPL(platform_device_register_full);
 
+static int platform_drv_remove(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+	int ret = 0;
+
+	if (drv->remove)
+		ret = drv->remove(dev);
+	if (drv->dev_groups)
+		device_remove_groups(_dev, drv->dev_groups);
+	dev_pm_domain_detach(_dev, true);
+
+	return ret;
+}
+
 static int platform_drv_probe(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
@@ -614,8 +629,18 @@ static int platform_drv_probe(struct device *_dev)
 
 	if (drv->probe) {
 		ret = drv->probe(dev);
-		if (ret)
+		if (ret) {
 			dev_pm_domain_detach(_dev, true);
+			goto out;
+		}
+	}
+	if (drv->dev_groups) {
+		ret = device_add_groups(_dev, drv->dev_groups);
+		if (ret) {
+			platform_drv_remove(_dev);
+			return ret;
+		}
+		kobject_uevent(&_dev->kobj, KOBJ_CHANGE);
 	}
 
 out:
@@ -632,19 +657,6 @@ static int platform_drv_probe_fail(struct device *_dev)
 	return -ENXIO;
 }
 
-static int platform_drv_remove(struct device *_dev)
-{
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
-	struct platform_device *dev = to_platform_device(_dev);
-	int ret = 0;
-
-	if (drv->remove)
-		ret = drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
-
-	return ret;
-}
-
 static void platform_drv_shutdown(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index cc464850b71e..027f1e1d7af8 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -190,6 +190,7 @@ struct platform_driver {
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 	const struct platform_device_id *id_table;
+	const struct attribute_group **dev_groups;
 	bool prevent_deferred_probe;
 };
 
-- 
2.22.0

