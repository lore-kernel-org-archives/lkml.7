Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE791C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EDD206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfFEPPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:15:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33644 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbfFEPPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:15:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD78F1682;
        Wed,  5 Jun 2019 08:15:01 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BD483F246;
        Wed,  5 Jun 2019 08:15:00 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Eric Anholt <eric@anholt.net>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Inki Dae <inki.dae@samsung.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: [PATCH 13/13] platform: Add platform_find_device_by_driver() helper
Date:   Wed,  5 Jun 2019 16:13:50 +0100
Message-Id: <1559747630-28065-14-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
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
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/platform.c         | 14 ++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d17298..158ac24 100644
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
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index cc46485..36aa775 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -52,6 +52,9 @@ extern struct device platform_bus;
 extern void arch_setup_pdev_archdata(struct platform_device *);
 extern struct resource *platform_get_resource(struct platform_device *,
 					      unsigned int, unsigned int);
+extern struct device *
+platform_find_device_by_driver(struct device * dev,
+			       const struct device_driver *drv);
 extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
-- 
2.7.4

