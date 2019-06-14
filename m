Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63655C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4938021848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfFNRyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:54:47 -0400
Received: from foss.arm.com ([217.140.110.172]:39252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfFNRyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:54:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F31D8367;
        Fri, 14 Jun 2019 10:54:45 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 324B93F718;
        Fri, 14 Jun 2019 10:54:45 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Arnd Bergman <arnd@arnd.de>
Subject: [PATCH v2 02/28] mfd: Remove unused helper syscon_regmap_lookup_by_pdevname
Date:   Fri, 14 Jun 2019 18:53:57 +0100
Message-Id: <1560534863-15115-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody uses the exported helper syscon_regmap_lookup_by_pdevname,
to lookup a device by name. Let us remove it.

Suggested-by: Arnd Bergman <arnd@arnd.de>
Cc: Arnd Bergman <arnd@arnd.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Hi,

This patch again, could be separate from the series. However, it
will conflict with the series during the merge. I have included it
here before the actual series changes appear. Please do the necessary.
---
 drivers/mfd/syscon.c       | 21 ---------------------
 include/linux/mfd/syscon.h |  6 ------
 2 files changed, 27 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 8ce1e41..b65e585 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -190,27 +190,6 @@ struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_compatible);
 
-static int syscon_match_pdevname(struct device *dev, void *data)
-{
-	return !strcmp(dev_name(dev), (const char *)data);
-}
-
-struct regmap *syscon_regmap_lookup_by_pdevname(const char *s)
-{
-	struct device *dev;
-	struct syscon *syscon;
-
-	dev = driver_find_device(&syscon_driver.driver, NULL, (void *)s,
-				 syscon_match_pdevname);
-	if (!dev)
-		return ERR_PTR(-EPROBE_DEFER);
-
-	syscon = dev_get_drvdata(dev);
-
-	return syscon->regmap;
-}
-EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_pdevname);
-
 struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 					const char *property)
 {
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index f0273c9..8cfda05 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -19,7 +19,6 @@ struct device_node;
 #ifdef CONFIG_MFD_SYSCON
 extern struct regmap *syscon_node_to_regmap(struct device_node *np);
 extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
-extern struct regmap *syscon_regmap_lookup_by_pdevname(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
@@ -34,11 +33,6 @@ static inline struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline struct regmap *syscon_regmap_lookup_by_pdevname(const char *s)
-{
-	return ERR_PTR(-ENOTSUPP);
-}
-
 static inline struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property)
-- 
2.7.4

