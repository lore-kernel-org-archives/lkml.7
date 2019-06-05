Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FBEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC922067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfFEPOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:14:49 -0400
Received: from foss.arm.com ([217.140.101.70]:33518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbfFEPOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:14:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5306A15A2;
        Wed,  5 Jun 2019 08:14:47 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 609023F246;
        Wed,  5 Jun 2019 08:14:45 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        Elie Morisse <syniurge@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Subject: [PATCH 09/13] drivers: Add generic helper to match any device
Date:   Wed,  5 Jun 2019 16:13:46 +0100
Message-Id: <1559747630-28065-10-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic helper to match any/all devices.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Elie Morisse <syniurge@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c    | 6 ++++++
 include/linux/device.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5724f93..053ee2e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3358,3 +3358,9 @@ int device_match_name(struct device *dev, const void *name)
 	return sysfs_streq(dev_name(dev), name);
 }
 EXPORT_SYMBOL_GPL(device_match_name);
+
+int device_match_any(struct device *dev, const void *unused)
+{
+	return 1;
+}
+EXPORT_SYMBOL_GPL(device_match_any);
diff --git a/include/linux/device.h b/include/linux/device.h
index 74dd9c6..8c8727b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -168,6 +168,7 @@ int device_match_fwnode(struct device *dev, const void *fwnode);
 int device_match_devt(struct device *dev, const void *pdevt);
 int device_match_acpi_dev(struct device *dev, const void *adev);
 int device_match_name(struct device *dev, const void *name);
+int device_match_any(struct device *dev, const void *unused);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
-- 
2.7.4

