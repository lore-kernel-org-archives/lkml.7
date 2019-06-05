Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01621C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123D72067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfFEPOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:14:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbfFEPOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:14:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E056715BF;
        Wed,  5 Jun 2019 08:14:40 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 612923F246;
        Wed,  5 Jun 2019 08:14:39 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 07/13] drivers: Add generic match helper by ACPI_COMPANION device
Date:   Wed,  5 Jun 2019 16:13:44 +0100
Message-Id: <1559747630-28065-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic helper to match a device by the acpi device.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c    | 6 ++++++
 include/linux/device.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b827ca1..597095b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3346,3 +3346,9 @@ int device_match_devt(struct device *dev, const void *pdevt)
 	return dev->devt == *(dev_t *)pdevt;
 }
 EXPORT_SYMBOL_GPL(device_match_devt);
+
+int device_match_acpi_dev(struct device *dev, const void *adev)
+{
+	return ACPI_COMPANION(dev) == adev;
+}
+EXPORT_SYMBOL(device_match_acpi_dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index f315692..a03b50d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -166,6 +166,7 @@ void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 int device_match_of_node(struct device *dev, const void *np);
 int device_match_fwnode(struct device *dev, const void *fwnode);
 int device_match_devt(struct device *dev, const void *pdevt);
+int device_match_acpi_dev(struct device *dev, const void *adev);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
-- 
2.7.4

