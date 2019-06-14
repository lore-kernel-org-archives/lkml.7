Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E13C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF51E2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfFNRzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:37 -0400
Received: from foss.arm.com ([217.140.110.172]:39722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbfFNRza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70D63D6E;
        Fri, 14 Jun 2019 10:55:30 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF1EA3F718;
        Fri, 14 Jun 2019 10:55:29 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH v2 27/28] drivers: Introduce driver_find_device_by_acpi_dev() helper
Date:   Fri, 14 Jun 2019 18:54:22 +0100
Message-Id: <1560534863-15115-28-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to driver_find_device() to search for a device
by the ACPI COMPANION device, reusing the generic match function.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/device.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 77f817d..a2a8ac2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -481,6 +481,27 @@ static inline struct device *driver_find_next_device(struct device_driver *drv,
 	return driver_find_device(drv, start, NULL, device_match_any);
 }
 
+#ifdef CONFIG_ACPI
+/**
+ * driver_find_device_by_acpi_dev : device iterator for locating a particular
+ * device matching the ACPI_COMPANION device.
+ * @driver: the driver we're iterating
+ * @adev: ACPI_COMPANION device to match.
+ */
+static inline struct device *
+driver_find_device_by_acpi_dev(struct device_driver *drv,
+			       const struct acpi_device *adev)
+{
+	return driver_find_device(drv, NULL, adev, device_match_acpi_dev);
+}
+#else
+static inline struct device *
+driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
+{
+	return NULL;
+}
+#endif
+
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
-- 
2.7.4

