Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE6E2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfFNRzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:42 -0400
Received: from foss.arm.com ([217.140.110.172]:39702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfFNRz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 555EECFC;
        Fri, 14 Jun 2019 10:55:28 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9AB0D3F718;
        Fri, 14 Jun 2019 10:55:27 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH v2 25/28] drivers: Introduce driver_find_device_by_devt() helper
Date:   Fri, 14 Jun 2019 18:54:20 +0100
Message-Id: <1560534863-15115-26-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to driver_find_device() to search for a device
by the device type, reusing the generic match function.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 2cf49f7..f7f6a43 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -463,6 +463,18 @@ driver_find_device_by_fwnode(struct device_driver *drv,
 	return driver_find_device(drv, NULL, fwnode, device_match_fwnode);
 }
 
+/**
+ * driver_find_device_by_devt- device iterator for locating a particular device
+ * by devt.
+ * @driver: the driver we're iterating
+ * @devt: devt pointer to match.
+ */
+static inline struct device *driver_find_device_by_devt(struct device_driver *drv,
+							dev_t devt)
+{
+	return driver_find_device(drv, NULL, &devt, device_match_devt);
+}
+
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
-- 
2.7.4

