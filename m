Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D106C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806AD2593D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfFCPvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:51:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53724 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbfFCPv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF225174E;
        Mon,  3 Jun 2019 08:51:28 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 322BE3F246;
        Mon,  3 Jun 2019 08:51:27 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Eric Anholt <eric@anholt.net>
Subject: [RFC PATCH 20/57] platform: Add a helper to find device by driver
Date:   Mon,  3 Jun 2019 16:49:46 +0100
Message-Id: <1559577023-558-21-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of places where we reuse platform specific
match to find a device. Instead of spilling the global varilable
everywhere, let us provide a helper to do the same.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Eric Anholt <eric@anholt.net>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/platform.c                     | 14 ++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_drv.c     |  9 +++------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  3 +--
 drivers/gpu/drm/vc4/vc4_drv.c               |  3 +--
 include/linux/platform_device.h             |  3 +++
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d17298..daca44f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1197,6 +1197,20 @@ struct bus_type platform_bus_type = {
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
+/**
+ * platform_find_device_by_driver - Find a platform device with a given
+ * driver.
+ * @start: The device to start the search from.
+ * @drv: The device driver to look for.
+ */
+struct device *platform_find_device_by_driver(struct device *start,
+					      const struct device_driver *drv)
+{
+	return bus_find_device(&platform_bus_type, start, (void *)drv,
+			       (int (*)(struct device *, void *))platform_match);
+}
+EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
+
 int __init platform_bus_init(void)
 {
 	int error;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index ba8932a..b357e0d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -244,9 +244,7 @@ static struct component_match *exynos_drm_match_add(struct device *dev)
 		if (!info->driver || !(info->flags & DRM_COMPONENT_DRIVER))
 			continue;
 
-		while ((d = bus_find_device(&platform_bus_type, p,
-					    &info->driver->driver,
-					    (void *)platform_bus_type.match))) {
+		while ((d = platform_find_device_by_driver(p, &info->driver->driver))) {
 			put_device(p);
 
 			if (!(info->flags & DRM_FIMC_DEVICE) ||
@@ -414,9 +412,8 @@ static void exynos_drm_unregister_devices(void)
 		if (!info->driver || !(info->flags & DRM_VIRTUAL_DEVICE))
 			continue;
 
-		while ((dev = bus_find_device(&platform_bus_type, NULL,
-					    &info->driver->driver,
-					    (void *)platform_bus_type.match))) {
+		while ((dev = platform_find_device_by_driver(NULL,
+						&info->driver->driver))) {
 			put_device(dev);
 			platform_device_unregister(to_platform_device(dev));
 		}
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index cb938d3..4eb4fb8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -338,8 +338,7 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
 		struct device *p = NULL, *d;
 
 		do {
-			d = bus_find_device(&platform_bus_type, p, &drv->driver,
-					    (void *)platform_bus_type.match);
+			d = platform_find_device_by_driver(p, &drv->driver);
 			put_device(p);
 			p = d;
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 6d9be20..d159eb5 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -236,8 +236,7 @@ static void vc4_match_add_drivers(struct device *dev,
 		struct device_driver *drv = &drivers[i]->driver;
 		struct device *p = NULL, *d;
 
-		while ((d = bus_find_device(&platform_bus_type, p, drv,
-					    (void *)platform_bus_type.match))) {
+		while ((d = platform_find_device_by_driver(p, drv))) {
 			put_device(p);
 			component_match_add(dev, match, compare_dev, d);
 			p = d;
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index cc46485..a82b3ec 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -52,6 +52,9 @@ extern struct device platform_bus;
 extern void arch_setup_pdev_archdata(struct platform_device *);
 extern struct resource *platform_get_resource(struct platform_device *,
 					      unsigned int, unsigned int);
+extern struct device *
+platform_find_device_by_driver(struct device dev*,
+			       const struct device_driver *drv);
 extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
-- 
2.7.4

