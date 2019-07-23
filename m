Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081DFC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D8C21926
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392468AbfGWWT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:19:26 -0400
Received: from foss.arm.com ([217.140.110.172]:60816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392453AbfGWWTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:19:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1579168F;
        Tue, 23 Jul 2019 15:19:23 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5CB553F694;
        Tue, 23 Jul 2019 15:19:22 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Eric Anholt <eric@anholt.net>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Inki Dae <inki.dae@samsung.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: [PATCH v3 7/7] platform: Add platform_find_device_by_driver() helper
Date:   Tue, 23 Jul 2019 23:18:38 +0100
Message-Id: <20190723221838.12024-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723221838.12024-1-suzuki.poulose@arm.com>
References: <20190723221838.12024-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a helper to lookup platform devices by matching device
driver in order to avoid drivers trying to use platform bus
internals.

Cc: Eric Anholt <eric@anholt.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/platform.c                     | 14 ++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_drv.c     |  9 +++------
 drivers/gpu/drm/mcde/mcde_drv.c             |  3 +--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  3 +--
 drivers/gpu/drm/vc4/vc4_drv.c               |  3 +--
 include/linux/platform_device.h             |  3 +++
 6 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 506a0175a5a7..a174ce5ea17c 100644
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
+	return bus_find_device(&platform_bus_type, start, drv,
+			       (void *)platform_match);
+}
+EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
+
 int __init platform_bus_init(void)
 {
 	int error;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index 58baf49d9926..badab94be2d6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -242,9 +242,7 @@ static struct component_match *exynos_drm_match_add(struct device *dev)
 		if (!info->driver || !(info->flags & DRM_COMPONENT_DRIVER))
 			continue;
 
-		while ((d = bus_find_device(&platform_bus_type, p,
-					    &info->driver->driver,
-					    (void *)platform_bus_type.match))) {
+		while ((d = platform_find_device_by_driver(p, &info->driver->driver))) {
 			put_device(p);
 
 			if (!(info->flags & DRM_FIMC_DEVICE) ||
@@ -412,9 +410,8 @@ static void exynos_drm_unregister_devices(void)
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
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index baf63fb6850a..c07abf9e201c 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -477,8 +477,7 @@ static int mcde_probe(struct platform_device *pdev)
 		struct device_driver *drv = &mcde_component_drivers[i]->driver;
 		struct device *p = NULL, *d;
 
-		while ((d = bus_find_device(&platform_bus_type, p, drv,
-					    (void *)platform_bus_type.match))) {
+		while ((d = platform_find_device_by_driver(p, drv))) {
 			put_device(p);
 			component_match_add(dev, &match, mcde_compare_dev, d);
 			p = d;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 53d2c5bd61dc..38dc26376961 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -330,8 +330,7 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
 		struct device *p = NULL, *d;
 
 		do {
-			d = bus_find_device(&platform_bus_type, p, &drv->driver,
-					    (void *)platform_bus_type.match);
+			d = platform_find_device_by_driver(p, &drv->driver);
 			put_device(p);
 			p = d;
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index bf11930e40e1..1551c8253bec 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -237,8 +237,7 @@ static void vc4_match_add_drivers(struct device *dev,
 		struct device_driver *drv = &drivers[i]->driver;
 		struct device *p = NULL, *d;
 
-		while ((d = bus_find_device(&platform_bus_type, p, drv,
-					    (void *)platform_bus_type.match))) {
+		while ((d = platform_find_device_by_driver(p, drv))) {
 			put_device(p);
 			component_match_add(dev, match, compare_dev, d);
 			p = d;
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 9bc36b589827..37e15a935a42 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -51,6 +51,9 @@ extern struct device platform_bus;
 extern void arch_setup_pdev_archdata(struct platform_device *);
 extern struct resource *platform_get_resource(struct platform_device *,
 					      unsigned int, unsigned int);
+extern struct device *
+platform_find_device_by_driver(struct device *start,
+			       const struct device_driver *drv);
 extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
-- 
2.21.0

